From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH] cpu hotplug driver: userspace back end
Date: Wed,  9 Jan 2008 08:21:06 -0200
Message-ID: <11998740781209-git-send-email-gcosta__20071.8667977073$1199874508$gmane$org@redhat.com>
References: <11998740663306-git-send-email-gcosta@redhat.com>
	<11998740731943-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11998740731943-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: virtualization@lists.linux-foundation.org, marcelot@redhat.com, anthony@codemonkey.ws, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 qemu/Makefile.target     |    2 +-
 qemu/hw/pc.c             |    4 +-
 qemu/hw/pc.h             |    3 +
 qemu/hw/virtio-hotplug.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++
 qemu/monitor.c           |   11 +++++
 qemu/qemu-kvm.h          |    2 +
 6 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 qemu/hw/virtio-hotplug.c

diff --git a/qemu/Makefile.target b/qemu/Makefile.target
index bb7be0f..4d5679a 100644
--- a/qemu/Makefile.target
+++ b/qemu/Makefile.target
@@ -464,7 +464,7 @@ VL_OBJS += rtl8139.o
 VL_OBJS+= hypercall.o
 
 # virtio devices
-VL_OBJS += virtio.o virtio-net.o virtio-blk.o
+VL_OBJS += virtio.o virtio-net.o virtio-blk.o virtio-hotplug.o
 
 ifeq ($(TARGET_BASE_ARCH), i386)
 # Hardware support
diff --git a/qemu/hw/pc.c b/qemu/hw/pc.c
index 3972ab4..c9d8f89 100644
--- a/qemu/hw/pc.c
+++ b/qemu/hw/pc.c
@@ -1029,7 +1029,9 @@ static void pc_init1(ram_addr_t ram_size, int vga_ram_size,
         }
     }
 
-#define USE_HYPERCALL
+    virtio_hotplug_init(pci_bus);
+
+#undef USE_HYPERCALL
 #ifdef USE_HYPERCALL
     pci_hypercall_init(pci_bus);
 #endif
diff --git a/qemu/hw/pc.h b/qemu/hw/pc.h
index 7d1832f..3e2cfb4 100644
--- a/qemu/hw/pc.h
+++ b/qemu/hw/pc.h
@@ -151,6 +151,9 @@ void virtio_net_poll(void);
 void *virtio_blk_init(PCIBus *bus, uint16_t vendor, uint16_t device,
 		      BlockDriverState *bs);
 
+/* virtio-hotplug.c */
+void *virtio_hotplug_init(PCIBus *bus);
+
 /* extboot.c */
 
 void extboot_init(BlockDriverState *bs, int cmd);
