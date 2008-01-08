From: Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] QEMU KVM balloon support
Date: Tue, 8 Jan 2008 13:43:40 -0200
Message-ID: <20080108154340.GC21726__2096.1927286864$1199824455$gmane$org@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org


Add QEMU support for the KVM balloon driver.

Memory hinting is performed via madvise().

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: kvm-userspace/libkvm/libkvm.c
===================================================================
--- kvm-userspace.orig/libkvm/libkvm.c
+++ kvm-userspace/libkvm/libkvm.c
@@ -886,6 +886,17 @@ int kvm_is_ready_for_interrupt_injection
 	return run->ready_for_interrupt_injection;
 }
 
+int kvm_sync_shadow_with_user(kvm_context_t kvm)
+{
+        int r = 0;
+#ifdef KVM_CAP_SYNC_SHADOW_WITH_USER
+        r = ioctl(kvm->fd, KVM_CHECK_EXTENSION, KVM_CAP_SYNC_SHADOW_WITH_USER);
+        if (r > 0)
+		r = ioctl(kvm->vm_fd, KVM_SYNC_SHADOW_WITH_USER);
+#endif
+	return r;
+}
+
 int kvm_run(kvm_context_t kvm, int vcpu)
 {
 	int r;
Index: kvm-userspace/libkvm/libkvm.h
===================================================================
--- kvm-userspace.orig/libkvm/libkvm.h
+++ kvm-userspace/libkvm/libkvm.h
@@ -423,6 +423,8 @@ int kvm_get_dirty_pages_range(kvm_contex
 			      int (*cb)(unsigned long start, unsigned long len,
 					void*bitmap, void *opaque));
 
+int kvm_sync_shadow_with_user(kvm_context_t kvm);
+
 /*!
  * \brief Create a memory alias
  *
Index: kvm-userspace/qemu/Makefile.target
===================================================================
--- kvm-userspace.orig/qemu/Makefile.target
+++ kvm-userspace/qemu/Makefile.target
@@ -464,7 +464,7 @@ VL_OBJS += rtl8139.o
 VL_OBJS+= hypercall.o
 
 # virtio devices
-VL_OBJS += virtio.o virtio-net.o virtio-blk.o
+VL_OBJS += virtio.o virtio-net.o virtio-blk.o virtio-balloon.o
 
 ifeq ($(TARGET_BASE_ARCH), i386)
 # Hardware support
Index: kvm-userspace/qemu/hw/pc.c
===================================================================
--- kvm-userspace.orig/qemu/hw/pc.c
+++ kvm-userspace/qemu/hw/pc.c
@@ -1029,6 +1029,8 @@ static void pc_init1(ram_addr_t ram_size
         }
     }
 
+    virtio_balloon_init(pci_bus);
+
 #define USE_HYPERCALL
 #ifdef USE_HYPERCALL
     pci_hypercall_init(pci_bus);
Index: kvm-userspace/qemu/hw/pc.h
===================================================================
--- kvm-userspace.orig/qemu/hw/pc.h
+++ kvm-userspace/qemu/hw/pc.h
@@ -155,4 +155,7 @@ void *virtio_blk_init(PCIBus *bus, uint1
 
 void extboot_init(BlockDriverState *bs, int cmd);
 
+/* virtio-balloon.c */
+void *virtio_balloon_init(PCIBus *bus);
+
 #endif
Index: kvm-userspace/qemu/hw/virtio-balloon.c
===================================================================
--- /dev/null
+++ kvm-userspace/qemu/hw/virtio-balloon.c
@@ -0,0 +1,103 @@
+#include "virtio.h"
+#include "pc.h"
+
+typedef struct VirtIOBalloon
+{
+    VirtIODevice vdev;
+} VirtIOBalloon;
+
+struct virtio_balloon_hdr 
+{
+	uint8_t cmd;
+	uint8_t status;
+};
+
+struct virtio_balloon_config
+{
+	uint32_t target_nrpages;
+};
+
+VirtIOBalloon *virtio_balloon;
+
+extern int64_t ram_size;
+int64_t target_ramsize;
+
+#define VIRTIO_ID_BALLOON 3
+
+#define CMD_BALLOON_INFLATE 0x1
+#define CMD_BALLOON_DEFLATE 0x2
+
+static VirtIOBalloon *to_virtio_balloon(VirtIODevice *vdev)
+{
+	return (VirtIOBalloon *)vdev;
+}
+
+static void virtio_balloon_queue(VirtIODevice *vdev, VirtQueue *vq)
+{
+	VirtIOBalloon *n = to_virtio_balloon(vdev);
+	VirtQueueElement elem;
+
+	while (virtqueue_pop(vq, &elem)) { 
+		int i, r;
+		size_t len = 0;
+		struct virtio_balloon_hdr *hdr;
+		void *data;
+
+		hdr = (void *)elem.in_sg[0].iov_base;
+		switch(hdr->cmd) {
+			case CMD_BALLOON_INFLATE:
+			case CMD_BALLOON_DEFLATE:
+				data = elem.in_sg[1].iov_base;
+				len = elem.in_sg[1].iov_len;
+
+				r = kvm_handle_ballooning_call(data, len);
+				hdr->status = (uint8_t) r; 
+				break;
+			default:
+				fprintf(stderr, "unknown command %x\n",
+						hdr->cmd);
+				hdr->status = 1;
+		}
+		len += sizeof(struct virtio_balloon_hdr);
+		virtqueue_push(vq, &elem, len);
+		virtio_notify(vdev, vq);
+	}
+}
+
+static void virtio_balloon_update_config(VirtIODevice *vdev, uint8_t *config)
+{
+	struct virtio_balloon_config cfg;
+
+	cfg.target_nrpages = target_ramsize / TARGET_PAGE_SIZE;
+
+	memcpy(config, &cfg, sizeof(cfg));
+}
+
+void *virtio_balloon_init(PCIBus *bus)
+{
+	VirtIOBalloon *n;
+
+	/* XXX: pif=0x80? */
+	n = (VirtIOBalloon *)virtio_init_pci(bus, "virtio-kvm-balloon", 0x1AF4,
+					     0x1003, 0, VIRTIO_ID_BALLOON,
+					     0xff, 0x80, 0x00, 4, 
+					     sizeof(VirtIOBalloon));
+	
+	virtio_add_queue(&n->vdev, 128, virtio_balloon_queue);
+	n->vdev.update_config = virtio_balloon_update_config;
+	target_ramsize = ram_size;
+	virtio_balloon = n;
+
+	return &n->vdev;
+}
+
+int balloon_update_target(int64_t target)
+{
+	VirtIODevice *vdev = &virtio_balloon->vdev;
+	target_ramsize = target;
+
+	vdev->update_config(vdev, vdev->config);
+	qemu_set_irq(vdev->pci_dev.irq[0], 1);
+
+	return 1;
+}
Index: kvm-userspace/qemu/migration.c
===================================================================
--- kvm-userspace.orig/qemu/migration.c
+++ kvm-userspace/qemu/migration.c
@@ -34,6 +34,7 @@
 #endif
 
 #include <sys/wait.h>
+#include <sys/mman.h>
 
 #define MIN_FINALIZE_SIZE	(200 << 10)
 #define MAX_ITERATIONS           30
@@ -765,6 +766,9 @@ static void migrate_incoming_homogeneous
 
     for (i=0; i<n; i++)
         p[i] = v;
+
+    if (v == 0)
+        madvise(phys_ram_base + addr, TARGET_PAGE_SIZE, MADV_DONTNEED);
 }
 
 static int migrate_incoming_page(QEMUFile *f, uint32_t addr)
