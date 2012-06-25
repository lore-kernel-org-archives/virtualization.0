From: Jason Wang <jasowang@redhat.com>
Subject: [RFC V2 PATCH 2/4] tap: multiqueue support
Date: Mon, 25 Jun 2012 18:04:25 +0800
Message-ID: <20120625100425.8096.69950.stgit@amd-6168-8-1.englab.nay.redhat.com>
References: <20120625095059.8096.49429.stgit@amd-6168-8-1.englab.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120625095059.8096.49429.stgit@amd-6168-8-1.englab.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: krkumar2@in.ibm.com, habanero@linux.vnet.ibm.com, aliguori@us.ibm.com, rusty@rustcorp.com.au, mst@redhat.com, mashirle@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, tahm@linux.vnet.ibm.com, jwhan@filewood.snu.ac.kr, akong@redhat.com
Cc: kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This patch adds basic support for the multiple queue capable tap device. When
multiqueue were enabled for a tap device, user can attach/detach multiple files
(sockets) to the device through TUNATTACHQUEUE/TUNDETACHQUEUE.

Two helpers tun_attach() and tun_deatch() were introduced to attach and detach
file. Platform-specific helpers were called and only linux helper has its
content as multiqueue tap were only supported in linux.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net.c             |    4 +
 net/tap-aix.c     |   13 +++-
 net/tap-bsd.c     |   13 +++-
 net/tap-haiku.c   |   13 +++-
 net/tap-linux.c   |   55 +++++++++++++++
 net/tap-linux.h   |    3 +
 net/tap-solaris.c |   13 +++-
 net/tap-win32.c   |   11 +++
 net/tap.c         |  189 ++++++++++++++++++++++++++++++++++-------------------
 net/tap.h         |    7 ++
 10 files changed, 245 insertions(+), 76 deletions(-)

diff --git a/net.c b/net.c
index 4aa416c..eabe830 100644
--- a/net.c
+++ b/net.c
@@ -978,6 +978,10 @@ static const struct {
                 .name = "vhostforce",
                 .type = QEMU_OPT_BOOL,
                 .help = "force vhost on for non-MSIX virtio guests",
+            }, {
+                .name = "queues",
+                .type = QEMU_OPT_NUMBER,
+                .help = "number of queues the backend can provides",
         },
 #endif /* _WIN32 */
             { /* end of list */ }
diff --git a/net/tap-aix.c b/net/tap-aix.c
index e19aaba..f111e0f 100644
--- a/net/tap-aix.c
+++ b/net/tap-aix.c
@@ -25,7 +25,8 @@
 #include "net/tap.h"
 #include <stdio.h>
 
-int tap_open(char *ifname, int ifname_size, int *vnet_hdr, int vnet_hdr_required)
+int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
+             int vnet_hdr_required, int attach)
 {
     fprintf(stderr, "no tap on AIX\n");
     return -1;
@@ -59,3 +60,13 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
                         int tso6, int ecn, int ufo)
 {
 }
+
+int tap_fd_attach(int fd, const char *ifname)
+{
+    return -1;
+}
+
+int tap_fd_detach(int fd, const char *ifname)
+{
+    return -1;
+}
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 937a94b..44f3421 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -33,7 +33,8 @@
 #include <net/if_tap.h>
 #endif
 
-int tap_open(char *ifname, int ifname_size, int *vnet_hdr, int vnet_hdr_required)
+int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
+             int vnet_hdr_required, int attach)
 {
     int fd;
 #ifdef TAPGIFNAME
@@ -145,3 +146,13 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
                         int tso6, int ecn, int ufo)
 {
 }
+
+int tap_fd_attach(int fd, const char *ifname)
+{
+    return -1;
+}
+
+int tap_fd_detach(int fd, const char *ifname)
+{
+    return -1;
+}
diff --git a/net/tap-haiku.c b/net/tap-haiku.c
index 91dda8e..6fb6719 100644
--- a/net/tap-haiku.c
+++ b/net/tap-haiku.c
@@ -25,7 +25,8 @@
 #include "net/tap.h"
 #include <stdio.h>
 
