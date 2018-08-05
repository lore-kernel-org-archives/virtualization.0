From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Sun, 5 Aug 2018 03:09:55 +0300
Message-ID: <20180805030326-mutt-send-email-mst__26660.4548240595$1533427683$gmane$org@kernel.org>
References: <26c1d3d50d8e081eed44fe9940fbefed34598cbd.camel@kernel.crashing.org>
	<20180802182959-mutt-send-email-mst@kernel.org>
	<82ccef6ec3d95ee43f3990a4a2d0aea87eb45e89.camel@kernel.crashing.org>
	<20180802200646-mutt-send-email-mst@kernel.org>
	<e9beb6bba5a7d05741e27e85b24a3b23ba7c2762.camel@kernel.crashing.org>
	<20180802225738-mutt-send-email-mst@kernel.org>
	<de4888b6457e220776e16a9c8958ff0886ffc66c.camel@kernel.crashing.org>
	<20180803070507.GA1344@infradead.org>
	<20180803221634-mutt-send-email-mst@kernel.org>
	<20180804081500.GA1455@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180804081500.GA1455@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@samba.org, marc.zyngier@arm.com, mpe@ellerman.id.au, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Aug 04, 2018 at 01:15:00AM -0700, Christoph Hellwig wrote:
> On Fri, Aug 03, 2018 at 10:17:32PM +0300, Michael S. Tsirkin wrote:
> > It seems reasonable to teach a platform to override dma-range
> > for a specific device e.g. in case it knows about bugs in ACPI.
> 
> A platform will be able override dma-range using the dev->bus_dma_mask
> field starting in 4.19.  But we'll still need a way how to
> 
>   a) document in the virtio spec that all bus dma quirks are to be
>      applied

I agree it's a good idea. In particular I suspect that PLATFORM_IOMMU
should be extended to cover that. But see below.

>   b) a way to document in a virtio-related spec how the bus handles
>      dma for Ben's totally fucked up hypervisor.  Without that there
>      is not way we'll get interoperable implementations.


So in this case however I'm not sure what exactly do we want to add. It
seems that from point of view of the device, there is nothing special -
it just gets a PA and writes there.  It also seems that guest does not
need to get any info from the device either. Instead guest itself needs
device to DMA into specific addresses, for its own reasons.

It seems that the fact that within guest it's implemented using a bounce
buffer and that it's easiest to do by switching virtio to use the DMA API
isn't something virtio spec concerns itself with.

I'm open to suggestions.

-- 
MST
