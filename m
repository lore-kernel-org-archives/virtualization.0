From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC V2 PATCH 4/4] virtio-net: add multiqueue support
Date: Mon, 2 Jul 2012 10:34:53 +0300
Message-ID: <20120702073453.GD8268@redhat.com>
References: <20120625095059.8096.49429.stgit@amd-6168-8-1.englab.nay.redhat.com>
	<20120625100449.8096.65545.stgit@amd-6168-8-1.englab.nay.redhat.com>
	<20120701094321.GA4642@redhat.com> <4FF147E0.7090903@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4FF147E0.7090903@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: krkumar2@in.ibm.com, habanero@linux.vnet.ibm.com, aliguori@us.ibm.com, mashirle@us.ibm.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, tahm@linux.vnet.ibm.com, jwhan@filewood.snu.ac.kr
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 02, 2012 at 03:04:00PM +0800, Jason Wang wrote:
> On 07/01/2012 05:43 PM, Michael S. Tsirkin wrote:
> >On Mon, Jun 25, 2012 at 06:04:49PM +0800, Jason Wang wrote:
> >>This patch let the virtio-net can transmit and recevie packets through multiuple
> >>VLANClientStates and abstract them as multiple virtqueues to guest. A new
> >>parameter 'queues' were introduced to specify the number of queue pairs.
> >>
> >>The main goal for vhost support is to let the multiqueue could be used without
> >>changes in vhost code. So each vhost_net structure were used to track a single
> >>VLANClientState and two virtqueues in the past. As multiple VLANClientState were
> >>stored in the NICState, we can infer the correspond VLANClientState from this
> >>and queue_index easily.
> >>
> >>Signed-off-by: Jason Wang<jasowang@redhat.com>
> >Can this patch be split up?
> >1. extend vhost API to allow multiqueue and minimally tweak virtio
> >2. add real multiqueue for virtio
> >
> >Hmm?
> 
> Sure, do you think it's necessary to separate the vhost parts of
> multiqueue from virtio?

Separating is always nice if it is not too hard.

