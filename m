From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Tue, 15 Jan 2019 14:09:22 +0100
Message-ID: <20190115130922.GB28364__29684.0519564741$1547692259$gmane$org@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
	<38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
	<20190114095002.GA29874@lst.de>
	<ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
	<20190114131114-mutt-send-email-mst@kernel.org>
	<20190114201935.GA10781@lst.de>
	<20190114153004-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190114153004-mutt-send-email-mst@kernel.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 14, 2019 at 03:48:47PM -0500, Michael S. Tsirkin wrote:
> I think you are exaggerating a little here.  Limited access with e.g.
> need to flush caches is common on lower end but less common on higher
> end systems used for virtualization.  As you point out that changes with
> e.g. SEV but then SEV is a pretty niche thing so far.
> 
> So I would make that a SHOULD probably.

The problem is that without using DMA ops you can't just plug the device
into a random system, which is a total no-go for periphals.

And cache flushing is not that uncommmon, e.g. every sparc systems
needs it, many arm/arm64 ones, some power ones, lots of mips ones, etc.

But cache flushing is just one side of it - lots of systems have either
mandatory or option IOMMUs, and without the platform access flag that
doesn't work.  As does that case where you have a DMA offset, which
is extremly common on arm and power systems.  So you might find a few
non-x86 systems you can plug it in and it'll just work, but it won't
be all that many.  And even on x86 your device will be completely broken
if the users dares to use an IOMMU.

> > flags really needs some major updates in terms of DMA access.
> 
> Thanks for the reminder. Yes generally spec tends to still say e.g.
> "physical address" where it really means a "DMA address" in Linux terms.
> Whether changing that will make things much clearer I'm not sure. E.g.
> hardware designers don't much care I guess.

At least say bus address - as said above the CPU and bus concepts of
physicall addresses are different in many systems.  Including x86
when you use IOMMUs.
