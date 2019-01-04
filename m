From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [virtio-dev] Re: [PATCH v1 1/2] virtio-balloon: tweak
	config_changed implementation
Date: Fri, 04 Jan 2019 13:14:27 +0800
Message-ID: <5C2EEBB3.3070109__31245.0856589296$1546578424$gmane$org@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
	<1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
	<20190103113228-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190103113228-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, cohuck@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 01/04/2019 12:42 AM, Michael S. Tsirkin wrote:
> On Thu, Jan 03, 2019 at 01:31:01PM +0800, Wei Wang wrote:
>> virtio-ccw has deadlock issues with reading config registers inside the
>> interrupt context, so we tweak the virtballoon_changed implementation
>> by moving the config read operations into the related workqueue contexts.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 54 ++++++++++++++++++++---------------------
>>   1 file changed, 26 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 728ecd1..9a82a11 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -394,33 +394,15 @@ static void virtballoon_changed(struct virtio_device *vdev)
>>   {
>>   	struct virtio_balloon *vb = vdev->priv;
>>   	unsigned long flags;
>> -	s64 diff = towards_target(vb);
>> -
>> -	if (diff) {
>> -		spin_lock_irqsave(&vb->stop_update_lock, flags);
>> -		if (!vb->stop_update)
>> -			queue_work(system_freezable_wq,
>> -				   &vb->update_balloon_size_work);
>> -		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>> -	}
>>   
>> -	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>> -		virtio_cread(vdev, struct virtio_balloon_config,
>> -			     free_page_report_cmd_id, &vb->cmd_id_received);
> There's one problem with this approach:
>
> previously updating the cmd_id_received here would immediately
> stop the report in send_free_pages.
>
> With this approach we are waiting for the wq to schedule,
> which might be blocked waiting for report to complete.
> So host can no longer quickly stop the report in progress.
>
> A simple work-around would be to set some kind of flag whenever there
> is a change interrupt, then have send_free_pages test it
> and re-read cmd_id_received.
>
> Needs to be an atomic I guess ...
>

Yes, sounds better..will update the patch.

Best,
Wei
