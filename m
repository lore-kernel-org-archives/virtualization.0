From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/3] virtio-serial: virtio device for simple host <-> guest
	communication
Date: Mon, 27 Jul 2009 23:34:34 +0530
Message-ID: <1248717876-17630-3-git-send-email-amit.shah__262.290312866931$1248718043$gmane$org@redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<1248717876-17630-2-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1248717876-17630-2-git-send-email-amit.shah@redhat.com>
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

Each port is to be assigned a unique function, for example, the first
4 ports may be reserved for libvirt usage, the next 4 for generic
streaming data and so on. This port-function mapping isn't finalised
yet.

For requirements, use-cases and some history see

    http://www.linux-kvm.org/page/VMchannel_Requirements

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 Makefile.target    |    2 +-
 hw/pc.c            |   17 +++
 hw/pci.h           |    1 +
 hw/qdev.c          |    6 +-
 hw/virtio-pci.c    |   17 +++
 hw/virtio-serial.c |  367 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/virtio-serial.h |   36 +++++
 hw/virtio.h        |    1 +
 monitor.c          |    7 +
 qemu-monitor.hx    |   10 ++
 qemu-options.hx    |    8 +
 sysemu.h           |   13 ++
 vl.c               |   90 +++++++++++++
 13 files changed, 573 insertions(+), 2 deletions(-)
 create mode 100644 hw/virtio-serial.c
 create mode 100644 hw/virtio-serial.h

diff --git a/Makefile.target b/Makefile.target
index df1f32b..21e8ec3 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -538,7 +538,7 @@ obj-y = vl.o osdep.o monitor.o pci.o loader.o isa_mmio.o machine.o \
         gdbstub.o gdbstub-xml.o msix.o ioport.o
 # virtio has to be here due to weird dependency between PCI and virtio-net.
 # need to fix this properly
-obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o
+obj-y += virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o virtio-serial.o
 obj-$(CONFIG_KVM) += kvm.o kvm-all.o
 
 LIBS+=-lz
diff --git a/hw/pc.c b/hw/pc.c
index ecc7046..6badad9 100644
--- a/hw/pc.c
+++ b/hw/pc.c
@@ -40,6 +40,8 @@
 
 #include "qemu-kvm.h"
 
+void *virtio_serial_new_port(PCIDevice *dev, int idx);
+
 /* output Bochs bios info messages */
 //#define DEBUG_BIOS
 
@@ -1456,6 +1458,21 @@ static void pc_init1(ram_addr_t ram_size,
         }
     }
 
