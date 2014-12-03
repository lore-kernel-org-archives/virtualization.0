From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v5 07/19] virtio: allow virtio-1 queue layout
Date: Wed, 3 Dec 2014 12:44:58 +0100
Message-ID: <20141203124458.190fd590.cornelia.huck@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
	<1417525227-14051-8-git-send-email-cornelia.huck@de.ibm.com>
	<20141202144628.GA2974@redhat.com>
	<20141202155444.0731c48f.cornelia.huck@de.ibm.com>
	<20141202164136.1a57f358.cornelia.huck@de.ibm.com>
	<20141202190345.GA5185@redhat.com>
	<20141203102736.73576850.cornelia.huck@de.ibm.com>
	<20141203105004.2349cad4.cornelia.huck@de.ibm.com>
	<20141203105251.GB9299@redhat.com>
	<20141203121410.03c86c21.cornelia.huck@de.ibm.com>
	<20141203111917.GD9299@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141203111917.GD9299@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 3 Dec 2014 13:19:17 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Dec 03, 2014 at 12:14:10PM +0100, Cornelia Huck wrote:
> > On Wed, 3 Dec 2014 12:52:51 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Wed, Dec 03, 2014 at 10:50:04AM +0100, Cornelia Huck wrote:

> > > > @@ -748,6 +756,11 @@ void virtio_queue_set_align(VirtIODevice *vdev, int n, int align)
> > > >      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> > > >      VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> > > >  
> > > > +    /* virtio-1 compliant devices cannot change the aligment */
> > > > +    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > > > +        error_report("tried to modify queue alignment for virtio-1 device");
> > > > +        return;
> > > > +    }
> > > >      /* Check that the transport told us it was going to do this
> > > >       * (so a buggy transport will immediately assert rather than
> > > >       * silently failing to migrate this state)
> > > 
> > > Do we have to touch this now?
> > > It's only used by MMIO, right?
> > 
> > I don't think it hurts to put a guard in here.
> 
> I'd say let's not touch mmio ATM.

This is not mmio but common code :) I don't really see how this can
possibly hurt us; when mmio is converted to virtio-1, their queue setup
code needs to be changed anyway.


> > > > @@ -949,7 +961,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
> > > >          if (k->has_variable_vring_alignment) {
> > > >              qemu_put_be32(f, vdev->vq[i].vring.align);
> > > >          }
> > > > -        qemu_put_be64(f, vdev->vq[i].pa);
> > > > +        /* XXX virtio-1 devices */
> > > > +        qemu_put_be64(f, vdev->vq[i].vring.desc);
> > > >          qemu_put_be16s(f, &vdev->vq[i].last_avail_idx);
> > > >          if (k->save_queue) {
> > > >              k->save_queue(qbus->parent, i, f);
> > > > @@ -1044,13 +1057,14 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> > > >          if (k->has_variable_vring_alignment) {
> > > >              vdev->vq[i].vring.align = qemu_get_be32(f);
> > > >          }
> > > > -        vdev->vq[i].pa = qemu_get_be64(f);
> > > > +        vdev->vq[i].vring.desc = qemu_get_be64(f);
> > > >          qemu_get_be16s(f, &vdev->vq[i].last_avail_idx);
> > > >          vdev->vq[i].signalled_used_valid = false;
> > > >          vdev->vq[i].notification = true;
> > > >  
> > > > -        if (vdev->vq[i].pa) {
> > > > -            virtqueue_init(&vdev->vq[i]);
> > > > +        if (vdev->vq[i].vring.desc) {
> > > > +            /* XXX virtio-1 devices */
> > > 
> > > What does XXX mean here?
> > 
> > That I have not cared about migration of virtio-1 devices yet :)
> 
> OK sure, but why put comment here not at start of
> function?

I find it easier to annotate the places I notice. YMMV.

> 
> > > 
> > > > +            virtio_queue_update_rings(vdev, i);
> > > >          } else if (vdev->vq[i].last_avail_idx) {
> > > >              error_report("VQ %d address 0x0 "
> > > >                           "inconsistent with Host index 0x%x",
> 
