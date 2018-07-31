From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Tue, 31 Jul 2018 15:36:22 -0500
Message-ID: <3d6e81511571260de1c8047aaffa8ac4df093d2e.camel__20272.8471755565$1533069399$gmane$org@kernel.crashing.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180727095804.GA25592@arm.com> <20180730093414.GD26245@infradead.org>
	<20180730125100-mutt-send-email-mst@kernel.org>
	<20180730111802.GA9830@infradead.org>
	<20180730155633-mutt-send-email-mst@kernel.org>
	<20180731173052.GA17153@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180731173052.GA17153@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2018-07-31 at 10:30 -0700, Christoph Hellwig wrote:
> > However the question people raise is that DMA API is already full of
> > arch-specific tricks the likes of which are outlined in your post linked
> > above. How is this one much worse?
> 
> None of these warts is visible to the driver, they are all handled in
> the architecture (possibly on a per-bus basis).
> 
> So for virtio we really need to decide if it has one set of behavior
> as specified in the virtio spec, or if it behaves exactly as if it
> was on a PCI bus, or in fact probably both as you lined up.  But no
> magic arch specific behavior inbetween.

The only arch specific behaviour is needed in the case where it doesn't
behave like PCI. In this case, the PCI DMA ops are not suitable, but in
our secure VMs, we still need to make it use swiotlb in order to bounce
through non-secure pages.

It would be nice if "real PCI" was the default but it's not, VMs are
created in "legacy" mode all the times and we don't know at VM creation
time whether it will become a secure VM or not. The way our secure VMs
work is that they start as a normal VM, load a secure "payload" and
call the Ultravisor to "become" secure.

So we're in a bit of a bind here. We need that one-liner optional arch
hook to make virtio use swiotlb in that "IOMMU bypass" case.

Ben.
