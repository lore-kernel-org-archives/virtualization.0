From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
	virtio_direct_dma_ops selectively
Date: Mon, 30 Jul 2018 02:30:27 -0700
Message-ID: <20180730093027.GC26245__29206.0160580606$1532942907$gmane$org@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180720035941.6844-3-khandual@linux.vnet.ibm.com>
	<c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
	<20180729001344-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180729001344-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, paulus@samba.org, mpe@ellerman.id.au, joe@perches.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

> > +
> > +	if (xen_domain())
> > +		goto skip_override;
> > +
> > +	if (virtio_has_iommu_quirk(dev))
> > +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
> > +
> > + skip_override:
> > +
> 
> I prefer normal if scoping as opposed to goto spaghetti pls.
> Better yet move vring_use_dma_api here and use it.
> Less of a chance something will break.

I agree about avoid pointless gotos here, but we can do things
perfectly well without either gotos or a confusing helper here
if we structure it right. E.g.:

	// suitably detailed comment here
	if (!xen_domain() &&
	    !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

and while we're at it - modifying dma ops for the parent looks very
dangerous.  I don't think we can do that, as it could break iommu
setup interactions.  IFF we set a specific dma map ops it has to be
on the virtio device itself, of which we have full control.