> >>---
> >>  hw/vhost.c      |   58 ++++---
> >>  hw/vhost.h      |    1
> >>  hw/vhost_net.c  |    7 +
> >>  hw/vhost_net.h  |    2
> >>  hw/virtio-net.c |  461 +++++++++++++++++++++++++++++++++++++------------------
> >>  hw/virtio-net.h |    3
> >>  6 files changed, 355 insertions(+), 177 deletions(-)
> >>
> >>diff --git a/hw/vhost.c b/hw/vhost.c
> >>index 43664e7..6318bb2 100644
> >>--- a/hw/vhost.c
> >>+++ b/hw/vhost.c
> >>@@ -620,11 +620,12 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
> >>  {
> >>      target_phys_addr_t s, l, a;
> >>      int r;
> >>+    int vhost_vq_index = (idx>  2 ? idx - 1 : idx) % dev->nvqs;
> >>      struct vhost_vring_file file = {
> >>-        .index = idx,
> >>+	.index = vhost_vq_index
> >>      };
> >>      struct vhost_vring_state state = {
> >>-        .index = idx,
> >>+        .index = vhost_vq_index
> >>      };
> >>      struct VirtQueue *vvq = virtio_get_queue(vdev, idx);
> >>
> >>@@ -670,11 +671,12 @@ static int vhost_virtqueue_init(struct vhost_dev *dev,
> >>          goto fail_alloc_ring;
> >>      }
> >>
> >>-    r = vhost_virtqueue_set_addr(dev, vq, idx, dev->log_enabled);
> >>+    r = vhost_virtqueue_set_addr(dev, vq, vhost_vq_index, dev->log_enabled);
> >>      if (r<  0) {
> >>          r = -errno;
> >>          goto fail_alloc;
> >>      }
> >>+
> >>      file.fd = event_notifier_get_fd(virtio_queue_get_host_notifier(vvq));
> >>      r = ioctl(dev->control, VHOST_SET_VRING_KICK,&file);
> >>      if (r) {
> >>@@ -715,7 +717,7 @@ static void vhost_virtqueue_cleanup(struct vhost_dev *dev,
> >>                                      unsigned idx)
> >>  {
> >>      struct vhost_vring_state state = {
> >>-        .index = idx,
> >>+        .index = (idx>  2 ? idx - 1 : idx) % dev->nvqs,
> >>      };
> >>      int r;
> >>      r = ioctl(dev->control, VHOST_GET_VRING_BASE,&state);
> >>@@ -829,7 +831,9 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
> >>      }
> >>
> >>      for (i = 0; i<  hdev->nvqs; ++i) {
> >>-        r = vdev->binding->set_host_notifier(vdev->binding_opaque, i, true);
> >>+        r = vdev->binding->set_host_notifier(vdev->binding_opaque,
> >>+					     hdev->start_idx + i,
> >>+					     true);
> >>          if (r<  0) {
> >>              fprintf(stderr, "vhost VQ %d notifier binding failed: %d\n", i, -r);
> >>              goto fail_vq;
> >>@@ -839,7 +843,9 @@ int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
> >>      return 0;
> >>  fail_vq:
> >>      while (--i>= 0) {
> >>-        r = vdev->binding->set_host_notifier(vdev->binding_opaque, i, false);
> >>+        r = vdev->binding->set_host_notifier(vdev->binding_opaque,
> >>+					     hdev->start_idx + i,
> >>+					     false);
> >>          if (r<  0) {
> >>              fprintf(stderr, "vhost VQ %d notifier cleanup error: %d\n", i, -r);
> >>              fflush(stderr);
> >>@@ -860,7 +866,9 @@ void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev)
> >>      int i, r;
> >>
> >>      for (i = 0; i<  hdev->nvqs; ++i) {
> >>-        r = vdev->binding->set_host_notifier(vdev->binding_opaque, i, false);
> >>+        r = vdev->binding->set_host_notifier(vdev->binding_opaque,
> >>+					     hdev->start_idx + i,
> >>+					     false);
> >>          if (r<  0) {
> >>              fprintf(stderr, "vhost VQ %d notifier cleanup failed: %d\n", i, -r);
> >>              fflush(stderr);
> >>@@ -874,15 +882,17 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >>  {
> >>      int i, r;
> >>      if (!vdev->binding->set_guest_notifiers) {
> >>-        fprintf(stderr, "binding does not support guest notifiers\n");
> >>+        fprintf(stderr, "binding does not support guest notifier\n");
> >>          r = -ENOSYS;
> >>          goto fail;
> >>      }
> >>
> >>-    r = vdev->binding->set_guest_notifiers(vdev->binding_opaque, true);
> >>-    if (r<  0) {
> >>-        fprintf(stderr, "Error binding guest notifier: %d\n", -r);
> >>-        goto fail_notifiers;
> >>+    if (hdev->start_idx == 0) {
> >>+        r = vdev->binding->set_guest_notifiers(vdev->binding_opaque, true);
> >>+        if (r<  0) {
> >>+            fprintf(stderr, "Error binding guest notifier: %d\n", -r);
> >>+            goto fail_notifiers;
> >>+        }
> >>      }
> >>
> >>      r = vhost_dev_set_features(hdev, hdev->log_enabled);
> >>@@ -898,7 +908,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
> >>          r = vhost_virtqueue_init(hdev,
> >>                                   vdev,
> >>                                   hdev->vqs + i,
> >>-                                 i);
> >>+                                 hdev->start_idx + i);
> >>          if (r<  0) {
> >>              goto fail_vq;
> >>          }
> >>@@ -925,11 +935,13 @@ fail_vq:
> >>          vhost_virtqueue_cleanup(hdev,
> >>                                  vdev,
> >>                                  hdev->vqs + i,
> >>-                                i);
> >>+                                hdev->start_idx + i);
> >>      }
> >>+    i = hdev->nvqs;
> >>  fail_mem:
> >>  fail_features:
> >>-    vdev->binding->set_guest_notifiers(vdev->binding_opaque, false);
> >>+    if (hdev->start_idx == 0)
> >>+        vdev->binding->set_guest_notifiers(vdev->binding_opaque, false);
> >>  fail_notifiers:
> >>  fail:
> >>      return r;
> >>@@ -944,18 +956,22 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
> >>          vhost_virtqueue_cleanup(hdev,
> >>                                  vdev,
> >>                                  hdev->vqs + i,
> >>-                                i);
> >>+                                hdev->start_idx + i);
> >>      }
> >>+
> >>      for (i = 0; i<  hdev->n_mem_sections; ++i) {
> >>          vhost_sync_dirty_bitmap(hdev,&hdev->mem_sections[i],
> >>                                  0, (target_phys_addr_t)~0x0ull);
> >>      }
> >>-    r = vdev->binding->set_guest_notifiers(vdev->binding_opaque, false);
> >>-    if (r<  0) {
> >>-        fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", r);
> >>-        fflush(stderr);
> >>+
> >>+    if (hdev->start_idx == 0) {
> >>+	r = vdev->binding->set_guest_notifiers(vdev->binding_opaque, false);
> >>+	if (r<  0) {
> >>+	    fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", r);
> >>+	    fflush(stderr);
> >>+	}
> >>+	assert (r>= 0);
> >>      }
> >>-    assert (r>= 0);
> >>
> >>      hdev->started = false;
> >>      g_free(hdev->log);
> >>diff --git a/hw/vhost.h b/hw/vhost.h
> >>index 80e64df..fa5357a 100644
> >>--- a/hw/vhost.h
> >>+++ b/hw/vhost.h
> >>@@ -34,6 +34,7 @@ struct vhost_dev {
> >>      MemoryRegionSection *mem_sections;
> >>      struct vhost_virtqueue *vqs;
> >>      int nvqs;
> >>+    int start_idx;
> >>      unsigned long long features;
> >>      unsigned long long acked_features;
> >>      unsigned long long backend_features;
> >>diff --git a/hw/vhost_net.c b/hw/vhost_net.c
> >>index f672e9d..73a72bb 100644
> >>--- a/hw/vhost_net.c
> >>+++ b/hw/vhost_net.c
> >>@@ -138,13 +138,15 @@ bool vhost_net_query(VHostNetState *net, VirtIODevice *dev)
> >>  }
> >>
> >>  int vhost_net_start(struct vhost_net *net,
> >>-                    VirtIODevice *dev)
> >>+                    VirtIODevice *dev,
> >>+                    int start_idx)
> >>  {
> >>      struct vhost_vring_file file = { };
> >>      int r;
> >>
> >>      net->dev.nvqs = 2;
> >>      net->dev.vqs = net->vqs;
> >>+    net->dev.start_idx = start_idx;
> >>
> >>      r = vhost_dev_enable_notifiers(&net->dev, dev);
> >>      if (r<  0) {
> >>@@ -227,7 +229,8 @@ bool vhost_net_query(VHostNetState *net, VirtIODevice *dev)
> >>  }
> >>
> >>  int vhost_net_start(struct vhost_net *net,
> >>-		    VirtIODevice *dev)
> >>+                    VirtIODevice *dev,
> >>+                    int start_idx)
> >>  {
> >>      return -ENOSYS;
> >>  }
> >>diff --git a/hw/vhost_net.h b/hw/vhost_net.h
> >>index 91e40b1..79a4f09 100644
> >>--- a/hw/vhost_net.h
> >>+++ b/hw/vhost_net.h
> >>@@ -9,7 +9,7 @@ typedef struct vhost_net VHostNetState;
> >>  VHostNetState *vhost_net_init(VLANClientState *backend, int devfd, bool force);
> >>
> >>  bool vhost_net_query(VHostNetState *net, VirtIODevice *dev);
> >>-int vhost_net_start(VHostNetState *net, VirtIODevice *dev);
> >>+int vhost_net_start(VHostNetState *net, VirtIODevice *dev, int start_idx);
> >>  void vhost_net_stop(VHostNetState *net, VirtIODevice *dev);
> >>
> >>  void vhost_net_cleanup(VHostNetState *net);
> >>diff --git a/hw/virtio-net.c b/hw/virtio-net.c
> >>index 3f190d4..d42c4cc 100644
> >>--- a/hw/virtio-net.c
> >>+++ b/hw/virtio-net.c
> >>@@ -26,34 +26,43 @@
> >>  #define MAC_TABLE_ENTRIES    64
> >>  #define MAX_VLAN    (1<<  12)   /* Per 802.1Q definition */
> >>
> >>-typedef struct VirtIONet
> >>+struct VirtIONet;
> >>+
> >>+typedef struct VirtIONetQueue
> >>  {
> >>-    VirtIODevice vdev;
> >>-    uint8_t mac[ETH_ALEN];
> >>-    uint16_t status;
> >>      VirtQueue *rx_vq;
> >>      VirtQueue *tx_vq;
> >>-    VirtQueue *ctrl_vq;
> >>-    NICState *nic;
> >>      QEMUTimer *tx_timer;
> >>      QEMUBH *tx_bh;
> >>      uint32_t tx_timeout;
> >>-    int32_t tx_burst;
> >>      int tx_waiting;
> >>-    uint32_t has_vnet_hdr;
> >>-    uint8_t has_ufo;
> >>      struct {
> >>          VirtQueueElement elem;
> >>          ssize_t len;
> >>      } async_tx;
> >>+    struct VirtIONet *n;
> >>+    uint8_t vhost_started;
> >>+} VirtIONetQueue;
> >>+
> >>+typedef struct VirtIONet
> >>+{
> >>+    VirtIODevice vdev;
> >>+    uint8_t mac[ETH_ALEN];
> >>+    uint16_t status;
> >>+    VirtIONetQueue vqs[MAX_QUEUE_NUM];
> >>+    VirtQueue *ctrl_vq;
> >>+    NICState *nic;
> >>+    int32_t tx_burst;
> >>+    uint32_t has_vnet_hdr;
> >>+    uint8_t has_ufo;
> >>      int mergeable_rx_bufs;
> >>+    int multiqueue;
> >>      uint8_t promisc;
> >>      uint8_t allmulti;
> >>      uint8_t alluni;
> >>      uint8_t nomulti;
> >>      uint8_t nouni;
> >>      uint8_t nobcast;
> >>-    uint8_t vhost_started;
> >>      struct {
> >>          int in_use;
> >>          int first_multi;
> >>@@ -63,6 +72,7 @@ typedef struct VirtIONet
> >>      } mac_table;
> >>      uint32_t *vlans;
> >>      DeviceState *qdev;
> >>+    uint32_t queues;
> >>  } VirtIONet;
> >>
> >>  /* TODO
> >>@@ -74,12 +84,25 @@ static VirtIONet *to_virtio_net(VirtIODevice *vdev)
> >>      return (VirtIONet *)vdev;
> >>  }
> >>
> >>+static int vq_get_pair_index(VirtIONet *n, VirtQueue *vq)
> >>+{
> >>+    int i;
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        if (n->vqs[i].tx_vq == vq || n->vqs[i].rx_vq == vq) {
> >>+            return i;
> >>+        }
> >>+    }
> >>+    assert(1);
> >>+    return -1;
> >>+}
> >>+
> >>  static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
> >>  {
> >>      VirtIONet *n = to_virtio_net(vdev);
> >>      struct virtio_net_config netcfg;
> >>
> >>      stw_p(&netcfg.status, n->status);
> >>+    netcfg.queues = n->queues * 2;
> >>      memcpy(netcfg.mac, n->mac, ETH_ALEN);
> >>      memcpy(config,&netcfg, sizeof(netcfg));
> >>  }
> >>@@ -103,78 +126,140 @@ static bool virtio_net_started(VirtIONet *n, uint8_t status)
> >>          (n->status&  VIRTIO_NET_S_LINK_UP)&&  n->vdev.vm_running;
> >>  }
> >>
> >>-static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
> >>+static void nc_vhost_status(VLANClientState *nc, VirtIONet *n,
> >>+                            uint8_t status)
> >>  {
> >>-    if (!n->nic->nc.peer) {
> >>+    int queue_index = nc->queue_index;
> >>+    VLANClientState *peer = nc->peer;
> >>+    VirtIONetQueue *netq =&n->vqs[nc->queue_index];
> >>+
> >>+    if (!peer) {
> >>          return;
> >>      }
> >>-    if (n->nic->nc.peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>+    if (peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>          return;
> >>      }
> >>
> >>-    if (!tap_get_vhost_net(n->nic->nc.peer)) {
> >>+    if (!tap_get_vhost_net(peer)) {
> >>          return;
> >>      }
> >>-    if (!!n->vhost_started == virtio_net_started(n, status)&&
> >>-                              !n->nic->nc.peer->link_down) {
> >>+    if (!!netq->vhost_started == virtio_net_started(n, status)&&
> >>+                                 !peer->link_down) {
> >>          return;
> >>      }
> >>-    if (!n->vhost_started) {
> >>-        int r;
> >>-        if (!vhost_net_query(tap_get_vhost_net(n->nic->nc.peer),&n->vdev)) {
> >>+    if (!netq->vhost_started) {
> >>+	/* skip ctrl vq */
> >>+	int r, start_idx = queue_index == 0 ? 0 : queue_index * 2 + 1;
> >>+        if (!vhost_net_query(tap_get_vhost_net(peer),&n->vdev)) {
> >>              return;
> >>          }
> >>-        r = vhost_net_start(tap_get_vhost_net(n->nic->nc.peer),&n->vdev);
> >>+        r = vhost_net_start(tap_get_vhost_net(peer),&n->vdev, start_idx);
> >>          if (r<  0) {
> >>              error_report("unable to start vhost net: %d: "
> >>                           "falling back on userspace virtio", -r);
> >>          } else {
> >>-            n->vhost_started = 1;
> >>+            netq->vhost_started = 1;
> >>          }
> >>      } else {
> >>-        vhost_net_stop(tap_get_vhost_net(n->nic->nc.peer),&n->vdev);
> >>-        n->vhost_started = 0;
> >>+        vhost_net_stop(tap_get_vhost_net(peer),&n->vdev);
> >>+        netq->vhost_started = 0;
> >>+    }
> >>+}
> >>+
> >>+static int peer_attach(VirtIONet *n, int index)
> >>+{
> >>+    if (!n->nic->ncs[index]->peer) {
> >>+	return -1;
> >>+    }
> >>+
> >>+    if (n->nic->ncs[index]->peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>+	return -1;
> >>+    }
> >>+
> >>+    return tap_attach(n->nic->ncs[index]->peer);
> >>+}
> >>+
> >>+static int peer_detach(VirtIONet *n, int index)
> >>+{
> >>+    if (!n->nic->ncs[index]->peer) {
> >>+	return -1;
> >>+    }
> >>+
> >>+    if (n->nic->ncs[index]->peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>+	return -1;
> >>+    }
> >>+
> >>+    return tap_detach(n->nic->ncs[index]->peer);
> >>+}
> >>+
> >>+static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
> >>+{
> >>+    int i;
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+	if (!n->multiqueue&&  i != 0)
> >>+	    status = 0;
> >>+        nc_vhost_status(n->nic->ncs[i], n, status);
> >>      }
> >>  }
> >>
> >>  static void virtio_net_set_status(struct VirtIODevice *vdev, uint8_t status)
> >>  {
> >>      VirtIONet *n = to_virtio_net(vdev);
> >>+    int i;
> >>
> >>      virtio_net_vhost_status(n, status);
> >>
> >>-    if (!n->tx_waiting) {
> >>-        return;
> >>-    }
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        VirtIONetQueue *netq =&n->vqs[i];
> >>+        if (!netq->tx_waiting) {
> >>+            continue;
> >>+        }
> >>+
> >>+	if (!n->multiqueue&&  i != 0)
> >>+	    status = 0;
> >>
> >>-    if (virtio_net_started(n, status)&&  !n->vhost_started) {
> >>-        if (n->tx_timer) {
> >>-            qemu_mod_timer(n->tx_timer,
> >>-                           qemu_get_clock_ns(vm_clock) + n->tx_timeout);
> >>+        if (virtio_net_started(n, status)&&  !netq->vhost_started) {
> >>+            if (netq->tx_timer) {
> >>+                qemu_mod_timer(netq->tx_timer,
> >>+                               qemu_get_clock_ns(vm_clock) + netq->tx_timeout);
> >>+            } else {
> >>+                qemu_bh_schedule(netq->tx_bh);
> >>+            }
> >>          } else {
> >>-            qemu_bh_schedule(n->tx_bh);
> >>+            if (netq->tx_timer) {
> >>+                qemu_del_timer(netq->tx_timer);
> >>+            } else {
> >>+                qemu_bh_cancel(netq->tx_bh);
> >>+            }
> >>          }
> >>-    } else {
> >>-        if (n->tx_timer) {
> >>-            qemu_del_timer(n->tx_timer);
> >>-        } else {
> >>-            qemu_bh_cancel(n->tx_bh);
> >>+    }
> >>+}
> >>+
> >>+static bool virtio_net_is_link_up(VirtIONet *n)
> >>+{
> >>+    int i;
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        if (n->nic->ncs[i]->link_down) {
> >>+            return false;
> >>          }
> >>      }
> >>+    return true;
> >>  }
> >>
> >>  static void virtio_net_set_link_status(VLANClientState *nc)
> >>  {
> >>-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
> >>+    VirtIONet *n = ((NICState *)(nc->opaque))->opaque;
> >>      uint16_t old_status = n->status;
> >>
> >>-    if (nc->link_down)
> >>+    if (virtio_net_is_link_up(n)) {
> >>          n->status&= ~VIRTIO_NET_S_LINK_UP;
> >>-    else
> >>+    } else {
> >>          n->status |= VIRTIO_NET_S_LINK_UP;
> >>+    }
> >>
> >>-    if (n->status != old_status)
> >>+    if (n->status != old_status) {
> >>          virtio_notify_config(&n->vdev);
> >>+    }
> >>
> >>      virtio_net_set_status(&n->vdev, n->vdev.status);
> >>  }
> >>@@ -202,13 +287,15 @@ static void virtio_net_reset(VirtIODevice *vdev)
> >>
> >>  static int peer_has_vnet_hdr(VirtIONet *n)
> >>  {
> >>-    if (!n->nic->nc.peer)
> >>+    if (!n->nic->ncs[0]->peer) {
> >>          return 0;
> >>+    }
> >>
> >>-    if (n->nic->nc.peer->info->type != NET_CLIENT_TYPE_TAP)
> >>+    if (n->nic->ncs[0]->peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>          return 0;
> >>+    }
> >>
> >>-    n->has_vnet_hdr = tap_has_vnet_hdr(n->nic->nc.peer);
> >>+    n->has_vnet_hdr = tap_has_vnet_hdr(n->nic->ncs[0]->peer);
> >>
> >>      return n->has_vnet_hdr;
> >>  }
> >>@@ -218,7 +305,7 @@ static int peer_has_ufo(VirtIONet *n)
> >>      if (!peer_has_vnet_hdr(n))
> >>          return 0;
> >>
> >>-    n->has_ufo = tap_has_ufo(n->nic->nc.peer);
> >>+    n->has_ufo = tap_has_ufo(n->nic->ncs[0]->peer);
> >>
> >>      return n->has_ufo;
> >>  }
> >>@@ -228,9 +315,13 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
> >>      VirtIONet *n = to_virtio_net(vdev);
> >>
> >>      features |= (1<<  VIRTIO_NET_F_MAC);
> >>+    features |= (1<<  VIRTIO_NET_F_MULTIQUEUE);
> >>
> >>      if (peer_has_vnet_hdr(n)) {
> >>-        tap_using_vnet_hdr(n->nic->nc.peer, 1);
> >>+        int i;
> >>+        for (i = 0; i<  n->queues; i++) {
> >>+            tap_using_vnet_hdr(n->nic->ncs[i]->peer, 1);
> >>+        }
> >>      } else {
> >>          features&= ~(0x1<<  VIRTIO_NET_F_CSUM);
> >>          features&= ~(0x1<<  VIRTIO_NET_F_HOST_TSO4);
> >>@@ -248,14 +339,15 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, uint32_t features)
> >>          features&= ~(0x1<<  VIRTIO_NET_F_HOST_UFO);
> >>      }
> >>
> >>-    if (!n->nic->nc.peer ||
> >>-        n->nic->nc.peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>+    if (!n->nic->ncs[0]->peer ||
> >>+        n->nic->ncs[0]->peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>          return features;
> >>      }
> >>-    if (!tap_get_vhost_net(n->nic->nc.peer)) {
> >>+    if (!tap_get_vhost_net(n->nic->ncs[0]->peer)) {
> >>          return features;
> >>      }
> >>-    return vhost_net_get_features(tap_get_vhost_net(n->nic->nc.peer), features);
> >>+    return vhost_net_get_features(tap_get_vhost_net(n->nic->ncs[0]->peer),
> >>+                                  features);
> >>  }
> >>
> >>  static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
> >>@@ -276,25 +368,38 @@ static uint32_t virtio_net_bad_features(VirtIODevice *vdev)
> >>  static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
> >>  {
> >>      VirtIONet *n = to_virtio_net(vdev);
> >>+    int i, r;
> >>
> >>      n->mergeable_rx_bufs = !!(features&  (1<<  VIRTIO_NET_F_MRG_RXBUF));
> >>+    n->multiqueue = !!(features&  (1<<  VIRTIO_NET_F_MULTIQUEUE));
> >>
> >>-    if (n->has_vnet_hdr) {
> >>-        tap_set_offload(n->nic->nc.peer,
> >>-                        (features>>  VIRTIO_NET_F_GUEST_CSUM)&  1,
> >>-                        (features>>  VIRTIO_NET_F_GUEST_TSO4)&  1,
> >>-                        (features>>  VIRTIO_NET_F_GUEST_TSO6)&  1,
> >>-                        (features>>  VIRTIO_NET_F_GUEST_ECN)&  1,
> >>-                        (features>>  VIRTIO_NET_F_GUEST_UFO)&  1);
> >>-    }
> >>-    if (!n->nic->nc.peer ||
> >>-        n->nic->nc.peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>-        return;
> >>-    }
> >>-    if (!tap_get_vhost_net(n->nic->nc.peer)) {
> >>-        return;
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        if (!n->multiqueue&&  i != 0) {
> >>+            r = peer_detach(n, i);
> >>+            assert(r == 0);
> >>+        } else {
> >>+            r = peer_attach(n, i);
> >>+            assert(r == 0);
> >>+
> >>+            if (n->has_vnet_hdr) {
> >>+                tap_set_offload(n->nic->ncs[i]->peer,
> >>+                                (features>>  VIRTIO_NET_F_GUEST_CSUM)&  1,
> >>+                                (features>>  VIRTIO_NET_F_GUEST_TSO4)&  1,
> >>+                                (features>>  VIRTIO_NET_F_GUEST_TSO6)&  1,
> >>+                                (features>>  VIRTIO_NET_F_GUEST_ECN)&  1,
> >>+                                (features>>  VIRTIO_NET_F_GUEST_UFO)&  1);
> >>+            }
> >>+            if (!n->nic->ncs[i]->peer ||
> >>+                n->nic->ncs[i]->peer->info->type != NET_CLIENT_TYPE_TAP) {
> >>+                continue;
> >>+            }
> >>+            if (!tap_get_vhost_net(n->nic->ncs[i]->peer)) {
> >>+                continue;
> >>+            }
> >>+            vhost_net_ack_features(tap_get_vhost_net(n->nic->ncs[i]->peer),
> >>+                                   features);
> >>+        }
> >>      }
> >>-    vhost_net_ack_features(tap_get_vhost_net(n->nic->nc.peer), features);
> >>  }
> >>
> >>  static int virtio_net_handle_rx_mode(VirtIONet *n, uint8_t cmd,
> >>@@ -446,7 +551,7 @@ static void virtio_net_handle_rx(VirtIODevice *vdev, VirtQueue *vq)
> >>  {
> >>      VirtIONet *n = to_virtio_net(vdev);
> >>
> >>-    qemu_flush_queued_packets(&n->nic->nc);
> >>+    qemu_flush_queued_packets(n->nic->ncs[vq_get_pair_index(n, vq)]);
> >>
> >>      /* We now have RX buffers, signal to the IO thread to break out of the
> >>       * select to re-poll the tap file descriptor */
> >>@@ -455,36 +560,37 @@ static void virtio_net_handle_rx(VirtIODevice *vdev, VirtQueue *vq)
> >>
> >>  static int virtio_net_can_receive(VLANClientState *nc)
> >>  {
> >>-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
> >>+    int queue_index = nc->queue_index;
> >>+    VirtIONet *n = ((NICState *)nc->opaque)->opaque;
> >>+
> >>      if (!n->vdev.vm_running) {
> >>          return 0;
> >>      }
> >>
> >>-    if (!virtio_queue_ready(n->rx_vq) ||
> >>+    if (!virtio_queue_ready(n->vqs[queue_index].rx_vq) ||
> >>          !(n->vdev.status&  VIRTIO_CONFIG_S_DRIVER_OK))
> >>          return 0;
> >>
> >>      return 1;
> >>  }
> >>
> >>-static int virtio_net_has_buffers(VirtIONet *n, int bufsize)
> >>+static int virtio_net_has_buffers(VirtIONet *n, int bufsize, VirtQueue *vq)
> >>  {
> >>-    if (virtio_queue_empty(n->rx_vq) ||
> >>-        (n->mergeable_rx_bufs&&
> >>-         !virtqueue_avail_bytes(n->rx_vq, bufsize, 0))) {
> >>-        virtio_queue_set_notification(n->rx_vq, 1);
> >>+    if (virtio_queue_empty(vq) || (n->mergeable_rx_bufs&&
> >>+        !virtqueue_avail_bytes(vq, bufsize, 0))) {
> >>+        virtio_queue_set_notification(vq, 1);
> >>
> >>          /* To avoid a race condition where the guest has made some buffers
> >>           * available after the above check but before notification was
> >>           * enabled, check for available buffers again.
> >>           */
> >>-        if (virtio_queue_empty(n->rx_vq) ||
> >>-            (n->mergeable_rx_bufs&&
> >>-             !virtqueue_avail_bytes(n->rx_vq, bufsize, 0)))
> >>+        if (virtio_queue_empty(vq) || (n->mergeable_rx_bufs&&
> >>+            !virtqueue_avail_bytes(vq, bufsize, 0))) {
> >>              return 0;
> >>+        }
> >>      }
> >>
> >>-    virtio_queue_set_notification(n->rx_vq, 0);
> >>+    virtio_queue_set_notification(vq, 0);
> >>      return 1;
> >>  }
> >>
> >>@@ -595,12 +701,15 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
> >>
> >>  static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_t size)
> >>  {
> >>-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
> >>+    int queue_index = nc->queue_index;
> >>+    VirtIONet *n = ((NICState *)(nc->opaque))->opaque;
> >>+    VirtQueue *vq = n->vqs[queue_index].rx_vq;
> >>      struct virtio_net_hdr_mrg_rxbuf *mhdr = NULL;
> >>      size_t guest_hdr_len, offset, i, host_hdr_len;
> >>
> >>-    if (!virtio_net_can_receive(&n->nic->nc))
> >>+    if (!virtio_net_can_receive(n->nic->ncs[queue_index])) {
> >>          return -1;
> >>+    }
> >>
> >>      /* hdr_len refers to the header we supply to the guest */
> >>      guest_hdr_len = n->mergeable_rx_bufs ?
> >>@@ -608,7 +717,7 @@ static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_
> >>
> >>
> >>      host_hdr_len = n->has_vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
> >>-    if (!virtio_net_has_buffers(n, size + guest_hdr_len - host_hdr_len))
> >>+    if (!virtio_net_has_buffers(n, size + guest_hdr_len - host_hdr_len, vq))
> >>          return 0;
> >>
> >>      if (!receive_filter(n, buf, size))
> >>@@ -623,7 +732,7 @@ static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_
> >>
> >>          total = 0;
> >>
> >>-        if (virtqueue_pop(n->rx_vq,&elem) == 0) {
> >>+        if (virtqueue_pop(vq,&elem) == 0) {
> >>              if (i == 0)
> >>                  return -1;
> >>              error_report("virtio-net unexpected empty queue: "
> >>@@ -675,47 +784,50 @@ static ssize_t virtio_net_receive(VLANClientState *nc, const uint8_t *buf, size_
> >>          }
> >>
> >>          /* signal other side */
> >>-        virtqueue_fill(n->rx_vq,&elem, total, i++);
> >>+        virtqueue_fill(vq,&elem, total, i++);
> >>      }
> >>
> >>      if (mhdr) {
> >>          stw_p(&mhdr->num_buffers, i);
> >>      }
> >>
> >>-    virtqueue_flush(n->rx_vq, i);
> >>-    virtio_notify(&n->vdev, n->rx_vq);
> >>+    virtqueue_flush(vq, i);
> >>+    virtio_notify(&n->vdev, vq);
> >>
> >>      return size;
> >>  }
> >>
> >>-static int32_t virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq);
> >>+static int32_t virtio_net_flush_tx(VirtIONet *n, VirtIONetQueue *tvq);
> >>
> >>  static void virtio_net_tx_complete(VLANClientState *nc, ssize_t len)
> >>  {
> >>-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
> >>+    VirtIONet *n = ((NICState *)nc->opaque)->opaque;
> >>+    VirtIONetQueue *netq =&n->vqs[nc->queue_index];
> >>
> >>-    virtqueue_push(n->tx_vq,&n->async_tx.elem, n->async_tx.len);
> >>-    virtio_notify(&n->vdev, n->tx_vq);
> >>+    virtqueue_push(netq->tx_vq,&netq->async_tx.elem, netq->async_tx.len);
> >>+    virtio_notify(&n->vdev, netq->tx_vq);
> >>
> >>-    n->async_tx.elem.out_num = n->async_tx.len = 0;
> >>+    netq->async_tx.elem.out_num = netq->async_tx.len;
> >>
> >>-    virtio_queue_set_notification(n->tx_vq, 1);
> >>-    virtio_net_flush_tx(n, n->tx_vq);
> >>+    virtio_queue_set_notification(netq->tx_vq, 1);
> >>+    virtio_net_flush_tx(n, netq);
> >>  }
> >>
> >>  /* TX */
> >>-static int32_t virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
> >>+static int32_t virtio_net_flush_tx(VirtIONet *n, VirtIONetQueue *netq)
> >>  {
> >>      VirtQueueElement elem;
> >>      int32_t num_packets = 0;
> >>+    VirtQueue *vq = netq->tx_vq;
> >>+
> >>      if (!(n->vdev.status&  VIRTIO_CONFIG_S_DRIVER_OK)) {
> >>          return num_packets;
> >>      }
> >>
> >>      assert(n->vdev.vm_running);
> >>
> >>-    if (n->async_tx.elem.out_num) {
> >>-        virtio_queue_set_notification(n->tx_vq, 0);
> >>+    if (netq->async_tx.elem.out_num) {
> >>+        virtio_queue_set_notification(vq, 0);
> >>          return num_packets;
> >>      }
> >>
> >>@@ -747,12 +859,12 @@ static int32_t virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
> >>              len += hdr_len;
> >>          }
> >>
> >>-        ret = qemu_sendv_packet_async(&n->nic->nc, out_sg, out_num,
> >>-                                      virtio_net_tx_complete);
> >>+        ret = qemu_sendv_packet_async(n->nic->ncs[vq_get_pair_index(n, vq)],
> >>+                                      out_sg, out_num, virtio_net_tx_complete);
> >>          if (ret == 0) {
> >>-            virtio_queue_set_notification(n->tx_vq, 0);
> >>-            n->async_tx.elem = elem;
> >>-            n->async_tx.len  = len;
> >>+            virtio_queue_set_notification(vq, 0);
> >>+            netq->async_tx.elem = elem;
> >>+            netq->async_tx.len  = len;
> >>              return -EBUSY;
> >>          }
> >>
> >>@@ -771,22 +883,23 @@ static int32_t virtio_net_flush_tx(VirtIONet *n, VirtQueue *vq)
> >>  static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
> >>  {
> >>      VirtIONet *n = to_virtio_net(vdev);
> >>+    VirtIONetQueue *netq =&n->vqs[vq_get_pair_index(n, vq)];
> >>
> >>      /* This happens when device was stopped but VCPU wasn't. */
> >>      if (!n->vdev.vm_running) {
> >>-        n->tx_waiting = 1;
> >>+        netq->tx_waiting = 1;
> >>          return;
> >>      }
> >>
> >>-    if (n->tx_waiting) {
> >>+    if (netq->tx_waiting) {
> >>          virtio_queue_set_notification(vq, 1);
> >>-        qemu_del_timer(n->tx_timer);
> >>-        n->tx_waiting = 0;
> >>-        virtio_net_flush_tx(n, vq);
> >>+        qemu_del_timer(netq->tx_timer);
> >>+        netq->tx_waiting = 0;
> >>+        virtio_net_flush_tx(n, netq);
> >>      } else {
> >>-        qemu_mod_timer(n->tx_timer,
> >>-                       qemu_get_clock_ns(vm_clock) + n->tx_timeout);
> >>-        n->tx_waiting = 1;
> >>+        qemu_mod_timer(netq->tx_timer,
> >>+                       qemu_get_clock_ns(vm_clock) + netq->tx_timeout);
> >>+        netq->tx_waiting = 1;
> >>          virtio_queue_set_notification(vq, 0);
> >>      }
> >>  }
> >>@@ -794,48 +907,53 @@ static void virtio_net_handle_tx_timer(VirtIODevice *vdev, VirtQueue *vq)
> >>  static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
> >>  {
> >>      VirtIONet *n = to_virtio_net(vdev);
> >>+    VirtIONetQueue *netq =&n->vqs[vq_get_pair_index(n, vq)];
> >>
> >>-    if (unlikely(n->tx_waiting)) {
> >>+    if (unlikely(netq->tx_waiting)) {
> >>          return;
> >>      }
> >>-    n->tx_waiting = 1;
> >>+    netq->tx_waiting = 1;
> >>      /* This happens when device was stopped but VCPU wasn't. */
> >>      if (!n->vdev.vm_running) {
> >>          return;
> >>      }
> >>      virtio_queue_set_notification(vq, 0);
> >>-    qemu_bh_schedule(n->tx_bh);
> >>+    qemu_bh_schedule(netq->tx_bh);
> >>  }
> >>
> >>  static void virtio_net_tx_timer(void *opaque)
> >>  {
> >>-    VirtIONet *n = opaque;
> >>+    VirtIONetQueue *netq = opaque;
> >>+    VirtIONet *n = netq->n;
> >>+
> >>      assert(n->vdev.vm_running);
> >>
> >>-    n->tx_waiting = 0;
> >>+    netq->tx_waiting = 0;
> >>
> >>      /* Just in case the driver is not ready on more */
> >>      if (!(n->vdev.status&  VIRTIO_CONFIG_S_DRIVER_OK))
> >>          return;
> >>
> >>-    virtio_queue_set_notification(n->tx_vq, 1);
> >>-    virtio_net_flush_tx(n, n->tx_vq);
> >>+    virtio_queue_set_notification(netq->tx_vq, 1);
> >>+    virtio_net_flush_tx(n, netq);
> >>  }
> >>
> >>  static void virtio_net_tx_bh(void *opaque)
> >>  {
> >>-    VirtIONet *n = opaque;
> >>+    VirtIONetQueue *netq = opaque;
> >>+    VirtQueue *vq = netq->tx_vq;
> >>+    VirtIONet *n = netq->n;
> >>      int32_t ret;
> >>
> >>      assert(n->vdev.vm_running);
> >>
> >>-    n->tx_waiting = 0;
> >>+    netq->tx_waiting = 0;
> >>
> >>      /* Just in case the driver is not ready on more */
> >>      if (unlikely(!(n->vdev.status&  VIRTIO_CONFIG_S_DRIVER_OK)))
> >>          return;
> >>
> >>-    ret = virtio_net_flush_tx(n, n->tx_vq);
> >>+    ret = virtio_net_flush_tx(n, netq);
> >>      if (ret == -EBUSY) {
> >>          return; /* Notification re-enable handled by tx_complete */
> >>      }
> >>@@ -843,33 +961,39 @@ static void virtio_net_tx_bh(void *opaque)
> >>      /* If we flush a full burst of packets, assume there are
> >>       * more coming and immediately reschedule */
> >>      if (ret>= n->tx_burst) {
> >>-        qemu_bh_schedule(n->tx_bh);
> >>-        n->tx_waiting = 1;
> >>+        qemu_bh_schedule(netq->tx_bh);
> >>+        netq->tx_waiting = 1;
> >>          return;
> >>      }
> >>
> >>      /* If less than a full burst, re-enable notification and flush
> >>       * anything that may have come in while we weren't looking.  If
> >>       * we find something, assume the guest is still active and reschedule */
> >>-    virtio_queue_set_notification(n->tx_vq, 1);
> >>-    if (virtio_net_flush_tx(n, n->tx_vq)>  0) {
> >>-        virtio_queue_set_notification(n->tx_vq, 0);
> >>-        qemu_bh_schedule(n->tx_bh);
> >>-        n->tx_waiting = 1;
> >>+    virtio_queue_set_notification(vq, 1);
> >>+    if (virtio_net_flush_tx(n, netq)>  0) {
> >>+        virtio_queue_set_notification(vq, 0);
> >>+        qemu_bh_schedule(netq->tx_bh);
> >>+        netq->tx_waiting = 1;
> >>      }
> >>  }
> >>
> >>  static void virtio_net_save(QEMUFile *f, void *opaque)
> >>  {
> >>      VirtIONet *n = opaque;
> >>+    int i;
> >>
> >>      /* At this point, backend must be stopped, otherwise
> >>       * it might keep writing to memory. */
> >>-    assert(!n->vhost_started);
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        assert(!n->vqs[i].vhost_started);
> >>+    }
> >>      virtio_save(&n->vdev, f);
> >>
> >>      qemu_put_buffer(f, n->mac, ETH_ALEN);
> >>-    qemu_put_be32(f, n->tx_waiting);
> >>+    qemu_put_be32(f, n->queues);
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        qemu_put_be32(f, n->vqs[i].tx_waiting);
> >>+    }
> >>      qemu_put_be32(f, n->mergeable_rx_bufs);
> >>      qemu_put_be16(f, n->status);
> >>      qemu_put_byte(f, n->promisc);
> >>@@ -902,7 +1026,10 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
> >>      }
> >>
> >>      qemu_get_buffer(f, n->mac, ETH_ALEN);
> >>-    n->tx_waiting = qemu_get_be32(f);
> >>+    n->queues = qemu_get_be32(f);
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        n->vqs[i].tx_waiting = qemu_get_be32(f);
> >>+    }
> >>      n->mergeable_rx_bufs = qemu_get_be32(f);
> >>
> >>      if (version_id>= 3)
> >>@@ -930,7 +1057,7 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
> >>              n->mac_table.in_use = 0;
> >>          }
> >>      }
> >>-
> >>+
> >>      if (version_id>= 6)
> >>          qemu_get_buffer(f, (uint8_t *)n->vlans, MAX_VLAN>>  3);
> >>
> >>@@ -941,13 +1068,16 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
> >>          }
> >>
> >>          if (n->has_vnet_hdr) {
> >>-            tap_using_vnet_hdr(n->nic->nc.peer, 1);
> >>-            tap_set_offload(n->nic->nc.peer,
> >>-                    (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_CSUM)&  1,
> >>-                    (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_TSO4)&  1,
> >>-                    (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_TSO6)&  1,
> >>-                    (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_ECN)&  1,
> >>-                    (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_UFO)&  1);
> >>+            for(i = 0; i<  n->queues; i++) {
> >>+                tap_using_vnet_hdr(n->nic->ncs[i]->peer, 1);
> >>+                tap_set_offload(n->nic->ncs[i]->peer,
> >>+                        (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_CSUM)&  1,
> >>+                        (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_TSO4)&  1,
> >>+                        (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_TSO6)&  1,
> >>+                        (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_ECN)&  1,
> >>+                        (n->vdev.guest_features>>  VIRTIO_NET_F_GUEST_UFO)&
> >>+                        1);
> >>+           }
> >>          }
> >>      }
> >>
> >>@@ -982,7 +1112,7 @@ static int virtio_net_load(QEMUFile *f, void *opaque, int version_id)
> >>
> >>  static void virtio_net_cleanup(VLANClientState *nc)
> >>  {
> >>-    VirtIONet *n = DO_UPCAST(NICState, nc, nc)->opaque;
> >>+    VirtIONet *n = ((NICState *)nc->opaque)->opaque;
> >>
> >>      n->nic = NULL;
> >>  }
> >>@@ -1000,6 +1130,7 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
> >>                                virtio_net_conf *net)
> >>  {
> >>      VirtIONet *n;
> >>+    int i;
> >>
> >>      n = (VirtIONet *)virtio_common_init("virtio-net", VIRTIO_ID_NET,
> >>                                          sizeof(struct virtio_net_config),
> >>@@ -1012,7 +1143,6 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
> >>      n->vdev.bad_features = virtio_net_bad_features;
> >>      n->vdev.reset = virtio_net_reset;
> >>      n->vdev.set_status = virtio_net_set_status;
> >>-    n->rx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_rx);
> >>
> >>      if (net->tx&&  strcmp(net->tx, "timer")&&  strcmp(net->tx, "bh")) {
> >>          error_report("virtio-net: "
> >>@@ -1021,15 +1151,6 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
> >>          error_report("Defaulting to \"bh\"");
> >>      }
> >>
> >>-    if (net->tx&&  !strcmp(net->tx, "timer")) {
> >>-        n->tx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_tx_timer);
> >>-        n->tx_timer = qemu_new_timer_ns(vm_clock, virtio_net_tx_timer, n);
> >>-        n->tx_timeout = net->txtimer;
> >>-    } else {
> >>-        n->tx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_tx_bh);
> >>-        n->tx_bh = qemu_bh_new(virtio_net_tx_bh, n);
> >>-    }
> >>-    n->ctrl_vq = virtio_add_queue(&n->vdev, 64, virtio_net_handle_ctrl);
> >>      qemu_macaddr_default_if_unset(&conf->macaddr);
> >>      memcpy(&n->mac[0],&conf->macaddr, sizeof(n->mac));
> >>      n->status = VIRTIO_NET_S_LINK_UP;
> >>@@ -1038,7 +1159,6 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
> >>
> >>      qemu_format_nic_info_str(&n->nic->nc, conf->macaddr.a);
> >>
> >>-    n->tx_waiting = 0;
> >>      n->tx_burst = net->txburst;
> >>      n->mergeable_rx_bufs = 0;
> >>      n->promisc = 1; /* for compatibility */
> >>@@ -1046,6 +1166,32 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
> >>      n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
> >>
> >>      n->vlans = g_malloc0(MAX_VLAN>>  3);
> >>+    n->queues = conf->queues;
> >>+
> >>+    /* Allocate per rx/tx vq's */
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        n->vqs[i].rx_vq = virtio_add_queue(&n->vdev, 256, virtio_net_handle_rx);
> >>+        if (net->tx&&  !strcmp(net->tx, "timer")) {
> >>+            n->vqs[i].tx_vq = virtio_add_queue(&n->vdev, 256,
> >>+                                               virtio_net_handle_tx_timer);
> >>+            n->vqs[i].tx_timer = qemu_new_timer_ns(vm_clock,
> >>+                                                   virtio_net_tx_timer,
> >>+&n->vqs[i]);
> >>+            n->vqs[i].tx_timeout = net->txtimer;
> >>+        } else {
> >>+            n->vqs[i].tx_vq = virtio_add_queue(&n->vdev, 256,
> >>+                                               virtio_net_handle_tx_bh);
> >>+            n->vqs[i].tx_bh = qemu_bh_new(virtio_net_tx_bh,&n->vqs[i]);
> >>+        }
> >>+
> >>+        n->vqs[i].tx_waiting = 0;
> >>+        n->vqs[i].n = n;
> >>+
> >>+        if (i == 0) {
> >>+            /* keep compatiable with spec and old guest */
> >>+            n->ctrl_vq = virtio_add_queue(&n->vdev, 64, virtio_net_handle_ctrl);
> >>+        }
> >>+    }
> >>
> >>      n->qdev = dev;
> >>      register_savevm(dev, "virtio-net", -1, VIRTIO_NET_VM_VERSION,
> >>@@ -1059,24 +1205,33 @@ VirtIODevice *virtio_net_init(DeviceState *dev, NICConf *conf,
> >>  void virtio_net_exit(VirtIODevice *vdev)
> >>  {
> >>      VirtIONet *n = DO_UPCAST(VirtIONet, vdev, vdev);
> >>+    int i;
> >>
> >>      /* This will stop vhost backend if appropriate. */
> >>      virtio_net_set_status(vdev, 0);
> >>
> >>-    qemu_purge_queued_packets(&n->nic->nc);
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        qemu_purge_queued_packets(n->nic->ncs[i]);
> >>+    }
> >>
> >>      unregister_savevm(n->qdev, "virtio-net", n);
> >>
> >>      g_free(n->mac_table.macs);
> >>      g_free(n->vlans);
> >>
> >>-    if (n->tx_timer) {
> >>-        qemu_del_timer(n->tx_timer);
> >>-        qemu_free_timer(n->tx_timer);
> >>-    } else {
> >>-        qemu_bh_delete(n->tx_bh);
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        VirtIONetQueue *netq =&n->vqs[i];
> >>+        if (netq->tx_timer) {
> >>+            qemu_del_timer(netq->tx_timer);
> >>+            qemu_free_timer(netq->tx_timer);
> >>+        } else {
> >>+            qemu_bh_delete(netq->tx_bh);
> >>+        }
> >>      }
> >>
> >>-    qemu_del_vlan_client(&n->nic->nc);
> >>      virtio_cleanup(&n->vdev);
> >>+
> >>+    for (i = 0; i<  n->queues; i++) {
> >>+        qemu_del_vlan_client(n->nic->ncs[i]);
> >>+    }
> >>  }
> >>diff --git a/hw/virtio-net.h b/hw/virtio-net.h
> >>index 36aa463..b35ba5d 100644
> >>--- a/hw/virtio-net.h
> >>+++ b/hw/virtio-net.h
> >>@@ -44,6 +44,7 @@
> >>  #define VIRTIO_NET_F_CTRL_RX    18      /* Control channel RX mode support */
> >>  #define VIRTIO_NET_F_CTRL_VLAN  19      /* Control channel VLAN filtering */
> >>  #define VIRTIO_NET_F_CTRL_RX_EXTRA 20   /* Extra RX mode control support */
> >>+#define VIRTIO_NET_F_MULTIQUEUE   22
> >>
> >>  #define VIRTIO_NET_S_LINK_UP    1       /* Link is up */
> >>
> >>@@ -72,6 +73,8 @@ struct virtio_net_config
> >>      uint8_t mac[ETH_ALEN];
> >>      /* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
> >>      uint16_t status;
> >>+
> >>+    uint16_t queues;
> >>  } QEMU_PACKED;
> >>
> >>  /* This is the first element of the scatter-gather list.  If you don't
> >--
> >To unsubscribe from this list: send the line "unsubscribe kvm" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