diff --git a/qemu/hw/virtio-hotplug.c b/qemu/hw/virtio-hotplug.c
new file mode 100644
index 0000000..e51f26f
--- /dev/null
+++ b/qemu/hw/virtio-hotplug.c
@@ -0,0 +1,111 @@
+#include "virtio.h"
+#include "net.h"
+#include "pc.h"
+#include "sysemu.h"
+
+typedef struct VirtIOHotplug {
+    VirtIODevice vdev;
+    VirtQueue *cmd_vq;
+    int buffer_ready;
+    struct VirtIOHotplug *next;
+    int job_status;
+} VirtIOHotplug;
+
+typedef struct VirtioHotplugHdr {
+    uint8_t cmd;
+    uint8_t status;
+} VirtioHotplugHdr;
+
+VirtIOHotplug *virtio_hotplug;
+uint32_t attempt_buffer;
+
+#define VIRTIO_ID_HOTPLUG 4 /* arbitrary */
+
+#define CMD_CPU_SET 1
+
+static VirtIOHotplug *to_virtio_hotplug(VirtIODevice *vdev)
+{
+    return (VirtIOHotplug *)vdev;
+}
+
+static void virtio_hotplug_update_config(VirtIODevice *vdev, uint8_t *config)
+{
+    /* nothing to do */
+}
+
+static uint32_t virtio_hotplug_get_features(VirtIODevice *vdev)
+{
+    /* no features yet */
+    return 0;
+}
+
+static void virtio_hotplug_send(VirtIODevice *vdev, VirtQueue *vq, uint8_t cmd,
+    			const uint32_t arg)
+{
+    VirtQueueElement elem;
+    VirtioHotplugHdr *hdr;
+    uint32_t *data;
+
+    if (virtqueue_pop(vq, &elem) == 0) {
+        fprintf(stderr, "pop failure\n"); 
+        return;
+    }
+    
+    hdr = (void *)elem.in_sg[0].iov_base;
+    hdr->cmd = cmd;
+    
+    data = (int *)elem.in_sg[1].iov_base;
+    *data = arg;
+     
+    virtqueue_push(vq, &elem, sizeof(*hdr) + elem.in_sg[1].iov_len);
+    virtio_notify(vdev, vq);
+}
+
+int hotplug_send_cmd(int value)
+{
+   
+    if (!virtio_hotplug->buffer_ready) {
+        attempt_buffer = value;
+        return;
+    }
+
+    virtio_hotplug_send(&virtio_hotplug->vdev, virtio_hotplug->cmd_vq, 
+                        CMD_CPU_SET, value);
+
+    return 0;
+}
+
+/* TX */
+static void virtio_hotplug_handle_cmd(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOHotplug *n = to_virtio_hotplug(vdev);
+
+    n->buffer_ready = 1;
+
+    if (attempt_buffer) {
+        uint32_t value = attempt_buffer;
+        attempt_buffer = 0;
+        hotplug_send_cmd(value);
+    }
+
+}
+
+void *virtio_hotplug_init(PCIBus *bus)
+{
+    VirtIOHotplug *n;
+
+    n = (VirtIOHotplug *)virtio_init_pci(bus, "virtio-hotplug", 0x2523, 0x2325,
+    			     0, VIRTIO_ID_HOTPLUG,
+    			     0xff, 0x80, 0x00,
+    			     6, sizeof(VirtIOHotplug));
+
+    n->vdev.update_config = virtio_hotplug_update_config;
+    n->vdev.get_features = virtio_hotplug_get_features;
+    n->cmd_vq = virtio_add_queue(&n->vdev, 128, virtio_hotplug_handle_cmd);
+
+    n->buffer_ready = 0;
+
+    virtio_hotplug = n;
+        
+    return &n->vdev;
+}
diff --git a/qemu/monitor.c b/qemu/monitor.c
index e03c473..f0c55c6 100644
--- a/qemu/monitor.c
+++ b/qemu/monitor.c
@@ -346,6 +346,16 @@ static void do_cpu_set(int index)
         term_printf("Invalid CPU index\n");
 }
 
+static void do_cpu_set_nr(int value)
+{
+    if ((value < 1)) {
+       term_printf("value out of range\n");
+       return;
+    }
+
+    hotplug_send_cmd(value);
+}
+
 static void do_info_jit(void)
 {
     dump_exec_info(NULL, monitor_fprintf);
@@ -1339,6 +1349,7 @@ static term_cmd_t term_cmds[] = {
       "", "cancel the current VM migration" },
     { "migrate_set_speed", "s", do_migrate_set_speed,
       "value", "set maximum speed (in bytes) for migrations" },
+    { "cpu_set", "i", do_cpu_set_nr, "value", "number of cpus in the guest" },
     { NULL, NULL, },
 };
 
diff --git a/qemu/qemu-kvm.h b/qemu/qemu-kvm.h
index e4aeb3a..6bf234d 100644
--- a/qemu/qemu-kvm.h
+++ b/qemu/qemu-kvm.h
@@ -48,6 +48,8 @@ void kvm_tpr_access_report(CPUState *env, uint64_t rip, int is_write);
 int handle_tpr_access(void *opaque, int vcpu,
 			     uint64_t rip, int is_write);
 
+int hotplug_send_smd(int cpus);
+
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
 #define BITMAP_SIZE(m) (ALIGN(((m)>>TARGET_PAGE_BITS), HOST_LONG_BITS) / 8)
 
-- 
1.5.0.6
