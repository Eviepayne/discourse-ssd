# name: discourse-self-service-delete
# about: Allow users to delete their own topic
# version: 0.0.1
# authors: VladTheImplier
# url: https://github.com/vladtheimplier/discourse-ssd

after_initialize do
  module TopicGuardian
     def can_delete_topic?(topic)
      !topic.trashed? &&
        (
          is_staff? || is_my_own?(topic) || is_category_group_moderator?(topic.category) ||
            user&.in_any_groups?(SiteSetting.delete_all_posts_and_topics_allowed_groups_map)
        ) && !topic.is_category_topic? && !Discourse.static_doc_topic_ids.include?(topic.id)
     end
  end
end
