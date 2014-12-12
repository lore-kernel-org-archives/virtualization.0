From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH RFC v6 05/20] virtio: support more feature bits
Date: Fri, 12 Dec 2014 11:17:47 +0100
Message-ID: <20141212111747.26047921.cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
	<20141212110640.5ddfcbda@oc7435384737.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141212110640.5ddfcbda@oc7435384737.ibm.com>
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 12 Dec 2014 11:06:40 +0100
Thomas Huth <thuth@linux.vnet.ibm.com> wrote:

> On Thu, 11 Dec 2014 14:25:07 +0100
> Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> 
> > With virtio-1, we support more than 32 feature bits. Let's extend both
> > host and guest features to 64, which should suffice for a while.
> > 
> > vhost and migration have been ignored for now.
> > 
> > Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

> > @@ -1036,7 +1036,7 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf, size_t
> >                  return -1;
> >              error_report("virtio-net unexpected empty queue: "
> >                      "i %zd mergeable %d offset %zd, size %zd, "
> > -                    "guest hdr len %zd, host hdr len %zd guest features 0x%x",
> > +                    "guest hdr len %zd, host hdr len %zd guest features 0x%lx",
> 
> I think you need a different format string like PRIx64 here so that the
> code also works right on a 32-bit system (where long is only 32-bit).

Reminder to self: set up cross-compile again.

> 
> >                      i, n->mergeable_rx_bufs, offset, size,
> >                      n->guest_hdr_len, n->host_hdr_len, vdev->guest_features);
> >              exit(1);

> > @@ -399,8 +401,14 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
> >              features.index = ldub_phys(&address_space_memory,
> >                                         ccw.cda + sizeof(features.features));
> >              features.features = ldl_le_phys(&address_space_memory, ccw.cda);
> > -            if (features.index < ARRAY_SIZE(dev->host_features)) {
> > -                virtio_set_features(vdev, features.features);
> > +            if (features.index == 0) {
> > +                virtio_set_features(vdev,
> > +                                    (vdev->guest_features & 0xffffffff00000000) |
> > +                                    features.features);
> > +            } else if (features.index == 1) {
> > +                virtio_set_features(vdev,
> > +                                    (vdev->guest_features & 0x00000000ffffffff) |
> > +                                    ((uint64_t)features.features << 32));
> 
> The long constants 0xffffffff00000000 and 0x00000000ffffffff should
> probably get an ULL suffix.

Probably.

> > @@ -593,6 +593,7 @@ void virtio_reset(void *opaque)
> >      }
> > 
> >      vdev->guest_features = 0;
> > +
> 
> Unnecessary white space change?

Crept in during various rebase sessions :)

> 
> >      vdev->queue_sel = 0;
> >      vdev->status = 0;
> >      vdev->isr = 0;
> > @@ -924,7 +925,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
> >      qemu_put_8s(f, &vdev->status);
> >      qemu_put_8s(f, &vdev->isr);
> >      qemu_put_be16s(f, &vdev->queue_sel);
> > -    qemu_put_be32s(f, &vdev->guest_features);
> > +    /* XXX features >= 32 */
> > +    qemu_put_be32s(f, (uint32_t *)&vdev->guest_features);
> 
> Casting a uint64_t* to a uint32_t* here sounds very wrong - this likely
> only works on little endian sytems, but certainly not on big-endian
> systems.
> If you do not want to extend this for 64-bit right from the beginning,
> I think you've got to use a temporary 32-bit variable to get this right.

Hm... always store the old 32 bits here, then store the new 32 bits
later? Should be able to get that compatible.


> > +#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {  \
> > +        .name      = (_name),                                    \
> > +        .info      = &(qdev_prop_bit64),                           \
> 
> No need for the paranthesis around qdev_prop_bit64 here?

Straight copy&paste :) I'd prefer to keep the same style for all
#defines here.

> 
> > +        .bitnr    = (_bit),                                      \
> > +        .offset    = offsetof(_state, _field)                    \
> > +            + type_check(uint64_t,typeof_field(_state, _field)), \
> > +        .qtype     = QTYPE_QBOOL,                                \
> > +        .defval    = (bool)_defval,                              \
> > +        }
