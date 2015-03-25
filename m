From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] Add virtio gpu driver.
Date: Wed, 25 Mar 2015 15:52:01 +0100
Message-ID: <1427295121.23304.5.camel__34808.874995406$1427295175$gmane$org@nilsson.home.kraxel.org>
References: <1427213239-8775-1-git-send-email-kraxel@redhat.com>
	<20150324171255-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150324171255-mutt-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, David Airlie <airlied@linux.ie>, "open
	list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open
	list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:VIRTIO
	CORE, NET..." <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>, Dave Airlie <airlied@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index e894eb2..a3167fa 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -510,7 +510,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
> >  		goto err_enable_device;
> >  
> >  	rc = pci_request_regions(pci_dev, "virtio-pci");
> > -	if (rc)
> > +	if (rc && ((pci_dev->class >> 8) != PCI_CLASS_DISPLAY_VGA))
> >  		goto err_request_regions;
> >  
> >  	if (force_legacy) {
> 
> This is probably what you described as "the only concern?

Ahem, no, forgot that one, but it is related.  With vesafb using and
registering the vga compat framebuffer bar pci_request_regions will not
succeed.

vesafb will be unregistered later on (this is what I was refering to) by
the virtio-gpu driver.

> If we only need to request specific
> regions, I think we should do exactly that, requesting only parts of
> regions that are covered by the virtio capabilities.

That should work too.

cheers,
  Gerd
