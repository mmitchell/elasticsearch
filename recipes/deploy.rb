node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/shared/config/elasticsearch.yml" do
    source "elasticsearch_rails_config.yml.erb"
    mode "0660"
    group deploy[:group]
    owner deploy[:user]
    variables(
      :elasticsearch => deploy[:elasticsearch] || {},
      :environment => deploy[:rails_env] || 'production'
    )

    only_if do
      deploy[:elasticsearch][:host].present? && File.directory?("#{deploy[:deploy_to]}/shared/config/")
    end
  end
end
