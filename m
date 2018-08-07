From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Tue, 07 Aug 2018 16:44:01 +1000
Message-ID: <7622efcbb499919616f165266968565b1d329a91.camel@kernel.crashing.org>
References: <20180803220443-mutt-send-email-mst@kernel.org>
	<051fd78e15595b414839fa8f9d445b9f4d7576c6.camel@kernel.crashing.org>
	<20180805031046-mutt-send-email-mst@kernel.org>
	<fd8fee94cf42e436878f179c7895de3a4dab3355.camel@kernel.crashing.org>
	<20180806164106-mutt-send-email-mst@kernel.org>
	<ef6d5d7c7b812bd797a1c3fd6bc7a26d0074020f.camel@kernel.crashing.org>
	<20180806233024-mutt-send-email-mst@kernel.org>
	<0967fc30001323e6e38ed12c8dba8ee3d1aa13f5.camel@kernel.crashing.org>
	<20180807002857-mutt-send-email-mst@kernel.org>
	<93518075238a07e9f011774d89bdc652c083f1ba.camel@kernel.crashing.org>
	<20180807062731.GA23159@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180807062731.GA23159@infradead.org>
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
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, mpe@ellerman.id.au, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, jean-philippe.brucker@arm.com, paulus@samba.org, marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2018-08-06 at 23:27 -0700, Christoph Hellwig wrote:
> On Tue, Aug 07, 2018 at 08:13:56AM +1000, Benjamin Herrenschmidt wrote:
> > It would be indeed ideal if all we had to do was setup some kind of
> > bus_dma_mask on all PCI devices and have virtio automagically insert
> > swiotlb when necessary.
> 
> For 4.20 I plan to remove the swiotlb ops and instead do the bounce
> buffering in the common code, including a direct call to the direct
> ops to avoid retpoline overhead.  For that you still need a flag
> in virtio that instead of blindly working physical addresses it needs
> to be treated like a real device in terms of DMA.

But you will still call the swiotlb infrastructure, right ? IE, I sitll
need to control where/how the swiotlb "pool" is allocated.
> 
> And for powerpc to make use of that I need to get the dma series I
> posted last week reviewed and included, otherwise powerpc will have
> to be excepted (like arm, where rmk didn't like the way the code
> was factored, everything else has already been taken care of).
> 
> https://lists.linuxfoundation.org/pipermail/iommu/2018-July/028989.html

Yes, I saw your series. I'm just back from a week of travel, I plan to
start reviewing it this week if Michael doesn't beat me to it.

Cheers,
Ben.
