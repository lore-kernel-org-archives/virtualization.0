From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 2/2] virtio-balloon: virtio 1 support
Date: Mon, 13 Apr 2015 14:15:51 +0200
Message-ID: <20150413141551.41daad1e.cornelia.huck@de.ibm.com>
References: <1428849904-28953-1-git-send-email-mst@redhat.com>
	<1428849904-28953-2-git-send-email-mst@redhat.com>
	<20150413100258.1f2c636f.cornelia.huck@de.ibm.com>
	<20150413132110-mutt-send-email-mst@redhat.com>
	<20150413133521.274fd658.cornelia.huck@de.ibm.com>
	<20150413134908-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150413134908-mutt-send-email-mst@redhat.com>
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
Cc: qemu-devel@nongnu.org, Anthony Liguori <aliguori@amazon.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Apr 2015 13:49:42 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Apr 13, 2015 at 01:35:21PM +0200, Cornelia Huck wrote:
> > On Mon, 13 Apr 2015 13:26:31 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Mon, Apr 13, 2015 at 10:02:58AM +0200, Cornelia Huck wrote:
> > 
> > > > Also, doesn't get_features need to be modified as well so that
> > > > VERSION_1 is advertised?
> > > 
> > > virtio_pci_device_plugged seems to set it ATM. I'll re-test to confirm.
> > 
> > Indeed, pci sets it, but ccw does not. And virtio-net, for example,
> > sets it explicitly as well. We need to unify this :)
> 
> I'm inclined to set it in transport and black-list in specific devices.
> 

Agreed, let's set it in the transports.

For ccw, I'd probably only want to offer it once the driver has
negotiated a revision >= 1, so something like the following (untested):

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 8b6b2ab..4d8cc24 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -703,6 +703,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
         dev->host_features =
             virtio_bus_get_vdev_features_rev(&dev->bus, dev->host_features,
                                              dev->revision >= 1 ? 1 : 0);
+        if (dev->revision >= 1) {
+            virtio_add_feature(&dev->host_features, VIRTIO_F_VERSION_1);
+        }
         break;
     default:
         ret = -ENOSYS;
