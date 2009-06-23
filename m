From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio-serial: virtio device for simple host <-> guest
	communication
Date: Tue, 23 Jun 2009 18:12:33 +0530
Message-ID: <1245760953-32139-3-git-send-email-amit.shah__24950.9663125083$1245761094$gmane$org@redhat.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
	<1245760953-32139-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245760953-32139-2-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This interface presents a char device from which bits can be
sent and read.

Sample uses for such a device can be obtaining info from the
guest like the file systems used, apps installed, etc. for
offline usage and logged-in users, clipboard copy-paste, etc.
for online usage.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 Makefile.target    |    2 +-
 hw/pc.c            |   17 +++
 hw/pci.h           |    1 +
 hw/qdev.c          |    6 +-
 hw/virtio-pci.c    |   15 +++
 hw/virtio-serial.c |  354 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio-serial.h |   39 ++++++
 hw/virtio.h        |    1 +
 monitor.c          |    9 ++
 qemu-monitor.hx    |    7 +
 qemu-options.hx    |    8 ++
 sysemu.h           |   11 ++
 vl.c               |   63 +++++++++
 13 files changed, 531 insertions(+), 2 deletions(-)
 create mode 100644 hw/virtio-serial.c
 create mode 100644 hw/virtio-serial.h

diff --git a/Makefile.target b/Makefile.target
index 08121a9..7a0deb3 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -550,7 +550,7 @@ OBJS=vl.o osdep.o monitor.o pci.o loader.o isa_mmio.o machine.o \
      gdbstub.o gdbstub-xml.o
 # virtio has to be here due to weird dependency between PCI and virtio-net.
 # need to fix this properly
-OBJS+=virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o
+OBJS+=virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o virtio-serial.o
 ifdef CONFIG_KVM
 OBJS+=kvm.o kvm-all.o
 endif
diff --git a/hw/pc.c b/hw/pc.c
index cb5b4d0..6ccf4b8 100644
--- a/hw/pc.c
+++ b/hw/pc.c
@@ -40,6 +40,8 @@
 
 #include "qemu-kvm.h"
 
+void *virtio_serial_new_port(PCIDevice *dev, int idx, char *name);
+
 /* output Bochs bios info messages */
 //#define DEBUG_BIOS
 
@@ -1204,6 +1206,21 @@ static void pc_init1(ram_addr_t ram_size,
         }
     }
 
