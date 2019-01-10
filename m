From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Thu, 10 Jan 2019 14:59:52 +0100
Message-ID: <20190110135952.GC9255__4875.31556650556$1547128681$gmane$org@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190110134433.15672-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Jens Axboe <axboe@kernel.dk>, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 10, 2019 at 02:44:30PM +0100, Joerg Roedel wrote:
> Hi,
> 
> there is a problem with virtio-blk driven devices when
> virtio-ring uses SWIOTLB through the DMA-API. This happens
> for example in AMD-SEV enabled guests, where the guest RAM
> is mostly encrypted and all emulated DMA has to happen
> to/from the SWIOTLB aperture.
> 
> The problem is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb. When
> the virtio-blk driver tries to read/write a block larger
> than that, the allocation of the dma-handle fails and an IO
> error is reported.

s/allocations/mappings/, right?  We don't use the swiotlb
buffer for the coherent allocations anymore, and I don't think
virtio-blk uses them anyway.

> This patch-set adds a check to the virtio-code whether it
> might be using SWIOTLB bounce buffering and limits the
> maximum segment size in the virtio-blk driver in this case,
> so that it doesn't try to do larger reads/writes.

I really don't like the fact that we hardcode swiotlb specific.
This needs to be indirect through the dma ops or struct device,
as various iommu implementations also have limits (although
usually much larger ones).
