From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Thu, 10 Jan 2019 15:26:40 +0100
Message-ID: <20190110142640.GA5825__30678.9795206443$1547130287$gmane$org@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
	<20190110135952.GC9255@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190110135952.GC9255@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Christoph,

On Thu, Jan 10, 2019 at 02:59:52PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 10, 2019 at 02:44:30PM +0100, Joerg Roedel wrote:

> > The problem is a limitation of the SWIOTLB implementation,
> > which does not support allocations larger than 256kb. When
> > the virtio-blk driver tries to read/write a block larger
> > than that, the allocation of the dma-handle fails and an IO
> > error is reported.
> 
> s/allocations/mappings/, right?  We don't use the swiotlb
> buffer for the coherent allocations anymore, and I don't think
> virtio-blk uses them anyway.

'Allocation' in the sense that there are address ranges allocated, not
memory, but mappings would also be right.

> I really don't like the fact that we hardcode swiotlb specific.
> This needs to be indirect through the dma ops or struct device,
> as various iommu implementations also have limits (although
> usually much larger ones).

I though about exposing it through DMA-API, but didn't go that route as
I didn't want to extend a generic API for some SWIOTLB specifics. But if
there are more implementations that have a size limitation it makes
certainly sense to put it into the DMA-API. I'll change that in the
next version.

Thanks,

	Joerg