+    /* Add virtio serial devices */
+    if (pci_enabled && virtio_serial_index) {
+        void *dev;
+
+        dev = pci_create_simple(pci_bus, -1, "virtio-serial-pci");
+        if (!dev) {
+            fprintf(stderr, "qemu: could not create virtio serial pci device\n");
+            exit(1);
+        }
+
+        for (i = 0; i < virtio_serial_index; i++) {
+                virtio_serial_new_port(dev, i, virtio_serial_names[i]);
+        }
+    }
+
 #ifdef USE_KVM_DEVICE_ASSIGNMENT
     if (kvm_enabled()) {
         add_assigned_devices(pci_bus, assigned_devices, assigned_devices_index);
diff --git a/hw/pci.h b/hw/pci.h
index d835b6d..fe5f29e 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -72,6 +72,7 @@ extern target_phys_addr_t pci_mem_base;
 #define PCI_DEVICE_ID_VIRTIO_BLOCK       0x1001
 #define PCI_DEVICE_ID_VIRTIO_BALLOON     0x1002
 #define PCI_DEVICE_ID_VIRTIO_CONSOLE     0x1003
+#define PCI_DEVICE_ID_VIRTIO_SERIAL      0x1004
 
 typedef void PCIConfigWriteFunc(PCIDevice *pci_dev,
                                 uint32_t address, uint32_t data, int len);
diff --git a/hw/qdev.c b/hw/qdev.c
index 385e709..fe5bcd0 100644
--- a/hw/qdev.c
+++ b/hw/qdev.c
@@ -168,9 +168,13 @@ CharDriverState *qdev_init_chardev(DeviceState *dev)
 {
     static int next_serial;
     static int next_virtconsole;
+    static int next_virtserial;
+
     /* FIXME: This is a nasty hack that needs to go away.  */
-    if (strncmp(dev->type->info->name, "virtio", 6) == 0) {
+    if (strncmp(dev->type->info->name, "virtio-console", 14) == 0) {
         return virtcon_hds[next_virtconsole++];
+    } else if (strncmp(dev->type->info->name, "virtio-serial", 13) == 0) {
+        return virtio_serial_hds[next_virtserial++];
     } else {
         return serial_hds[next_serial++];
     }
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 24fe837..199f0c6 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -334,6 +334,19 @@ static void virtio_balloon_init_pci(PCIDevice *pci_dev)
                     0x00);
 }
 
+static void virtio_serial_init_pci(PCIDevice *pci_dev)
+{
+    VirtIOPCIProxy *proxy = DO_UPCAST(VirtIOPCIProxy, pci_dev, pci_dev);
+    VirtIODevice *vdev;
+
+    vdev = virtio_serial_init(&pci_dev->qdev);
+    virtio_init_pci(proxy, vdev,
+                    PCI_VENDOR_ID_REDHAT_QUMRANET,
+                    PCI_DEVICE_ID_VIRTIO_SERIAL,
+                    PCI_CLASS_COMMUNICATION_OTHER,
+                    0x00);
+}
+
 static void virtio_pci_register_devices(void)
 {
     pci_qdev_register("virtio-blk-pci", sizeof(VirtIOPCIProxy),
@@ -344,6 +357,8 @@ static void virtio_pci_register_devices(void)
                       virtio_console_init_pci);
     pci_qdev_register("virtio-balloon-pci", sizeof(VirtIOPCIProxy),
                       virtio_balloon_init_pci);
+    pci_qdev_register("virtio-serial-pci", sizeof(VirtIOPCIProxy),
+                      virtio_serial_init_pci);
 }
 
 device_init(virtio_pci_register_devices)
diff --git a/hw/virtio-serial.c b/hw/virtio-serial.c
new file mode 100644
index 0000000..5162316
--- /dev/null
+++ b/hw/virtio-serial.c
@@ -0,0 +1,354 @@
+/*
+ * Virtio serial interface
+ *
+ * This serial interface is a paravirtualised guest<->host
+ * communication channel for relaying short messages and events in
+ * either direction.
+ *
+ * There's support for multiple serial channels within one virtio PCI
+ * device to keep the guest PCI device count low.
+ *
+ * Copyright (C) 2009, Red Hat, Inc.
+ *
+ * Author(s): Amit Shah <amit.shah@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "hw.h"
+#include "pci.h"
+#include "monitor.h"
+#include "qemu-char.h"
+#include "virtio.h"
+#include "virtio-serial.h"
+#include "sysemu.h"
+
+typedef struct VirtIOSerial {
+    VirtIODevice *vdev;
+    VirtQueue *cvq;
+    VirtQueue *ivq, *ovq;
+    struct VirtIOSerialPort *ports;
+} VirtIOSerial;
+
+typedef struct VirtIOSerialPort {
+    VirtIOSerial *virtserial;
+    CharDriverState *hd;
+    char name[VIRTIO_SERIAL_NAME_MAX_LEN];
+} VirtIOSerialPort;
+
+typedef struct VirtIOSerialId {
+    uint32_t id; /* Port id */
+} VirtIOSerialId;
+
+VirtIOSerial virtio_serial;
+
+static VirtIOSerialPort *get_port_from_id(uint32_t id)
+{
+    if (id > virtio_serial_index)
+        return NULL;
+
+    return &virtio_serial.ports[id];
+}
+
+static char *get_port_name_from_id(uint32_t id)
+{
+    VirtIOSerialPort *port;
+
+    port = get_port_from_id(id);
+    if (port)
+        return port->name;
+    else
+        return NULL;
+}
+
+static int get_id_from_port(VirtIOSerialPort *port)
+{
+    uint32_t i;
+
+    for (i = 0; i < virtio_serial_index; i++) {
+        if (port == &virtio_serial.ports[i]) {
+            return i;
+        }
+    }
+    return VIRTIO_SERIAL_BAD_ID;
+}
+
+static void virtio_serial_handle_control(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement elem;
+
+    while (virtqueue_pop(vq, &elem)) {
+        int i;
+        char *name;
+        ssize_t len, strlen;
+        struct virtio_serial_control ser_control;
+
+        len = 0;
+        for (i = 0; i < elem.out_num; i++) {
+            memcpy(&ser_control, elem.out_sg[i].iov_base, sizeof(ser_control));
+
+            switch(ser_control.key) {
+            case VIRTIO_SERIAL_GET_PORT_NAME:
+                name = get_port_name_from_id(ser_control.port_nr);
+
+                strlen = strnlen(name, VIRTIO_SERIAL_NAME_MAX_LEN);
+
+                memcpy(elem.in_sg[0].iov_base, &ser_control,
+                       sizeof(ser_control));
+                memcpy(elem.in_sg[0].iov_base + sizeof(ser_control), name,
+                       strlen);
+
+                len = strlen + sizeof(ser_control);
+                break;
+            }
+        }
+        virtqueue_push(vq, &elem, len);
+    }
+    virtio_notify(vdev, vq);
+
+    return;
+}
+
+static void virtio_serial_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSerialPort *port;
+    VirtQueueElement elem;
+    VirtIOSerialId id;
+
+    while (virtqueue_pop(vq, &elem)) {
+        ssize_t len = 0;
+        int id_len = sizeof(id);
+        int i;
+
+        memcpy(&id, elem.out_sg[0].iov_base, id_len);
+        port = get_port_from_id(id.id);
+
+        if (port->hd) {
+            for (i = 0; i < elem.out_num; i++) {
+                len += qemu_chr_write(port->hd,
+                                      elem.out_sg[i].iov_base + id_len,
+                                      elem.out_sg[i].iov_len - id_len);
+                id_len = 0;
+            }
+        }
+        virtqueue_push(vq, &elem, len);
+    }
+    virtio_notify(vdev, vq);
+}
+
+static void virtio_serial_handle_input(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+
+/* FIXME: we just accept a single string */
+void virtio_serial_send_input(const char *command, const char *key,
+			      const char *value)
+{
+    VirtQueueElement elem;
+    VirtIOSerialPort *s = &virtio_serial.ports[0];
+    VirtIODevice *vdev = s->virtserial->vdev;
+    VirtQueue *vq = s->virtserial->ivq;
+    char buf[300];
+    ssize_t len;
+    int ret;
+    unsigned int i;
+
+    if (!virtio_queue_ready(vq)) {
+        goto queue_not_ready;
+    }
+
+    len = snprintf(buf, 299, "%s %s %s\n", command, key, value);
+
+    /* FIXME! actually handle this in a for loop */
+
+    ret = virtqueue_pop(vq, &elem);
+    if (!ret) {
+        goto queue_not_ready;
+    }
+
+    i = 0;
+    /* Note: We only have PAGE_SIZE sized buffers */
+    memcpy(elem.in_sg[i].iov_base, buf, len);
+    elem.in_sg[i].iov_len = len;
+
+    virtqueue_push(vq, &elem, len);
+    virtio_notify(vdev, vq);
+    return;
+
+queue_not_ready:
+    monitor_printf(cur_mon,
+                   "vmserial: No free virtio buffer found. Message not sent.\n");
+    return;
+}
+
+static int cons_can_read(void *opaque)
+{
+    VirtIOSerialPort *port = (VirtIOSerialPort *) opaque;
+    VirtQueue *vq = port->virtserial->ivq;
+    int size;
+
+    if (!virtio_queue_ready(vq)) {
+        return 0;
+    }
+
+    size = TARGET_PAGE_SIZE;
+    if (virtqueue_avail_bytes(vq, size, 0)) {
+        return size - sizeof(VirtIOSerialId);
+    }
+
+    size = sizeof(VirtIOSerialId) + 1;
+    if (virtqueue_avail_bytes(vq, size, 0)) {
+        return size - sizeof(VirtIOSerialId);
+    }
+    return 0;
+}
+
+static void cons_read(void *opaque, const uint8_t *buf, int size)
+{
+    VirtIOSerialPort *port = (VirtIOSerialPort *) opaque;
+    VirtQueue *vq = port->virtserial->ivq;
+    VirtQueueElement elem;
+    int offset = 0;
+
+    while (offset < size) {
+        VirtIOSerialId id;
+        int i, id_len;
+
+        id_len = sizeof(VirtIOSerialId);
+
+        if (!virtqueue_pop(vq, &elem)) {
+            break;
+        }
+        if (elem.in_sg[0].iov_len < id_len) {
+            /* We can't even store our port number in this buffer. Bug? */
+            fprintf(stderr, "virtio-serial: size %zd less than expected\n",
+                    elem.in_sg[0].iov_len);
+            exit(1);
+        }
+        id.id = cpu_to_le32(get_id_from_port(port));
+        memcpy(elem.in_sg[0].iov_base, &id, id_len);
+
+        for (i = 0; offset < size && i < elem.in_num; i++) {
+            int len = MIN(elem.in_sg[i].iov_len - id_len, size - offset);
+
+            memcpy(elem.in_sg[i].iov_base + id_len, buf + offset, len);
+            offset += len;
+            id_len = 0;
+        }
+        virtqueue_push(vq, &elem, size + sizeof(VirtIOSerialId));
+    }
+    virtio_notify(port->virtserial->vdev, vq);
+}
+
+static void cons_event(void *opaque, int event)
+{
+    /* we will ignore any event for the time being */
+}
+
+static uint32_t virtio_serial_get_features(VirtIODevice *vdev)
+{
+    return 0;
+}
+
+static void virtio_serial_get_config(VirtIODevice *vdev, uint8_t *config_data)
+{
+    struct virtio_serial_config config;
+
+    /* This might have to be updated for serial port hotplug */
+    config.nr_ports = virtio_serial_index;
+    config.status = 0;
+
+    memcpy(config_data, &config, sizeof(config));
+}
+
+static void virtio_serial_set_config(VirtIODevice *vdev,
+                                     const uint8_t *config_data)
+{
+    struct virtio_serial_config config;
+
+    memcpy(&config, config_data, sizeof(config));
+
+    /* Nothing to do as of now */
+}
+
+static void virtio_serial_save(QEMUFile *f, void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    virtio_save(vdev, f);
+}
+
+static int virtio_serial_load(QEMUFile *f, void *opaque, int version_id)
+{
+    VirtIODevice *vdev = opaque;
+
+    if (version_id != 1)
+        return -EINVAL;
+
+    virtio_load(vdev, f);
+    return 0;
+}
+
+void *virtio_serial_new_port(PCIDevice *dev, int idx, char *name)
+{
+    VirtIOSerialPort *port;
+
+    port = &virtio_serial.ports[idx];
+
+    port->virtserial = &virtio_serial;
+
+    memcpy(port->name, name, VIRTIO_SERIAL_NAME_MAX_LEN);
+
+    port->hd = qdev_init_chardev(&dev->qdev);
+    if (port->hd) {
+        qemu_chr_add_handlers(port->hd, cons_can_read, cons_read, cons_event,
+                              port);
+    }
+
+    /* Send an update to the guest about this new port added */
+    virtio_notify_config(port->virtserial->vdev);
+    return port;
+}
+
+VirtIODevice *virtio_serial_init(DeviceState *dev)
+{
+    VirtIODevice *vdev;
+    int nr_ports = 4;
+
+    vdev = virtio_common_init("virtio-serial",
+			      VIRTIO_ID_SERIAL,
+			      sizeof(struct virtio_serial_config),
+			      sizeof(VirtIODevice));
+    if (vdev == NULL)
+        return NULL;
+
+    virtio_serial.vdev = vdev;
+    vdev->get_config = virtio_serial_get_config;
+    vdev->set_config = virtio_serial_set_config;
+    vdev->get_features = virtio_serial_get_features;
+
+    /* Add a queue for control information transfer common to all
+     * serial ports
+     */
+    virtio_serial.cvq = virtio_add_queue(vdev, 2, virtio_serial_handle_control);
+
+    /* Add queue for host to guest transfers */
+    virtio_serial.ivq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
+                                         virtio_serial_handle_input);
+    /* Add queue for guest to host transfers */
+    virtio_serial.ovq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
+                                         virtio_serial_handle_output);
+
+
+    /* Allocate space for the number of serial ports specified on the
+     * command line
+     */
+    virtio_serial.ports = qemu_mallocz(sizeof(VirtIOSerialPort) * nr_ports);
+
+    register_savevm("virtio-serial", -1, 1, virtio_serial_save,
+                    virtio_serial_load, vdev);
+
+    return vdev;
+}
diff --git a/hw/virtio-serial.h b/hw/virtio-serial.h
new file mode 100644
index 0000000..abbfd0f
--- /dev/null
+++ b/hw/virtio-serial.h
@@ -0,0 +1,39 @@
+/*
+ * Virtio Serial Support
+ *
+ * Copyright (C) 2009, Red Hat, Inc.
+ *
+ * Author(s): Amit Shah <amit.shah@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+#ifndef _QEMU_VIRTIO_SERIAL_H
+#define _QEMU_VIRTIO_SERIAL_H
+
+/* The ID for virtio serial */
+#define VIRTIO_ID_SERIAL 7
+#define VIRTIO_SERIAL_BAD_ID		(~(uint32_t)0)
+
+struct virtio_serial_config
+{
+    uint32_t nr_ports;
+    uint16_t status;
+} __attribute__((packed));
+
+struct virtio_serial_control
+{
+    uint32_t port_nr;
+    uint32_t key;
+};
+
+/* Some defines for the control channel key */
+#define VIRTIO_SERIAL_GET_PORT_NAME 1
+
+
+void *virtio_serial_new_port(PCIDevice *dev, int idx, char *name);
+void virtio_serial_send_input(const char *command,
+			      const char *key, const char *value);
+
+#endif
diff --git a/hw/virtio.h b/hw/virtio.h
index 425727e..d2b50c3 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -151,5 +151,6 @@ VirtIODevice *virtio_blk_init(DeviceState *dev);
 VirtIODevice *virtio_net_init(DeviceState *dev);
 VirtIODevice *virtio_console_init(DeviceState *dev);
 VirtIODevice *virtio_balloon_init(DeviceState *dev);
