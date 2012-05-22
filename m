From: Asias He <asias@redhat.com>
Subject: Re: [RFC PATCH 5/5] virtio-blk: Use block layer provided spinlock
Date: Tue, 22 May 2012 16:22:04 +0800
Message-ID: <4FBB4CAC.7010908@redhat.com>
References: <1337591313-26333-1-git-send-email-asias@redhat.com>
	<1337591313-26333-5-git-send-email-asias@redhat.com>
	<20120521205953.GC17031@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120521205953.GC17031@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 05/22/2012 04:59 AM, Michael S. Tsirkin wrote:
> On Mon, May 21, 2012 at 05:08:33PM +0800, Asias He wrote:
>> Block layer will allocate a spinlock for the queue if the driver does
>> not provide one in blk_init_queue().
>>
>> The reason to use the internal spinlock is that blk_cleanup_queue() will
>> switch to use the internal spinlock in the cleanup code path.
>>          if (q->queue_lock !=&q->__queue_lock)
>>                  q->queue_lock =&q->__queue_lock;
>>
>> However, processes which are in D state might have taken the driver
>> provided spinlock, when the processes wake up , they would release the
>> block provided spinlock.
>
> Are you saying any driver with its own spinlock is
> broken if hotunplugged under stress?

Hi, Michael

I can not say that. It is very hard to find real hardware device to try 
this.  I tried on qemu with LSI Logic / Symbios Logic 53c895a scsi disk 
with hot-unplug. It is completely broken. And IDE does not support 
hotplug at all.

Do you see any downside of using the block provided spinlock?

>
>> =====================================
>> [ BUG: bad unlock balance detected! ]
>> 3.4.0-rc7+ #238 Not tainted
>> -------------------------------------
>> fio/3587 is trying to release lock (&(&q->__queue_lock)->rlock) at:
>> [<ffffffff813274d2>] blk_queue_bio+0x2a2/0x380
>> but there are no more locks to release!
>>
>> other info that might help us debug this:
>> 1 lock held by fio/3587:
>>   #0:  (&(&vblk->lock)->rlock){......}, at:
>> [<ffffffff8132661a>] get_request_wait+0x19a/0x250
>>
>> Cc: Rusty Russell<rusty@rustcorp.com.au>
>> Cc: "Michael S. Tsirkin"<mst@redhat.com>
>> Cc: virtualization@lists.linux-foundation.org
>> Cc: kvm@vger.kernel.org
>> Signed-off-by: Asias He<asias@redhat.com>
>> ---
>>   drivers/block/virtio_blk.c |    9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index ba35509..0c2f0e8 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -21,8 +21,6 @@ struct workqueue_struct *virtblk_wq;
>>
>>   struct virtio_blk
>>   {
>> -	spinlock_t lock;
>> -
>>   	struct virtio_device *vdev;
>>   	struct virtqueue *vq;
>>
>> @@ -65,7 +63,7 @@ static void blk_done(struct virtqueue *vq)
>>   	unsigned int len;
>>   	unsigned long flags;
>>
>> -	spin_lock_irqsave(&vblk->lock, flags);
>> +	spin_lock_irqsave(vblk->disk->queue->queue_lock, flags);
>>   	while ((vbr = virtqueue_get_buf(vblk->vq,&len)) != NULL) {
>>   		int error;
>>
>> @@ -99,7 +97,7 @@ static void blk_done(struct virtqueue *vq)
>>   	}
>>   	/* In case queue is stopped waiting for more buffers. */
>>   	blk_start_queue(vblk->disk->queue);
>> -	spin_unlock_irqrestore(&vblk->lock, flags);
>> +	spin_unlock_irqrestore(vblk->disk->queue->queue_lock, flags);
>>   }
>>
>>   static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
>> @@ -456,7 +454,6 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>>   		goto out_free_index;
>>   	}
>>
>> -	spin_lock_init(&vblk->lock);
>>   	vblk->vdev = vdev;
>>   	vblk->sg_elems = sg_elems;
>>   	sg_init_table(vblk->sg, vblk->sg_elems);
>> @@ -481,7 +478,7 @@ static int __devinit virtblk_probe(struct virtio_device *vdev)
>>   		goto out_mempool;
>>   	}
>>
>> -	q = vblk->disk->queue = blk_init_queue(do_virtblk_request,&vblk->lock);
>> +	q = vblk->disk->queue = blk_init_queue(do_virtblk_request, NULL);
>>   	if (!q) {
>>   		err = -ENOMEM;
>>   		goto out_put_disk;
>> --
>> 1.7.10.1


-- 
Asias
