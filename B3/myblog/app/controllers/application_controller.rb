class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method [:markdown]

  # Highlight code with Pygments
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      language = 'text' if language.blank?
      sha = Digest::SHA1.hexdigest(code)
      Rails.cache.fetch ['code', language, sha].join('-') do
        Pygments.highlight(code, lexer: language)
      end
    end
  end

  protected

  # Markdown with Redcarpet
  def markdown(text)
    renderer = HTMLwithPygments.new(filter_html: true,
                                    hard_wrap: true,
                                    link_attributes: { rel: 'external nofollow' })

    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      tables: true
    }

    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  private

  def require_login
    unless session[:status]
      flash[:error] = '你当前未登录，请登录！'
      redirect_to login_admins_path
    end
  end
end
