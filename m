From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC 00/11] qemu: towards virtio-1 host support
Date: Fri, 24 Oct 2014 10:38:39 +0200
Message-ID: <20141024103839.7162b93f.cornelia.huck__5550.73094224117$1414139940$gmane$org@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<20141023214158.GA29716@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141023214158.GA29716@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 24 Oct 2014 00:42:20 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Oct 07, 2014 at 04:39:56PM +0200, Cornelia Huck wrote:
> > This patchset aims to get us some way to implement virtio-1 compliant
> > and transitional devices in qemu. Branch available at
> > 
> > git://github.com/cohuck/qemu virtio-1
> > 
> > I've mainly focused on:
> > - endianness handling
> > - extended feature bits
> > - virtio-ccw new/changed commands
> 
> So issues identified so far:

Thanks for taking a look.

> - devices not converted yet should not advertize 1.0

Neither should an uncoverted transport. So we either can
- have transport set the bit and rely on devices ->get_features
  callback to mask it out
  (virtio-ccw has to change the calling order for get_features, btw.)
- have device set the bit and the transport mask it out later. Feels a
  bit weird, as virtio-1 is a transport feature bit.

I'm tending towards the first option; smth like this (on top of my
branch):

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index c29c8c8..f6501ea 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -24,6 +24,9 @@
 static uint32_t virtio_9p_get_features(VirtIODevice *vdev, unsigned int index,
                                        uint32_t features)
 {
+    if (index == 1) {
+        features &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+    }
     if (index > 0) {
         return features;
     }
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 0d843fe..07a7a6f 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -472,6 +472,9 @@ static uint32_t get_features(VirtIODevice *vdev, unsigned int index,
 {
     VirtIOSerial *vser;
 
+    if (index == 1) {
+        features &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+    }
     if (index > 0) {
         return features;
     }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 67f91c0..4b75105 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -447,6 +447,9 @@ static uint32_t virtio_net_get_features(VirtIODevice *vdev, unsigned int index,
     VirtIONet *n = VIRTIO_NET(vdev);
     NetClientState *nc = qemu_get_queue(n->nic);
 
+    if (index == 1 && get_vhost_net(nc->peer)) {
+        features &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+    }
     if (index > 0) {
         return features;
     }
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 80efe88..07fbf40 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -839,16 +839,16 @@ static int virtio_ccw_device_init(VirtioCcwDevice *dev, VirtIODevice *vdev)
     dev->revision = -1;
 
     /* Set default feature bits that are offered by the host. */
+    dev->host_features[0] = 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
+    dev->host_features[0] |= 0x1 << VIRTIO_F_BAD_FEATURE;
+
+    dev->host_features[1] = 1 << (VIRTIO_F_VERSION_1 - 32);
+
     for (i = 0; i < ARRAY_SIZE(dev->host_features); i++) {
         dev->host_features[i] =
             virtio_bus_get_vdev_features(&dev->bus, i, dev->host_features[i]);
     }
 
-    dev->host_features[0] |= 0x1 << VIRTIO_F_NOTIFY_ON_EMPTY;
-    dev->host_features[0] |= 0x1 << VIRTIO_F_BAD_FEATURE;
-
-    dev->host_features[1] = 1 << (VIRTIO_F_VERSION_1 - 32);
-
     css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
                           parent->hotplugged, 1);
     return 0;
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 8e1afa0..8a8fdb9 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -155,6 +155,9 @@ static uint32_t vhost_scsi_get_features(VirtIODevice *vdev, unsigned int index,
 {
     VHostSCSI *s = VHOST_SCSI(vdev);
 
+    if (index == 1) {
+        features &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+    }
     if (index > 0) {
         return features;
     }
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 088e688..378783f 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -611,6 +611,9 @@ static void virtio_scsi_set_config(VirtIODevice *vdev,
 static uint32_t virtio_scsi_get_features(VirtIODevice *vdev, unsigned int index,
                                          uint32_t requested_features)
 {
+    if (index == 1) {
+        requested_features &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+    }
     return requested_features;
 }
 
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 5af17e2..bd52845 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -306,6 +306,9 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
 static uint32_t virtio_balloon_get_features(VirtIODevice *vdev,
                                             unsigned int index, uint32_t f)
 {
+    if (index == 1) {
+        f &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+    }
     if (index > 0) {
         return f;
     }
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 2814017..bf6101d 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -101,6 +101,9 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
 
 static uint32_t get_features(VirtIODevice *vdev, unsigned int index, uint32_t f)
 {
+    if (index == 1) {
+        f &= ~(1 << (VIRTIO_F_VERSION_1 - 32));
+    }
     return f;
 }
 


> - blk has some features removed under 1.0,
>   specifically CONFIG_WCE.
> - net header is different for 1.0