+    /* Add virtio serial devices */
+    if (pci_enabled && virtio_serial_nr_ports) {
+        void *dev;
+
+        dev = pci_create_simple(pci_bus, -1, "virtio-serial-pci");
+        if (!dev) {
+            fprintf(stderr, "qemu: could not create virtio serial pci device\n");
+            exit(1);
+        }
+
+        for (i = 0; i < virtio_serial_nr_ports; i++) {
+                virtio_serial_new_port(dev, virtio_serial_idx[i]);
+        }
+    }
+
 #ifdef USE_KVM_DEVICE_ASSIGNMENT
     if (kvm_enabled()) {
         add_assigned_devices(pci_bus, assigned_devices, assigned_devices_index);
diff --git a/hw/pci.h b/hw/pci.h
index 7ca3ba9..42d1291 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -74,6 +74,7 @@ extern target_phys_addr_t pci_mem_base;
 #define PCI_DEVICE_ID_VIRTIO_BLOCK       0x1001
 #define PCI_DEVICE_ID_VIRTIO_BALLOON     0x1002
 #define PCI_DEVICE_ID_VIRTIO_CONSOLE     0x1003
+#define PCI_DEVICE_ID_VIRTIO_SERIAL      0x1004
 
 typedef void PCIConfigWriteFunc(PCIDevice *pci_dev,
                                 uint32_t address, uint32_t data, int len);
diff --git a/hw/qdev.c b/hw/qdev.c
index 83e98bf..f2ab508 100644
--- a/hw/qdev.c
+++ b/hw/qdev.c
@@ -156,9 +156,13 @@ CharDriverState *qdev_init_chardev(DeviceState *dev)
 {
     static int next_serial;
     static int next_virtconsole;
+    static int next_virtserial;
+
     /* FIXME: This is a nasty hack that needs to go away.  */
-    if (strncmp(dev->info->name, "virtio", 6) == 0) {
+    if (strncmp(dev->info->name, "virtio-console", 14) == 0) {
         return virtcon_hds[next_virtconsole++];
+    } else if (strncmp(dev->info->name, "virtio-serial", 13) == 0) {
+        return virtio_serial_hds[next_virtserial++];
     } else {
         return serial_hds[next_serial++];
     }
diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 3b9bfd1..53e4295 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -478,6 +478,19 @@ static void virtio_balloon_init_pci(PCIDevice *pci_dev)
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
 static PCIDeviceInfo virtio_info[] = {
     {
         .qdev.name = "virtio-blk-pci",
@@ -496,6 +509,10 @@ static PCIDeviceInfo virtio_info[] = {
         .qdev.size = sizeof(VirtIOPCIProxy),
         .init      = virtio_balloon_init_pci,
     },{
+        .qdev.name = "virtio-serial-pci",
+        .qdev.size = sizeof(VirtIOPCIProxy),
+        .init      = virtio_serial_init_pci,
+    },{
         /* end of list */
     }
 };
diff --git a/hw/virtio-serial.c b/hw/virtio-serial.c
new file mode 100644
index 0000000..d77af9b
--- /dev/null
+++ b/hw/virtio-serial.c
@@ -0,0 +1,367 @@
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
+
+typedef struct VirtIOSerial {
+    PCIDevice *dev;
+    VirtIODevice *vdev;
+    VirtQueue *ivq, *ovq;
+    struct VirtIOSerialPort *ports;
+    struct virtio_serial_config config;
+} VirtIOSerial;
+
+typedef struct VirtIOSerialPort {
+    VirtIOSerial *virtserial;
+    CharDriverState *hd;
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
+    if (id > MAX_VIRTIO_SERIAL_PORTS)
+        return NULL;
+
+    return &virtio_serial.ports[id];
+}
+
+static int get_id_from_port(VirtIOSerialPort *port)
+{
+    uint32_t i;
+
+    for (i = 0; i < MAX_VIRTIO_SERIAL_PORTS; i++) {
+        if (port == &virtio_serial.ports[i]) {
+            return i;
+        }
+    }
+    return VIRTIO_SERIAL_BAD_ID;
+}
+
+void virtio_serial_monitor_command(Monitor *mon,
+                            const char *command, const char *param)
+{
+    VirtIOSerialPort *port = &virtio_serial.ports[0];
+    VirtIODevice *vdev = port->virtserial->vdev;
+    VirtQueue *vq = port->virtserial->ivq;
+    VirtQueueElement elem;
+    char buf[300];
+    ssize_t len;
+    unsigned int i;
+    int ret;
+
+    if(!strncmp(command, "add_port", 8)) {
+        if (!param) {
+            monitor_printf(mon, "Error: need port id to add new port\n");
+            return;
+        }
+        ret = init_virtio_serial_port(virtio_serial_nr_ports, param);
+        if (ret < 0) {
+            monitor_printf(mon, "Error: cannot add new port: %s\n",
+                           strerror(-ret));
+            return;
+        }
+        virtio_serial_new_port(NULL, virtio_serial_idx[virtio_serial_nr_ports]);
+        virtio_serial_nr_ports++;
+        virtio_serial.config.nr_active_ports = cpu_to_le32(virtio_serial_nr_ports);
+        return;
+    }
+    if (!virtio_queue_ready(vq)) {
+        goto queue_not_ready;
+    }
+    len = snprintf(buf, 299, "%s %s\n", command, param);
+
+    ret = virtqueue_pop(vq, &elem);
+    if (!ret) {
+        goto queue_not_ready;
+    }
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
+    monitor_printf(cur_mon, "No free virtio buffer found. Message not sent.\n");
+    return;
+}
+
+static size_t flush_buf(uint32_t id, const uint8_t *buf, size_t len)
+{
+    VirtIOSerialPort *port;
+    size_t write_len = 0;
+
+    port = get_port_from_id(id);
+    if (port && port->hd) {
+        write_len = qemu_chr_write(port->hd, buf, len);
+	return write_len;
+    }
+    return 0;
+}
+
+/* Guest wrote something to some port.
+ *
+ * Flush the data in the entire chunk that we received rather than
+ * splitting it into multiple buffers. VNC clients don't consume split
+ * buffers
+ */
+static void virtio_serial_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtQueueElement elem;
+
+    while (virtqueue_pop(vq, &elem)) {
+        uint8_t *buf;
+        size_t totlen, buf_offset;
+        VirtIOSerialId id;
+        int id_len, i;
+
+        id_len = sizeof(id);
+        memcpy(&id, elem.out_sg[0].iov_base, id_len);
+
+        totlen = 0;
+        for (i = 0; i < elem.out_num; i++) {
+            totlen += elem.out_sg[i].iov_len;
+        }
+        buf = qemu_mallocz(totlen - id_len);
+        buf_offset = 0;
+        for (i = 0; i < elem.out_num; i++) {
+            size_t len = elem.out_sg[i].iov_len - id_len;
+
+            memcpy(buf + buf_offset, elem.out_sg[i].iov_base + id_len, len);
+
+            buf_offset += len;
+            id_len = 0; /* id is only sent with the first packet in each sg */
+        }
+        flush_buf(id.id, buf, totlen - sizeof(id_len));
+        virtqueue_push(vq, &elem, totlen);
+        qemu_free(buf);
+    }
+    virtio_notify(vdev, vq);
+}
+
+static void virtio_serial_handle_input(VirtIODevice *vdev, VirtQueue *vq)
+{
+}
+
+static void write_to_port(VirtIOSerialPort *port,
+			  const uint8_t *buf, size_t size)
+{
+    VirtQueue *vq = port->virtserial->ivq;
+    VirtQueueElement elem;
+    size_t offset = 0;
+    size_t len = 0;
+
+    if (!virtio_queue_ready(vq)) {
+        return;
+    }
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
+            len = MIN(elem.in_sg[i].iov_len - id_len, size - offset);
+
+            memcpy(elem.in_sg[i].iov_base + id_len, buf + offset, len);
+            offset += len;
+            id_len = 0;
+        }
+        virtqueue_push(vq, &elem, len + sizeof(VirtIOSerialId));
+    }
+    virtio_notify(port->virtserial->vdev, vq);
+}
+
+/* Readiness of the guest to accept data on a port */
+static int cons_can_read(void *opaque)
+{
+    VirtIOSerialPort *port = (VirtIOSerialPort *) opaque;
+    VirtQueue *vq = port->virtserial->ivq;
+    int size;
+
+    if (!virtio_queue_ready(vq)) {
+        return 0;
+    }
+    size = TARGET_PAGE_SIZE;
+    if (virtqueue_avail_bytes(vq, size, 0)) {
+        return size - sizeof(VirtIOSerialId);
+    }
+    size = sizeof(VirtIOSerialId) + 1;
+    if (virtqueue_avail_bytes(vq, size, 0)) {
+        return size - sizeof(VirtIOSerialId);
+    }
+    return 0;
+}
+
+/* Send data from a char device over to the guest */
+static void cons_read(void *opaque, const uint8_t *buf, int size)
+{
+    VirtIOSerialPort *port = (VirtIOSerialPort *) opaque;
+
+    write_to_port(port, buf, size);
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
+/* Guest requested config info */
+static void virtio_serial_get_config(VirtIODevice *vdev, uint8_t *config_data)
+{
+    memcpy(config_data, &virtio_serial.config, sizeof(virtio_serial.config));
+}
+
+static void virtio_serial_set_config(VirtIODevice *vdev,
+                                     const uint8_t *config_data)
+{
+    struct virtio_serial_config config;
+
+    memcpy(&config, config_data, sizeof(config));
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
+void virtio_serial_set_port_active(uint32_t idx)
+{
+    int i = 0;
+
+    while (idx / 32) {
+        i++;
+        idx -= 32;
+    }
+    virtio_serial.config.ports_map[i] |= 1U << idx;
+}
+
+bool virtio_serial_is_port_active(uint32_t idx)
+{
+    int i = 0;
+
+    while (idx / 32) {
+        i++;
+        idx -= 32;
+    }
+    return virtio_serial.config.ports_map[i] & (1U << idx);
+}
+
+void *virtio_serial_new_port(PCIDevice *dev, int idx)
+{
+    VirtIOSerialPort *port;
+
+    port = get_port_from_id(idx);
+    port->virtserial = &virtio_serial;
+
+    if (!port->virtserial->dev && !dev) {
+        return NULL;
+    }
+    if (!port->virtserial->dev) {
+        port->virtserial->dev = dev;
+    }
+    /* Hot-adding ports to existing device */
+    if (!dev) {
+        dev = port->virtserial->dev;
+    }
+    port->hd = qdev_init_chardev(&dev->qdev);
+    if (port->hd) {
+        qemu_chr_add_handlers(port->hd, cons_can_read, cons_read, cons_event,
+                              port);
+    }
+    /* Send an update to the guest about this new port added */
+    virtio_notify_config(port->virtserial->vdev);
+    return port;
+}
+
+VirtIODevice *virtio_serial_init(DeviceState *dev)
+{
+    VirtIODevice *vdev;
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
+    /* Add queue for host to guest transfers */
+    virtio_serial.ivq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
+                                         virtio_serial_handle_input);
+    /* Add queue for guest to host transfers */
+    virtio_serial.ovq = virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
+                                         virtio_serial_handle_output);
+
+    /* Allocate space for the max. number of serial ports supported */
+    virtio_serial.ports = qemu_mallocz(sizeof(VirtIOSerialPort) * MAX_VIRTIO_SERIAL_PORTS);
+
+    register_savevm("virtio-serial", -1, 1, virtio_serial_save,
+                    virtio_serial_load, vdev);
+
+    virtio_serial.config.max_nr_ports = cpu_to_le32(MAX_VIRTIO_SERIAL_PORTS);
+    virtio_serial.config.nr_active_ports = cpu_to_le32(virtio_serial_nr_ports);
+
+    return vdev;
+}
diff --git a/hw/virtio-serial.h b/hw/virtio-serial.h
new file mode 100644
index 0000000..08c4b51
--- /dev/null
+++ b/hw/virtio-serial.h
@@ -0,0 +1,36 @@
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
+#include "sysemu.h"
+
+/* The ID for virtio serial */
+#define VIRTIO_ID_SERIAL		7
+#define VIRTIO_SERIAL_BAD_ID		(~(uint32_t)0)
+
+struct virtio_serial_config
+{
+    uint32_t max_nr_ports;
+    uint32_t nr_active_ports;
+    uint32_t ports_map[(MAX_VIRTIO_SERIAL_PORTS + 31) / 32];
+};
+
+/* Some defines for the control channel key */
+#define VIRTIO_SERIAL_GET_PORT_NAME 1
+
+
+void *virtio_serial_new_port(PCIDevice *dev, int idx);
+void virtio_serial_monitor_command(Monitor *mon,
+                                   const char *command, const char *param);
+
+#endif
diff --git a/hw/virtio.h b/hw/virtio.h
index aa55677..ec111f6 100644
--- a/hw/virtio.h
+++ b/hw/virtio.h
@@ -165,5 +165,6 @@ VirtIODevice *virtio_blk_init(DeviceState *dev);
 VirtIODevice *virtio_net_init(DeviceState *dev);
 VirtIODevice *virtio_console_init(DeviceState *dev);
 VirtIODevice *virtio_balloon_init(DeviceState *dev);
+VirtIODevice *virtio_serial_init(DeviceState *dev);
 
 #endif
diff --git a/monitor.c b/monitor.c
index 193f0b9..1e701e5 100644
--- a/monitor.c
+++ b/monitor.c
@@ -45,6 +45,7 @@
 #include "kvm.h"
 #include "acl.h"
 #include "exec-all.h"
+#include "hw/virtio-serial.h"
 
 #include "qemu-kvm.h"
 
@@ -1723,6 +1724,12 @@ static void do_inject_mce(Monitor *mon,
 }
 #endif
 
+static void do_virtio_serial_action(Monitor *mon,
+                                    const char *command, const char *param)
+{
+    virtio_serial_monitor_command(mon, command, param);
+}
+
 static const mon_cmd_t mon_cmds[] = {
 #include "qemu-monitor.h"
     { NULL, NULL, },
diff --git a/qemu-monitor.hx b/qemu-monitor.hx
index 1b0a6ef..2c30335 100644
--- a/qemu-monitor.hx
+++ b/qemu-monitor.hx
@@ -569,6 +569,16 @@ STEXI
 Change watchdog action.
 ETEXI
 
+    { "virtio-serial", "ss?", do_virtio_serial_action,
+      "<command> [<parameters>]\n",
+      "virtio-serial write port=3,key=get,value=clipboard\n"
+      "virtio-serial add_port\n"
+      "virtio-serial add_port port=6,name=foo,protocol=keyvalue\n" },
+STEXI
+@item virtio-serial
+Hot-add ports or send data to virtio-serial port
+ETEXI
+
     { "acl_show", "s", do_acl_show, "aclname",
       "list rules in the access control list" },
 STEXI
diff --git a/qemu-options.hx b/qemu-options.hx
index 8e6cd43..86c7441 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1591,6 +1591,14 @@ STEXI
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
index 75ea191..8dc5847 100644
--- a/sysemu.h
+++ b/sysemu.h
@@ -2,6 +2,7 @@
 #define SYSEMU_H
 /* Misc. things related to the system emulator.  */
 
+#include <stdbool.h>
 #include "qemu-common.h"
 
 #ifdef _WIN32
@@ -240,6 +241,18 @@ extern CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
 
 extern CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
 
+/* virtio serial ports */
+
+#define MAX_VIRTIO_SERIAL_PORTS 64
+#define VIRTIO_SERIAL_PROTO_MAX_LEN 30
+
+extern CharDriverState *virtio_serial_hds[MAX_VIRTIO_SERIAL_PORTS];
+extern uint32_t virtio_serial_idx[MAX_VIRTIO_SERIAL_PORTS];
+extern int virtio_serial_nr_ports;
+extern int init_virtio_serial_port(int port, const char *opts);
+extern void virtio_serial_set_port_active(uint32_t idx);
+extern bool virtio_serial_is_port_active(uint32_t idx);
+
 #define TFR(expr) do { if ((expr) != -1) break; } while (errno == EINTR)
 
 #ifdef NEED_CPU_H
diff --git a/vl.c b/vl.c
index 30c4ff9..6c8aa11 100644
--- a/vl.c
+++ b/vl.c
@@ -221,6 +221,10 @@ int no_quit = 0;
 CharDriverState *serial_hds[MAX_SERIAL_PORTS];
 CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
 CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
+CharDriverState *virtio_serial_hds[MAX_VIRTIO_SERIAL_PORTS];
+char virtio_serial_proto[MAX_VIRTIO_SERIAL_PORTS][VIRTIO_SERIAL_PROTO_MAX_LEN];
+uint32_t virtio_serial_idx[MAX_VIRTIO_SERIAL_PORTS];
+int virtio_serial_nr_ports;
 #ifdef TARGET_I386
 int win2k_install_hack = 0;
 int rtc_td_hack = 0;
@@ -4824,6 +4828,60 @@ char *qemu_find_file(int type, const char *name)
     return buf;
 }
 
+
+int init_virtio_serial_port(int port, const char *opts)
+{
+    char serdev[256];
+    const char *virtserprot;
+    const char *virtseridx;
+    uint32_t port_nr;
+    int j, k;
+
+    memset(serdev, 0, sizeof(serdev));
+    virtserprot = strstr(opts, ",protocol=");
+    virtseridx  = strstr(opts, ",id=");
+
+    /* We only create ports at specific locations */
+    if (!virtseridx) {
+        return -EINVAL;
+    }
+
+    j = k = 0;
+
+    /* Just to maintain compatibility with other qemu options,
+     * we have the format of
+     *
+     * -virtioserial unix:/tmp/foo,protocol=bar,id=3
+     *
+     * so to parse the 'unix:', we have to do the following
+     */
+    while (&opts[j] != virtserprot && &opts[j] != virtseridx) {
+        serdev[k++] = opts[j++];
+    }
+
+    port_nr = atol(virtseridx + 4); /* skip ',id=' */
+
+    k = virtio_serial_is_port_active(port_nr);
+    if (k || port_nr >= MAX_VIRTIO_SERIAL_PORTS) {
+        return -EEXIST;
+    }
+    if (serdev[0] && strncmp(serdev, "none", 4)) {
+        char label[32];
+        snprintf(label, sizeof(label), "virtio-serial%u", port_nr);
+        virtio_serial_hds[port] = qemu_chr_open(label, serdev, NULL);
+        if (!virtio_serial_hds[port]) {
+            /* We could be called from a monitor command to hot-add
+             * the port. Don't exit.
+             */
+            return -EIO;
+        }
+    }
+    virtio_serial_idx[port] = port_nr;
+    virtio_serial_set_port_active(port_nr);
+
+    return 0;
+}
+
 int main(int argc, char **argv, char **envp)
 {
     const char *gdbstub_dev = NULL;
@@ -4851,6 +4909,7 @@ int main(int argc, char **argv, char **envp)
     int parallel_device_index;
     const char *virtio_consoles[MAX_VIRTIO_CONSOLES];
     int virtio_console_index;
+    const char *virtio_serials[MAX_VIRTIO_SERIAL_PORTS];
     const char *loadvm = NULL;
     QEMUMachine *machine;
     const char *cpu_model;
@@ -4930,6 +4989,10 @@ int main(int argc, char **argv, char **envp)
         virtio_consoles[i] = NULL;
     virtio_console_index = 0;
 
+    for (i = 0; i < MAX_VIRTIO_SERIAL_PORTS; i++)
+        virtio_serials[i] = NULL;
+    virtio_serial_nr_ports = 0;
+
     for (i = 0; i < MAX_NODES; i++) {
         node_mem[i] = 0;
         node_cpumask[i] = 0;
@@ -5360,6 +5423,14 @@ int main(int argc, char **argv, char **envp)
                 virtio_consoles[virtio_console_index] = optarg;
                 virtio_console_index++;
                 break;
+	    case QEMU_OPTION_virtioserial:
+                if (virtio_serial_nr_ports >= MAX_VIRTIO_SERIAL_PORTS) {
+                    fprintf(stderr, "qemu: too many virtio serial ports\n");
+                    exit(1);
+                }
+                virtio_serials[virtio_serial_nr_ports] = optarg;
+                virtio_serial_nr_ports++;
+                break;
             case QEMU_OPTION_parallel:
                 if (parallel_device_index >= MAX_PARALLEL_PORTS) {
                     fprintf(stderr, "qemu: too many parallel ports\n");
@@ -5985,6 +6056,16 @@ int main(int argc, char **argv, char **envp)
         }
     }
 
+    for (i = 0; i < virtio_serial_nr_ports; i++) {
+        int ret;
+
+        ret = init_virtio_serial_port(i, virtio_serials[i]);
+        if (ret < 0) {
+            fprintf(stderr, "qemu: could not init virtio serial ports\n");
+            exit(1);
+        }
+    }
+
     module_call_init(MODULE_INIT_DEVICE);
 
     machine->init(ram_size, boot_devices,
@@ -6102,6 +6183,15 @@ int main(int argc, char **argv, char **envp)
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
1.6.2.5
