From: Ming Lin <mlin@kernel.org>
Subject: Re: [RFC PATCH 0/9] vhost-nvme: new qemu nvme backend using nvme
	target
Date: Tue, 24 Nov 2015 00:23:53 -0800
Message-ID: <1448353433.6696.4.camel@hasee>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
	<56506D95.70101@redhat.com> <1448266667.18175.5.camel@hasee>
	<56531F5F.3050709@redhat.com> <1448350074.6696.3.camel@hasee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1448350074.6696.3.camel@hasee>
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
Cc: qemu-devel@nongnu.org, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2015-11-23 at 23:27 -0800, Ming Lin wrote:
> On Mon, 2015-11-23 at 15:14 +0100, Paolo Bonzini wrote:
> > 
> > On 23/11/2015 09:17, Ming Lin wrote:
> > > On Sat, 2015-11-21 at 14:11 +0100, Paolo Bonzini wrote:
> > >>
> > >> On 20/11/2015 01:20, Ming Lin wrote:
> > >>> One improvment could be to use google's NVMe vendor extension that
> > >>> I send in another thread, aslo here:
> > >>> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=nvme-google-ext
> > >>>
> > >>> Qemu side:
> > >>> http://www.minggr.net/cgit/cgit.cgi/qemu/log/?h=vhost-nvme.0
> > >>> Kernel side also here:
> > >>> https://git.kernel.org/cgit/linux/kernel/git/mlin/linux.git/log/?h=vhost-nvme.0
> > >>
> > >> How much do you get with vhost-nvme plus vendor extension, compared to
> > >> 190 MB/s for QEMU?
> > > 
> > > There is still some bug. I'll update.
> > 
> > Sure.
> > 
> > >> Note that in all likelihood, QEMU can actually do better than 190 MB/s,
> > >> and gain more parallelism too, by moving the processing of the
> > >> ioeventfds to a separate thread.  This is similar to
> > >> hw/block/dataplane/virtio-blk.c.
> > >>
> > >> It's actually pretty easy to do.  Even though
> > >> hw/block/dataplane/virtio-blk.c is still using some old APIs, all memory
> > >> access in QEMU is now thread-safe.  I have pending patches for 2.6 that
> > >> cut that file down to a mere 200 lines of code, NVMe would probably be
> > >> about the same.
> > > 
> > > Is there a git tree for your patches?
> > 
> > No, not yet.  I'll post them today or tomorrow, will make sure to Cc you.
> > 
> > > Did you mean some pseduo code as below?
> > > 1. need a iothread for each cq/sq?
> > > 2. need a AioContext for each cq/sq?
> > > 
> > >  hw/block/nvme.c | 32 ++++++++++++++++++++++++++++++--
> > >  hw/block/nvme.h |  8 ++++++++
> > >  2 files changed, 38 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index f27fd35..fed4827 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -28,6 +28,8 @@
> > >  #include "sysemu/sysemu.h"
> > >  #include "qapi/visitor.h"
> > >  #include "sysemu/block-backend.h"
> > > +#include "sysemu/iothread.h"
> > > +#include "qom/object_interfaces.h"
> > >  
> > >  #include "nvme.h"
> > >  
> > > @@ -558,9 +560,22 @@ static void nvme_init_cq_eventfd(NvmeCQueue *cq)
> > >      uint16_t offset = (cq->cqid*2+1) * (4 << NVME_CAP_DSTRD(n->bar.cap));
> > >  
> > >      event_notifier_init(&cq->notifier, 0);
> > > -    event_notifier_set_handler(&cq->notifier, nvme_cq_notifier);
> > >      memory_region_add_eventfd(&n->iomem,
> > >          0x1000 + offset, 4, false, 0, &cq->notifier);
> > > +
> > > +    object_initialize(&cq->internal_iothread_obj,
> > > +                      sizeof(cq->internal_iothread_obj),
> > > +                      TYPE_IOTHREAD);
> > > +    user_creatable_complete(OBJECT(&cq->internal_iothread_obj), &error_abort);
> > 
> > For now, you have to use one iothread for all cq/sq of a single NVMe
> > device; multiqueue block layer is planned for 2.7 or 2.8.  Otherwise
> > yes, it's very close to just these changes.
> 
> Here is the call stack of iothread for virtio-blk-dataplane.
> 
> handle_notify (qemu/hw/block/dataplane/virtio-blk.c:126)
> aio_dispatch (qemu/aio-posix.c:329)
> aio_poll (qemu/aio-posix.c:474)
> iothread_run (qemu/iothread.c:45)
> start_thread (pthread_create.c:312)
> /lib/x86_64-linux-gnu/libc.so.6(clone+0x6d)
> 
> I think I'll have a "nvme_dev_notify" similar as "handle_notify"
> 
> static void nvme_dev_notify(EventNotifier *e)
> {
>     ....
> }
> 
> But then how can I know this notify is for cq or sq?

