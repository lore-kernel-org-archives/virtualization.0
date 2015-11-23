From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Mon, 23 Nov 2015 00:17:47 -0800
Message-ID: <1448266667.18175.5.camel@hasee>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56506D95.70101@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2015-11-21 at 14:11 +0100, Paolo Bonzini wrote:
> 
> On 20/11/2015 01:20, Ming Lin wrote:
> > One improvment could be to use google's NVMe vendor extension that
> > I send in another thread, aslo here:
> > https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-google-ext
> > 
> > Qemu side:
> > http://www.minggr.net/cgit/cgit.cgi/qemu/log/?h=vhost-nvme.0
> > Kernel side also here:
> > https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=vhost-nvme.0
> 
> How much do you get with vhost-nvme plus vendor extension, compared to
> 190 MB/s for QEMU?

There is still some bug. I'll update.

> 
> Note that in all likelihood, QEMU can actually do better than 190 MB/s,
> and gain more parallelism too, by moving the processing of the
> ioeventfds to a separate thread.  This is similar to
> hw/block/dataplane/virtio-blk.c.
> 
> It's actually pretty easy to do.  Even though
> hw/block/dataplane/virtio-blk.c is still using some old APIs, all memory
> access in QEMU is now thread-safe.  I have pending patches for 2.6 that
> cut that file down to a mere 200 lines of code, NVMe would probably be
> about the same.

Is there a git tree for your patches?

Did you mean some pseduo code as below?
1. need a iothread for each cq/sq?
2. need a AioContext for each cq/sq?

 hw/block/nvme.c | 32 ++++++++++++++++++++++++++++++--
 hw/block/nvme.h |  8 ++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f27fd35..fed4827 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -28,6 +28,8 @@
 #include "sysemu/sysemu.h"
 #include "qapi/visitor.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/iothread.h"
+#include "qom/object_interfaces.h"
 
 #include "nvme.h"
 
@@ -558,9 +560,22 @@ static void nvme_init_cq_eventfd(NvmeCQueue *cq)
     uint16_t offset = (cq->cqid*2+1) * (4 << NVME_CAP_DSTRD(n->bar.cap));
 
     event_notifier_init(&cq->notifier, 0);
-    event_notifier_set_handler(&cq->notifier, nvme_cq_notifier);
     memory_region_add_eventfd(&n->iomem,
         0x1000 + offset, 4, false, 0, &cq->notifier);
+
+    object_initialize(&cq->internal_iothread_obj,
+                      sizeof(cq->internal_iothread_obj),
+                      TYPE_IOTHREAD);
+    user_creatable_complete(OBJECT(&cq->internal_iothread_obj), &error_abort);
+    cq->iothread = &cq->internal_iothread_obj;
+    cq->ctx = iothread_get_aio_context(cq->iothread);
+    //Question: Need a conf.blk for each cq/sq???
+    //blk_set_aio_context(cq->conf->conf.blk, cq->ctx);
+
+    aio_context_acquire(cq->ctx);
+    aio_set_event_notifier(cq->ctx, &cq->notifier, true,
+                           nvme_cq_notifier);
+    aio_context_release(cq->ctx);
 }
 
 static void nvme_sq_notifier(EventNotifier *e)
@@ -578,9 +593,22 @@ static void nvme_init_sq_eventfd(NvmeSQueue *sq)
     uint16_t offset = sq->sqid * 2 * (4 << NVME_CAP_DSTRD(n->bar.cap));
 
     event_notifier_init(&sq->notifier, 0);
-    event_notifier_set_handler(&sq->notifier, nvme_sq_notifier);
     memory_region_add_eventfd(&n->iomem,
         0x1000 + offset, 4, false, 0, &sq->notifier);
+
+    object_initialize(&sq->internal_iothread_obj,
+                      sizeof(sq->internal_iothread_obj),
+                      TYPE_IOTHREAD);
+    user_creatable_complete(OBJECT(&sq->internal_iothread_obj), &error_abort);
+    sq->iothread = &sq->internal_iothread_obj;
+    sq->ctx = iothread_get_aio_context(sq->iothread);
+    //Question: Need a conf.blk for each cq/sq???
+    //blk_set_aio_context(sq->conf->conf.blk, sq->ctx);
+
+    aio_context_acquire(sq->ctx);
+    aio_set_event_notifier(sq->ctx, &sq->notifier, true,
+                           nvme_sq_notifier);
+    aio_context_release(sq->ctx);
 }
 
 static uint16_t nvme_set_db_memory(NvmeCtrl *n, const NvmeCmd *cmd)
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 608f202..171ee0b 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -667,6 +667,10 @@ typedef struct NvmeSQueue {
      * do not go over this value will not result in MMIO writes (but will
      * still write the tail pointer to the "db_addr" location above). */
     uint64_t    eventidx_addr;
+
+    IOThread *iothread;
+    IOThread internal_iothread_obj;
+    AioContext *ctx;
     EventNotifier notifier;
 } NvmeSQueue;
 
@@ -690,6 +694,10 @@ typedef struct NvmeCQueue {
      * do not go over this value will not result in MMIO writes (but will
      * still write the head pointer to the "db_addr" location above). */
     uint64_t    eventidx_addr;
+
+    IOThread *iothread;
+    IOThread internal_iothread_obj;
+    AioContext *ctx;
     EventNotifier notifier;
 } NvmeCQueue;
 

> 
> Paolo
