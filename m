From: "Guillaume Missonnier" <guillaume.missonnier@atos.net>
Subject: [PATCH] vhost: Move vhost.h to allow vhost driver out-of-tree
	compilation
Date: Tue, 7 Mar 2017 10:47:05 +0100
Message-ID: <20170307094646.GA29530@centos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Move vhost.h to include/linux to allow vhost driver out-of-tree compilation.
Currently, this cannot be done properly because the vhost header file is in
driver/vhost.

To distribute a new vhost driver before it is included in the kernel tree,
we need to package it using kmod, dkms, ..., and to compile it out-of-tree
using headers provided by the distribution's kernel development package.

Signed-off-by: Guillaume Missonnier <guillaume.missonnier@atos.net>
---
 MAINTAINERS                |   1 +
 drivers/vhost/net.c        |   2 -
 drivers/vhost/scsi.c       |   2 -
 drivers/vhost/test.c       |   1 -
 drivers/vhost/vhost.c      |   2 -
 drivers/vhost/vhost.h      | 292 --------------------------------------------
 drivers/vhost/vsock.c      |   1 -
 include/linux/vhost.h      | 293 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h |   4 +-
 9 files changed, 296 insertions(+), 302 deletions(-)
 delete mode 100644 drivers/vhost/vhost.h
 create mode 100644 include/linux/vhost.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 527d137..0788737 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13113,6 +13113,7 @@ L:	netdev@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
 S:	Maintained
 F:	drivers/vhost/
+F:	include/linux/vhost.h
 F:	include/uapi/linux/vhost.h
 
 VIRTIO INPUT DRIVER
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 5dc3465..5de59ad 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -28,8 +28,6 @@
 
 #include <net/sock.h>
 
-#include "vhost.h"
-
 static int experimental_zcopytx = 1;
 module_param(experimental_zcopytx, int, 0444);
 MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index fd6c8b6..5b41456 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -48,8 +48,6 @@
 #include <linux/bitmap.h>
 #include <linux/percpu_ida.h>
 
-#include "vhost.h"
-
 #define VHOST_SCSI_VERSION  "v0.1"
 #define VHOST_SCSI_NAMELEN 256
 #define VHOST_SCSI_MAX_CDB_SIZE 32
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 3cc98c0..d515cbd 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 
 #include "test.h"
-#include "vhost.h"
 
 /* Max number of bytes transferred before requeueing the job.
  * Using this limit prevents one virtqueue from starving others. */
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 998bed5..d5c5f3c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -29,8 +29,6 @@
 #include <linux/sort.h>
 #include <linux/interval_tree_generic.h>
 