-int tap_open(char *ifname, int ifname_size, int *vnet_hdr, int vnet_hdr_required)
+int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
+             int vnet_hdr_required, int attach)
 {
     fprintf(stderr, "no tap on Haiku\n");
     return -1;
@@ -59,3 +60,13 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
                         int tso6, int ecn, int ufo)
 {
 }
+
+int tap_fd_attach(int fd, const char *ifname)
+{
+    return -1;
+}
+
+int tap_fd_detach(int fd, const char *ifname)
+{
+    return -1;
+}
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 41d581b..5d74b53 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -35,7 +35,8 @@
 
 #define PATH_NET_TUN "/dev/net/tun"
 
-int tap_open(char *ifname, int ifname_size, int *vnet_hdr, int vnet_hdr_required)
+int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
+             int vnet_hdr_required, int attach)
 {
     struct ifreq ifr;
     int fd, ret;
@@ -47,6 +48,8 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr, int vnet_hdr_required
     }
     memset(&ifr, 0, sizeof(ifr));
     ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
+    if (!attach)
+        ifr.ifr_flags |= IFF_MULTI_QUEUE;
 
     if (*vnet_hdr) {
         unsigned int features;
@@ -71,7 +74,10 @@ int tap_open(char *ifname, int ifname_size, int *vnet_hdr, int vnet_hdr_required
         pstrcpy(ifr.ifr_name, IFNAMSIZ, ifname);
     else
         pstrcpy(ifr.ifr_name, IFNAMSIZ, "tap%d");
-    ret = ioctl(fd, TUNSETIFF, (void *) &ifr);
+    if (attach)
+        ret = ioctl(fd, TUNATTACHQUEUE, (void *) &ifr);
+    else
+        ret = ioctl(fd, TUNSETIFF, (void *) &ifr);
     if (ret != 0) {
         if (ifname[0] != '\0') {
             error_report("could not configure %s (%s): %m", PATH_NET_TUN, ifr.ifr_name);
@@ -197,3 +203,48 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
         }
     }
 }
+
+/* Attach a file descriptor to a TUN/TAP device. This descriptor should be
+ * detached before.
+ */
+int tap_fd_attach(int fd, const char *ifname)
+{
+    struct ifreq ifr;
+    int ret;
+
+    memset(&ifr, 0, sizeof(ifr));
+
+    ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
+    pstrcpy(ifr.ifr_name, IFNAMSIZ, ifname);
+
+    ret = ioctl(fd, TUNATTACHQUEUE, (void *) &ifr);
+
+    if (ret != 0) {
+        error_report("could not attach to %s", ifname);
+    }
+
+    return ret;
+}
+
+/* Detach a file descriptor to a TUN/TAP device. This file descriptor must have
+ * been attach to a device.
+ */
+int tap_fd_detach(int fd, const char *ifname)
+{
+    struct ifreq ifr;
+    int ret;
+
+    memset(&ifr, 0, sizeof(ifr));
+
+    ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
+    pstrcpy(ifr.ifr_name, IFNAMSIZ, ifname);
+
+    ret = ioctl(fd, TUNDETACHQUEUE, (void *) &ifr);
+
+    if (ret != 0) {
+        error_report("could not detach to %s", ifname);
+    }
+
+    return ret;
+}
+
diff --git a/net/tap-linux.h b/net/tap-linux.h
index 659e981..0f5e34e 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -29,6 +29,8 @@
 #define TUNSETSNDBUF   _IOW('T', 212, int)
 #define TUNGETVNETHDRSZ _IOR('T', 215, int)
 #define TUNSETVNETHDRSZ _IOW('T', 216, int)
+#define TUNATTACHQUEUE  _IOW('T', 217, int)
+#define TUNDETACHQUEUE  _IOW('T', 218, int)
 
 #endif
 
@@ -36,6 +38,7 @@
 #define IFF_TAP		0x0002
 #define IFF_NO_PI	0x1000
 #define IFF_VNET_HDR	0x4000
+#define IFF_MULTI_QUEUE 0x0100
 
 /* Features for GSO (TUNSETOFFLOAD). */
 #define TUN_F_CSUM	0x01	/* You can hand me unchecksummed packets. */
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index cf76463..f7c8e8d 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -173,7 +173,8 @@ static int tap_alloc(char *dev, size_t dev_size)
     return tap_fd;
 }
 
