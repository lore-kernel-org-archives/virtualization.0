From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH 1/5] monitor: Rename+move net_handle_fd_param ->
	monitor_handle_fd_param
Date: Fri,  7 Sep 2012 06:48:15 +0000
Message-ID: <1347000499-28701-2-git-send-email-nab__40685.3151195266$1347000802$gmane$org@linux-iscsi.org>
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

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch renames+moves the net_handle_fd_param() caller used to
obtain a file descriptor from either qemu_parse_fd() (the normal case)
or from monitor_get_fd() (migration case) into a generically prefixed
monitor_handle_fd_param() to be used by vhost-scsi code.

Also update net/[socket,tap].c consumers to use the new prefix.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony Liguori <aliguori@us.ibm.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 monitor.c    |   18 ++++++++++++++++++
 monitor.h    |    1 +
 net.c        |   18 ------------------
 net.h        |    2 --
 net/socket.c |    2 +-
 net/tap.c    |    4 ++--
 6 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/monitor.c b/monitor.c
index 49dccfe..0641efe 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2389,6 +2389,24 @@ int monitor_get_fd(Monitor *mon, const char *fdname)
     return -1;
 }
 
+int monitor_handle_fd_param(Monitor *mon, const char *fdname)
+{
+    int fd;
+
+    if (!qemu_isdigit(fdname[0]) && mon) {
+
+        fd = monitor_get_fd(mon, fdname);
+        if (fd == -1) {
+            error_report("No file descriptor named %s found", fdname);
+            return -1;
+        }
+    } else {
+        fd = qemu_parse_fd(fdname);
+    }
+
+    return fd;
+}
+
 /* mon_cmds and info_cmds would be sorted at runtime */
 static mon_cmd_t mon_cmds[] = {
 #include "hmp-commands.h"
diff --git a/monitor.h b/monitor.h
index 5f4de1b..d557e97 100644
--- a/monitor.h
+++ b/monitor.h
@@ -65,6 +65,7 @@ int monitor_read_block_device_key(Monitor *mon, const char *device,
                                   void *opaque);
 
 int monitor_get_fd(Monitor *mon, const char *fdname);
+int monitor_handle_fd_param(Monitor *mon, const char *fdname);
 
 void monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     GCC_FMT_ATTR(2, 0);
diff --git a/net.c b/net.c
index 60043dd..e5d25d4 100644
--- a/net.c
+++ b/net.c
@@ -522,24 +522,6 @@ int qemu_find_nic_model(NICInfo *nd, const char * const *models,
     return -1;
 }
 
-int net_handle_fd_param(Monitor *mon, const char *param)
-{
-    int fd;
-
-    if (!qemu_isdigit(param[0]) && mon) {
-
-        fd = monitor_get_fd(mon, param);
-        if (fd == -1) {
-            error_report("No file descriptor named %s found", param);
-            return -1;
-        }
-    } else {
-        fd = qemu_parse_fd(param);
-    }
-
-    return fd;
-}
-
 static int net_init_nic(const NetClientOptions *opts, const char *name,
                         NetClientState *peer)
 {
diff --git a/net.h b/net.h
index 2975056..04fda1d 100644
--- a/net.h
+++ b/net.h
@@ -168,8 +168,6 @@ int qmp_netdev_add(Monitor *mon, const QDict *qdict, QObject **ret);
 
 void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
 
-int net_handle_fd_param(Monitor *mon, const char *param);
-
 #define POLYNOMIAL 0x04c11db6
 unsigned compute_mcast_idx(const uint8_t *ep);
 
diff --git a/net/socket.c b/net/socket.c
index c172c24..7c602e4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -629,7 +629,7 @@ int net_init_socket(const NetClientOptions *opts, const char *name,
     if (sock->has_fd) {
         int fd;
 
-        fd = net_handle_fd_param(cur_mon, sock->fd);
+        fd = monitor_handle_fd_param(cur_mon, sock->fd);
         if (fd == -1 || !net_socket_fd_init(peer, "socket", name, fd, 1)) {
             return -1;
         }
diff --git a/net/tap.c b/net/tap.c
index 1971525..a88ae8f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -610,7 +610,7 @@ int net_init_tap(const NetClientOptions *opts, const char *name,
             return -1;
         }
 
-        fd = net_handle_fd_param(cur_mon, tap->fd);
+        fd = monitor_handle_fd_param(cur_mon, tap->fd);
         if (fd == -1) {
             return -1;
         }
@@ -686,7 +686,7 @@ int net_init_tap(const NetClientOptions *opts, const char *name,
         int vhostfd;
 
         if (tap->has_vhostfd) {
-            vhostfd = net_handle_fd_param(cur_mon, tap->vhostfd);
+            vhostfd = monitor_handle_fd_param(cur_mon, tap->vhostfd);
             if (vhostfd == -1) {
                 return -1;
             }
-- 
1.7.2.5
