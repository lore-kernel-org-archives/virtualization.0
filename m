From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-pci: alloc only resources actually used.
Date: Thu, 18 Jun 2015 10:14:40 +0200
Message-ID: <1434615280.4968.14.camel@redhat.com>
References: <1434463073-29648-1-git-send-email-kraxel@redhat.com>
	<20150616160052-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150616160052-mutt-send-email-mst@redhat.com>
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
Cc: open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> > +static struct resource *request_capability(struct pci_dev *dev, int off,
> > +					   const char *name)
> > +{
> > +	u8 bar;
> > +	u32 offset, length;
> > +
> > +	pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
> > +						 bar),
> > +			     &bar);
> > +	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, offset),
> > +			     &offset);
> > +	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
> > +			      &length);
> > +
> > +	return request_mem_region(pci_resource_start(dev, bar) + offset,
> > +				  length, name);
> > +}
> > +
> 
> For device config, this might request too much. The spec says:
> 	The drivers SHOULD only map part of configuration structure large enough
> 	for device operation.

We don't map it here though.  We just reserve what belongs to virtio
according to the capabilities.

> I think you should limit this to PAGE_SIZE like we do for map_capability.

notify is much larger than PAGE_SIZE.

> >  	err = -EINVAL;
> >  	vp_dev->common = map_capability(pci_dev, common,
> >  					sizeof(struct virtio_pci_common_cfg), 4,
> 
> map_capability has a bunch of checks in place to validate the capability
> structure. With request_capability called earlier, they are now done too
> late.

Hmm, lets move the checks to find_capability then?

cheers,
  Gerd
