From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] swiotlb: Export maximum allocation size
Date: Tue, 15 Jan 2019 14:05:36 +0100
Message-ID: <20190115130536.GA28364__4485.74296101487$1547692243$gmane$org@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org>
	<20190110134433.15672-2-joro@8bytes.org>
	<20190110170205.GB27546@char.us.oracle.com>
	<20190111091231.GB5825@8bytes.org>
	<20190114204907.GH32038@char.us.oracle.com>
	<20190114165800-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190114165800-mutt-send-email-mst@kernel.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Joerg Roedel <jroedel@suse.de>, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Joerg Roedel <joro@8bytes.org>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 14, 2019 at 04:59:27PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 14, 2019 at 03:49:07PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Fri, Jan 11, 2019 at 10:12:31AM +0100, Joerg Roedel wrote:
> > > On Thu, Jan 10, 2019 at 12:02:05PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > Why not use swiotlb_nr_tbl ? That is how drivers/gpu/drm use to figure if they
> > > > need to limit the size of pages.
> > > 
> > > That function just exports the overall size of the swiotlb aperture, no?
> > > What I need here is the maximum size for a single mapping.
> > 
> > Yes. The other drivers just assumed that if there is SWIOTLB they would use
> > the smaller size by default (as in they knew the limitation).
> > 
> > But I agree it would be better to have something smarter - and also convert the
> > DRM drivers to piggy back on this.
> > 
> > Or alternatively we could make SWIOTLB handle bigger sizes..
> 
> 
> Just a thought: is it a good idea to teach blk_queue_max_segment_size
> to get the dma size? This will help us find other devices
> possibly missing this check.

Yes, we should.  Both the existing DMA size communicated through dma_params
which is set by the driver, and this new DMA-ops exposed one which needs
to be added.  I'm working on some preliminary patches for the first part,
as I think I introduced a bug related to that in the SCSI layer in 5.0..
