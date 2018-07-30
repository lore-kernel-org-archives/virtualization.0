From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
Date: Mon, 30 Jul 2018 02:34:14 -0700
Message-ID: <20180730093414.GD26245@infradead.org>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
	<20180727095804.GA25592@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180727095804.GA25592@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com, benh@kernel.crashing.org, linuxram@us.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, hch@infradead.org, paulus@samba.org, marc.zyngier@arm.com, mpe@ellerman.id.au, joe@perches.com, robin.murphy@arm.com, david@gibson.dropbear.id.au, linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net, haren@linux.vnet.ibm.com, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 27, 2018 at 10:58:05AM +0100, Will Deacon wrote:
> 
> I just wanted to say that this patch series provides a means for us to
> force the coherent DMA ops for legacy virtio devices on arm64, which in turn
> means that we can enable the SMMU with legacy devices in our fastmodel
> emulation platform (which is slowly being upgraded to virtio 1.0) without
> hanging during boot. Patch below.

Yikes, this is a nightmare.  That is exactly where I do not want things
to end up.  We really need to distinguish between legacy virtual crappy
virtio (and that includes v1) that totally ignores the bus it pretends
to be on, and sane virtio (to be defined) that sit on a real (or
properly emulated including iommu and details for dma mapping) bus.

Having a mumble jumble of arch specific undocumented magic as in
the powerpc patch replied to or this arm patch is a complete no-go.

Nacked-by: Christoph Hellwig <hch@lst.de>

for both.