Did you mean patch as below?
But it doesn't work yet.

 hw/block/nvme.c | 64 +++++++++++++++++++++++++++++++++++++++------------------
 hw/block/nvme.h |  5 +++++
 2 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f27fd35..a8c9914 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -28,6 +28,8 @@
 #include "sysemu/sysemu.h"
 #include "qapi/visitor.h"
 #include "sysemu/block-backend.h"
+#include "sysemu/iothread.h"
+#include "qom/object_interfaces.h"
 
 #include "nvme.h"
 
@@ -543,42 +545,22 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
-static void nvme_cq_notifier(EventNotifier *e)
-{
-    NvmeCQueue *cq =
-        container_of(e, NvmeCQueue, notifier);
-
-    event_notifier_test_and_clear(&cq->notifier);
-    nvme_post_cqes(cq);
-}
-
 static void nvme_init_cq_eventfd(NvmeCQueue *cq)
 {
     NvmeCtrl *n = cq->ctrl;
     uint16_t offset = (cq->cqid*2+1) * (4 << NVME_CAP_DSTRD(n->bar.cap));
 
     event_notifier_init(&cq->notifier, 0);
-    event_notifier_set_handler(&cq->notifier, nvme_cq_notifier);
     memory_region_add_eventfd(&n->iomem,
         0x1000 + offset, 4, false, 0, &cq->notifier);
 }
 
-static void nvme_sq_notifier(EventNotifier *e)
-{
-    NvmeSQueue *sq =
-        container_of(e, NvmeSQueue, notifier);
-
-    event_notifier_test_and_clear(&sq->notifier);
-    nvme_process_sq(sq);
-}
-
 static void nvme_init_sq_eventfd(NvmeSQueue *sq)
 {
     NvmeCtrl *n = sq->ctrl;
     uint16_t offset = sq->sqid * 2 * (4 << NVME_CAP_DSTRD(n->bar.cap));
 
     event_notifier_init(&sq->notifier, 0);
-    event_notifier_set_handler(&sq->notifier, nvme_sq_notifier);
     memory_region_add_eventfd(&n->iomem,
         0x1000 + offset, 4, false, 0, &sq->notifier);
 }
@@ -900,6 +882,45 @@ static const MemoryRegionOps nvme_mmio_ops = {
     },
 };
 
+static void nvme_dev_notify(EventNotifier *e)
+{
+    NvmeCtrl *n =
+        container_of(e, NvmeCtrl, notifier);
+    int i;
+
+    event_notifier_test_and_clear(e);
+
+    for (i = 1; i < n->num_queues; i++) {
+        NvmeSQueue *sq = n->sq[i];
+        NvmeCQueue *cq = n->cq[i];
+
+        if (sq != NULL) {
+            event_notifier_test_and_clear(&sq->notifier);
+            nvme_process_sq(sq);
+        }
+
+        if (cq != NULL) {
+            event_notifier_test_and_clear(&cq->notifier);
+            nvme_post_cqes(cq);
+        }
+    }
+}
+
+static void nvme_init_iothread(NvmeCtrl *n)
+{
+    object_initialize(&n->internal_iothread_obj,
+                      sizeof(n->internal_iothread_obj),
+                      TYPE_IOTHREAD);
+    user_creatable_complete(OBJECT(&n->internal_iothread_obj), &error_abort);
+    n->iothread = &n->internal_iothread_obj;
+    n->ctx = iothread_get_aio_context(n->iothread);
+
+    aio_context_acquire(n->ctx);
+    aio_set_event_notifier(n->ctx, &n->notifier, true,
+                           nvme_dev_notify);
+    aio_context_release(n->ctx);
+}
+
 static int nvme_init(PCIDevice *pci_dev)
 {
     NvmeCtrl *n = NVME(pci_dev);
@@ -995,6 +1016,9 @@ static int nvme_init(PCIDevice *pci_dev)
             cpu_to_le64(n->ns_size >>
                 id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
     }
+
+    nvme_init_iothread(n);
+
     return 0;
 }
 
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 608f202..089af35 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -727,6 +727,11 @@ typedef struct NvmeCtrl {
     NvmeSQueue      admin_sq;
     NvmeCQueue      admin_cq;
     NvmeIdCtrl      id_ctrl;
+
+    IOThread *iothread;
+    IOThread internal_iothread_obj;
+    AioContext *ctx;
+    EventNotifier notifier;
 } NvmeCtrl;
 
 #endif /* HW_NVME_H */
