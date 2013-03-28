From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 2/3] vhost-scsi: new device supporting the tcm_vhost
	Linux kernel module
Date: Wed, 27 Mar 2013 17:21:30 -0700
Message-ID: <1364430090.17698.50.camel@haakon2.linux-iscsi.org>
References: <1364421586-29857-1-git-send-email-nab@linux-iscsi.org>
	<1364421586-29857-3-git-send-email-nab@linux-iscsi.org>
	<20130327222856.GC12518@redhat.com>
	<1364424342.17698.31.camel@haakon2.linux-iscsi.org>
	<20130327225021.GA12858@redhat.com> <20130327225349.GA12927@redhat.com>
	<1364426662.17698.41.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364426662.17698.41.camel@haakon2.linux-iscsi.org>
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
Cc: kvm-devel <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, target-devel <target-devel@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2013-03-27 at 16:24 -0700, Nicholas A. Bellinger wrote:
> On Thu, 2013-03-28 at 00:53 +0200, Michael S. Tsirkin wrote:
> > On Thu, Mar 28, 2013 at 12:50:21AM +0200, Michael S. Tsirkin wrote:
> > > On Wed, Mar 27, 2013 at 03:45:42PM -0700, Nicholas A. Bellinger wrote:
> > > > On Thu, 2013-03-28 at 00:28 +0200, Michael S. Tsirkin wrote:
> > > > > On Wed, Mar 27, 2013 at 09:59:45PM +0000, Nicholas A. Bellinger wrote:
> > > > > > From: Paolo Bonzini <pbonzini@redhat.com>
> > > > > > 
> > > > > > The WWPN specified in configfs is passed to "-device vhost-scsi-pci".
> > > > > > The tgpt field of the SET_ENDPOINT ioctl is obsolete now, so it is not
> > > > > > available from the QEMU command-line.  Instead, I hardcode it to zero.
> > > > > > 
> > > > > > Changes in V4:
> > > > > >    - Set event_idx=off by default (nab, thanks asias)
> > > > > 
> > > > > Why? What's going on here?
> > > > > 
> > > > 
> > > > Not disabling event_idx by default, or disabling from the command line
> > > > ends up resulting in ->handle_kick() not getting called for subsequent
> > > > commands..
> > > > 
> > > > I spent some time trying to track this down recently with no luck, and
> > > > AFAICT it's always been required in order for vhost-scsi to function.
> > > 
> > > Hmm this is a bug in kernel then. A better work-around is
> > > to disable EVENT_IDX in kernel. Let's do it for 3.9?
> > 
> > But before we do, can you check that SET_FEATURES is
> > called with this bit set if you enable event_idx?
> > If not that's your bug then ...
> > 
> 
> Ok, SET_FEATURES is currently not setting any bits at all based upon
> vhost_dev->features, so it looks like a vhost-scsi-pci bug..
> 
> 

Adding the following patch for a vhost_scsi specific ->get_features()
call in order to strip off the unsupported host feature bits.  Please
review.

Also, providing the proper EVENT_IDX bit to SET_FEATURES results in the
same lost ->handle_kick() for vhost-scsi-pci devices, so the previous
VHOST_TCM_FEATURES patch to strip off EVENT_IDX is still required to
work..  Sending this out separately, please review and ACK.

Thanks,

--nab

diff --git a/hw/vhost-scsi.c b/hw/vhost-scsi.c
index 70e42fc..adc929b 100644
--- a/hw/vhost-scsi.c
+++ b/hw/vhost-scsi.c
@@ -128,6 +128,28 @@ static void vhost_scsi_stop(VHostSCSI *vs, VirtIODevice *vdev)
     vhost_dev_disable_notifiers(&vs->dev, vdev);
 }
 
