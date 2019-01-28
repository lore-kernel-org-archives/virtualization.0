From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/5 v3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 28 Jan 2019 10:53:22 -0500
Message-ID: <20190128155322.GA32686__23773.2361698121$1548701813$gmane$org@char.us.oracle.com>
References: <20190123163049.24863-1-joro@8bytes.org>
	<20190123135000-mutt-send-email-mst@kernel.org>
	<20190123211453.GA2474@char.us.oracle.com>
	<20190128101852-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190128101852-mutt-send-email-mst@kernel.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, jroedel@suse.de, brijesh.singh@amd.com, Joerg Roedel <joro@8bytes.org>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 28, 2019 at 10:20:05AM -0500, Michael S. Tsirkin wrote:
> On Wed, Jan 23, 2019 at 04:14:53PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Wed, Jan 23, 2019 at 01:51:29PM -0500, Michael S. Tsirkin wrote:
> > > On Wed, Jan 23, 2019 at 05:30:44PM +0100, Joerg Roedel wrote:
> > > > Hi,
> > > > 
> > > > here is the third version of this patch-set. Previous
> > > > versions can be found here:
> > > > 
> > > > 	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/
> > > > 
> > > > 	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/
> > > > 
> > > > The problem solved here is a limitation of the SWIOTLB implementation,
> > > > which does not support allocations larger than 256kb.  When the
> > > > virtio-blk driver tries to read/write a block larger than that, the
> > > > allocation of the dma-handle fails and an IO error is reported.
> > > 
> > > 
> > > OK looks good to me.
> > > I will park this in my tree for now this way it will get
> > > testing in linux-next.
> > > Can I get an ack from DMA maintainers on the DMA bits for
> > > merging this in 5.0?
> > 
> > You got mine (SWIOTBL is my area).
> 
> OK so
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Yes :-)
> 
> 
> 
> > > 
> > > > Changes to v2 are:
> > > > 
> > > > 	* Check if SWIOTLB is active before returning its limit in
> > > > 	  dma_direct_max_mapping_size()
> > > > 
> > > > 	* Only apply the maximum segment limit in virtio-blk when
> > > > 	  DMA-API is used for the vring
> > > > 
> > > > Please review.
> > > > 
> > > > Thanks,
> > > > 
> > > > 	Joerg
> > > > 
> > > > Joerg Roedel (5):
> > > >   swiotlb: Introduce swiotlb_max_mapping_size()
> > > >   swiotlb: Add is_swiotlb_active() function
> > > >   dma: Introduce dma_max_mapping_size()
> > > >   virtio: Introduce virtio_max_dma_size()
> > > >   virtio-blk: Consider virtio_max_dma_size() for maximum segment size
> > > > 
> > > >  drivers/block/virtio_blk.c   | 10 ++++++----
> > > >  drivers/virtio/virtio_ring.c | 10 ++++++++++
> > > >  include/linux/dma-mapping.h  | 16 ++++++++++++++++
> > > >  include/linux/swiotlb.h      | 11 +++++++++++
> > > >  include/linux/virtio.h       |  2 ++
> > > >  kernel/dma/direct.c          | 11 +++++++++++
> > > >  kernel/dma/swiotlb.c         | 10 ++++++++++
> > > >  7 files changed, 66 insertions(+), 4 deletions(-)
> > > > 
> > > > -- 
> > > > 2.17.1
