From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-pci: alloc only resources actually used.
Date: Thu, 18 Jun 2015 15:27:09 +0200
Message-ID: <20150618151945-mutt-send-email-mst@redhat.com>
References: <1434619654-10142-1-git-send-email-kraxel@redhat.com>
	<20150618115029-mutt-send-email-mst@redhat.com>
	<1434623600.4968.29.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1434623600.4968.29.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 18, 2015 at 12:33:20PM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > > +	if (offset + length < offset ||
> > > +	    offset + length > pci_resource_len(dev, bar)) {
> > > +		dev_err(&dev->dev,
> > > +			"virtio_pci: virtio capability %u@%u "
> > > +			"out of range on bar %i length %lu\n",
> > > +			length, offset, bar,
> > > +			(unsigned long)pci_resource_len(dev, bar));
> > > +		return NULL;
> > > +	}
> > > +
> > > +	if (limit && length > limit)
> > > +		length = limit;
> > > +
> > 
> > I'll have to review the above carefully. Hopefully next week.
> > Any reason you didn't just move code out map_capability to a helper,
> > without changes?  Would have made review easier.
> 
> Doesn't work that easily as there are different things to check.
> request_capability verifies the capability itself only, map_capability
> has a bunch of additional range checks because it supports partial maps.

So use a helper, call it from both places with slightly
different parameters.

> > I don't see reasons to request regions that we aren't going to
> > claim ...
> 
> I had it that way first, simply calling request_mem_region from
> map_capability.  But then you get tons of notify entries in /proc/iomem,
> and keeping track of the requested regions (for cleanup in
> virtio_pci_modern_remove) also is more complicated than with a simple
> set of 4 fixed regions.

In case of notify I guess we can limit the resource to 64K VQs,
will help keep it simple.

> > > +	return request_mem_region(pci_resource_start(dev, bar) + offset,
> > > +				  length, name);
> > 
> > Hmm this seems wrong, resource can be IO, not just memory.
> 
> Right (not the case in the current qemu implementation, but still ...).
> 
> > > +	vp_dev->res_common = request_capability(pci_dev, common, 0,
> > 
> > Please make limit = sizeof(struct virtio_pci_common_cfg) and not 0.
> > 
> > > +						"virtio-pci-common");
> > > +	vp_dev->res_isr = request_capability(pci_dev, isr, 0,
> > > +						"virtio-pci-isr");
> > 
> > And here, 1.
> > 
> > > +	vp_dev->res_notify = request_capability(pci_dev, notify, 0,
> > > +						"virtio-pci-notify");
> > > +	if (device) {
> > > +		vp_dev->res_device = request_capability(pci_dev, device,
> > > +							PAGE_SIZE,
> > > +							"virtio-pci-device");
> > > +	}
> > 
> > Please drop {} around a single statement.
> 
> I'll fix them for the next version.
> 
> cheers,
>   Gerd
> 
