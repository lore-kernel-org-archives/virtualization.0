From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH 0/8] virtio: Support for hibernation (S4)
Date: Wed, 10 Aug 2011 16:23:56 +0530
Message-ID: <20110810105356.GB19156@amit-x200.redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Thu) 28 Jul 2011 [20:05:05], Amit Shah wrote:
> Hello,
> 
> These patches are an initial attempt at supporting hibernation for
> virtio drivers.
> 
> The default configuration of event_index=on doesn't work; i.e. restore
> from a hibernated image only works if the devices have event_index
> support turned off.  I have not yet dug into this, but is most likely
> due to some state not being sync'ed.

This was due to the host forgetting which features the guest had
acked.  Adding this on top of this series makes things work fine.
I'll do more testing, refining code (sharing code with probe, etc.)
and repost as a proper series (mostly after the KVM Forum).

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 9c37561..c09d6a5 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -734,6 +734,7 @@ static int virtio_pci_restore(struct device *dev)
 			   struct virtio_driver, driver);
 
 	vp_set_status(&vp_dev->vdev, vp_dev->saved_status);
+	vp_finalize_features(&vp_dev->vdev);
 	if (drv && drv->restore)
 		return drv->restore(&vp_dev->vdev);
 

		Amit
