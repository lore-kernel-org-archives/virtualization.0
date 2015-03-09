From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio fixes pull for 4.0?
Date: Mon, 09 Mar 2015 17:43:19 +1030
Message-ID: <87y4n6wsmo.fsf@rustcorp.com.au>
References: <20150307193049.GA32459@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150307193049.GA32459@redhat.com>
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
Cc: pawel.moll@arm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> Hi Rusty!
> There are a bunch of (mostly virtio 1.0 related) fixes for virtio
> that need to go into 4.0 I think.
> 	virtio_blk: typo fix
> 	virtio_blk: fix comment for virtio 1.0

OK, I've added these two.  I tend to be overcautious after the merge
window.

> 	virtio_console: init work unconditionally
> 	virtio_console: avoid config access from irq
> 	virtio_balloon: set DRIVER_OK before using device
>
> seem ready?

These are in my virtio-next tree already.  

> 	virtio_mmio: generation support
> 	virtio_mmio: fix endian-ness for mmio these two are waiting for ack by Pawel
>
> These two fix bugs in virtio 1.0 code for mmio.
> Host code for that was AFAIK not posted, so I can't test properly.
> Pawel?

I'm waiting on Acks for these two.

> 	virtio-balloon: do not call blocking ops when !TASK_RUNNING
>
> Rusty, it seems you prefer a different fix for this issue,
> while Cornelia prefers mine. Maybe both me and Cornelia misunderstand the
> issue? I know you dealt with a ton of similar issues recently
> so you are more likely to be right, but I'd like to understand
> what's going on better all the same. Could you help please?

In the longer run, we should handle failures from these callbacks.  But
we don't need to do that right now.  So we want the minimal fix.

And an annotation is the minimal fix.  The bug has been there for ages;
it's just the warning that is new (if we *always* slept, we would
spin, but in practice we'll rarely sleep).

> 	virtio_rpmsg: set DRIVER_OK before using device
>
> Just posted this, but seems pretty obvious.

Yep, I've applied this too.  Thanks!

> I think it's a good idea to merge these patches (maybe except the
> !TASK_RUNNING thing) sooner rather than later, to make sure people have
> the time to test the fixes properly.  Would you like me to pack up (some
> of them) them up and do a pull request?

I'm waiting a bit longer, since they seem to still be tricking in.

I'm still chasing a QEMU bug, where it seems to fill in a number too
large in the 'len' field for a block device.  It should be 1 byte for a
block device write, for example.  See patch which causes assert() in
qemu, but I had to stop at that point (should get back tomorrow I hope).

Thanks,
Rusty.

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 882a31b..98e99b8 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -243,16 +243,21 @@ int virtio_queue_empty(VirtQueue *vq)
 }
 
 void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
-                    unsigned int len, unsigned int idx)
+                    unsigned int len_written, unsigned int idx)
 {
-    unsigned int offset;
+    unsigned int offset, tot_wlen;
     int i;
 
-    trace_virtqueue_fill(vq, elem, len, idx);
+    trace_virtqueue_fill(vq, elem, len_written, idx);
+
+    for (tot_wlen = i = 0; i < elem->out_num; i++) {
+        tot_wlen += elem->out_sg[i].iov_len;
+    }
+    assert(len_written <= tot_wlen);
 
     offset = 0;
     for (i = 0; i < elem->in_num; i++) {
-        size_t size = MIN(len - offset, elem->in_sg[i].iov_len);
+        size_t size = MIN(len_written - offset, elem->in_sg[i].iov_len);
 
         cpu_physical_memory_unmap(elem->in_sg[i].iov_base,
                                   elem->in_sg[i].iov_len,
@@ -270,7 +275,7 @@ void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
 
     /* Get a pointer to the next entry in the used ring. */
     vring_used_ring_id(vq, idx, elem->index);
-    vring_used_ring_len(vq, idx, len);
+    vring_used_ring_len(vq, idx, len_written);
 }
 
 void virtqueue_flush(VirtQueue *vq, unsigned int count)
@@ -288,9 +293,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int count)
 }
 
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
-                    unsigned int len)
+                    unsigned int len_written)
 {
-    virtqueue_fill(vq, elem, len, 0);
+    virtqueue_fill(vq, elem, len_written, 0);
     virtqueue_flush(vq, 1);
 }
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index df09993..153374f 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -191,10 +191,10 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int queue_size,
 void virtio_del_queue(VirtIODevice *vdev, int n);
 
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
-                    unsigned int len);
+                    unsigned int len_written);
 void virtqueue_flush(VirtQueue *vq, unsigned int count);
 void virtqueue_fill(VirtQueue *vq, const VirtQueueElement *elem,
-                    unsigned int len, unsigned int idx);
+                    unsigned int len_written, unsigned int idx);
 
 void virtqueue_map_sg(struct iovec *sg, hwaddr *addr,
     size_t num_sg, int is_write);