Index: kvm-userspace/qemu/monitor.c
===================================================================
--- kvm-userspace.orig/qemu/monitor.c
+++ kvm-userspace/qemu/monitor.c
@@ -1339,6 +1339,8 @@ static term_cmd_t term_cmds[] = {
       "", "cancel the current VM migration" },
     { "migrate_set_speed", "s", do_migrate_set_speed,
       "value", "set maximum speed (in bytes) for migrations" },
+    { "setmem", "s", do_setmemory, "value", 
+      "set memory for the guest (in bytes)" },
     { NULL, NULL, },
 };
 
Index: kvm-userspace/qemu/qemu-kvm.c
===================================================================
--- kvm-userspace.orig/qemu/qemu-kvm.c
+++ kvm-userspace/qemu/qemu-kvm.c
@@ -21,6 +21,7 @@ int kvm_irqchip = 1;
 #include <libkvm.h>
 #include <pthread.h>
 #include <sys/utsname.h>
+#include <sys/mman.h>
 
 extern void perror(const char *s);
 
@@ -513,7 +514,74 @@ static int kvm_shutdown(void *opaque, in
     qemu_system_reset_request();
     return 1;
 }
- 
+
+static int do_balloon_on_page(unsigned int gfn, int is_inflate)
+{
+    unsigned long addr = gfn * TARGET_PAGE_SIZE;
+    unsigned char *curr_addr = phys_ram_base + addr;
+    int r;
+    int advice = is_inflate ? MADV_DONTNEED : MADV_NORMAL;
+    
+    r = madvise(curr_addr, TARGET_PAGE_SIZE, advice);
+
+    if (r < 0) {
+        perror("madvise");
+        fprintf(stderr, "%s: gfn=0x%x is_inflate=%d mlock/madvise: failed\n",
+                __FUNCTION__, gfn, is_inflate);
+    }
+    return r;
+}
+
+int kvm_handle_ballooning_call(void *data, size_t len)
+{
+    unsigned int gfn;
+    unsigned int *curr_pfn;
+    int is_inflate;
+    int req_npages, npages;
+    int i, r = 0, saved_r = 0;
+
+    curr_pfn = data;
+
+    req_npages = (int)*curr_pfn++;
+
+    npages = abs(req_npages);
+    is_inflate = (req_npages > 0);
+    
+    if (is_inflate)
+         kvm_sync_shadow_with_user(kvm_context);
+
+    for (i = 0; i < npages; i++, curr_pfn++) {
+        gfn = *curr_pfn;
+
+        r = do_balloon_on_page(gfn, is_inflate);
+        if (r) {
+            printf("do_balloon_on_page FAILED, gfn=0x%x, is_inflate=%d\n",
+                   gfn, is_inflate);
+            goto out_failed;
+        }
+    }
+
+    return r;
+
+out_failed:
+    npages = i;
+    curr_pfn = data;
+    curr_pfn++;
+    saved_r = r;
+
+    for (i = 0; i<npages; i++, curr_pfn++) {
+        gfn = *curr_pfn;
+
+        r = do_balloon_on_page(gfn, !is_inflate);
+        if (r) {
+             printf("do_balloon_on_page EH FAILED, gfn=0x%x, is_inflate=%d\n",
+                    gfn, !is_inflate);
+             return r;
+        }
+    }
+    return saved_r;
+}
+
 static struct kvm_callbacks qemu_kvm_ops = {
     .debug = kvm_debug,
     .inb   = kvm_inb,
@@ -546,6 +614,31 @@ int kvm_qemu_init()
     return 0;
 }
 