+static uint32_t vhost_scsi_get_features(VirtIODevice *vdev,
+                                        uint32_t features)
+{
+    VHostSCSI *vs = (VHostSCSI *)vdev;
+
+    /* Clear features not supported by host kernel. */
+    if (!(vs->dev.features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY))) {
+        features &= ~(1 << VIRTIO_F_NOTIFY_ON_EMPTY);
+    }
+    if (!(vs->dev.features & (1 << VIRTIO_RING_F_INDIRECT_DESC))) {
+        features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
+    }
+    if (!(vs->dev.features & (1 << VIRTIO_RING_F_EVENT_IDX))) {
+        features &= ~(1 << VIRTIO_RING_F_EVENT_IDX);
+    }
+    if (!(vs->dev.features & (1 << VIRTIO_SCSI_F_HOTPLUG))) {
+        features &= ~(1 << VIRTIO_SCSI_F_HOTPLUG);
+    }
+
+    return features;
+}
+
 static void vhost_scsi_set_config(VirtIODevice *vdev,
                                   const uint8_t *config)
 {
@@ -203,6 +225,7 @@ VirtIODevice *vhost_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf)
     vs = (VHostSCSI *)virtio_scsi_init_common(dev, proxyconf,
                                               sizeof(VHostSCSI));
 
+    vs->vs.vdev.get_features = vhost_scsi_get_features;
     vs->vs.vdev.set_config = vhost_scsi_set_config;
     vs->vs.vdev.set_status = vhost_scsi_set_status;
     vs->vs.vdev.guest_notifier_mask = vhost_scsi_guest_notifier_mask;
@@ -219,7 +242,7 @@ VirtIODevice *vhost_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf)
         return NULL;
     }
     vs->dev.backend_features = 0;
-    vs->dev.acked_features = 0;
+    vs->dev.acked_features = vs->dev.features;
 
     error_setg(&vs->migration_blocker,
             "vhost-scsi does not support migration");
diff --git a/hw/vhost-scsi.h b/hw/vhost-scsi.h
index b01f012..70f4a58 100644
--- a/hw/vhost-scsi.h
+++ b/hw/vhost-scsi.h
@@ -50,14 +50,12 @@ enum vhost_scsi_vq_list {
 #define VHOST_SCSI_GET_ABI_VERSION _IOW(VHOST_VIRTIO, 0x42, int)
 
 #define DEFINE_VHOST_SCSI_PROPERTIES(_state, _features_field, _conf_field) \
-    DEFINE_PROP_BIT("indirect_desc", _state, _features_field, VIRTIO_RING_F_INDIRECT_DESC, true), \
-    DEFINE_PROP_BIT("event_idx", _state, _features_field, VIRTIO_RING_F_EVENT_IDX, false), \
+    DEFINE_VIRTIO_COMMON_FEATURES(_state, _features_field), \
     DEFINE_PROP_STRING("vhostfd", _state, _conf_field.vhostfd), \
     DEFINE_PROP_STRING("wwpn", _state, _conf_field.wwpn), \
     DEFINE_PROP_UINT32("num_queues", _state, _conf_field.num_queues, 1), \
     DEFINE_PROP_UINT32("max_sectors", _state, _conf_field.max_sectors, 0xFFFF), \
-    DEFINE_PROP_UINT32("cmd_per_lun", _state, _conf_field.cmd_per_lun, 128), \
-    DEFINE_PROP_BIT("hotplug", _state, _features_field, VIRTIO_SCSI_F_HOTPLUG, true)
+    DEFINE_PROP_UINT32("cmd_per_lun", _state, _conf_field.cmd_per_lun, 128)
 
 VirtIODevice *vhost_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf);
 void vhost_scsi_exit(VirtIODevice *vdev);
diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
index 9dc7150..c59e9c6 100644
--- a/hw/virtio-scsi.c
+++ b/hw/virtio-scsi.c
@@ -595,7 +595,6 @@ VirtIOSCSICommon *virtio_scsi_init_common(DeviceState *dev, VirtIOSCSIConf *prox
     s->cdb_size = VIRTIO_SCSI_CDB_SIZE;
 
     s->vdev.get_config = virtio_scsi_get_config;
-    s->vdev.get_features = virtio_scsi_get_features;
 
     s->ctrl_vq = virtio_add_queue(&s->vdev, VIRTIO_SCSI_VQ_SIZE,
                                    virtio_scsi_handle_ctrl);
@@ -618,6 +617,7 @@ VirtIODevice *virtio_scsi_init(DeviceState *dev, VirtIOSCSIConf *proxyconf)
 
     s = (VirtIOSCSI *)virtio_scsi_init_common(dev, proxyconf, sizeof(VirtIOSCSI));
 
+    s->vs.vdev.get_features = virtio_scsi_get_features;
     s->vs.vdev.set_config = virtio_scsi_set_config;
     s->vs.vdev.reset = virtio_scsi_reset;