-int tap_open(char *ifname, int ifname_size, int *vnet_hdr, int vnet_hdr_required)
+int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
+             int vnet_hdr_required, int attach)
 {
     char  dev[10]="";
     int fd;
@@ -225,3 +226,13 @@ void tap_fd_set_offload(int fd, int csum, int tso4,
                         int tso6, int ecn, int ufo)
 {
 }
+
+int tap_fd_attach(int fd, const char *ifname)
+{
+    return -1;
+}
+
+int tap_fd_detach(int fd, const char *ifname)
+{
+    return -1;
+}
diff --git a/net/tap-win32.c b/net/tap-win32.c
index a801a55..dae1c00 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -749,3 +749,14 @@ struct vhost_net *tap_get_vhost_net(VLANClientState *nc)
 {
     return NULL;
 }
+
+int tap_attach(VLANClientState *nc)
+{
+    return -1;
+}
+
+int tap_detach(VLANClientState *nc)
+{
+    return -1;
+}
+
diff --git a/net/tap.c b/net/tap.c
index 5ac4ba3..2b9dcb5 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -53,11 +53,13 @@ typedef struct TAPState {
     int fd;
     char down_script[1024];
     char down_script_arg[128];
+    char ifname[128];
     uint8_t buf[TAP_BUFSIZE];
     unsigned int read_poll : 1;
     unsigned int write_poll : 1;
     unsigned int using_vnet_hdr : 1;
     unsigned int has_ufo: 1;
+    unsigned int enabled:1;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
 } TAPState;
@@ -546,7 +548,7 @@ int net_init_bridge(QemuOpts *opts, const char *name, VLANState *vlan)
     return 0;
 }
 
-static int net_tap_init(QemuOpts *opts, int *vnet_hdr)
+static int net_tap_init(QemuOpts *opts, int *vnet_hdr, int attach)
 {
     int fd, vnet_hdr_required;
     char ifname[128] = {0,};
@@ -563,7 +565,9 @@ static int net_tap_init(QemuOpts *opts, int *vnet_hdr)
         vnet_hdr_required = 0;
     }
 
-    TFR(fd = tap_open(ifname, sizeof(ifname), vnet_hdr, vnet_hdr_required));
+    TFR(fd = tap_open(ifname, sizeof(ifname), vnet_hdr, vnet_hdr_required,
+                      attach));
+
     if (fd < 0) {
         return -1;
     }
@@ -572,7 +576,7 @@ static int net_tap_init(QemuOpts *opts, int *vnet_hdr)
     if (setup_script &&
         setup_script[0] != '\0' &&
         strcmp(setup_script, "no") != 0 &&
-        launch_script(setup_script, ifname, fd)) {
+        (!attach && launch_script(setup_script, ifname, fd))) {
         close(fd);
         return -1;
     }
@@ -582,74 +586,11 @@ static int net_tap_init(QemuOpts *opts, int *vnet_hdr)
     return fd;
 }
 
