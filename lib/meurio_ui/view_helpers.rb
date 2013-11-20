# coding: utf-8

module MeurioUi
  module ViewHelpers
    def meurio_header_for app
      content_tag(:header) do
        meurio_brand_and_user_panel+
          application_menu
      end
    end

    def meurio_brand_and_user_panel
      content_tag(:div, class: :user) do
        content_tag(:div, class: :row) do
          content_tag(:div, class: :meurio_logo) do
            link_to image_tag('meurio.png'), 'http://meurio.org.br/'
          end +
          content_tag(:div, class: :user_menu) do
            if current_user.present?
              content_tag(:div, class: :user_name) do
                image_tag(current_user.avatar_url) + current_user.name + content_tag(:span, nil, class: 'icon-triangle-down')
              end +
              content_tag(:div, class: :user_links) do
                link_to('Minhas campanhas', user_campaigns_path(current_user)) +
                if can?(:moderate, Campaign)
                    link_to('Moderar campanhas', unmoderated_campaigns_path)
                end +
                if can?(:export, User)
                  link_to("Exportar todos os usuários", users_path(:format => :csv))
                end
              end
            else
              link_to 'Entrar', "http://accounts.meurio.org.br/?redirect_url=#{request.url}", class: :btn2
            end
          end +
          content_tag(:div, nil, class: :clear)
        end
      end
    end

    def application_menu
      content_tag(:div, class: :app) do
        content_tag(:div, class: :row) do
          content_tag(:div, class: :logo) do
            content_tag(:div, class: :current_app) do
              link_to(root_path) do
                image_tag('pdp.png') + content_tag(:span, 'Panela de Pressão')
              end +
              content_tag(:span, nil, class: 'icon-arrow-box')
            end +
            content_tag(:div, class: :apps) do
              link_to('http://meurio.org.br/', class: :app_btn) do
                image_tag('mr.png') + content_tag(:span, 'Ação em Rede')
              end +
              link_to('http://paneladepressao.meurio.org.br/', class: :app_btn) do
                image_tag('pdp.png') + content_tag(:span, 'Panela de Pressão')
              end +
              link_to('http://imagine.meurio.org.br/', class: :app_btn) do
                image_tag('imagine.png') + content_tag(:span, 'Imagine')
              end +
              link_to('https://apoie.meurio.org.br/', class: :app_btn) do
                image_tag('apoie.png') + content_tag(:span, 'Faça Acontecer')
              end +
              link_to('http://deolho.meurio.org.br/', class: :app_btn) do
                image_tag('deolho.png') + content_tag(:span, 'De Olho')
              end +
              link_to('http://deguarda.meurio.org.br/', class: :app_btn) do
                image_tag('deguarda.png') + content_tag(:span, 'De Guarda')
              end
            end
          end +
          content_tag(:div, class: :menu) do
            link_to('Como funciona?', about_path) + link_to('Descubra as campanhas', explore_path) + link_to('Crie sua campanha', new_campaign_path, class: :btn)
          end +
          content_tag(:div, nil, class: :clear)
        end
      end
    end
  end
end