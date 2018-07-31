From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Tue, 31 Jul 2018 10:30:52 -0700
Message-ID: <20180731173052.GA17153@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180727095804.GA25592@arm.com>
	<20180730093414.GD26245@infradead.org>
	<20180730125100-mutt-send-email-mst@kernel.org>
	<20180730111802.GA9830@infradead.org>
	<20180730155633-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180730155633-mutt-send-email-mst@kernel.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, benh@kernel.crashing.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, paulus@samba.org, marc.zyngier@arm.com, mpe@ellerman.id.au, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 30, 2018 at 04:26:32PM +0300, Michael S. Tsirkin wrote:
> Real hardware would reuse parts of the interface but by necessity it
> needs to behave slightly differently on some platforms.  However for
> some platforms (such as x86) a PV virtio driver will by luck work with a
> PCI device backend without changes. As these platforms and drivers are
> widely deployed, some people will deploy hardware like that.  Should be
> a non issue as by definition it's transparent to guests.

On some x86.  As soon as you have an iommu or strange PCI root ports
things are going to start breaking apart.

> > And that very much excludes arch-specific (or
> > Xen-specific) overrides.
> 
> We already committed to a xen specific hack but generally I prefer
> devices that describe how they work instead of platforms magically
> guessing, yes.

For legacy reasons I guess we'll have to keep it, but we really need
to avoid adding more junk than this.

> However the question people raise is that DMA API is already full of
> arch-specific tricks the likes of which are outlined in your post linked
> above. How is this one much worse?

None of these warts is visible to the driver, they are all handled in
the architecture (possibly on a per-bus basis).

So for virtio we really need to decide if it has one set of behavior
as specified in the virtio spec, or if it behaves exactly as if it
was on a PCI bus, or in fact probably both as you lined up.  But no
magic arch specific behavior inbetween.
