From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio: new feature to detect IOMMU device quirk
Date: Tue, 26 Jul 2016 21:50:56 +0300
Message-ID: <20160726185056.GA16244__18233.2159289674$1469559073$gmane$org@redhat.com>
References: <20160719053823-mutt-send-email-mst@redhat.com>
	<20160725075009.GA25638@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160725075009.GA25638@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jul 25, 2016 at 12:50:09AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 19, 2016 at 05:38:23AM +0300, Michael S. Tsirkin wrote:
> > 
> > On other systems, including SPARC and PPC64, virtio-pci devices are
> > enumerated as though they are behind an IOMMU, but the virtio host
> > ignores the IOMMU, so we must either pretend that the IOMMU isn't
> > there or somehow map everything as the identity.
> > 
> > Add a feature bit to detect that quirk: VIRTIO_F_IOMMU_PLATFORM.
> > 
> > Any device with this feature bit set to 0 needs a quirk and has to be
> > passed physical addresses (as opposed to bus addresses) even though
> > the device is behind an IOMMU.
> 
> This is the wrong way around.
> 
> > Note: it has to be a per-device quirk because for example, there could
> > be a mix of passed-through and virtual virtio devices. As another
> > example, some devices could be implemented by an out of process
> > hypervisor backend (in case of qemu vhost, or vhost-user) and so support
> > for an IOMMU needs to be coded up separately.
> > 
> > It would be cleanest to handle this in IOMMU core code, but that needs
> > per-device DMA ops. While we are waiting for that to be implemented, use
> > a work-around in virtio core.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > wanted to use per-device dma ops but that does not
> > seem to be ready. So let's put this in virtio
> > code for now, and move when it becomes possible.
> 
> So work on making it ready.  We're close to there, and given that
> virtio needs it, finish it off.  We now have everyone using the
> operation vectors for DMA, so the only thing you need is a dma_ops
> pointer in struct device initialized to what get_dma_ops returns.

Given the timing, I suspect this will mean missing 4.8 though and I'd
much rather have something working finally and clean it up later.

And from experience, people seem to find it easier to re-factor
and clean up working code.

This patch is all of 10 lines so I'm comfortable including it right away -
I'll add a big TODO in v4 so we don't forget.

-- 
MST
