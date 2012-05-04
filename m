From: Asias He <asias@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: Fix hot-unplug race in remove method
Date: Fri, 04 May 2012 16:37:45 +0800
Message-ID: <4FA39559.2000705@redhat.com>
References: <1336030247-16323-1-git-send-email-asias@redhat.com>
	<20120503075634.GK8266@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120503075634.GK8266@redhat.com>
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
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Mason <chris.mason@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/03/2012 03:56 PM, Michael S. Tsirkin wrote:
> On Thu, May 03, 2012 at 03:30:47PM +0800, Asias He wrote:
>> If we reset the virtio-blk device before the requests already dispatched
>> to the virtio-blk driver from the block layer are finised, we will stuck
>> in blk_cleanup_queue() and the remove will fail.
>>
>> blk_cleanup_queue() calls blk_drain_queue() to drain all requests queued
>> before DEAD marking. However it will never success if the device is
>> already stopped. We'll have q->in_flight[]>  0, so the drain will not
>> finish.
>>
>> How to reproduce the race:
>> 1. hot-plug a virtio-blk device
>> 2. keep reading/writing the device in guest
>> 3. hot-unplug while the device is busy serving I/O
>>
>> Changes in v2:
>> - Drop req_in_flight
>> - Use virtqueue_detach_unused_buf to get request dispatched to driver
>>
>> Signed-off-by: Asias He<asias@redhat.com>
>> ---
>>   drivers/block/virtio_blk.c |   16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 72fe55d..670c28f 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -443,7 +443,7 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>>   	if (err)
>>   		goto out_free_vblk;
>>
>> -	vblk->pool = mempool_create_kmalloc_pool(1,sizeof(struct virtblk_req));
>> +	vblk->pool = mempool_create_kmalloc_pool(1, sizeof(struct virtblk_req));
>>   	if (!vblk->pool) {
>>   		err = -ENOMEM;
>>   		goto out_free_vq;
>
> Would be a bit easier to review if whitespace changes
> are avoided, and done in a separate patch targeting 3.5.

Well, I will cook another patch for this.

>> @@ -576,20 +576,30 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
>>   {
>>   	struct virtio_blk *vblk = vdev->priv;
>>   	int index = vblk->index;
>> +	struct virtblk_req *vbr;
>>
>>   	/* Prevent config work handler from accessing the device. */
>>   	mutex_lock(&vblk->config_lock);
>>   	vblk->config_enable = false;
>>   	mutex_unlock(&vblk->config_lock);
>>
>> +	/* Abort all request on the queue. */
>
> All requests
>
> Also, the comment isn't
> really helpful. Want to explain why we abort
> them all here? Won't they be drained
> by later detach code?

blk_cleanup_queue is trying to drain the queue by calling request_fn, 
which is do_virtblk_request in this case. As we already stopped the 
device when calling blk_cleanup_queue, the drain might fail if do_req fails.

blk_cleanup_queue
    blk_drain_queue
        while (true)
           __blk_run_queue
             q->request_fn(q);

>> +	blk_abort_queue(vblk->disk->queue);

And now, I realized that using blk_abort_queue here to abort the queue 
is not right. it is used for timeout handling (block/blk-timeout.c).

[ CC'ing Jens and Chris ]

I suspect the btrfs code is using this in the wrong way too:

btrfs_abort_devices() {
         list_for_each_entry_rcu(dev, head, dev_list) {
                 blk_abort_queue(dev->bdev->bd_disk->queue);
         }
}

>> +	del_gendisk(vblk->disk);
>> +
>>   	/* Stop all the virtqueues. */
>>   	vdev->config->reset(vdev);
>> -
>>   	flush_work(&vblk->config_work);
>>
>> -	del_gendisk(vblk->disk);
>
> Is there a reason you move del_gendisk to before reset?
> Is it safe to del_gendisk while we might
> still be getting callbacks from the device?

The original idea was to make the block layer stop sending request to 
driver asap. This is wrong since virtblk_config_changed_work might 
access vblk->disk.

>> +	/* Abort request dispatched to driver. */
>> +	while ((vbr = virtqueue_detach_unused_buf(vblk->vq))) {
>> +		blk_abort_request(vbr->req);
>> +		mempool_free(vbr, vblk->pool);
>> +	}
>> +
>>   	blk_cleanup_queue(vblk->disk->queue);
>>   	put_disk(vblk->disk);
>> +
>>   	mempool_destroy(vblk->pool);
>>   	vdev->config->del_vqs(vdev);
>>   	kfree(vblk);
>> --
>> 1.7.10
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Asias