-int net_init_tap(QemuOpts *opts, const char *name, VLANState *vlan)
+static int __net_init_tap(QemuOpts *opts, Monitor *mon, const char *name,
+                          VLANState *vlan, int fd, int vnet_hdr)
 {
-    TAPState *s;
-    int fd, vnet_hdr = 0;
-    const char *model;
-
-    if (qemu_opt_get(opts, "fd")) {
-        if (qemu_opt_get(opts, "ifname") ||
-            qemu_opt_get(opts, "script") ||
-            qemu_opt_get(opts, "downscript") ||
-            qemu_opt_get(opts, "vnet_hdr") ||
-            qemu_opt_get(opts, "helper")) {
-            error_report("ifname=, script=, downscript=, vnet_hdr=, "
-                         "and helper= are invalid with fd=");
-            return -1;
-        }
-
-        fd = net_handle_fd_param(cur_mon, qemu_opt_get(opts, "fd"));
-        if (fd == -1) {
-            return -1;
-        }
-
-        fcntl(fd, F_SETFL, O_NONBLOCK);
-
-        vnet_hdr = tap_probe_vnet_hdr(fd);
-
-        model = "tap";
-
-    } else if (qemu_opt_get(opts, "helper")) {
-        if (qemu_opt_get(opts, "ifname") ||
-            qemu_opt_get(opts, "script") ||
-            qemu_opt_get(opts, "downscript") ||
-            qemu_opt_get(opts, "vnet_hdr")) {
-            error_report("ifname=, script=, downscript=, and vnet_hdr= "
-                         "are invalid with helper=");
-            return -1;
-        }
-
-        fd = net_bridge_run_helper(qemu_opt_get(opts, "helper"),
-                                   DEFAULT_BRIDGE_INTERFACE);
-        if (fd == -1) {
-            return -1;
-        }
-
-        fcntl(fd, F_SETFL, O_NONBLOCK);
-
-        vnet_hdr = tap_probe_vnet_hdr(fd);
-
-        model = "bridge";
-
-    } else {
-        if (!qemu_opt_get(opts, "script")) {
-            qemu_opt_set(opts, "script", DEFAULT_NETWORK_SCRIPT);
-        }
-
-        if (!qemu_opt_get(opts, "downscript")) {
-            qemu_opt_set(opts, "downscript", DEFAULT_NETWORK_DOWN_SCRIPT);
-        }
+    TAPState *s = net_tap_fd_init(vlan, "tap", name, fd, vnet_hdr);
 
-        fd = net_tap_init(opts, &vnet_hdr);
-        if (fd == -1) {
-            return -1;
-        }
-
-        model = "tap";
-    }
-
-    s = net_tap_fd_init(vlan, model, name, fd, vnet_hdr);
     if (!s) {
         close(fd);
         return -1;
@@ -671,6 +612,7 @@ int net_init_tap(QemuOpts *opts, const char *name, VLANState *vlan)
         script     = qemu_opt_get(opts, "script");
         downscript = qemu_opt_get(opts, "downscript");
 
+        pstrcpy(s->ifname, sizeof(s->ifname), ifname);
         snprintf(s->nc.info_str, sizeof(s->nc.info_str),
                  "ifname=%s,script=%s,downscript=%s",
                  ifname, script, downscript);
@@ -704,6 +646,82 @@ int net_init_tap(QemuOpts *opts, const char *name, VLANState *vlan)
         return -1;
     }
 
+    s->enabled = 1;
+    return 0;
+}
+
+int net_init_tap(QemuOpts *opts, const char *name, VLANState *vlan)
+{
+    int i, fd, vnet_hdr = 0;
+    int numqueues = qemu_opt_get_number(opts, "queues", 1);
+
+    if (qemu_opt_get(opts, "fd")) {
+        const char *fdp[16];
+        if (qemu_opt_get(opts, "ifname") ||
+            qemu_opt_get(opts, "script") ||
+            qemu_opt_get(opts, "downscript") ||
+            qemu_opt_get(opts, "vnet_hdr") ||
+            qemu_opt_get(opts, "helper")) {
+            error_report("ifname=, script=, downscript=, vnet_hdr=, "
+                         "and helper= are invalid with fd=");
+            return -1;
+        }
+
+        if (numqueues != qemu_opt_get_all(opts, "fd", fdp, 16)) {
+            error_report("the number of queue does not match the"
+                         "number of fd passed");
+            return -1;
+        }
+
+        for (i = 0; i < numqueues; i++) {
+            fd = net_handle_fd_param(cur_mon, fdp[i]);
+            if (fd == -1) {
+                return -1;
+            }
+
+            fcntl(fd, F_SETFL, O_NONBLOCK);
+
+            vnet_hdr = tap_probe_vnet_hdr(fd);
+
+            __net_init_tap(opts, cur_mon, name, vlan, fd, vnet_hdr);
+        }
+    } else if (qemu_opt_get(opts, "helper")) {
+        if (qemu_opt_get(opts, "ifname") ||
+            qemu_opt_get(opts, "script") ||
+            qemu_opt_get(opts, "downscript") ||
+            qemu_opt_get(opts, "vnet_hdr")) {
+            error_report("ifname=, script=, downscript=, and vnet_hdr= "
+                         "are invalid with helper=");
+            return -1;
+        }
+
+        /* FIXME: multiqueue helper */
+        fd = net_bridge_run_helper(qemu_opt_get(opts, "helper"),
+                                   DEFAULT_BRIDGE_INTERFACE);
+        if (fd == -1) {
+            return -1;
+        }
+
+        fcntl(fd, F_SETFL, O_NONBLOCK);
+
+        vnet_hdr = tap_probe_vnet_hdr(fd);
+    } else {
+        if (!qemu_opt_get(opts, "script")) {
+            qemu_opt_set(opts, "script", DEFAULT_NETWORK_SCRIPT);
+        }
+
+        if (!qemu_opt_get(opts, "downscript")) {
+            qemu_opt_set(opts, "downscript", DEFAULT_NETWORK_DOWN_SCRIPT);
+        }
+
+        for (i = 0; i < numqueues; i++) {
+            fd = net_tap_init(opts, &vnet_hdr, i != 0);
+            if (fd == -1) {
+                return -1;
+            }
+            __net_init_tap(opts, cur_mon, name, vlan, fd, vnet_hdr);
+        }
+    }
     return 0;
 }
 
