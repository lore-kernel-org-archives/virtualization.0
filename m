From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/5] swiotlb: Add is_swiotlb_active() function
Date: Mon, 28 Jan 2019 12:19:02 -0500
Message-ID: <20190128121749-mutt-send-email-mst__24261.7431724042$1548701830$gmane$org@kernel.org>
References: <20190123163049.24863-1-joro@8bytes.org>
	<20190123163049.24863-3-joro@8bytes.org>
	<20190123212755.GA9032@lst.de> <20190124082923.GI32526@8bytes.org>
	<20190124084107.GA19441@lst.de> <20190124150000.GN32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190124150000.GN32526@8bytes.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, jroedel@suse.de, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 24, 2019 at 04:00:00PM +0100, Joerg Roedel wrote:
> On Thu, Jan 24, 2019 at 09:41:07AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 24, 2019 at 09:29:23AM +0100, Joerg Roedel wrote:
> > > > As I've just introduced and fixed a bug in this area in the current
> > > > cycle - I don't think no_iotlb_memory is what your want (and maybe
> > > > not useful at all): if the arch valls swiotlb_exit after previously
> > > > initializing a buffer it won't be set.  You probably want to check
> > > > for non-zero io_tlb_start and/or io_tlb_end.
> > > 
> > > Okay, but that requires that I also set io_tlb_start and friends back to
> > > zero in the failure path of swiotlb_init(). Otherwise it could be left
> > > non-zero in case swiotlb_init_with_tbl() returns an error.
> > 
> > Indeed, and we'll need to do that anyway as otherwise the dma mapping
> > path might cause problems similar to the one when swiotlb_exit is
> > called that I fixed.
> 
> Turns out the the error path in swiotlb_init() is redundant because it
> will never be executed. If the function returns it will always return 0
> because in case of failure it will just panic (through memblock_alloc).
> 
> I'll clean that up in a separate patch-set. There are more users of that
> function and all of them panic when the function fails.
> 
> 
> 	Joerg

OK so are you going to post a new version then? Time's running out for 5.0.
This isn't a regression so maybe we should just defer it all to 5.1.

-- 
MST
