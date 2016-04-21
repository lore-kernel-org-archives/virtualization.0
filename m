From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2 RFC] fixup! virtio: convert to use DMA api
Date: Thu, 21 Apr 2016 18:11:40 +0300
Message-ID: <20160421181102-mutt-send-email-mst@redhat.com>
References: <1461245745-6710-1-git-send-email-mst@redhat.com>
	<20160421145653.GB11814@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160421145653.GB11814@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Liu <wei.liu2@citrix.com>, kvm@vger.kernel.org, qemu-block@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, peterx@redhat.com, linux-kernel@vger.kernel.org, Amit Shah <amit.shah@redhat.com>, Andy Lutomirski <luto@kernel.org>, pbonzini@redhat.com, virtualization@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 21, 2016 at 03:56:53PM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 21, 2016 at 04:43:45PM +0300, Michael S. Tsirkin wrote:
> > This adds a flag to enable/disable bypassing the IOMMU by
> > virtio devices.
> > 
> > This is on top of patch
> > http://article.gmane.org/gmane.comp.emulators.qemu/403467
> > virtio: convert to use DMA api
> > 
> > Tested with patchset
> > http://article.gmane.org/gmane.linux.kernel.virtualization/27545
> > virtio-pci: iommu support (note: bit number has been kept at 34
> > intentionally to match posted guest code. a non-RFC version will
> > renumber bits to be contigious).
> > 
> > changes from v1:
> >     drop PASSTHROUGH flag
> > 
> > The interaction between virtio and DMA API is messy.
> > 
> > On most systems with virtio, physical addresses match bus addresses,
> > and it doesn't particularly matter whether we use the DMA API.
> > 
> > On some systems, including Xen and any system with a physical device
> > that speaks virtio behind a physical IOMMU, we must use the DMA API
> > for virtio DMA to work at all.
> > 
> > Add a feature bit to detect that: VIRTIO_F_IOMMU_PLATFORM.
> > 
> > If not there, we preserve historic behavior and bypass the DMA
> > API unless within Xen guest. This is actually required for
> > systems, including SPARC and PPC64, where virtio-pci devices are
> > enumerated as though they are behind an IOMMU, but the virtio host
> > ignores the IOMMU, so we must either pretend that the IOMMU isn't
> > there or somehow map everything as the identity.
> > 
> > Re: non-virtio devices.
> > 
> > It turns out that on old QEMU hosts, only emulated devices which were
> > part of QEMU use the IOMMU.  Should we want to bypass the IOMMU for such
> > devices *only*, it would be rather easy to detect them by looking at
> > subsystem vendor and device ID. Thus, no new interfaces are required
> > except for virtio which always uses the same subsystem vendor and device ID.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/hw/virtio/virtio-access.h              | 3 ++-
> >  include/hw/virtio/virtio.h                     | 4 +++-
> >  include/standard-headers/linux/virtio_config.h | 2 ++
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> > index 967cc75..bb6f34e 100644
> > --- a/include/hw/virtio/virtio-access.h
> > +++ b/include/hw/virtio/virtio-access.h
> > @@ -23,7 +23,8 @@ static inline AddressSpace *virtio_get_dma_as(VirtIODevice *vdev)
> >      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> >      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> >  
> > -    if (k->get_dma_as) {
> > +    if (virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM) &&
> > +        k->get_dma_as) {
> >          return k->get_dma_as(qbus->parent);
> >      }
> >      return &address_space_memory;
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index b12faa9..44f3788 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -228,7 +228,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> >      DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
> >                        VIRTIO_F_NOTIFY_ON_EMPTY, true), \
> >      DEFINE_PROP_BIT64("any_layout", _state, _field, \
> > -                      VIRTIO_F_ANY_LAYOUT, true)
> > +                      VIRTIO_F_ANY_LAYOUT, true), \
> > +    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> > +                      VIRTIO_F_IOMMU_PLATFORM, false)
> 
> Looks like the impact of this patch is that users who relied on
> k->get_dma_as today may now have to explicitly add iommu_platform=on.
> Are there any such users (e.g. Xen)?

No because upstream this is ignored. This is an incremental patch
on top of Jason's one.

> Instead of breaking the command-line for these users you could invert
> the flag's meaning ("iommu_bypass=on") and set it in the SPARC/PPC
> machine types.
> 
> Stefan

I hope I made it clear that there are no such users.
