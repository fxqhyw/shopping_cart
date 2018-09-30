module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop do
        sleep 0.1
        break if finished_all_ajax_requests?
      end
    end
  end

  private

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end
