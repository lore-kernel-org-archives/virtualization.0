From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH 3/5] vhost-scsi: add -vhost-scsi host device for use with
	tcm-vhost
Date: Fri,  7 Sep 2012 06:48:17 +0000
Message-ID: <1347000499-28701-4-git-send-email-nab__39054.8962088816$1347000802$gmane$org@linux-iscsi.org>
References: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1347000499-28701-1-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: target-devel <target-devel@vger.kernel.org>
Cc: Anthony Liguori <aliguori@us.ibm.com>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

This patch adds a new type of host device that drives the vhost_scsi
device.  The syntax to add vhost-scsi is:

  qemu -vhost-scsi id=vhost-scsi0,wwpn=...,tpgt=123

The virtio-scsi emulated device will make use of vhost-scsi to process
virtio-scsi requests inside the kernel and hand them to the in-kernel
SCSI target stack using the tcm_vhost fabric driver.

The tcm_vhost driver was merged into the upstream linux kernel for 3.6-rc2,
and the commit can be found here:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=057cbf49a1f08297

Changelog v2 -> v3:

- Move qdev_prop_vhost_scsi + DEFINE_PROP_VHOST_SCSI defs into vhost-scsi.[c,h]
  (reported by MST)
- Add enum vhost_scsi_vq_list for VHostSCSI->vqs[] enumeration (reported by MST)
- Add missing braces around single like if statement to following QEMU
  style (reported by Blue Swirl)
- Change vhost_scsi_target->vhost_wwpn to char *, in order to drop casts to
  pstrcpy in vhost_scsi_start() + vhost_scsi_stop() (reported by Blue Swirl)
- Change VHOST_SCSI_GET_ABI_VERSION to 'int' type (MST)
- Fix 4 byte alignment of vhost_scsi_target (MST)
- Convert fprintf(stderr, ...) usage to -> error_report() (reported by MST)
- Do explict memset of backend before calling VHOST_SCSI_CLEAR_ENDPOINT
  in vhost_scsi_stop() (reported by MST)
- Add support for vhostfd passing in vhost_scsi_add() (reported by MST)
- Change vhost_scsi_add() to use monitor_handle_fd_param() (reported by MST)

Changelog v1 -> v2:

- Expose ABI version via VHOST_SCSI_GET_ABI_VERSION + use Rev 0 as
  starting point for v3.6-rc code (Stefan + ALiguori + nab)
- Fix upstream qemu conflict in hw/qdev-properties.c
- Make GET_ABI_VERSION use int (nab + mst)
- Fix vhost-scsi case lables in configure (reported by paolo)
- Convert qdev_prop_vhost_scsi to use ->get() + ->set() following
  qdev_prop_netdev (reported by paolo)
- Fix typo in qemu-options.hx definition of vhost-scsi (reported by paolo)

Changelog v0 -> v1:

- Add VHOST_SCSI_SET_ENDPOINT call (stefan)
- Enable vhost notifiers for multiple queues (Zhi)
- clear vhost-scsi endpoint on stopped (Zhi)
- Add CONFIG_VHOST_SCSI for QEMU build configure (nab)
- Rename vhost_vring_target -> vhost_scsi_target (mst + nab)
- Add support for VHOST_SCSI_GET_ABI_VERSION ioctl (aliguori + nab)

Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 configure            |   10 +++
 hw/Makefile.objs     |    1 +
 hw/qdev-properties.c |   41 +++++++++++
 hw/vhost-scsi.c      |  190 ++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vhost-scsi.h      |   62 ++++++++++++++++
 qemu-common.h        |    1 +
 qemu-config.c        |   19 +++++
 qemu-options.hx      |    4 +
 vl.c                 |   18 +++++
 9 files changed, 346 insertions(+), 0 deletions(-)
 create mode 100644 hw/vhost-scsi.c
 create mode 100644 hw/vhost-scsi.h

diff --git a/configure b/configure
index f0dbc03..1f03202 100755
--- a/configure
+++ b/configure
@@ -168,6 +168,7 @@ libattr=""
 xfs=""
 
 vhost_net="no"
+vhost_scsi="no"
 kvm="no"
 gprof="no"
 debug_tcg="no"
