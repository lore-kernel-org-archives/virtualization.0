From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: Add dma_addr_is_phys_addr()
Date: Tue, 15 Oct 2019 09:31:04 +0200
Message-ID: <20191015073104.GA32252__25733.4757408657$1571124689$gmane$org@lst.de>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
	<1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
	<20191014045139.GN4080@umbus.fritz.box>
	<37609731-5539-b906-aa94-2ef0242795ac@arm.com>
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
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, mpe@ellerman.id.au, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de, David Gibson <david@gibson.dropbear.id.au>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 14, 2019 at 11:29:24AM +0100, Robin Murphy wrote:
>> However, I would like to see the commit message (and maybe the inline
>> comments) expanded a bit on what the distinction here is about.  Some
>> of the text from the next patch would be suitable, about DMA addresses
>> usually being in a different address space but not in the case of
>> bounce buffering.
>
> Right, this needs a much tighter definition. "DMA address happens to be a 
> valid physical address" is true of various IOMMU setups too, but I can't 
> believe it's meaningful in such cases.
>
> If what you actually want is "DMA is direct or SWIOTLB" - i.e. "DMA address 
> is physical address of DMA data (not necessarily the original buffer)" - 
> wouldn't dma_is_direct() suffice?

It would.  But drivers have absolutely no business knowing any of this.
