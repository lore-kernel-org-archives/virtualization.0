From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Wed, 16 Jan 2019 09:16:05 -0500
Message-ID: <20190116091048-mutt-send-email-mst__30408.2949100577$1547692586$gmane$org@kernel.org>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
	<38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
	<20190114095002.GA29874@lst.de>
	<ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
	<20190114131114-mutt-send-email-mst@kernel.org>
	<20190115083742.GF5825@8bytes.org> <20190115132019.GA28778@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190115132019.GA28778@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Joerg Roedel <joro@8bytes.org>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 15, 2019 at 02:20:19PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 15, 2019 at 09:37:42AM +0100, Joerg Roedel wrote:
> > On Mon, Jan 14, 2019 at 01:20:45PM -0500, Michael S. Tsirkin wrote:
> > > Which would be fine especially if we can manage not to introduce a bunch
> > > of indirect calls all over the place and hurt performance.
> > 
> > Which indirect calls? In case of unset dma_ops the DMA-API functions
> > call directly into the dma-direct implementation, no indirect calls at
> > all.
> 
> True.  But the NULL-ops dma direct case still has two issues that might
> not work for virtio:
> 
>  (a) if the architecture supports devices that are not DMA coherent it
>      will dip into a special allocator and do cache maintainance for
>      streaming mappings.  Although it would be a bit of a hack we could
>      work around this in virtio doings something like:
> 
> #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> 	dev->dma_coherent = true;
> #endif
> 
>     except that won't work for mips, which has a mode where it does
>     a system instead of device level coherency flag and thus doesn't
>     look at this struct device field
> 
>  (b) we can still mangle the DMA address, either using the
>      dma_pfn_offset field in struct device, or by a full override
>      of __phys_to_dma / __dma_to_phys by the architecture code.
>      The first could be solved using a hack like the one above,
>      but the latter would be a little harder.  In the long run
>      I'd love to get rid of that hook and have everyone use the
>      generic offset code, but for that we first need to support
>      multiple ranges with different offset and do quite some
>      nasty arch code surgery.
>  
> So for the legacy virtio case I fear we need to keep local dma mapping
> implementation for now.  I just wish now recent hypervisor would ever
> offer devices in this broken legacy mode..

IIUC some emulated hardware has no reasonable way to specify that
some devices bypass the IOMMU, and no cheap way to cover all
memory with an IOMMU mapping.

So I suspect !ACCESS_PLATFORM will stay a supported configuration
forever :(



> > 
> > Regards,
> > 
> > 	Joerg
> ---end quoted text---
