
class ShaController < ApplicationController

  def index
    @services = {
      'differ'  => info('differ', differ.sha),
      'mapper'  => info('mapper', mapper.sha),
      'nginx'   => info('nginx', nginx_sha),
      'runner'  => info('runner', runner.sha, 'runner-stateless'),
      'saver'   => info('saver', saver.sha),
      'starter' => info('starter', starter.sha, 'start-points-base'),
      'web'     => info('web', web_sha),
      # 'zipper'  => info('zipper', zipper.sha)
    }
  end

  private

  def web_sha
    ENV['SHA']
  end

  def nginx_sha
    '' # nginx is upstream of web, client fills this in
  end

  def info(name, sha, repo_name = name)
    { 'repo_name' => repo_name,
      'sha' => sha,
      'github_url' => github_url(repo_name, sha),
      'dockerhub_url' => dockerhub_url(repo_name)
    }
  end

  def github_url(repo_name, sha)
    "https://github.com/cyber-dojo/#{repo_name}/tree/#{sha}"
  end

  def dockerhub_url(repo_name)
    "https://hub.docker.com/r/cyberdojo/#{repo_name}/tags"
  end

end