-#include "vhost.h"
-
 static ushort max_mem_regions = 64;
 module_param(max_mem_regions, ushort, 0444);
 MODULE_PARM_DESC(max_mem_regions,
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
deleted file mode 100644
index f55671d..0000000
--- a/drivers/vhost/vhost.h
+++ /dev/null
@@ -1,292 +0,0 @@
-#ifndef _VHOST_H
-#define _VHOST_H
-
-#include <linux/eventfd.h>
-#include <linux/vhost.h>
-#include <linux/mm.h>
-#include <linux/mutex.h>
-#include <linux/poll.h>
-#include <linux/file.h>
-#include <linux/uio.h>
-#include <linux/virtio_config.h>
-#include <linux/virtio_ring.h>
-#include <linux/atomic.h>
-
-struct vhost_work;
-typedef void (*vhost_work_fn_t)(struct vhost_work *work);
-
-#define VHOST_WORK_QUEUED 1
-struct vhost_work {
-	struct llist_node	  node;
-	vhost_work_fn_t		  fn;
-	wait_queue_head_t	  done;
-	int			  flushing;
-	unsigned		  queue_seq;
-	unsigned		  done_seq;
-	unsigned long		  flags;
-};
-
-/* Poll a file (eventfd or socket) */
-/* Note: there's nothing vhost specific about this structure. */
-struct vhost_poll {
-	poll_table                table;
-	wait_queue_head_t        *wqh;
-	wait_queue_t              wait;
-	struct vhost_work	  work;
-	unsigned long		  mask;
-	struct vhost_dev	 *dev;
-};
-
-void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
-void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
-bool vhost_has_work(struct vhost_dev *dev);
-
-void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     unsigned long mask, struct vhost_dev *dev);
-int vhost_poll_start(struct vhost_poll *poll, struct file *file);
-void vhost_poll_stop(struct vhost_poll *poll);
-void vhost_poll_flush(struct vhost_poll *poll);
-void vhost_poll_queue(struct vhost_poll *poll);
-void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work);
-long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
-
-struct vhost_log {
-	u64 addr;
-	u64 len;
-};
-
-#define START(node) ((node)->start)
-#define LAST(node) ((node)->last)
-
-struct vhost_umem_node {
-	struct rb_node rb;
-	struct list_head link;
-	__u64 start;
-	__u64 last;
-	__u64 size;
-	__u64 userspace_addr;
-	__u32 perm;
-	__u32 flags_padding;
-	__u64 __subtree_last;
-};
-
-struct vhost_umem {
-	struct rb_root umem_tree;
-	struct list_head umem_list;
-	int numem;
-};
-
-enum vhost_uaddr_type {
-	VHOST_ADDR_DESC = 0,
-	VHOST_ADDR_AVAIL = 1,
-	VHOST_ADDR_USED = 2,
-	VHOST_NUM_ADDRS = 3,
-};
-
-/* The virtqueue structure describes a queue attached to a device. */
-struct vhost_virtqueue {
-	struct vhost_dev *dev;
-
-	/* The actual ring of buffers. */
-	struct mutex mutex;
-	unsigned int num;
-	struct vring_desc __user *desc;
-	struct vring_avail __user *avail;
-	struct vring_used __user *used;
-	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
-	struct file *kick;
-	struct file *call;
-	struct file *error;
-	struct eventfd_ctx *call_ctx;
-	struct eventfd_ctx *error_ctx;
-	struct eventfd_ctx *log_ctx;
-
-	struct vhost_poll poll;
-
-	/* The routine to call when the Guest pings us, or timeout. */
-	vhost_work_fn_t handle_kick;
-
-	/* Last available index we saw. */
-	u16 last_avail_idx;
-
-	/* Caches available index value from user. */
-	u16 avail_idx;
-
-	/* Last index we used. */
-	u16 last_used_idx;
-
-	/* Last used evet we've seen */
-	u16 last_used_event;
-
-	/* Used flags */
-	u16 used_flags;
-
-	/* Last used index value we have signalled on */
-	u16 signalled_used;
-
-	/* Last used index value we have signalled on */
-	bool signalled_used_valid;
-
-	/* Log writes to used structure. */
-	bool log_used;
-	u64 log_addr;
-
-	struct iovec iov[UIO_MAXIOV];
-	struct iovec iotlb_iov[64];
-	struct iovec *indirect;
-	struct vring_used_elem *heads;
-	/* Protected by virtqueue mutex. */
-	struct vhost_umem *umem;
-	struct vhost_umem *iotlb;
-	void *private_data;
-	u64 acked_features;
-	/* Log write descriptors */
-	void __user *log_base;
-	struct vhost_log *log;
-
-	/* Ring endianness. Defaults to legacy native endianness.
-	 * Set to true when starting a modern virtio device. */
-	bool is_le;
-#ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
-	/* Ring endianness requested by userspace for cross-endian support. */
-	bool user_be;
-#endif
-	u32 busyloop_timeout;
-};
-
-struct vhost_msg_node {
-  struct vhost_msg msg;
-  struct vhost_virtqueue *vq;
-  struct list_head node;
-};
-
-struct vhost_dev {
-	struct mm_struct *mm;
-	struct mutex mutex;
-	struct vhost_virtqueue **vqs;
-	int nvqs;
-	struct file *log_file;
-	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
-	struct vhost_umem *umem;
-	struct vhost_umem *iotlb;
-	spinlock_t iotlb_lock;
-	struct list_head read_list;
-	struct list_head pending_list;
-	wait_queue_head_t wait;
-};
-
-void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs, int nvqs);
-long vhost_dev_set_owner(struct vhost_dev *dev);
-bool vhost_dev_has_owner(struct vhost_dev *dev);
-long vhost_dev_check_owner(struct vhost_dev *);
-struct vhost_umem *vhost_dev_reset_owner_prepare(void);
-void vhost_dev_reset_owner(struct vhost_dev *, struct vhost_umem *);
-void vhost_dev_cleanup(struct vhost_dev *, bool locked);
-void vhost_dev_stop(struct vhost_dev *);
-long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
-long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
-int vhost_vq_access_ok(struct vhost_virtqueue *vq);
-int vhost_log_access_ok(struct vhost_dev *);
-
-int vhost_get_vq_desc(struct vhost_virtqueue *,
-		      struct iovec iov[], unsigned int iov_count,
-		      unsigned int *out_num, unsigned int *in_num,
-		      struct vhost_log *log, unsigned int *log_num);
-void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
-
-int vhost_vq_init_access(struct vhost_virtqueue *);
-int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
-int vhost_add_used_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
-		     unsigned count);
-void vhost_add_used_and_signal(struct vhost_dev *, struct vhost_virtqueue *,
-			       unsigned int id, int len);
-void vhost_add_used_and_signal_n(struct vhost_dev *, struct vhost_virtqueue *,
-			       struct vring_used_elem *heads, unsigned count);
-void vhost_signal(struct vhost_dev *, struct vhost_virtqueue *);
-void vhost_disable_notify(struct vhost_dev *, struct vhost_virtqueue *);
-bool vhost_vq_avail_empty(struct vhost_dev *, struct vhost_virtqueue *);
-bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
-
-int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
-		    unsigned int log_num, u64 len);
-int vq_iotlb_prefetch(struct vhost_virtqueue *vq);
-
-struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type);
-void vhost_enqueue_msg(struct vhost_dev *dev,
-		       struct list_head *head,
-		       struct vhost_msg_node *node);
-struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
-					 struct list_head *head);
-unsigned int vhost_chr_poll(struct file *file, struct vhost_dev *dev,
-			    poll_table *wait);
-ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
-			    int noblock);
-ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
-			     struct iov_iter *from);
-int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled);
-
-#define vq_err(vq, fmt, ...) do {                                  \
-		pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
-		if ((vq)->error_ctx)                               \
-				eventfd_signal((vq)->error_ctx, 1);\
-	} while (0)
-
-enum {
-	VHOST_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
-			 (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
-			 (1ULL << VIRTIO_RING_F_EVENT_IDX) |
-			 (1ULL << VHOST_F_LOG_ALL) |
-			 (1ULL << VIRTIO_F_ANY_LAYOUT) |
-			 (1ULL << VIRTIO_F_VERSION_1)
-};
-
-static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
-{
-	return vq->acked_features & (1ULL << bit);
-}
-
-#ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
-static inline bool vhost_is_little_endian(struct vhost_virtqueue *vq)
-{
-	return vq->is_le;
-}
-#else
-static inline bool vhost_is_little_endian(struct vhost_virtqueue *vq)
-{
-	return virtio_legacy_is_little_endian() || vq->is_le;
-}
-#endif
-
-/* Memory accessors */
-static inline u16 vhost16_to_cpu(struct vhost_virtqueue *vq, __virtio16 val)
-{
-	return __virtio16_to_cpu(vhost_is_little_endian(vq), val);
-}
-
-static inline __virtio16 cpu_to_vhost16(struct vhost_virtqueue *vq, u16 val)
-{
-	return __cpu_to_virtio16(vhost_is_little_endian(vq), val);
-}
-
-static inline u32 vhost32_to_cpu(struct vhost_virtqueue *vq, __virtio32 val)
-{
-	return __virtio32_to_cpu(vhost_is_little_endian(vq), val);
-}
-
-static inline __virtio32 cpu_to_vhost32(struct vhost_virtqueue *vq, u32 val)
-{
-	return __cpu_to_virtio32(vhost_is_little_endian(vq), val);
-}
-
-static inline u64 vhost64_to_cpu(struct vhost_virtqueue *vq, __virtio64 val)
-{
-	return __virtio64_to_cpu(vhost_is_little_endian(vq), val);
-}
-
-static inline __virtio64 cpu_to_vhost64(struct vhost_virtqueue *vq, u64 val)
-{
-	return __cpu_to_virtio64(vhost_is_little_endian(vq), val);
-}
-#endif
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ce5e63d..f4c6fd8 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -17,7 +17,6 @@
 #include <linux/vhost.h>
 
 #include <net/af_vsock.h>
-#include "vhost.h"
 
 #define VHOST_VSOCK_DEFAULT_HOST_CID	2
 
diff --git a/include/linux/vhost.h b/include/linux/vhost.h
new file mode 100644
index 0000000..7168c40
--- /dev/null
+++ b/include/linux/vhost.h
@@ -0,0 +1,293 @@
+#ifndef _LINUX_VHOST_H
+#define _LINUX_VHOST_H
+
+#include <uapi/linux/vhost.h>
+
+#include <linux/eventfd.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/poll.h>
+#include <linux/file.h>
+#include <linux/uio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ring.h>
+#include <linux/atomic.h>
+
+struct vhost_work;
+typedef void (*vhost_work_fn_t)(struct vhost_work *work);
+
+#define VHOST_WORK_QUEUED 1
+struct vhost_work {
+	struct llist_node	  node;
+	vhost_work_fn_t		  fn;
+	wait_queue_head_t	  done;
+	int			  flushing;
+	unsigned		  queue_seq;
+	unsigned		  done_seq;
+	unsigned long		  flags;
+};
+
+/* Poll a file (eventfd or socket) */
+/* Note: there's nothing vhost specific about this structure. */
+struct vhost_poll {
+	poll_table                table;
+	wait_queue_head_t        *wqh;
+	wait_queue_t              wait;
+	struct vhost_work	  work;
+	unsigned long		  mask;
+	struct vhost_dev	 *dev;
+};
+
+void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
+void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
+bool vhost_has_work(struct vhost_dev *dev);
+
+void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
+		     unsigned long mask, struct vhost_dev *dev);
+int vhost_poll_start(struct vhost_poll *poll, struct file *file);
+void vhost_poll_stop(struct vhost_poll *poll);
+void vhost_poll_flush(struct vhost_poll *poll);
+void vhost_poll_queue(struct vhost_poll *poll);
+void vhost_work_flush(struct vhost_dev *dev, struct vhost_work *work);
+long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
+
+struct vhost_log {
+	u64 addr;
+	u64 len;
+};
+
+#define START(node) ((node)->start)
+#define LAST(node) ((node)->last)
+
+struct vhost_umem_node {
+	struct rb_node rb;
+	struct list_head link;
+	__u64 start;
+	__u64 last;
+	__u64 size;
+	__u64 userspace_addr;
+	__u32 perm;
+	__u32 flags_padding;
+	__u64 __subtree_last;
+};
+
+struct vhost_umem {
+	struct rb_root umem_tree;
+	struct list_head umem_list;
+	int numem;
+};
+
+enum vhost_uaddr_type {
+	VHOST_ADDR_DESC = 0,
+	VHOST_ADDR_AVAIL = 1,
+	VHOST_ADDR_USED = 2,
+	VHOST_NUM_ADDRS = 3,
+};
+
+/* The virtqueue structure describes a queue attached to a device. */
+struct vhost_virtqueue {
+	struct vhost_dev *dev;
+
+	/* The actual ring of buffers. */
+	struct mutex mutex;
+	unsigned int num;
+	struct vring_desc __user *desc;
+	struct vring_avail __user *avail;
+	struct vring_used __user *used;
+	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
+	struct file *kick;
+	struct file *call;
+	struct file *error;
+	struct eventfd_ctx *call_ctx;
+	struct eventfd_ctx *error_ctx;
+	struct eventfd_ctx *log_ctx;
+
+	struct vhost_poll poll;
+
+	/* The routine to call when the Guest pings us, or timeout. */
+	vhost_work_fn_t handle_kick;
+
+	/* Last available index we saw. */
+	u16 last_avail_idx;
+
+	/* Caches available index value from user. */
+	u16 avail_idx;
+
+	/* Last index we used. */
+	u16 last_used_idx;
+
+	/* Last used evet we've seen */
+	u16 last_used_event;
+
+	/* Used flags */
+	u16 used_flags;
+
+	/* Last used index value we have signalled on */
+	u16 signalled_used;
+
+	/* Last used index value we have signalled on */
+	bool signalled_used_valid;
+
+	/* Log writes to used structure. */
+	bool log_used;
+	u64 log_addr;
+
+	struct iovec iov[UIO_MAXIOV];
+	struct iovec iotlb_iov[64];
+	struct iovec *indirect;
+	struct vring_used_elem *heads;
+	/* Protected by virtqueue mutex. */
+	struct vhost_umem *umem;
+	struct vhost_umem *iotlb;
+	void *private_data;
+	u64 acked_features;
+	/* Log write descriptors */
+	void __user *log_base;
+	struct vhost_log *log;
+
+	/* Ring endianness. Defaults to legacy native endianness.
+	 * Set to true when starting a modern virtio device. */
+	bool is_le;
+#ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
+	/* Ring endianness requested by userspace for cross-endian support. */
+	bool user_be;
+#endif
+	u32 busyloop_timeout;
+};
+
+struct vhost_msg_node {
+  struct vhost_msg msg;
+  struct vhost_virtqueue *vq;
+  struct list_head node;
+};
+
+struct vhost_dev {
+	struct mm_struct *mm;
+	struct mutex mutex;
+	struct vhost_virtqueue **vqs;
+	int nvqs;
+	struct file *log_file;
+	struct eventfd_ctx *log_ctx;
+	struct llist_head work_list;
+	struct task_struct *worker;
+	struct vhost_umem *umem;
+	struct vhost_umem *iotlb;
+	spinlock_t iotlb_lock;
+	struct list_head read_list;
+	struct list_head pending_list;
+	wait_queue_head_t wait;
+};
+
+void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs, int nvqs);
+long vhost_dev_set_owner(struct vhost_dev *dev);
+bool vhost_dev_has_owner(struct vhost_dev *dev);
+long vhost_dev_check_owner(struct vhost_dev *);
+struct vhost_umem *vhost_dev_reset_owner_prepare(void);
+void vhost_dev_reset_owner(struct vhost_dev *, struct vhost_umem *);
+void vhost_dev_cleanup(struct vhost_dev *, bool locked);
+void vhost_dev_stop(struct vhost_dev *);
+long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
+long vhost_vring_ioctl(struct vhost_dev *d, int ioctl, void __user *argp);
+int vhost_vq_access_ok(struct vhost_virtqueue *vq);
+int vhost_log_access_ok(struct vhost_dev *);
+
+int vhost_get_vq_desc(struct vhost_virtqueue *,
+		      struct iovec iov[], unsigned int iov_count,
+		      unsigned int *out_num, unsigned int *in_num,
+		      struct vhost_log *log, unsigned int *log_num);
+void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
+
+int vhost_vq_init_access(struct vhost_virtqueue *);
+int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
+int vhost_add_used_n(struct vhost_virtqueue *, struct vring_used_elem *heads,
+		     unsigned count);
+void vhost_add_used_and_signal(struct vhost_dev *, struct vhost_virtqueue *,
+			       unsigned int id, int len);
+void vhost_add_used_and_signal_n(struct vhost_dev *, struct vhost_virtqueue *,
+			       struct vring_used_elem *heads, unsigned count);
+void vhost_signal(struct vhost_dev *, struct vhost_virtqueue *);
+void vhost_disable_notify(struct vhost_dev *, struct vhost_virtqueue *);
+bool vhost_vq_avail_empty(struct vhost_dev *, struct vhost_virtqueue *);
+bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
+
+int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
+		    unsigned int log_num, u64 len);
+int vq_iotlb_prefetch(struct vhost_virtqueue *vq);
+
+struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type);
+void vhost_enqueue_msg(struct vhost_dev *dev,
+		       struct list_head *head,
+		       struct vhost_msg_node *node);
+struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
+					 struct list_head *head);
+unsigned int vhost_chr_poll(struct file *file, struct vhost_dev *dev,
+			    poll_table *wait);
+ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
+			    int noblock);
+ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
+			     struct iov_iter *from);
+int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled);
+
+#define vq_err(vq, fmt, ...) do {                                  \
+		pr_debug(pr_fmt(fmt), ##__VA_ARGS__);       \
+		if ((vq)->error_ctx)                               \
+				eventfd_signal((vq)->error_ctx, 1);\
+	} while (0)
+
+enum {
+	VHOST_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
+			 (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
+			 (1ULL << VIRTIO_RING_F_EVENT_IDX) |
+			 (1ULL << VHOST_F_LOG_ALL) |
+			 (1ULL << VIRTIO_F_ANY_LAYOUT) |
+			 (1ULL << VIRTIO_F_VERSION_1)
+};
+
+static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
+{
+	return vq->acked_features & (1ULL << bit);
+}
+
+#ifdef CONFIG_VHOST_CROSS_ENDIAN_LEGACY
+static inline bool vhost_is_little_endian(struct vhost_virtqueue *vq)
+{
+	return vq->is_le;
+}
+#else
+static inline bool vhost_is_little_endian(struct vhost_virtqueue *vq)
+{
+	return virtio_legacy_is_little_endian() || vq->is_le;
+}
+#endif
+
+/* Memory accessors */
+static inline u16 vhost16_to_cpu(struct vhost_virtqueue *vq, __virtio16 val)
+{
+	return __virtio16_to_cpu(vhost_is_little_endian(vq), val);
+}
+
+static inline __virtio16 cpu_to_vhost16(struct vhost_virtqueue *vq, u16 val)
+{
+	return __cpu_to_virtio16(vhost_is_little_endian(vq), val);
+}
+
+static inline u32 vhost32_to_cpu(struct vhost_virtqueue *vq, __virtio32 val)
+{
+	return __virtio32_to_cpu(vhost_is_little_endian(vq), val);
+}
+
+static inline __virtio32 cpu_to_vhost32(struct vhost_virtqueue *vq, u32 val)
+{
+	return __cpu_to_virtio32(vhost_is_little_endian(vq), val);
+}
+
+static inline u64 vhost64_to_cpu(struct vhost_virtqueue *vq, __virtio64 val)
+{
+	return __virtio64_to_cpu(vhost_is_little_endian(vq), val);
+}
+
+static inline __virtio64 cpu_to_vhost64(struct vhost_virtqueue *vq, u64 val)
+{
+	return __cpu_to_virtio64(vhost_is_little_endian(vq), val);
+}
+#endif
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 60180c0..678a716 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -1,5 +1,5 @@
-#ifndef _LINUX_VHOST_H
-#define _LINUX_VHOST_H
+#ifndef _UAPI_LINUX_VHOST_H
+#define _UAPI_LINUX_VHOST_H
 /* Userspace interface for in-kernel virtio accelerators. */
 
 /* vhost is used to reduce the number of system calls involved in virtio.
-- 
1.8.3.1
