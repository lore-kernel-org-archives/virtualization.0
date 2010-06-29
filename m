From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Tue, 29 Jun 2010 08:08:29 +0100
Message-ID: <AANLkTikhPJnw81hhh3PQGSwv7Hkd56YMlOZQM0N-fTLp__47614.2010688365$1277795348$gmane$org@mail.gmail.com>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<20100628155505.GB4717@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100628155505.GB4717@amt.cnet>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 28, 2010 at 4:55 PM, Marcelo Tosatti <mtosatti@redhat.com> wrot=
e:
> On Wed, Jun 23, 2010 at 10:24:02PM +0100, Stefan Hajnoczi wrote:
>> The virtio block device holds a lock during I/O request processing.
>> Kicking the virtqueue while the lock is held results in long lock hold
>> times and increases contention for the lock.
>>
>> This patch modifies virtqueue_kick() to optionally release a lock while
>> notifying the host. =A0Virtio block is modified to pass in its lock. =A0=
This
>> allows other vcpus to queue I/O requests during the time spent servicing
>> the virtqueue notify in the host.
>>
>> The virtqueue_kick() function is modified to know about locking because
>> it changes the state of the virtqueue and should execute with the lock
>> held (it would not be correct for virtio block to release the lock
>> before calling virtqueue_kick()).
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
>> ---
>> I am not yet 100% happy with this patch which aims to reduce guest CPU
>> consumption related to vblk->lock contention. =A0Although this patch red=
uces
>> wait/hold times it does not affect I/O throughput or guest CPU utilizati=
on.
>> More investigation is required to get to the bottom of why guest CPU
>> utilization does not decrease when a lock bottleneck has been removed.
>>
>> Performance figures:
>>
>> Host: 2.6.34 upstream kernel, qemu-kvm-0.12.4 if=3Dvirtio,cache=3Dnone
>> Guest: 2.6.35-rc3-kvm.git upstream kernel
>> Storage: 12 disks as striped LVM volume
>> Benchmark: 4 concurrent dd bs=3D4k iflag=3Ddirect
>>
>> Lockstat data for &vblk->lock:
>>
>> test =A0 =A0 =A0 con-bounces contentions =A0waittime-min waittime-max wa=
ittime-total
>> unmodified 7097 =A0 =A0 =A0 =A07108 =A0 =A0 =A0 =A0 0.31 =A0 =A0 =A0 =A0=
 956.09 =A0 =A0 =A0 161165.4
>> patched =A0 =A011484 =A0 =A0 =A0 11550 =A0 =A0 =A0 =A00.30 =A0 =A0 =A0 =
=A0 411.80 =A0 =A0 =A0 50245.83
>>
>> The maximum wait time went down by 544.29 us (-57%) and the total wait t=
ime
>> decreased by 69%. =A0This shows that the virtqueue kick is indeed hoggin=
g the
>> lock.
>>
>> The patched version actually has higher contention than the unmodified v=
ersion.
>> I think the reason for this is that each virtqueue kick now includes a s=
hort
>> release and reacquire. =A0This short release gives other vcpus a chance =
to
>> acquire the lock and progress, hence more contention but overall better =
wait
>> time numbers.
>>
>> name =A0 =A0 =A0 acq-bounces acquisitions holdtime-min holdtime-max hold=
time-total
>> unmodified 10771 =A0 =A0 =A0 5038346 =A0 =A0 =A00.00 =A0 =A0 =A0 =A0 327=
1.81 =A0 =A0 =A059016905.47
>> patched =A0 =A031594 =A0 =A0 =A0 5857813 =A0 =A0 =A00.00 =A0 =A0 =A0 =A0=
 219.76 =A0 =A0 =A0 24104915.55
