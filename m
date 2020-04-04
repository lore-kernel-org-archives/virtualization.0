From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] kernel: move use_mm/unuse_mm to kthread.c
Date: Sat,  4 Apr 2020 11:40:59 +0200
Message-ID: <20200404094101.672954-5-hch@lst.de>
References: <20200404094101.672954-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <20200404094101.672954-1-hch@lst.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Felipe Balbi <balbi@kernel.org>, amd-gfx@lists.freedesktop.org, "Michael S. Tsirkin" <mst@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, linux-usb@vger.kernel.org, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, intel-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, intel-gvt-dev@lists.freedesktop.org, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

These helpers are only for use with kernel threads, and I will tie them
more into the kthread infrastructure going forward.  Also move the
prototypes to kthread.h - mmu_context.h was a little weird to start with
as it otherwise contains very low-level MM bits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  1 -
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  2 -
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  2 -
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 -
 drivers/gpu/drm/i915/gvt/kvmgt.c              |  2 +-
 drivers/usb/gadget/function/f_fs.c            |  2 +-
 drivers/usb/gadget/legacy/inode.c             |  2 +-
 drivers/vhost/vhost.c                         |  1 -
 fs/aio.c                                      |  1 -
 fs/io-wq.c                                    |  1 -
 fs/io_uring.c                                 |  1 -
 include/linux/kthread.h                       |  5 ++
 include/linux/mmu_context.h                   |  5 --
 kernel/kthread.c                              | 56 ++++++++++++++++
 mm/Makefile                                   |  2 +-
 mm/mmu_context.c                              | 64 -------------------
 18 files changed, 66 insertions(+), 85 deletions(-)
 delete mode 100644 mm/mmu_context.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4db143c19dcc..bce5e93fefc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -27,6 +27,7 @@
 
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/kthread.h>
 #include <linux/workqueue.h>
 #include <kgd_kfd_interface.h>
 #include <drm/ttm/ttm_execbuf_util.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 6529caca88fe..35d4a5ab0228 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/fdtable.h>
 #include <linux/uaccess.h>
-#include <linux/mmu_context.h>
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 4ec6d0c03201..b1655054b919 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -19,7 +19,6 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-#include <linux/mmu_context.h>
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "gc/gc_10_1_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 0b7e78748540..7d01420c0c85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -20,8 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <linux/mmu_context.h>
-
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "cikd.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index ccd635b812b5..635cd1a26bed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -20,8 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <linux/mmu_context.h>
-
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "gfx_v8_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2ac5e7..c7fd0c47b254 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -19,8 +19,6 @@
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  */
-#include <linux/mmu_context.h>
-
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "gc/gc_9_0_offset.h"
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 5848400620b4..dee01c371bf5 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -31,7 +31,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/mm.h>
-#include <linux/mmu_context.h>
+#include <linux/kthread.h>
 #include <linux/sched/mm.h>
 #include <linux/types.h>
 #include <linux/list.h>
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index c81023b195c3..c57b1b2507c6 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -32,7 +32,7 @@
 #include <linux/usb/functionfs.h>
 
 #include <linux/aio.h>
-#include <linux/mmu_context.h>
+#include <linux/kthread.h>
 #include <linux/poll.h>
 #include <linux/eventfd.h>
 
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index aa0de9e35afa..8b5233888bf8 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -21,7 +21,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
-#include <linux/mmu_context.h>
+#include <linux/kthread.h>
 #include <linux/aio.h>
 #include <linux/uio.h>
 #include <linux/refcount.h>
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index f44340b41494..4e9ce54869af 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -14,7 +14,6 @@
 #include <linux/vhost.h>
 #include <linux/uio.h>
 #include <linux/mm.h>
-#include <linux/mmu_context.h>
 #include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/poll.h>
diff --git a/fs/aio.c b/fs/aio.c
index 5f3d3d814928..328829f0343b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -27,7 +27,6 @@
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
-#include <linux/mmu_context.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
diff --git a/fs/io-wq.c b/fs/io-wq.c
index cc5cf2209fb0..c49c2bdbafb5 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -10,7 +10,6 @@
 #include <linux/errno.h>
 #include <linux/sched/signal.h>
 #include <linux/mm.h>
-#include <linux/mmu_context.h>
 #include <linux/sched/mm.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 358f97be9c7b..27a4ecb724ca 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -55,7 +55,6 @@
 #include <linux/fdtable.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
-#include <linux/mmu_context.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8bbcaad7ef0f..c2d40c9672d6 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -5,6 +5,8 @@
 #include <linux/err.h>
 #include <linux/sched.h>
 
+struct mm_struct;
+
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 					   void *data,
@@ -198,6 +200,9 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
+void use_mm(struct mm_struct *mm);
+void unuse_mm(struct mm_struct *mm);
+
 struct cgroup_subsys_state;
 
 #ifdef CONFIG_BLK_CGROUP
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index d9a543a9e1cc..c51a84132d7c 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -4,11 +4,6 @@
 
 #include <asm/mmu_context.h>
 
