From: Jason Wang <jasowang@redhat.com>
Subject: [RFC V3 3/5] net: multiqueue support
Date: Fri,  6 Jul 2012 17:31:08 +0800
Message-ID: <1341567070-14136-4-git-send-email-jasowang__10217.6119843081$1341567488$gmane$org@redhat.com>
References: <1341567070-14136-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1341567070-14136-1-git-send-email-jasowang@redhat.com>
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

This patch adds the multiqueues support for emulated nics. Each VLANClientState
pairs are now abstract as a queue instead of a nic, and multiple VLANClientState
pointers were stored in the NICState. A queue_index were also introduced to let
the emulated nics know which queue the packet were came from or sent
out. Virtio-net would be the first user.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/dp8393x.c         |    2 +-
 hw/mcf_fec.c         |    2 +-
 hw/qdev-properties.c |   34 +++++++++++++++++----
 hw/qdev.h            |    3 +-
 net.c                |   79 +++++++++++++++++++++++++++++++++++++++++---------
 net.h                |   16 +++++++--
 net/tap.c            |    2 +-
 7 files changed, 110 insertions(+), 28 deletions(-)

diff --git a/hw/dp8393x.c b/hw/dp8393x.c
index 017d074..483a868 100644
--- a/hw/dp8393x.c
+++ b/hw/dp8393x.c
@@ -900,7 +900,7 @@ void dp83932_init(NICInfo *nd, target_phys_addr_t base, int it_shift,
 
     s->conf.macaddr = nd->macaddr;
     s->conf.vlan = nd->vlan;
-    s->conf.peer = nd->netdev;
+    s->conf.peers[0] = nd->netdev;
 
     s->nic = qemu_new_nic(&net_dp83932_info, &s->conf, nd->model, nd->name, s);
 
diff --git a/hw/mcf_fec.c b/hw/mcf_fec.c
index ae37bef..69f508d 100644
--- a/hw/mcf_fec.c
+++ b/hw/mcf_fec.c
@@ -473,7 +473,7 @@ void mcf_fec_init(MemoryRegion *sysmem, NICInfo *nd,
 
     s->conf.macaddr = nd->macaddr;
     s->conf.vlan = nd->vlan;
-    s->conf.peer = nd->netdev;
+    s->conf.peers[0] = nd->netdev;
 
     s->nic = qemu_new_nic(&net_mcf_fec_info, &s->conf, nd->model, nd->name, s);
 
diff --git a/hw/qdev-properties.c b/hw/qdev-properties.c
index 9ae3187..88e97e9 100644
--- a/hw/qdev-properties.c
+++ b/hw/qdev-properties.c
@@ -554,16 +554,38 @@ PropertyInfo qdev_prop_chr = {
 
 static int parse_netdev(DeviceState *dev, const char *str, void **ptr)
 {
-    VLANClientState *netdev = qemu_find_netdev(str);
+    VLANClientState ***nc = (VLANClientState ***)ptr;
+    VLANClientState *vcs[MAX_QUEUE_NUM];
+    int queues, i = 0;
+    int ret;
 
-    if (netdev == NULL) {
-        return -ENOENT;
+    *nc = g_malloc(MAX_QUEUE_NUM * sizeof(VLANClientState *));
+    queues = qemu_find_netdev_all(str, vcs, MAX_QUEUE_NUM);
+    if (queues == 0) {
+        ret = -ENOENT;
+        goto err;
     }
-    if (netdev->peer) {
-        return -EEXIST;
+
+    for (i = 0; i < queues; i++) {
+        if (vcs[i] == NULL) {
+            ret = -ENOENT;
+            goto err;
+        }
+
+        if (vcs[i]->peer) {
+            ret = -EEXIST;
+            goto err;
+        }
+
+        (*nc)[i] = vcs[i];
+	vcs[i]->queue_index = i;
     }
-    *ptr = netdev;
+
     return 0;
+
+err:
+    g_free(*nc);
+    return ret;
 }
 
 static const char *print_netdev(void *ptr)
diff --git a/hw/qdev.h b/hw/qdev.h
index 5386b16..1c023b4 100644
--- a/hw/qdev.h
+++ b/hw/qdev.h
@@ -248,6 +248,7 @@ extern PropertyInfo qdev_prop_blocksize;
         .defval    = (bool)_defval,                              \
         }
 
+
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_DEFAULT(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
@@ -274,7 +275,7 @@ extern PropertyInfo qdev_prop_blocksize;
 #define DEFINE_PROP_STRING(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
 #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, VLANClientState*)
+    DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, VLANClientState**)
 #define DEFINE_PROP_VLAN(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_vlan, VLANState*)
 #define DEFINE_PROP_DRIVE(_n, _s, _f) \
diff --git a/net.c b/net.c
index eabe830..f5db537 100644
--- a/net.c
+++ b/net.c
@@ -238,16 +238,33 @@ NICState *qemu_new_nic(NetClientInfo *info,
 {
     VLANClientState *nc;
     NICState *nic;
+    int i;
 
     assert(info->type == NET_CLIENT_TYPE_NIC);
     assert(info->size >= sizeof(NICState));
 
-    nc = qemu_new_net_client(info, conf->vlan, conf->peer, model, name);
+    if (conf->peers) {
+        nc = qemu_new_net_client(info, NULL, conf->peers[0], model, name);
+    } else {
+        nc = qemu_new_net_client(info, conf->vlan, NULL, model, name);
+    }
 
     nic = DO_UPCAST(NICState, nc, nc);
     nic->conf = conf;
     nic->opaque = opaque;
 
+    /* For compatiablity with single queue nic */
+    nic->ncs[0] = nc;
+    nc->opaque = nic;
+
+    for (i = 1 ; i < conf->queues; i++) {
+        VLANClientState *vc = qemu_new_net_client(info, NULL, conf->peers[i],
+                                                  model, name);
+        vc->opaque = nic;
+        nic->ncs[i] = vc;
+        vc->queue_index = i;
+    }
+
     return nic;
 }
 
@@ -283,11 +300,10 @@ void qemu_del_vlan_client(VLANClientState *vc)
 {
     /* If there is a peer NIC, delete and cleanup client, but do not free. */
     if (!vc->vlan && vc->peer && vc->peer->info->type == NET_CLIENT_TYPE_NIC) {
-        NICState *nic = DO_UPCAST(NICState, nc, vc->peer);
-        if (nic->peer_deleted) {
+        if (vc->peer_deleted) {
             return;
         }
-        nic->peer_deleted = true;
+        vc->peer_deleted = true;
         /* Let NIC know peer is gone. */
         vc->peer->link_down = true;
         if (vc->peer->info->link_status_changed) {
@@ -299,8 +315,7 @@ void qemu_del_vlan_client(VLANClientState *vc)
 
     /* If this is a peer NIC and peer has already been deleted, free it now. */
     if (!vc->vlan && vc->peer && vc->info->type == NET_CLIENT_TYPE_NIC) {
-        NICState *nic = DO_UPCAST(NICState, nc, vc);
-        if (nic->peer_deleted) {
+        if (vc->peer_deleted) {
             qemu_free_vlan_client(vc->peer);
         }
     }
@@ -342,14 +357,14 @@ void qemu_foreach_nic(qemu_nic_foreach func, void *opaque)
 
     QTAILQ_FOREACH(nc, &non_vlan_clients, next) {
         if (nc->info->type == NET_CLIENT_TYPE_NIC) {
-            func(DO_UPCAST(NICState, nc, nc), opaque);
+            func((NICState *)nc->opaque, opaque);
         }
     }
 
     QTAILQ_FOREACH(vlan, &vlans, next) {
         QTAILQ_FOREACH(nc, &vlan->clients, next) {
             if (nc->info->type == NET_CLIENT_TYPE_NIC) {
-                func(DO_UPCAST(NICState, nc, nc), opaque);
+                func((NICState *)nc->opaque, opaque);
             }
         }
     }
@@ -674,6 +689,26 @@ VLANClientState *qemu_find_netdev(const char *id)
     return NULL;
 }
 
+int qemu_find_netdev_all(const char *id, VLANClientState **vcs, int max)
+{
+    VLANClientState *vc;
+    int ret = 0;
+
+    QTAILQ_FOREACH(vc, &non_vlan_clients, next) {
+        if (vc->info->type == NET_CLIENT_TYPE_NIC) {
+            continue;
+        }
+        if (!strcmp(vc->name, id) && ret < max) {
+            vcs[ret++] = vc;
+        }
+        if (ret >= max) {
+            break;
+        }
+    }
+
+    return ret;
+}
+
 static int nic_get_free_idx(void)
 {
     int index;
@@ -1275,22 +1310,27 @@ exit_err:
 
 void qmp_netdev_del(const char *id, Error **errp)
 {
-    VLANClientState *vc;
+    VLANClientState *vcs[MAX_QUEUE_NUM];
+    int queues, i;
 
-    vc = qemu_find_netdev(id);
-    if (!vc) {
+    queues = qemu_find_netdev_all(id, vcs, MAX_QUEUE_NUM);
+    if (queues == 0) {
         error_set(errp, QERR_DEVICE_NOT_FOUND, id);
         return;
     }
 
-    qemu_del_vlan_client(vc);
+    for (i = 0; i < queues; i++) {
+        /* FIXME: pointer check? */
+        qemu_del_vlan_client(vcs[i]);
+    }
     qemu_opts_del(qemu_opts_find(qemu_find_opts_err("netdev", errp), id));
 }
 
 static void print_net_client(Monitor *mon, VLANClientState *vc)
 {
-    monitor_printf(mon, "%s: type=%s,%s\n", vc->name,
-                   net_client_types[vc->info->type].type, vc->info_str);
+    monitor_printf(mon, "%s: type=%s,%s, queue=%d\n", vc->name,
+                   net_client_types[vc->info->type].type, vc->info_str,
+                   vc->queue_index);
 }
 
 void do_info_network(Monitor *mon)
@@ -1326,6 +1366,17 @@ void qmp_set_link(const char *name, bool up, Error **errp)
 {
     VLANState *vlan;
     VLANClientState *vc = NULL;
+    VLANClientState *vcs[MAX_QUEUE_NUM];
+    int queues, i;
+
+    queues = qemu_find_netdev_all(name, vcs, MAX_QUEUE_NUM);
+    if (queues) {
+	    for (i = 1; i < queues; i++) {
+		    vcs[i]->link_down = !up;
+	    }
+	    vc = vcs[0];
+	    goto done;
+    }
 
     QTAILQ_FOREACH(vlan, &vlans, next) {
         QTAILQ_FOREACH(vc, &vlan->clients, next) {
diff --git a/net.h b/net.h
index bdc2a06..40378ce 100644
--- a/net.h
+++ b/net.h
@@ -12,20 +12,24 @@ struct MACAddr {
     uint8_t a[6];
 };
 
+#define MAX_QUEUE_NUM 32
+
 /* qdev nic properties */
 
 typedef struct NICConf {
     MACAddr macaddr;
     VLANState *vlan;
-    VLANClientState *peer;
+    VLANClientState **peers;
     int32_t bootindex;
+    int32_t queues;
 } NICConf;
 
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
     DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
     DEFINE_PROP_VLAN("vlan",     _state, _conf.vlan),                   \
-    DEFINE_PROP_NETDEV("netdev", _state, _conf.peer),                   \
-    DEFINE_PROP_INT32("bootindex", _state, _conf.bootindex, -1)
+    DEFINE_PROP_NETDEV("netdev", _state, _conf.peers),                   \
+    DEFINE_PROP_INT32("bootindex", _state, _conf.bootindex, -1),        \
+    DEFINE_PROP_INT32("queues", _state, _conf.queues, 1)
 
 /* VLANs support */
 
@@ -72,13 +76,16 @@ struct VLANClientState {
     char *name;
     char info_str[256];
     unsigned receive_disabled : 1;
+    unsigned int queue_index;
+    bool peer_deleted;
+    void *opaque;
 };
 
 typedef struct NICState {
     VLANClientState nc;
+    VLANClientState *ncs[MAX_QUEUE_NUM];
     NICConf *conf;
     void *opaque;
-    bool peer_deleted;
 } NICState;
 
 struct VLANState {
@@ -90,6 +97,7 @@ struct VLANState {
 
 VLANState *qemu_find_vlan(int id, int allocate);
 VLANClientState *qemu_find_netdev(const char *id);
+int qemu_find_netdev_all(const char *id, VLANClientState **vcs, int max);
 VLANClientState *qemu_new_net_client(NetClientInfo *info,
                                      VLANState *vlan,
                                      VLANClientState *peer,
diff --git a/net/tap.c b/net/tap.c
index 65457e5..4ce83b8 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -290,7 +290,7 @@ static void tap_cleanup(VLANClientState *nc)
 
     qemu_purge_queued_packets(nc);
 
-    if (s->down_script[0])
+    if (s->down_script[0] && nc->queue_index == 0)
         launch_script(s->down_script, s->down_script_arg, s->fd);
 
     tap_read_poll(s, 0);
-- 
1.7.1