>>
>> Here we see the full impact of this patch: hold time reduced to 219.76 us
>> (-93%).
>>
>> Again the acquisitions have increased since we're now doing an extra
>> unlock+lock per virtqueue kick.
>>
>> Testing, ideas, and comments appreciated.
>>
>> =A0drivers/block/virtio_blk.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
>> =A0drivers/char/hw_random/virtio-rng.c | =A0 =A02 +-
>> =A0drivers/char/virtio_console.c =A0 =A0 =A0 | =A0 =A06 +++---
>> =A0drivers/net/virtio_net.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 +++---
>> =A0drivers/virtio/virtio_balloon.c =A0 =A0 | =A0 =A06 +++---
>> =A0drivers/virtio/virtio_ring.c =A0 =A0 =A0 =A0| =A0 13 +++++++++++--
>> =A0include/linux/virtio.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 ++-
>> =A0net/9p/trans_virtio.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A08 files changed, 25 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index 258bc2a..de033bf 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -187,7 +187,7 @@ static void do_virtblk_request(struct request_queue =
*q)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (issued)
>> - =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_kick(vblk->vq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_kick(vblk->vq, &vblk->lock);
>> =A0}
>>
>> =A0static void virtblk_prepare_flush(struct request_queue *q, struct req=
uest *req)
>> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_rando=
m/virtio-rng.c
>> index 75f1cbd..852d563 100644
>> --- a/drivers/char/hw_random/virtio-rng.c
>> +++ b/drivers/char/hw_random/virtio-rng.c
>> @@ -49,7 +49,7 @@ static void register_buffer(u8 *buf, size_t size)
>> =A0 =A0 =A0 if (virtqueue_add_buf(vq, &sg, 0, 1, buf) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>>
>> - =A0 =A0 virtqueue_kick(vq);
>> + =A0 =A0 virtqueue_kick(vq, NULL);
>> =A0}
>>
>> =A0static int virtio_read(struct hwrng *rng, void *buf, size_t size, boo=
l wait)
>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console=
.c
>> index 942a982..677714d 100644
>> --- a/drivers/char/virtio_console.c
>> +++ b/drivers/char/virtio_console.c
>> @@ -328,7 +328,7 @@ static int add_inbuf(struct virtqueue *vq, struct po=
rt_buffer *buf)
>> =A0 =A0 =A0 sg_init_one(sg, buf->buf, buf->size);
>>
>> =A0 =A0 =A0 ret =3D virtqueue_add_buf(vq, sg, 0, 1, buf);
>> - =A0 =A0 virtqueue_kick(vq);
>> + =A0 =A0 virtqueue_kick(vq, NULL);
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> @@ -400,7 +400,7 @@ static ssize_t __send_control_msg(struct ports_devic=
e *portdev, u32 port_id,
>>
>> =A0 =A0 =A0 sg_init_one(sg, &cpkt, sizeof(cpkt));
>> =A0 =A0 =A0 if (virtqueue_add_buf(vq, sg, 1, 0, &cpkt) >=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_kick(vq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_kick(vq, NULL);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!virtqueue_get_buf(vq, &len))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>> =A0 =A0 =A0 }
>> @@ -444,7 +444,7 @@ static ssize_t send_buf(struct port *port, void *in_=
buf, size_t in_count,
>> =A0 =A0 =A0 ret =3D virtqueue_add_buf(out_vq, sg, 1, 0, in_buf);
>>
>> =A0 =A0 =A0 /* Tell Host to go! */
>> - =A0 =A0 virtqueue_kick(out_vq);
>> + =A0 =A0 virtqueue_kick(out_vq, NULL);
>>
>> =A0 =A0 =A0 if (ret < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 in_count =3D 0;
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1edb7a6..6a837b3 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -433,7 +433,7 @@ static bool try_fill_recv(struct virtnet_info *vi, g=
fp_t gfp)
>> =A0 =A0 =A0 } while (err > 0);
>> =A0 =A0 =A0 if (unlikely(vi->num > vi->max))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 vi->max =3D vi->num;
>> - =A0 =A0 virtqueue_kick(vi->rvq);
>> + =A0 =A0 virtqueue_kick(vi->rvq, NULL);
>> =A0 =A0 =A0 return !oom;
>> =A0}
>>
>> @@ -581,7 +581,7 @@ again:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NETDEV_TX_BUSY;
>> =A0 =A0 =A0 }
>> - =A0 =A0 virtqueue_kick(vi->svq);
>> + =A0 =A0 virtqueue_kick(vi->svq, NULL);
>>
>> =A0 =A0 =A0 /* Don't wait up for transmitted skbs to be freed. */
>> =A0 =A0 =A0 skb_orphan(skb);
>> @@ -680,7 +680,7 @@ static bool virtnet_send_command(struct virtnet_info=
 *vi, u8 class, u8 cmd,
>>
>> =A0 =A0 =A0 BUG_ON(virtqueue_add_buf(vi->cvq, sg, out, in, vi) < 0);
>>
>> - =A0 =A0 virtqueue_kick(vi->cvq);
>> + =A0 =A0 virtqueue_kick(vi->cvq, NULL);
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Spin for a response, the kick causes an ioport write, t=
rapping
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_bal=
loon.c
>> index 0f1da45..c9c5c4a 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -91,7 +91,7 @@ static void tell_host(struct virtio_balloon *vb, struc=
t virtqueue *vq)
>> =A0 =A0 =A0 /* We should always be able to add one buffer to an empty qu=
eue. */
>> =A0 =A0 =A0 if (virtqueue_add_buf(vq, &sg, 1, 0, vb) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> - =A0 =A0 virtqueue_kick(vq);
>> + =A0 =A0 virtqueue_kick(vq, NULL);
>>
>> =A0 =A0 =A0 /* When host has read buffer, this completes via balloon_ack=
 */
>> =A0 =A0 =A0 wait_for_completion(&vb->acked);
>> @@ -223,7 +223,7 @@ static void stats_handle_request(struct virtio_ballo=
on *vb)
>> =A0 =A0 =A0 sg_init_one(&sg, vb->stats, sizeof(vb->stats));
>> =A0 =A0 =A0 if (virtqueue_add_buf(vq, &sg, 1, 0, vb) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> - =A0 =A0 virtqueue_kick(vq);
>> + =A0 =A0 virtqueue_kick(vq, NULL);
>> =A0}
>>
>> =A0static void virtballoon_changed(struct virtio_device *vdev)
>> @@ -316,7 +316,7 @@ static int virtballoon_probe(struct virtio_device *v=
dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_init_one(&sg, vb->stats, sizeof vb->stats=
);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (virtqueue_add_buf(vb->stats_vq, &sg, 1, =
0, vb) < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> - =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_kick(vb->stats_vq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_kick(vb->stats_vq, NULL);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 vb->thread =3D kthread_run(balloon, vb, "vballoon");
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 1ca8890..163a237 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -236,7 +236,7 @@ add_head:
>> =A0}
>> =A0EXPORT_SYMBOL_GPL(virtqueue_add_buf_gfp);
>>
>> -void virtqueue_kick(struct virtqueue *_vq)
>> +void virtqueue_kick(struct virtqueue *_vq, spinlock_t *lock)
>> =A0{
>> =A0 =A0 =A0 struct vring_virtqueue *vq =3D to_vvq(_vq);
>> =A0 =A0 =A0 START_USE(vq);
>> @@ -250,10 +250,19 @@ void virtqueue_kick(struct virtqueue *_vq)
>> =A0 =A0 =A0 /* Need to update avail index before checking if we should n=
otify */
>> =A0 =A0 =A0 virtio_mb();
>>
>> - =A0 =A0 if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY))
>> + =A0 =A0 if (!(vq->vring.used->flags & VRING_USED_F_NO_NOTIFY)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Release lock while doing the kick because t=
he guest should
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* not exit with the lock held. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(lock);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Prod other side to tell it about changes.=
 */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 vq->notify(&vq->vq);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(lock);
>> + =A0 =A0 }
>> +
>
> The queue lock requires irq's to be disabled in addition to lock
> acquision.

Irqs are already disabled by the block layer when acquiring the queue
lock.  During the virtqueue kick irqs stay disabled on the local CPU
but other CPUs may acquire the lock and make progress.

Is it incorrect to have the following pattern?
spin_lock_irqsave(q->queue_lock);
spin_unlock(q->queue_lock);
spin_lock(q->queue_lock);
spin_unlock_irqrestore(q->queue_lock);

Stefan