+void do_setmemory(const char *value)
+{
+	int target_ramsize;
+	char *ptr;
+
+	target_ramsize = strtol(value, &ptr, 10);
+	switch (*ptr) {
+	case 'G': case 'g':
+		target_ramsize *= 1024;
+	case 'M': case 'm':
+		target_ramsize *= 1024;
+	case 'K': case 'k':
+		target_ramsize *= 1024;
+	default:
+		break;
+	}
+
+	if (target_ramsize > ram_size) {
+		term_printf("Invalid RAM size, maximum: %d\n", ram_size);
+		return;
+	}
+	
+	balloon_update_target(target_ramsize);
+}
+
 int kvm_qemu_create_context(void)
 {
     int r;
Index: kvm-userspace/qemu/qemu-kvm.h
===================================================================
--- kvm-userspace.orig/qemu/qemu-kvm.h
+++ kvm-userspace/qemu/qemu-kvm.h
@@ -39,6 +39,9 @@ void kvm_arch_post_kvm_run(void *opaque,
 int kvm_arch_has_work(CPUState *env);
 int kvm_arch_try_push_interrupts(void *opaque);
 void kvm_arch_update_regs_for_sipi(CPUState *env);
+int kvm_handle_ballooning_call(void *data, size_t len);
+
+void do_setmemory(const char *value);
 
 extern int kvm_allowed;
 extern int kvm_irqchip;
Index: kvm-userspace/qemu/vl.c
===================================================================
--- kvm-userspace.orig/qemu/vl.c
+++ kvm-userspace/qemu/vl.c
@@ -7216,6 +7216,30 @@ static void ram_decompress_close(RamDeco
     inflateEnd(&s->zstream);
 }
 
+#ifdef USE_KVM
+extern int64_t target_ramsize; /* qemu/hw/virtio-balloon.c */
+static void balloon_save(QEMUFile *f, void *opaque)
+{
+    qemu_put_be64(f, target_ramsize);
+}
+
+static int balloon_load(QEMUFile *f, void *opaque, int version_id)
+{
+    int64_t target;
+
+    if (version_id != 1)
+        return -EINVAL;
+
+    target = qemu_get_be64(f);
+    if (!target)
+        return -EINVAL;
+
+    balloon_update_target(target);
+
+    return 0;
+}
+#endif
+
 static void ram_save_live(QEMUFile *f, void *opaque)
 {
     target_ulong addr;
@@ -9378,6 +9402,9 @@ int main(int argc, char **argv)
 
     register_savevm("timer", 0, 2, timer_save, timer_load, NULL);
     register_savevm("ram", 0, 3, ram_save, ram_load, NULL);
+    if (kvm_allowed)
+        register_savevm("balloon", 0, 1, balloon_save, balloon_load, NULL);
+
 
     init_ioports();
