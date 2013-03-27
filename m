From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 2/3] vhost-scsi: new device supporting the tcm_vhost
	Linux kernel module
Date: Wed, 27 Mar 2013 16:05:47 -0700
Message-ID: <1364425547.17698.35.camel__29028.2662878328$1364425586$gmane$org@haakon2.linux-iscsi.org>
References: <1364421586-29857-1-git-send-email-nab@linux-iscsi.org>
	<1364421586-29857-3-git-send-email-nab@linux-iscsi.org>
	<20130327222856.GC12518@redhat.com>
	<1364424342.17698.31.camel@haakon2.linux-iscsi.org>
	<20130327225021.GA12858@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130327225021.GA12858@redhat.com>
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

On Thu, 2013-03-28 at 00:50 +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 27, 2013 at 03:45:42PM -0700, Nicholas A. Bellinger wrote:
> > On Thu, 2013-03-28 at 00:28 +0200, Michael S. Tsirkin wrote:
> > > On Wed, Mar 27, 2013 at 09:59:45PM +0000, Nicholas A. Bellinger wrote:
> > > > From: Paolo Bonzini <pbonzini@redhat.com>
> > > > 
> > > > The WWPN specified in configfs is passed to "-device vhost-scsi-pci".
> > > > The tgpt field of the SET_ENDPOINT ioctl is obsolete now, so it is not
> > > > available from the QEMU command-line.  Instead, I hardcode it to zero.
> > > > 
> > > > Changes in V4:
> > > >    - Set event_idx=off by default (nab, thanks asias)
> > > 
> > > Why? What's going on here?
> > > 
> > 
> > Not disabling event_idx by default, or disabling from the command line
> > ends up resulting in ->handle_kick() not getting called for subsequent
> > commands..
> > 
> > I spent some time trying to track this down recently with no luck, and
> > AFAICT it's always been required in order for vhost-scsi to function.
> 
> Hmm this is a bug in kernel then. A better work-around is
> to disable EVENT_IDX in kernel. Let's do it for 3.9?
> Then when we fix it, things just work for userspace.
> 

Mmmm, the following patch yields the same results with the event_idx=on
default for DEFINE_VHOST_SCSI_PROPERTIES.

Is there another method you had in mind to disable EVENT_IDX..?

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 0524267..757cbda 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -981,7 +981,7 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 
 static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
 {
-       if (features & ~VHOST_FEATURES)
+       if (features & ~VHOST_TCM_FEATURES)
                return -EOPNOTSUPP;
 
        mutex_lock(&vs->dev.mutex);
@@ -1027,7 +1027,7 @@ static long vhost_scsi_ioctl(struct file *f, unsigned int ioctl,
                        return -EFAULT;
                return 0;
        case VHOST_GET_FEATURES:
-               features = VHOST_FEATURES;
+               features = VHOST_TCM_FEATURES;
                if (copy_to_user(featurep, &features, sizeof features))
                        return -EFAULT;
                return 0;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 17261e2..588536e 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -204,6 +204,9 @@ enum {
        VHOST_NET_FEATURES = VHOST_FEATURES |
                         (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
                         (1ULL << VIRTIO_NET_F_MRG_RXBUF),
+       VHOST_TCM_FEATURES = (1ULL << VIRTIO_F_NOTIFY_ON_EMPTY) |
+                            (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
+                            (1ULL << VHOST_F_LOG_ALL)
 };
 
 static inline int vhost_has_feature(struct vhost_dev *dev, int bit)
