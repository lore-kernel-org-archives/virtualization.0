From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 15:48:47 -0500
Message-ID: <20190114153004-mutt-send-email-mst__47209.0195552029$1547693553$gmane$org@kernel.org>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
	<38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
	<20190114095002.GA29874@lst.de>
	<ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
	<20190114131114-mutt-send-email-mst@kernel.org>
	<20190114201935.GA10781@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190114201935.GA10781@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 14, 2019 at 09:19:35PM +0100, Christoph Hellwig wrote:
> > Christoph is saying that !IOMMU_PLATFORM devices should hide the
> > compatibility code in a special per-device DMA API implementation.
> > Which would be fine especially if we can manage not to introduce a bunch
> > of indirect calls all over the place and hurt performance.  It's just
> > that the benefit is unlikely to be big (e.g. we can't also get rid of
> > the virtio specific memory barriers) so no one was motivated enough to
> > work on it.
> 
> No.  

Oh ok then.

> The problem is that we still haven't fully specified what
> IOMMU_PLATFORM and !IOMMU_PLATFORM actually mean.  Your
> "ACCESS_PLATFORM/ORDER_PLATFORM" commit in the virtio-spec repo
> improves it a little bit, but it is still far from enough.
> 
> As a start VIRTIO_F_ORDER_PLATFORM and VIRTIO_F_ACCESS_PLATFORM
> absolutely MUST be set for hardware implementations.  Otherwise said
> hardware has no chance of working on anything but the most x86-like
> systems.

I think you are exaggerating a little here.  Limited access with e.g.
need to flush caches is common on lower end but less common on higher
end systems used for virtualization.  As you point out that changes with
e.g. SEV but then SEV is a pretty niche thing so far.

So I would make that a SHOULD probably.

> Second software implementations SHOULD set VIRTIO_F_ACCESS_PLATFORM,
> because otherwise we can't add proper handling for things like SEV or
> the IBM "secure hypervisor" thing.

Yes. If host does not have access to all of memory it SHOULD set
VIRTIO_F_ACCESS_PLATFORM.

It seems rather straight-forward to add conformance clauses
for this, thanks for reminding me.


> Last but not least a lot of wording outside the area describing these
> flags really needs some major updates in terms of DMA access.

Thanks for the reminder. Yes generally spec tends to still say e.g.
"physical address" where it really means a "DMA address" in Linux terms.
Whether changing that will make things much clearer I'm not sure. E.g.
hardware designers don't much care I guess.

If you want to list the most problematic cases, e.g. in a github issue,
we might get to clarifying them sooner.

Thanks!

-- 
MST
