# == Route Map
#
#                    Prefix Verb URI Pattern                                                                              Controller#Action
#                 users_new GET  /users/new(.:format)                                                                     users#new
#                      root GET  /                                                                                        static_pages#home
#         static_pages_help GET  /static_pages/help(.:format)                                                             static_pages#help
#        static_pages_about GET  /static_pages/about(.:format)                                                            static_pages#about
#      static_pages_contact GET  /static_pages/contact(.:format)                                                          static_pages#contact
#                           GET  /users/new(.:format)                                                                     users#new
#        rails_service_blob GET  /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET  /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET  /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT  /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get 'users/new'
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'
  get 'users/new'
end