-struct mm_struct;
-
-void use_mm(struct mm_struct *mm);
-void unuse_mm(struct mm_struct *mm);
-
 /* Architectures that care about IRQ state in switch_mm can override this. */
 #ifndef switch_mm_irqs_off
 # define switch_mm_irqs_off switch_mm
diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..ce4610316377 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1,13 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Kernel thread helper functions.
  *   Copyright (C) 2004 IBM Corporation, Rusty Russell.
+ *   Copyright (C) 2009 Red Hat, Inc.
  *
  * Creation is done via kthreadd, so that we get a clean environment
  * even if we're invoked from userspace (think modprobe, hotplug cpu,
  * etc.).
  */
 #include <uapi/linux/sched/types.h>
+#include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/kthread.h>
 #include <linux/completion.h>
@@ -25,6 +29,7 @@
 #include <linux/numa.h>
 #include <trace/events/sched.h>
 
+
 static DEFINE_SPINLOCK(kthread_create_lock);
 static LIST_HEAD(kthread_create_list);
 struct task_struct *kthreadd_task;
@@ -1203,6 +1208,57 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
 
+/*
+ * use_mm
+ *	Makes the calling kernel thread take on the specified
+ *	mm context.
+ *	(Note: this routine is intended to be called only
+ *	from a kernel thread context)
+ */
+void use_mm(struct mm_struct *mm)
+{
+	struct mm_struct *active_mm;
+	struct task_struct *tsk = current;
+
+	task_lock(tsk);
+	active_mm = tsk->active_mm;
+	if (active_mm != mm) {
+		mmgrab(mm);
+		tsk->active_mm = mm;
+	}
+	tsk->mm = mm;
+	switch_mm(active_mm, mm, tsk);
+	task_unlock(tsk);
+#ifdef finish_arch_post_lock_switch
+	finish_arch_post_lock_switch();
+#endif
+
+	if (active_mm != mm)
+		mmdrop(active_mm);
+}
+EXPORT_SYMBOL_GPL(use_mm);
+
+/*
+ * unuse_mm
+ *	Reverses the effect of use_mm, i.e. releases the
+ *	specified mm context which was earlier taken on
+ *	by the calling kernel thread
+ *	(Note: this routine is intended to be called only
+ *	from a kernel thread context)
+ */
+void unuse_mm(struct mm_struct *mm)
+{
+	struct task_struct *tsk = current;
+
+	task_lock(tsk);
+	sync_mm_rss(mm);
+	tsk->mm = NULL;
+	/* active_mm is still 'mm' */
+	enter_lazy_tlb(mm, tsk);
+	task_unlock(tsk);
+}
+EXPORT_SYMBOL_GPL(unuse_mm);
+
 #ifdef CONFIG_BLK_CGROUP
 /**
  * kthread_associate_blkcg - associate blkcg to current kthread
diff --git a/mm/Makefile b/mm/Makefile
index dbc8346d16ca..0af4ee81aed2 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -41,7 +41,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   maccess.o page-writeback.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
-			   mm_init.o mmu_context.o percpu.o slab_common.o \
+			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o $(mmu-y)
diff --git a/mm/mmu_context.c b/mm/mmu_context.c
deleted file mode 100644
index 3e612ae748e9..000000000000
--- a/mm/mmu_context.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/* Copyright (C) 2009 Red Hat, Inc.
- *
- * See ../COPYING for licensing terms.
- */
-
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/sched/mm.h>
-#include <linux/sched/task.h>
-#include <linux/mmu_context.h>
-#include <linux/export.h>
-
-#include <asm/mmu_context.h>
-
-/*
- * use_mm
- *	Makes the calling kernel thread take on the specified
- *	mm context.
- *	(Note: this routine is intended to be called only
- *	from a kernel thread context)
- */
-void use_mm(struct mm_struct *mm)
-{
-	struct mm_struct *active_mm;
-	struct task_struct *tsk = current;
-
-	task_lock(tsk);
-	active_mm = tsk->active_mm;
-	if (active_mm != mm) {
-		mmgrab(mm);
-		tsk->active_mm = mm;
-	}
-	tsk->mm = mm;
-	switch_mm(active_mm, mm, tsk);
-	task_unlock(tsk);
-#ifdef finish_arch_post_lock_switch
-	finish_arch_post_lock_switch();
-#endif
-
-	if (active_mm != mm)
-		mmdrop(active_mm);
-}
-EXPORT_SYMBOL_GPL(use_mm);
-
-/*
- * unuse_mm
- *	Reverses the effect of use_mm, i.e. releases the
- *	specified mm context which was earlier taken on
- *	by the calling kernel thread
- *	(Note: this routine is intended to be called only
- *	from a kernel thread context)
- */
-void unuse_mm(struct mm_struct *mm)
-{
-	struct task_struct *tsk = current;
-
-	task_lock(tsk);
-	sync_mm_rss(mm);
-	tsk->mm = NULL;
-	/* active_mm is still 'mm' */
-	enter_lazy_tlb(mm, tsk);
-	task_unlock(tsk);
-}
-EXPORT_SYMBOL_GPL(unuse_mm);
-- 
2.25.1
