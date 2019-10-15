From: Ram Pai <linuxram@us.ibm.com>
Subject: RE: [PATCH 1/2] dma-mapping: Add dma_addr_is_phys_addr()
Date: Tue, 15 Oct 2019 00:30:03 -0700
Message-ID: <20191015073003.GA5355@oc0525413822.ibm.com>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
	<20191014045139.GN4080@umbus.fritz.box>
	<37609731-5539-b906-aa94-2ef0242795ac@arm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <37609731-5539-b906-aa94-2ef0242795ac@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, mst@redhat.com, paul.burton@mips.com, mpe@ellerman.id.au, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 14, 2019 at 11:29:24AM +0100, Robin Murphy wrote:
> On 14/10/2019 05:51, David Gibson wrote:
> >On Fri, Oct 11, 2019 at 06:25:18PM -0700, Ram Pai wrote:
> >>From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >>
> >>In order to safely use the DMA API, virtio needs to know whether DMA
> >>addresses are in fact physical addresses and for that purpose,
> >>dma_addr_is_phys_addr() is introduced.
> >>
> >>cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>cc: David Gibson <david@gibson.dropbear.id.au>
> >>cc: Michael Ellerman <mpe@ellerman.id.au>
> >>cc: Paul Mackerras <paulus@ozlabs.org>
> >>cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> >>cc: Alexey Kardashevskiy <aik@linux.ibm.com>
> >>cc: Paul Burton <paul.burton@mips.com>
> >>cc: Robin Murphy <robin.murphy@arm.com>
> >>cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >>cc: Christoph Hellwig <hch@lst.de>
> >>Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >>Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> >>Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >
> >The change itself looks ok, so
> >
> >Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >
> >However, I would like to see the commit message (and maybe the inline
> >comments) expanded a bit on what the distinction here is about.  Some
> >of the text from the next patch would be suitable, about DMA addresses
> >usually being in a different address space but not in the case of
> >bounce buffering.
> 
> Right, this needs a much tighter definition. "DMA address happens to
> be a valid physical address" is true of various IOMMU setups too,
> but I can't believe it's meaningful in such cases.

The definition by itself is meaningful AFAICT. At its core its just
indicating whether DMA addresses are physical addresses or not.

However its up to the caller to use it meaningfully. For non-virtio caller,
dma_addr_is_phys_addr() by itself may or may not be meaningful.

But for a virtio caller, this information when paired with
mem_encrypt_active() is meaningful.

For IOMMU setups DMA API will get used regardless of "DMA address
happens to be a valid physical address"


> 
> If what you actually want is "DMA is direct or SWIOTLB" - i.e. "DMA
> address is physical address of DMA data (not necessarily the
> original buffer)" - wouldn't dma_is_direct() suffice?

This may also work, I think.  MST: thoughts?

RP