@@ -513,6 +514,7 @@ Haiku)
   usb="linux"
   kvm="yes"
   vhost_net="yes"
+  vhost_scsi="yes"
   if [ "$cpu" = "i386" -o "$cpu" = "x86_64" ] ; then
     audio_possible_drivers="$audio_possible_drivers fmod"
   fi
@@ -818,6 +820,10 @@ for opt do
   ;;
   --enable-vhost-net) vhost_net="yes"
   ;;
+  --disable-vhost-scsi) vhost_scsi="no"
+  ;;
+  --enable-vhost-scsi) vhost_scsi="yes"
+  ;;
   --disable-opengl) opengl="no"
   ;;
   --enable-opengl) opengl="yes"
@@ -3116,6 +3122,7 @@ echo "posix_madvise     $posix_madvise"
 echo "uuid support      $uuid"
 echo "libcap-ng support $cap_ng"
 echo "vhost-net support $vhost_net"
+echo "vhost-scsi support $vhost_scsi"
 echo "Trace backend     $trace_backend"
 echo "Trace output file $trace_file-<pid>"
 echo "spice support     $spice"
@@ -3828,6 +3835,9 @@ case "$target_arch2" in
       if test "$vhost_net" = "yes" ; then
         echo "CONFIG_VHOST_NET=y" >> $config_target_mak
       fi
+      if test "$vhost_scsi" = "yes" ; then
+        echo "CONFIG_VHOST_SCSI=y" >> $config_target_mak
+      fi
     fi
 esac
 case "$target_arch2" in
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 3ba5dd0..6ab75ec 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -169,6 +169,7 @@ obj-$(CONFIG_VIRTIO) += virtio.o virtio-blk.o virtio-balloon.o virtio-net.o
 obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o virtio-scsi.o
 obj-$(CONFIG_SOFTMMU) += vhost_net.o
 obj-$(CONFIG_VHOST_NET) += vhost.o
+obj-$(CONFIG_VHOST_SCSI) += vhost-scsi.o
 obj-$(CONFIG_REALLY_VIRTFS) += 9pfs/
 obj-$(CONFIG_NO_PCI) += pci-stub.o
 obj-$(CONFIG_VGA) += vga.o
diff --git a/hw/qdev-properties.c b/hw/qdev-properties.c
index 8aca0d4..8b505ca 100644
--- a/hw/qdev-properties.c
+++ b/hw/qdev-properties.c
@@ -4,6 +4,7 @@
 #include "blockdev.h"
 #include "hw/block-common.h"
 #include "net/hub.h"