+VirtIODevice *virtio_serial_init(DeviceState *dev);
 
 #endif
diff --git a/monitor.c b/monitor.c
index 8d5165c..7cb896e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -45,6 +45,7 @@
 #include "kvm.h"
 #include "acl.h"
 #include "exec-all.h"
+#include "hw/virtio-serial.h"
 
 #include "qemu-kvm.h"
 
@@ -1683,6 +1684,14 @@ static void do_acl(Monitor *mon,
     }
 }
 
+static void do_virtio_serial_action(Monitor *mon,
+                                    const char *command,
+                                    const char *key,
+                                    const char *value)
+{
+    virtio_serial_send_input(command, key, value);
+}
+
 static const mon_cmd_t mon_cmds[] = {
 #include "qemu-monitor.h"
     { NULL, NULL, },
diff --git a/qemu-monitor.hx b/qemu-monitor.hx
index dea0704..e1c3eb3 100644
--- a/qemu-monitor.hx
+++ b/qemu-monitor.hx
@@ -567,6 +567,13 @@ STEXI
 Change watchdog action.
 ETEXI
 
+    { "virtio-serial", "sss", do_virtio_serial_action,
+      "<command> <key> <value>\n", "virtio-serial write get clipboard\n" },
+STEXI
+@item virtio-serial
+Send data to virtio-serial port
+ETEXI
+
     { "acl", "sss?i?", do_acl, "<command> <aclname> [<match> [<index>]]\n",
                                "acl show vnc.username\n"
                                "acl policy vnc.username deny\n"
diff --git a/qemu-options.hx b/qemu-options.hx
index c5aed0e..9c9f767 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1533,6 +1533,14 @@ STEXI
 Set virtio console.
 ETEXI
 
+DEF("virtioserial", HAS_ARG, QEMU_OPTION_virtioserial, \
+    "-virtioserial c\n" \
+    "                define virtio serial device\n")
+STEXI
+@item -virtserial @var{c}
+Set virtio serial device.
+ETEXI
+
 DEF("show-cursor", 0, QEMU_OPTION_show_cursor, \
     "-show-cursor    show cursor\n")
 STEXI
diff --git a/sysemu.h b/sysemu.h
index 686228d..a0501d2 100644
--- a/sysemu.h
+++ b/sysemu.h
@@ -234,6 +234,17 @@ extern CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
 
 extern CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
 
+/* virtio serial ports */
+
+#define MAX_VIRTIO_SERIAL_PORTS 4
+#define VIRTIO_SERIAL_NAME_MAX_LEN 30
+
+
+extern CharDriverState *virtio_serial_hds[MAX_VIRTIO_SERIAL_PORTS];
+extern char virtio_serial_names[MAX_VIRTIO_SERIAL_PORTS][VIRTIO_SERIAL_NAME_MAX_LEN];
+extern int virtio_serial_index;
+
+
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
 #ifdef NEED_CPU_H
diff --git a/vl.c b/vl.c
index 7278999..a078588 100644
--- a/vl.c
+++ b/vl.c
@@ -237,6 +237,9 @@ int no_quit = 0;
 CharDriverState *serial_hds[MAX_SERIAL_PORTS];
 CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
 CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
+CharDriverState *virtio_serial_hds[MAX_VIRTIO_SERIAL_PORTS];
+char virtio_serial_names[MAX_VIRTIO_SERIAL_PORTS][VIRTIO_SERIAL_NAME_MAX_LEN];
+int virtio_serial_index;
 #ifdef TARGET_I386
 int win2k_install_hack = 0;
 int rtc_td_hack = 0;
@@ -5039,6 +5042,7 @@ int main(int argc, char **argv, char **envp)
     int parallel_device_index;
     const char *virtio_consoles[MAX_VIRTIO_CONSOLES];
     int virtio_console_index;
+    const char *virtio_serials[MAX_VIRTIO_SERIAL_PORTS];
     const char *loadvm = NULL;
     QEMUMachine *machine;
     const char *cpu_model;
@@ -5118,6 +5122,10 @@ int main(int argc, char **argv, char **envp)
         virtio_consoles[i] = NULL;
     virtio_console_index = 0;
 
+    for (i = 0; i < MAX_VIRTIO_SERIAL_PORTS; i++)
+        virtio_serials[i] = NULL;
+    virtio_serial_index = 0;
+
     for (i = 0; i < MAX_NODES; i++) {
         node_mem[i] = 0;
         node_cpumask[i] = 0;
@@ -5548,6 +5556,14 @@ int main(int argc, char **argv, char **envp)
                 virtio_consoles[virtio_console_index] = optarg;
                 virtio_console_index++;
                 break;
+	    case QEMU_OPTION_virtioserial:
+                if (virtio_serial_index >= MAX_VIRTIO_SERIAL_PORTS) {
+                    fprintf(stderr, "qemu: too many virtio serial ports\n");
+                    exit(1);
+                }
+                virtio_serials[virtio_serial_index] = optarg;
+                virtio_serial_index++;
+                break;
             case QEMU_OPTION_parallel:
                 if (parallel_device_index >= MAX_PARALLEL_PORTS) {
                     fprintf(stderr, "qemu: too many parallel ports\n");
@@ -6209,6 +6225,44 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+    for (i = 0; i < virtio_serial_index; i++) {
+        const char *virtseropt;
+        char devname[80];
+        int j, k;
+
+        memset(devname, 0, 80);
+        j = k = 0;
+        while (isalnum(virtio_serials[i][j])) {
+            devname[k] = virtio_serials[i][j];
+            k++;
+            j++;
+        }
+
+        if (devname[0] && strncmp(devname, "none", 4)) {
+            char label[32];
+            snprintf(label, sizeof(label), "virtio-serial%d", i);
+            virtio_serial_hds[i] = qemu_chr_open(label, devname, NULL);
+            if (!virtio_serial_hds[i]) {
+                fprintf(stderr, "qemu: could not open virtio serial '%s'\n",
+                        devname);
+                exit(1);
+            }
+        }
+        virtseropt = strstr(virtio_serials[i], ",name=");
+        if (virtseropt) {
+            int j, k = 6;
+
+            for (j = 0; j < VIRTIO_SERIAL_NAME_MAX_LEN && isalnum(virtseropt[k]);
+                 j++, k++) {
+                virtio_serial_names[i][j] = virtseropt[k];
+            }
+            if (j < VIRTIO_SERIAL_NAME_MAX_LEN - 1) {
+                virtio_serial_names[i][j + 1] = 0;
+            }
+        }
+
+    }
+
     module_call_init(MODULE_INIT_DEVICE);
 
     if (kvm_enabled())
@@ -6340,6 +6394,15 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+    for(i = 0; i < MAX_VIRTIO_SERIAL_PORTS; i++) {
+        const char *devname = virtio_serials[i];
+        if (virtio_serial_hds[i] && devname) {
+            if (strstart(devname, "vc", 0)) {
+                qemu_chr_printf(virtio_serial_hds[i], "virtio serial%d\r\n", i);
+            }
+        }
+    }
+
     if (gdbstub_dev && gdbserver_start(gdbstub_dev) < 0) {
         fprintf(stderr, "qemu: could not open gdbserver on device '%s'\n",
                 gdbstub_dev);
-- 
1.6.2.2
