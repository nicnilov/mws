module Mws
  module Concerns
    module Services
      module Feeds
        include Mws::Concerns::Api

        # See available feed type values at
        # http://docs.developer.amazonservices.com/en_US/feeds/Feeds_FeedType.html
        def submit_feed(feed_type, payload = '')
          params = {
            'Action' => 'SubmitFeed',
            'FeedType' => feed_type,
            'Version' => '2009-01-01'
          }
          if block_given?
            request(payload, params, &Proc.new)
          else
            request(payload, params)
          end
        end

        def get_feed_submission_result(feed_submission_id)
          params = {
            'Action' => 'GetFeedSubmissionResult',
            'FeedSubmissionId' => feed_submission_id
          }
          request('', params)
        end

        # needs support for optional arguments, see
        # http://docs.developer.amazonservices.com/en_US/feeds/Feeds_GetFeedSubmissionCount.html
        def get_feed_submission_count
          params = {
            'Action' => 'GetFeedSubmissionCount',
          }
          request('', params)
        end

        # needs support for optional arguments, see
        # http://docs.developer.amazonservices.com/en_US/feeds/Feeds_GetFeedSubmissionList.html
        def get_feed_submission_list
          params = {
            'Action' => 'GetFeedSubmissionList',
          }
          request('', params)
        end

        # needs support for optional arguments, see
        # http://docs.developer.amazonservices.com/en_US/feeds/Feeds_GetFeedSubmissionListByNextToken.html
        def get_feed_submission_list_by_next_token(next_token)
          params = {
            'Action' => 'GetFeedSubmissionList',
            'NextToken' => next_token
          }
          request('', params)
        end

        # currently cancels all submissions, see
        # http://docs.developer.amazonservices.com/en_US/feeds/Feeds_CancelFeedSubmissions.html
        def cancel_feed_submissions
          params = {
            'Action' => 'CancelFeedSubmissions',
          }
          request('', params)
        end

      end
    end
  end
end