+#include "vhost-scsi.h"
 
 void *qdev_get_prop_ptr(DeviceState *dev, Property *prop)
 {
@@ -696,6 +697,46 @@ PropertyInfo qdev_prop_vlan = {
     .set   = set_vlan,
 };
 
+/* --- vhost-scsi --- */
+
+static int parse_vhost_scsi_dev(DeviceState *dev, const char *str, void **ptr)
+{
+   VHostSCSI *p;
+
+   p = find_vhost_scsi(str);
+   if (p == NULL) {
+       return -ENOENT;
+   }
+
+   *ptr = p;
+   return 0;
+}
+
+static const char *print_vhost_scsi_dev(void *ptr)
+{
+    VHostSCSI *p = ptr;
+
+    return (p) ? vhost_scsi_get_id(p) : "<null>";
+}
+
+static void get_vhost_scsi_dev(Object *obj, Visitor *v, void *opaque,
+                       const char *name, Error **errp)
+{
+    get_pointer(obj, v, opaque, print_vhost_scsi_dev, name, errp);
+}
+
+static void set_vhost_scsi_dev(Object *obj, Visitor *v, void *opaque,
+                               const char *name, Error **errp)
+{
+    set_pointer(obj, v, opaque, parse_vhost_scsi_dev, name, errp);
+}
+
+PropertyInfo qdev_prop_vhost_scsi = {
+     .name = "vhost-scsi",
+     .get  = get_vhost_scsi_dev,
+     .set  = set_vhost_scsi_dev,
+};
+
 /* --- pointer --- */
 
 /* Not a proper property, just for dirty hacks.  TODO Remove it!  */
diff --git a/hw/vhost-scsi.c b/hw/vhost-scsi.c
new file mode 100644
index 0000000..96da2fc
--- /dev/null
+++ b/hw/vhost-scsi.c
@@ -0,0 +1,190 @@
+/*
+ * vhost_scsi host device
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
+ *
+ * Changes for QEMU mainline + tcm_vhost kernel upstream:
+ *  Nicholas Bellinger <nab@risingtidesystems.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#include <sys/ioctl.h>
+#include "config.h"
+#include "qemu-queue.h"
+#include "monitor.h"
+#include "vhost-scsi.h"
+#include "vhost.h"
+
+struct VHostSCSI {
+    const char *id;
+    const char *wwpn;
+    uint16_t tpgt;
+    int vhostfd;
+    struct vhost_dev dev;
+    struct vhost_virtqueue vqs[VHOST_SCSI_VQ_NUM];
+    QLIST_ENTRY(VHostSCSI) list;
+};
+
+static QLIST_HEAD(, VHostSCSI) vhost_scsi_list =
+    QLIST_HEAD_INITIALIZER(vhost_scsi_list);
+
+VHostSCSI *find_vhost_scsi(const char *id)
+{
+    VHostSCSI *vs;
+
+    QLIST_FOREACH(vs, &vhost_scsi_list, list) {
+        if (!strcmp(id, vs->id)) {
+            return vs;
+        }
+    }
+    return NULL;
+}
+
+const char *vhost_scsi_get_id(VHostSCSI *vs)
+{
+    return vs->id;
+}
+
+int vhost_scsi_start(VHostSCSI *vs, VirtIODevice *vdev)
+{
+    int ret, abi_version;
+    struct vhost_scsi_target backend;
+
+    if (!vhost_dev_query(&vs->dev, vdev)) {
+        return -ENOTSUP;
+    }
+
+    vs->dev.nvqs = VHOST_SCSI_VQ_NUM;
+    vs->dev.vqs = vs->vqs;
+
+    ret = vhost_dev_enable_notifiers(&vs->dev, vdev);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = vhost_dev_start(&vs->dev, vdev);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret = ioctl(vs->dev.control, VHOST_SCSI_GET_ABI_VERSION, &abi_version);
+    if (ret < 0) {
+        ret = -errno;
+        vhost_dev_stop(&vs->dev, vdev);
+        return ret;
+    }
+    if (abi_version > VHOST_SCSI_ABI_VERSION) {
+        error_report("vhost-scsi: The running tcm_vhost kernel abi_version:"
+		" %d is greater than vhost_scsi userspace supports: %d, please"
+		" upgrade your version of QEMU\n", abi_version,
+		VHOST_SCSI_ABI_VERSION);
+        ret = -ENOSYS;
+        vhost_dev_stop(&vs->dev, vdev);
+        return ret;
+    }
+    fprintf(stdout, "TCM_vHost ABI version: %d\n", abi_version);
+
+    memset(&backend, 0, sizeof(backend));
+    pstrcpy(backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
+    backend.vhost_tpgt = vs->tpgt;
+    ret = ioctl(vs->dev.control, VHOST_SCSI_SET_ENDPOINT, &backend);
+    if (ret < 0) {
+        ret = -errno;
+        vhost_dev_stop(&vs->dev, vdev);
+        return ret;
+    }
+
+    return 0;
+}
+
+void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev)
+{
+    int ret;
+    struct vhost_scsi_target backend;
+
+    memset(&backend, 0, sizeof(backend));
+    pstrcpy(backend.vhost_wwpn, sizeof(backend.vhost_wwpn), vs->wwpn);
+    backend.vhost_tpgt = vs->tpgt;
+    ret = ioctl(vs->dev.control, VHOST_SCSI_CLEAR_ENDPOINT, &backend);
+    if (ret < 0) {
+        error_report("vhost-scsi: Failed to clear endpoint\n");
+    }
+
+    vhost_dev_stop(&vs->dev, vdev);
+}
+
+static VHostSCSI *vhost_scsi_add(const char *id, const char *wwpn,
+                                 uint16_t tpgt, const char *vhostfd_str)
+{
+    VHostSCSI *vs;
+    int ret;
+
+    vs = g_malloc0(sizeof(*vs));
+    if (!vs) {
+        error_report("vhost-scsi: unable to allocate *vs\n");
+        return NULL;
+    }
+    vs->vhostfd = -1;
+
+    if (vhostfd_str) {
+        vs->vhostfd = monitor_handle_fd_param(cur_mon, vhostfd_str);
+        if (vs->vhostfd == -1) {
+            error_report("vhost-scsi: unable to parse vs->vhostfd\n");
+            return NULL;
+        }
+    }
+    /* TODO set up vhost-scsi device and bind to tcm_vhost/$wwpm/tpgt_$tpgt */
+    ret = vhost_dev_init(&vs->dev, vs->vhostfd, "/dev/vhost-scsi", false);
+    if (ret < 0) {
+        error_report("vhost-scsi: vhost initialization failed: %s\n",
+                strerror(-ret));
+        return NULL;
+    }
+    vs->dev.backend_features = 0;
+    vs->dev.acked_features = 0;
+
+    vs->id = g_strdup(id);
+    vs->wwpn = g_strdup(wwpn);
+    vs->tpgt = tpgt;
+    QLIST_INSERT_HEAD(&vhost_scsi_list, vs, list);
+
+    return vs;
+}
+
+VHostSCSI *vhost_scsi_add_opts(QemuOpts *opts)
+{
+    const char *id;
+    const char *wwpn, *vhostfd;
+    uint64_t tpgt;
+
+    id = qemu_opts_id(opts);
+    if (!id) {
+        error_report("vhost-scsi: no id specified\n");
+        return NULL;
+    }
+    if (find_vhost_scsi(id)) {
+        error_report("duplicate vhost-scsi: \"%s\"\n", id);
+        return NULL;
+    }
+
+    wwpn = qemu_opt_get(opts, "wwpn");
+    if (!wwpn) {
+        error_report("vhost-scsi: \"%s\" missing wwpn\n", id);
+        return NULL;
+    }
+
+    tpgt = qemu_opt_get_number(opts, "tpgt", UINT64_MAX);
+    if (tpgt > UINT16_MAX) {
+        error_report("vhost-scsi: \"%s\" needs a 16-bit tpgt\n", id);
+        return NULL;
+    }
+    vhostfd = qemu_opt_get(opts, "vhostfd");
+
+    return vhost_scsi_add(id, wwpn, tpgt, vhostfd);
+}
diff --git a/hw/vhost-scsi.h b/hw/vhost-scsi.h
new file mode 100644
index 0000000..68de51a
--- /dev/null
+++ b/hw/vhost-scsi.h
@@ -0,0 +1,62 @@
+/*
+ * vhost_scsi host device
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#ifndef VHOST_SCSI_H
+#define VHOST_SCSI_H
+
+#include "qemu-common.h"
+#include "qemu-option.h"
+#include "qdev.h"
+
+/*
+ * Used by QEMU userspace to ensure a consistent vhost-scsi ABI.
+ *
+ * ABI Rev 0: July 2012 version starting point for v3.6-rc merge candidate +
+ *            RFC-v2 vhost-scsi userspace.  Add GET_ABI_VERSION ioctl usage
+ */
+
+#define VHOST_SCSI_ABI_VERSION	0
+
+/* TODO #include <linux/vhost.h> properly */
+/* For VHOST_SCSI_SET_ENDPOINT/VHOST_SCSI_CLEAR_ENDPOINT ioctl */
+struct vhost_scsi_target {
+    int abi_version;
+    char vhost_wwpn[224];
+    unsigned short vhost_tpgt;
+    unsigned short reserved;
+};
+
+enum vhost_scsi_vq_list {
+    VHOST_SCSI_VQ_CTL = 0,
+    VHOST_SCSI_VQ_EVT = 1,
+    VHOST_SCSI_VQ_IO = 2,
+    VHOST_SCSI_VQ_NUM = 3,
+};
+
+#define VHOST_VIRTIO 0xAF
+#define VHOST_SCSI_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x40, struct vhost_scsi_target)
+#define VHOST_SCSI_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x41, struct vhost_scsi_target)
+#define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, int)
+
+extern PropertyInfo qdev_prop_vhost_scsi;
+
+#define DEFINE_PROP_VHOST_SCSI(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_vhost_scsi, VHostSCSI*)
+
+VHostSCSI *find_vhost_scsi(const char *id);
+const char *vhost_scsi_get_id(VHostSCSI *vs);
+VHostSCSI *vhost_scsi_add_opts(QemuOpts *opts);
+int vhost_scsi_start(VHostSCSI *vs, VirtIODevice *vdev);
+void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev);
+
+#endif
diff --git a/qemu-common.h b/qemu-common.h
index f9deca6..ec36002 100644
--- a/qemu-common.h
+++ b/qemu-common.h
@@ -280,6 +280,7 @@ typedef struct EventNotifier EventNotifier;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct QEMUSGList QEMUSGList;
 typedef struct SHPCDevice SHPCDevice;
