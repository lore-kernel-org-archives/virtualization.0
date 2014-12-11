From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC v6 04/20] virtio: add feature checking helpers
Date: Thu, 11 Dec 2014 19:05:26 +0200
Message-ID: <20141211170526.GA14001@redhat.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-5-git-send-email-cornelia.huck@de.ibm.com>
	<20141211154623.4a73fef9@oc7435384737.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141211154623.4a73fef9@oc7435384737.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 11, 2014 at 03:46:23PM +0100, Thomas Huth wrote:
> On Thu, 11 Dec 2014 14:25:06 +0100
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> > Add a helper function for checking whether a bit is set in the guest
> > features for a vdev as well as one that works on a feature bit set.
> > 
> > Convert code that open-coded this: It cleans up the code and makes it
> > easier to extend the guest feature bits.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ...
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index ef48550..56c92fb 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -144,7 +144,7 @@ static int virtio_scsi_parse_req(VirtIOSCSIReq *req,
> >       *
> >       * TODO: always disable this workaround for virtio 1.0 devices.
> >       */
> > -    if ((vdev->guest_features & VIRTIO_F_ANY_LAYOUT) == 0) {
> > +    if (!virtio_has_feature(vdev, VIRTIO_F_ANY_LAYOUT)) {
> 
> Wait ... this does not only look like a clean-up, but also like a
> bug-fix to me, since it should have been "(1 << VIRTIO_F_ANY_LAYOUT)"
> instead of "VIRTIO_F_ANY_LAYOUT" in the original code instead?
> 
> So in case this patch queue takes a little bit longer 'til it gets
> upstream, do we might want to submit a separate patch for fixing this
> issue first?

Yes, please do.


> >          req_size = req->elem.out_sg[0].iov_len;
> >          resp_size = req->elem.in_sg[0].iov_len;
> >      }
> > @@ -748,7 +748,7 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
> >      VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
> >      VirtIODevice *vdev = VIRTIO_DEVICE(s);
> > 
> > -    if (((vdev->guest_features >> VIRTIO_SCSI_F_CHANGE) & 1) &&
> > +    if (virtio_has_feature(vdev, VIRTIO_SCSI_F_CHANGE) &&
> >          dev->type != TYPE_ROM) {
> >          virtio_scsi_push_event(s, dev, VIRTIO_SCSI_T_PARAM_CHANGE,
> >                                 sense.asc | (sense.ascq << 8));
> > @@ -769,7 +769,7 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >          blk_op_block_all(sd->conf.blk, s->blocker);
> >      }
> > 
> > -    if ((vdev->guest_features >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
> > +    if (virtio_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
> >          virtio_scsi_push_event(s, sd,
> >                                 VIRTIO_SCSI_T_TRANSPORT_RESET,
> >                                 VIRTIO_SCSI_EVT_RESET_RESCAN);
> > @@ -783,7 +783,7 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >      VirtIOSCSI *s = VIRTIO_SCSI(vdev);
> >      SCSIDevice *sd = SCSI_DEVICE(dev);
> > 
> > -    if ((vdev->guest_features >> VIRTIO_SCSI_F_HOTPLUG) & 1) {
> > +    if (virtio_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
> >          virtio_scsi_push_event(s, sd,
> >                                 VIRTIO_SCSI_T_TRANSPORT_RESET,
> >                                 VIRTIO_SCSI_EVT_RESET_REMOVED);
> ...
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index 2fede2e..f6c0379 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -278,6 +278,17 @@ static inline void virtio_clear_feature(uint32_t *features, unsigned int fbit)
> >      *features &= ~(1 << fbit);
> >  }
> > 
> > +static inline bool __virtio_has_feature(uint32_t features, unsigned int fbit)
> > +{
> > +    assert(fbit < 32);
> > +    return !!(features & (1 << fbit));
> > +}
> > +
> > +static inline bool virtio_has_feature(VirtIODevice *vdev, unsigned int fbit)
> > +{
> > +    return __virtio_has_feature(vdev->guest_features, fbit);
> > +}
> > +
> 
> I've got to say that I'm a little bit unhappy with the naming of the
> functions - and in contrast to the Linux kernel code, I think it is
> also quite uncommon in the QEMU sources to use function names with
> double underscores at the beginning.
> 
> Could you maybe rename the second function to "virtio_vdev_has_feature"
> instead? And then remove the double underscores from the first function?
> 
>  Thomas