@@ -713,3 +731,36 @@ VHostNetState *tap_get_vhost_net(VLANClientState *nc)
     assert(nc->info->type == NET_CLIENT_TYPE_TAP);
     return s->vhost_net;
 }
+
+int tap_attach(VLANClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    int ret;
+
+    if (s->enabled) {
+        return 0;
+    } else {
+        ret = tap_fd_attach(s->fd, s->ifname);
+        if (ret == 0) {
+            s->enabled = 1;
+        }
+        return ret;
+    }
+}
+
+int tap_detach(VLANClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    int ret;
+
+    if (s->enabled == 0) {
+        return 0;
+    } else {
+        ret = tap_fd_detach(s->fd, s->ifname);
+        if (ret == 0) {
+            s->enabled = 0;
+        }
+        return ret;
+    }
+}
+
diff --git a/net/tap.h b/net/tap.h
index b2a9450..cead7ca 100644
--- a/net/tap.h
+++ b/net/tap.h
@@ -34,7 +34,8 @@
 
 int net_init_tap(QemuOpts *opts, const char *name, VLANState *vlan);
 
-int tap_open(char *ifname, int ifname_size, int *vnet_hdr, int vnet_hdr_required);
+int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
+             int vnet_hdr_required, int attach);
 
 ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
@@ -51,6 +52,10 @@ int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
+int tap_attach(VLANClientState *vc);
+int tap_detach(VLANClientState *vc);
+int tap_fd_attach(int fd, const char *ifname);
+int tap_fd_detach(int fd, const char *ifname);
 
 int tap_get_fd(VLANClientState *vc);