+typedef struct VHostSCSI VHostSCSI;
 
 typedef uint64_t pcibus_t;
 
diff --git a/qemu-config.c b/qemu-config.c
index 5c3296b..2d4884c 100644
--- a/qemu-config.c
+++ b/qemu-config.c
@@ -626,6 +626,24 @@ QemuOptsList qemu_boot_opts = {
     },
 };
 
+QemuOptsList qemu_vhost_scsi_opts = {
+    .name = "vhost-scsi",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_vhost_scsi_opts.head),
+    .desc = {
+        {
+            .name = "wwpn",
+            .type = QEMU_OPT_STRING,
+        }, {
+            .name = "tpgt",
+            .type = QEMU_OPT_NUMBER,
+        }, {
+            .name = "vhostfd",
+            .type = QEMU_OPT_STRING,
+        },
+        { /* end of list */ }
+    },
+};
+
 static QemuOptsList *vm_config_groups[32] = {
     &qemu_drive_opts,
     &qemu_chardev_opts,
@@ -641,6 +659,7 @@ static QemuOptsList *vm_config_groups[32] = {
     &qemu_machine_opts,
     &qemu_boot_opts,
     &qemu_iscsi_opts,
+    &qemu_vhost_scsi_opts,
     NULL,
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 47cb5bd..4e7a03c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -565,6 +565,10 @@ possible drivers and properties, use @code{-device ?} and
 ETEXI
 
 DEFHEADING()
+DEF("vhost-scsi", HAS_ARG, QEMU_OPTION_vhost_scsi,
+    "-vhost-scsi wwpn=string0,tpgt=number0\n"
+    "                add vhost-scsi device\n",
+    QEMU_ARCH_ALL)
 
 DEFHEADING(File system options:)
 
diff --git a/vl.c b/vl.c
index 91076f0..61c8284 100644
--- a/vl.c
+++ b/vl.c
@@ -144,6 +144,7 @@ int main(int argc, char **argv)
 #include "qemu-options.h"
 #include "qmp-commands.h"
 #include "main-loop.h"
+#include "hw/vhost-scsi.h"
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
 #endif
@@ -1858,6 +1859,14 @@ static int fsdev_init_func(QemuOpts *opts, void *opaque)
 }
 #endif
 
+static int vhost_scsi_init_func(QemuOpts *opts, void *opaque)
+{
+    if (!vhost_scsi_add_opts(opts)) {
+        return -1;
+    }
+    return 0;
+}
+
 static int mon_init_func(QemuOpts *opts, void *opaque)
 {
     CharDriverState *chr;
@@ -2617,6 +2626,11 @@ int main(int argc, char **argv, char **envp)
                 }
                 break;
 #endif
+            case QEMU_OPTION_vhost_scsi:
+                if (!qemu_opts_parse(qemu_find_opts("vhost-scsi"), optarg, 0)) {
+                    exit(1);
+                }
+                break;
 #ifdef CONFIG_SLIRP
             case QEMU_OPTION_tftp:
                 legacy_tftp_prefix = optarg;
@@ -3337,6 +3351,10 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 #endif
+    if (qemu_opts_foreach(qemu_find_opts("vhost-scsi"),
+                          vhost_scsi_init_func, NULL, 1)) {
+        exit(1);
+    }
 
     os_daemonize();
 
-- 
1.7.2.5
