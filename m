From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Mon, 14 Jan 2019 21:19:35 +0100
Message-ID: <20190114201935.GA10781__11297.0951515765$1547693512$gmane$org@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
	<38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
	<20190114095002.GA29874@lst.de>
	<ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
	<20190114131114-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190114131114-mutt-send-email-mst@kernel.org>
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

On Mon, Jan 14, 2019 at 01:20:45PM -0500, Michael S. Tsirkin wrote:
> I don't think so - the issue is really that DMA API does not yet handle
> the SEV case 100% correctly. I suspect passthrough devices would have
> the same issue.

The DMA API handles the SEV case perfectly.  Its just that virtio_blk
supports huge segments that virtio does not generally support, but that
is not related to SEV in any way.

> In fact whoever sets IOMMU_PLATFORM is completely unaffected by
> Christoph's pet peeve.

No, the above happens only when we set IOMMU_PLATFORM.

> Christoph is saying that !IOMMU_PLATFORM devices should hide the
> compatibility code in a special per-device DMA API implementation.
> Which would be fine especially if we can manage not to introduce a bunch
> of indirect calls all over the place and hurt performance.  It's just
> that the benefit is unlikely to be big (e.g. we can't also get rid of
> the virtio specific memory barriers) so no one was motivated enough to
> work on it.

No.  The problem is that we still haven't fully specified what
IOMMU_PLATFORM and !IOMMU_PLATFORM actually mean.  Your
"ACCESS_PLATFORM/ORDER_PLATFORM" commit in the virtio-spec repo
improves it a little bit, but it is still far from enough.

As a start VIRTIO_F_ORDER_PLATFORM and VIRTIO_F_ACCESS_PLATFORM
absolutely MUST be set for hardware implementations.  Otherwise said
hardware has no chance of working on anything but the most x86-like
systems.

Second software implementations SHOULD set VIRTIO_F_ACCESS_PLATFORM,
because otherwise we can't add proper handling for things like SEV or
the IBM "secure hypervisor" thing.

Last but not least a lot of wording outside the area describing these
flags really needs some major updates in terms of DMA access.
