From: =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
Subject: Re: [PATCH] virtio_ring: Use workqueue to execute virtqueue
 callback
Date: Wed, 15 Jan 2020 14:56:40 +0100 (CET)
Message-ID: <1473755958.12366773.1579096600598.JavaMail.zimbra@kalray.eu>
References: <20200115120535.17454-1-cleger@kalray.eu> <20200115084601-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200115084601-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



----- On 15 Jan, 2020, at 14:49, Michael S. Tsirkin mst@redhat.com wrote:

> On Wed, Jan 15, 2020 at 01:05:35PM +0100, Clement Leger wrote:
>> Currently, in vring_interrupt, the vq callbacks are called directly.
>> However, these callbacks are not meant to be executed in IRQ context.
>> They do not return any irq_return_t value and some of them can do
>> locking (rpmsg_recv_done -> rpmsg_recv_single -> mutex_lock).
> 
> That's a bug in rpmsg. Pls fix there.

Ok.

> 
>> When compiled with DEBUG_ATOMIC_SLEEP, the kernel will spit out warnings
>> when such case shappen.
>> 
>> In order to allow calling these callbacks safely (without sleeping in
>> IRQ context), execute them in a workqueue if needed.
>> 
>> Signed-off-by: Clement Leger <cleger@kalray.eu>
> 
> If applied this would slow data path handling of VQ events
> significantly. Teaching callbacks to return irqreturn_t
> might be a good idea, though it's not an insignificant
> amount of work.

Yes, I was expecting that it would slow down VQ event handling.
I was not completely sure of the criticality of that.

Thanks for your answer.

> 
> 
>> ---
>>  drivers/virtio/virtio_ring.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 867c7ebd3f10..0e4d0e5ca227 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -183,6 +183,9 @@ struct vring_virtqueue {
>>  	/* DMA, allocation, and size information */
>>  	bool we_own_ring;
>>  
>> +	/* Work struct for vq callback handling */
>> +	struct work_struct work;
>> +
>>  #ifdef DEBUG
>>  	/* They're supposed to lock for us. */
>>  	unsigned int in_use;
>> @@ -2029,6 +2032,16 @@ static inline bool more_used(const struct vring_virtqueue
>> *vq)
>>  	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>>  }
>>  
>> +static void vring_work_handler(struct work_struct *work_struct)
>> +{
>> +	struct vring_virtqueue *vq = container_of(work_struct,
>> +						  struct vring_virtqueue,
>> +						  work);
>> +	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>> +
>> +	vq->vq.callback(&vq->vq);
>> +}
>> +
>>  irqreturn_t vring_interrupt(int irq, void *_vq)
>>  {
>>  	struct vring_virtqueue *vq = to_vvq(_vq);
>> @@ -2041,9 +2054,8 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>>  	if (unlikely(vq->broken))
>>  		return IRQ_HANDLED;
>>  
>> -	pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback);
>>  	if (vq->vq.callback)
>> -		vq->vq.callback(&vq->vq);
>> +		schedule_work(&vq->work);
>>  
>>  	return IRQ_HANDLED;
>>  }
>> @@ -2110,6 +2122,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int
>> index,
>>  					vq->split.avail_flags_shadow);
>>  	}
>>  
>> +	INIT_WORK(&vq->work, vring_work_handler);
>> +
>>  	vq->split.desc_state = kmalloc_array(vring.num,
>>  			sizeof(struct vring_desc_state_split), GFP_KERNEL);
>>  	if (!vq->split.desc_state) {
>> @@ -2179,6 +2193,8 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>>  {
>>  	struct vring_virtqueue *vq = to_vvq(_vq);
>>  
>> +	cancel_work_sync(&vq->work);
>> +
>>  	if (vq->we_own_ring) {
>>  		if (vq->packed_ring) {
>>  			vring_free_queue(vq->vq.vdev,
>> --
> > 2.15.0.276.g89ea799
