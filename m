From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] virtio-blk: Consider virtio_max_dma_size() for
	maximum segment size
Date: Tue, 29 Jan 2019 08:38:39 +0100
Message-ID: <20190129073839.GB4087__36873.4165023611$1548826302$gmane$org@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org>
	<20190123163049.24863-6-joro@8bytes.org>
	<20190123213139.GD9032@lst.de> <20190124084011.GJ32526@8bytes.org>
	<20190124084221.GB19441@lst.de> <20190124095150.GL32526@8bytes.org>
	<20190128080526.GA3874@lst.de>
	<20190128121407-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190128121407-mutt-send-email-mst@kernel.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, jroedel@suse.de, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 28, 2019 at 12:14:33PM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 28, 2019 at 09:05:26AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 24, 2019 at 10:51:51AM +0100, Joerg Roedel wrote:
> > > On Thu, Jan 24, 2019 at 09:42:21AM +0100, Christoph Hellwig wrote:
> > > > Yes.  But more importantly it would fix the limit for all other block
> > > > drivers that set large segment sizes when running over swiotlb.
> > > 
> > > True, so it would be something like the diff below? I havn't worked on
> > > the block layer, so I don't know if that needs additional checks for
> > > ->dev or anything.
> > 
> > Looks sensible.  Maybe for now we'll just do the virtio-blk case
> > that triggered it, and we'll do something like this patch for the
> > next merge window.  We'll also need to apply the same magic to the
> > DMA boundary.
> 
> So do I get an ack for this patch then?

I'll wait for a resend of the series to review the whole thing.
