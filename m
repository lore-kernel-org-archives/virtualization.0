From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v6 07/20] virtio: allow virtio-1 queue
	layout
Date: Wed, 28 Jan 2015 17:07:01 +0100
Message-ID: <20150128170701.4788fd09.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-8-git-send-email-cornelia.huck@de.ibm.com>
	<20150122020609.GI27371@voom.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150122020609.GI27371@voom.fritz.box>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 22 Jan 2015 13:06:09 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Dec 11, 2014 at 02:25:09PM +0100, Cornelia Huck wrote:
> > For virtio-1 devices, we allow a more complex queue layout that doesn't
> > require descriptor table and rings on a physically-contigous memory area:
> > add virtio_queue_set_rings() to allow transports to set this up.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> > ---
> >  hw/virtio/virtio-mmio.c    |    3 +++
> >  hw/virtio/virtio.c         |   53 ++++++++++++++++++++++++++++----------------
> >  include/hw/virtio/virtio.h |    3 +++
> >  3 files changed, 40 insertions(+), 19 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index 43b7e02..0c9b63b 100644
> > --- a/hw/virtio/virtio-mmio.c
> > +++ b/hw/virtio/virtio-mmio.c
> > @@ -244,8 +244,11 @@ static void virtio_mmio_write(void *opaque, hwaddr offset, uint64_t value,
> >      case VIRTIO_MMIO_QUEUENUM:
> >          DPRINTF("mmio_queue write %d max %d\n", (int)value, VIRTQUEUE_MAX_SIZE);
> >          virtio_queue_set_num(vdev, vdev->queue_sel, value);
> > +        /* Note: only call this function for legacy devices */
> 
> It's not clear to me if this is an assertion that this *does* only
> call the function for legacy devices or a fixme, that it *should* only
> call the function for legacy devices.

It's more like a note to whoever takes the virtio-mmio legacy device
code and writes a virtio-1 virtio-mmio device.

Does
/* Note: this function must only be called for legacy devices */
make that intention clearer?

> 
> > +        virtio_queue_update_rings(vdev, vdev->queue_sel);
> >          break;
> >      case VIRTIO_MMIO_QUEUEALIGN:
> > +        /* Note: this is only valid for legacy devices */
> >          virtio_queue_set_align(vdev, vdev->queue_sel, value);
> >          break;
> >      case VIRTIO_MMIO_QUEUEPFN:

(...)

> >  /* virt queue functions */
> > -static void virtqueue_init(VirtQueue *vq)
> > +void virtio_queue_update_rings(VirtIODevice *vdev, int n)
> 
> Perhaps something in the name to emphasise that this is only for <v1.0
> devices?

virtio_queue_legacy_update_rings()? Maybe a bit long...

> 
> >  {
> > -    hwaddr pa = vq->pa;
> > +    VRing *vring = &vdev->vq[n].vring;
> >  
> > -    vq->vring.desc = pa;
> > -    vq->vring.avail = pa + vq->vring.num * sizeof(VRingDesc);
> > -    vq->vring.used = vring_align(vq->vring.avail +
> > -                                 offsetof(VRingAvail, ring[vq->vring.num]),
> > -                                 vq->vring.align);
> > +    if (!vring->desc) {
> > +        /* not yet setup -> nothing to do */
> > +        return;
> > +    }
> > +    vring->avail = vring->desc + vring->num * sizeof(VRingDesc);
> > +    vring->used = vring_align(vring->avail +
> > +                              offsetof(VRingAvail, ring[vring->num]),
> > +                              vring->align);
> 
> Would it make sense to implement this in terms of
> virtio_queue_set_rings()?

Perhaps a bit confusing, since that would re-write desc.
> 
> >  }
