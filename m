From: Konstantin Neumoin <kneumoin@virtuozzo.com>
Subject: Re: [PATCH 1/1] update balloon size in balloon "probe"
Date: Mon, 26 Sep 2016 10:16:14 +0300
Message-ID: <c41cf1cf-35e5-1f31-0d2c-9864e6012ac9__2344.09824847734$1475473050$gmane$org@virtuozzo.com>
References: <1474638477-8658-1-git-send-email-den@openvz.org>
	<20160923215334-mutt-send-email-mst@kernel.org>
Reply-To: kneumoin@virtuozzo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160923215334-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/23/2016 09:58 PM, Michael S. Tsirkin wrote:
> On Fri, Sep 23, 2016 at 04:47:57PM +0300, Denis V. Lunev wrote:
>> From: Konstantin Neumoin <kneumoin@virtuozzo.com>
>>
>> Patch
>>      Commit 3d2a3774c1b046f548ebea0391a602fd5685a307
>>      Author: Michael S. Tsirkin <mst@redhat.com>
>>      Date:   Tue Mar 10 11:55:08 2015 +1030
>>      virtio-balloon: do not call blocking ops when !TASK_RUNNING
>> has added a regression. Original code with wait_event_interruptible
>> checked the condition before start waiting and started balloon operations
>> if necessary.
> I don't get it, sorry.
>
> +               add_wait_queue(&vb->config_change, &wait);
> +               for (;;) {
> +                       if ((diff = towards_target(vb)) != 0 ||
> +                           vb->need_stats_update ||
> +                           kthread_should_stop() ||
> +                           freezing(current))
> +                               break;
> +                       wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> +               }
> +               remove_wait_queue(&vb->config_change, &wait);
>
> Seems to check the condition before waiting.
>
> The issue is more likely with this patch:
>
> 	commit fad7b7b27b6a168ca8ebc84482043886f837b89d
> 	Author: Petr Mladek <pmladek@suse.com>
> 	Date:   Mon Jan 25 17:38:05 2016 +0100
>
> 	    virtio_balloon: Use a workqueue instead of "vballoon" kthread
yes, you are right, sorry, commit message is incorrect.
>      
>
>
>> Right now balloon is not inflated if ballon target is set before the
>> driver is loaded.
>>
>> Signed-off-by: Konstantin Neumoin <kneumoin@virtuozzo.com>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: "Michael S. Tsirkin" <mst@redhat.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 4e7003d..0a6c10f 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -577,6 +577,10 @@ static int virtballoon_probe(struct virtio_device *vdev)
>>   
>>   	virtio_device_ready(vdev);
>>   
>> +	if (towards_target(vb))
>> +		virtballoon_changed(vdev);
>> +	update_balloon_size(vb);
>> +
>>   	return 0;
>>   
>>   out_del_vqs:
>
> I know we have same thing on restore, but it seems bogus
> there as well:
>          if (towards_target(vb))
>                  virtballoon_changed(vdev);
>          update_balloon_size(vb);
>
> makes no sense because virtballoon_changed merely queues
> the work.
  in virtballoon_probe we just init work items, but if we have a target 
- num_pages != 0
we will catch it only after virtballoon_changed will be called, isn't it?

  So, I believe, on probe, we have to do the same thing as on restore: 
check towards_target(vb)
and call virtballoon_changed(vdev) if necessary.
>
>> -- 
>> 2.7.4
