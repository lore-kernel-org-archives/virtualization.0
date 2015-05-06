From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH RFC 5/7] tap: add VNET_LE/VNET_BE operations
Date: Wed, 06 May 2015 14:08:09 +0200
Message-ID: <20150506120809.8607.18426.stgit@bahia.huguette.org>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150506120729.8607.23404.stgit@bahia.huguette.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The linux tap and macvtap backends can be told to parse vnet headers
according to little or big endian. This is done through the TUNSETVNETLE
and TUNSETVNETBE ioctls.

This patch brings all the plumbing for QEMU to use these APIs.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 include/net/net.h |    6 ++++++
 net/net.c         |   18 ++++++++++++++++++
 net/tap-linux.c   |   34 ++++++++++++++++++++++++++++++++++
 net/tap-linux.h   |    2 ++
 net/tap.c         |   16 ++++++++++++++++
 net/tap_int.h     |    2 ++
 6 files changed, 78 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 50ffcb9..86f57f7 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -55,6 +55,8 @@ typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef void (UsingVnetHdr)(NetClientState *, bool);
 typedef void (SetOffload)(NetClientState *, int, int, int, int, int);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
+typedef int (SetVnetLE)(NetClientState *, bool);
+typedef int (SetVnetBE)(NetClientState *, bool);
 
 typedef struct NetClientInfo {
     NetClientOptionsKind type;
@@ -73,6 +75,8 @@ typedef struct NetClientInfo {
     UsingVnetHdr *using_vnet_hdr;
     SetOffload *set_offload;
     SetVnetHdrLen *set_vnet_hdr_len;
+    SetVnetLE *set_vnet_le;
+    SetVnetBE *set_vnet_be;
 } NetClientInfo;
 
 struct NetClientState {
@@ -138,6 +142,8 @@ void qemu_using_vnet_hdr(NetClientState *nc, bool enable);
 void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                       int ecn, int ufo);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
+int qemu_set_vnet_le(NetClientState *nc, bool is_le);
+int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
 int qemu_show_nic_models(const char *arg, const char *const *models);
 void qemu_check_nic_model(NICInfo *nd, const char *model);
diff --git a/net/net.c b/net/net.c
index 0be084d..eb8ef3e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -452,6 +452,24 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
     nc->info->set_vnet_hdr_len(nc, len);
 }
 
+int qemu_set_vnet_le(NetClientState *nc, bool is_le)
+{
+    if (!nc || !nc->info->set_vnet_le) {
+        return -ENOSYS;
+    }
+
+    return nc->info->set_vnet_le(nc, is_le);
+}
+
+int qemu_set_vnet_be(NetClientState *nc, bool is_be)
+{
+    if (!nc || !nc->info->set_vnet_be) {
+        return -ENOSYS;
+    }
+
+    return nc->info->set_vnet_be(nc, is_be);
+}
+
 int qemu_can_send_packet(NetClientState *sender)
 {
     int vm_running = runstate_is_running();
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 812bf2d..15b57a7 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -198,6 +198,40 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
     }
 }
 
+int tap_fd_set_vnet_le(int fd, int is_le)
+{
+    int arg = is_le ? 1 : 0;
+
+    if (!ioctl(fd, TUNSETVNETLE, &arg)) {
+        return 0;
+    }
+
+    /* Check if our kernel supports TUNSETVNETLE */
+    if (errno == EINVAL) {
+        return -errno;
+    }
+
+    error_report("TUNSETVNETLE ioctl() failed: %s.\n", strerror(errno));
+    abort();
+}
+
+int tap_fd_set_vnet_be(int fd, int is_be)
+{
+    int arg = is_be ? 1 : 0;
+
+    if (!ioctl(fd, TUNSETVNETBE, &arg)) {
+        return 0;
+    }
+
+    /* Check if our kernel supports TUNSETVNETBE */
+    if (errno == EINVAL) {
+        return -errno;
+    }
+
+    error_report("TUNSETVNETBE ioctl() failed: %s.\n", strerror(errno));
+    abort();
+}
+
 void tap_fd_set_offload(int fd, int csum, int tso4,
                         int tso6, int ecn, int ufo)
 {
diff --git a/net/tap-linux.h b/net/tap-linux.h
index 1cf35d4..01dc6f8 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -30,6 +30,8 @@
 #define TUNGETVNETHDRSZ _IOR('T', 215, int)
 #define TUNSETVNETHDRSZ _IOW('T', 216, int)
 #define TUNSETQUEUE  _IOW('T', 217, int)
+#define TUNSETVNETLE _IOW('T', 220, int)
+#define TUNSETVNETBE _IOW('T', 222, int)
 
 #endif
 
diff --git a/net/tap.c b/net/tap.c
index 968df46..c6f9a7d 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -274,6 +274,20 @@ static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
     s->using_vnet_hdr = using_vnet_hdr;
 }
 
+static int tap_set_vnet_le(NetClientState *nc, bool is_le)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    return tap_fd_set_vnet_le(s->fd, is_le);
+}
+
+static int tap_set_vnet_be(NetClientState *nc, bool is_be)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    return tap_fd_set_vnet_be(s->fd, is_be);
+}
+
 static void tap_set_offload(NetClientState *nc, int csum, int tso4,
                      int tso6, int ecn, int ufo)
 {
@@ -335,6 +349,8 @@ static NetClientInfo net_tap_info = {
     .using_vnet_hdr = tap_using_vnet_hdr,
     .set_offload = tap_set_offload,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
+    .set_vnet_le = tap_set_vnet_le,
+    .set_vnet_be = tap_set_vnet_be,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
diff --git a/net/tap_int.h b/net/tap_int.h
index 79afdf2..5cb79fc 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -40,6 +40,8 @@ int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
+int tap_fd_set_vnet_le(int fd, int vnet_is_le);
+int tap_fd_set_vnet_be(int fd, int vnet_is_be);
 int tap_fd_enable(int fd);
 int tap_fd_disable(int fd);
 int tap_fd_get_ifname(int fd, char *ifname);
