#!/usr/bin/env ruby

# Much stuff stolen from https://github.com/topfunky/zsh-simple

def git_repo_path
  @git_repo_path ||= `git rev-parse --git-dir 2>/dev/null`.strip
end

def in_git_repo
  !git_repo_path.empty? &&
  git_repo_path != '~' &&
  git_repo_path != "#{ENV['HOME']}/.git"
end

def rebasing_etc
  if File.exists? File.join(git_repo_path, 'BISECT_LOG')
    ' (bisect)'
  elsif File.exists? File.join(git_repo_path, 'MERGE_HEAD')
    ' (merge)'
  elsif %w[rebase rebase-apply rebase-merge ../.dotest].any? { |d| File.exists? File.join(git_repo_path, d) }
    '(rebase)'
  else
    ''
  end
end

exit unless in_git_repo


_stage = []
_working_tree = []

`git status --porcelain -u`.each_line do |line|
  _stage << line[0,1]
  _working_tree << line[1,1]
end

stage = {
  :modified => _stage.count { |x| x == 'M' },
  :added    => _stage.count { |x| x == 'A' },
  :deleted  => _stage.count { |x| x == 'D' },
  :renamed  => _stage.count { |x| x == 'R' },
}
working_tree = {
  :modified => _working_tree.count { |x| x == 'M' },
  :deleted  => _working_tree.count { |x| x == 'D' },
  :unmerged => _working_tree.count { |x| x == 'U' },
}


staged_count = 0
staged_prompt = stage.map { |kv|
  staged_count += kv[1]
  kv[1] > 0 ? "#{kv[1]} #{kv[0]}" : nil
}.compact.join ', '

unstaged_count = 0
unstaged_prompt = working_tree.map { |kv|
  unstaged_count += kv[1]
  kv[1] > 0 ? "#{kv[1]} #{kv[0]}" : nil
}.compact.join ', '

untracked_count = _working_tree.count { |x| x == '?' }
untracked_prompt = "#{untracked_count} untracked"


prompt = "%F{81}" + `git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||'`.chomp
prompt += rebasing_etc
prompt += " %F{118}(#{staged_prompt})" if staged_count > 0
prompt += " %F{166}(#{unstaged_prompt})" if unstaged_count > 0
prompt += " %F{161}(#{untracked_prompt})" if untracked_count > 0

puts prompt
