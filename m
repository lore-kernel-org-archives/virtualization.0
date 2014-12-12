From: Thomas Huth <thuth@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC v6 05/20] virtio: support more feature bits
Date: Fri, 12 Dec 2014 11:06:40 +0100
Message-ID: <20141212110640.5ddfcbda@oc7435384737.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-6-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 11 Dec 2014 14:25:07 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> With virtio-1, we support more than 32 feature bits. Let's extend both
> host and guest features to 64, which should suffice for a while.
> 
> vhost and migration have been ignored for now.
> 
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/9pfs/virtio-9p-device.c      |    2 +-
>  hw/block/virtio-blk.c           |    2 +-
>  hw/char/virtio-serial-bus.c     |    2 +-
>  hw/core/qdev-properties.c       |   58 +++++++++++++++++++++++++++++++++++++++
>  hw/net/virtio-net.c             |   22 +++++++--------
>  hw/s390x/s390-virtio-bus.c      |    3 +-
>  hw/s390x/s390-virtio-bus.h      |    2 +-
>  hw/s390x/virtio-ccw.c           |   39 +++++++++++++++-----------
>  hw/s390x/virtio-ccw.h           |    5 +---
>  hw/scsi/vhost-scsi.c            |    3 +-
>  hw/scsi/virtio-scsi.c           |    4 +--
>  hw/virtio/virtio-balloon.c      |    2 +-
>  hw/virtio/virtio-bus.c          |    6 ++--
>  hw/virtio/virtio-mmio.c         |    4 +--
>  hw/virtio/virtio-pci.c          |    3 +-
>  hw/virtio/virtio-pci.h          |    2 +-
>  hw/virtio/virtio-rng.c          |    2 +-
>  hw/virtio/virtio.c              |   13 +++++----
>  include/hw/qdev-properties.h    |   12 ++++++++
>  include/hw/virtio/virtio-bus.h  |    8 +++---
>  include/hw/virtio/virtio-net.h  |   46 +++++++++++++++----------------
>  include/hw/virtio/virtio-scsi.h |    6 ++--
>  include/hw/virtio/virtio.h      |   38 ++++++++++++++-----------
>  23 files changed, 184 insertions(+), 100 deletions(-)
...
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 9f3c58a..d6d1b98 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
...
> @@ -514,7 +514,7 @@ static inline uint64_t virtio_net_supported_guest_offloads(VirtIONet *n)
>      return virtio_net_guest_offloads_by_features(vdev->guest_features);
>  }
> 
> -static void virtio_net_set_features(VirtIODevice *vdev, uint32_t features)
> +static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>  {
>      VirtIONet *n = VIRTIO_NET(vdev);
>      int i;
> @@ -1036,7 +1036,7 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf, size_t
>                  return -1;
>              error_report("virtio-net unexpected empty queue: "
>                      "i %zd mergeable %d offset %zd, size %zd, "
> -                    "guest hdr len %zd, host hdr len %zd guest features 0x%x",
> +                    "guest hdr len %zd, host hdr len %zd guest features 0x%lx",

I think you need a different format string like PRIx64 here so that the
code also works right on a 32-bit system (where long is only 32-bit).

>                      i, n->mergeable_rx_bufs, offset, size,
>                      n->guest_hdr_len, n->host_hdr_len, vdev->guest_features);
>              exit(1);
...
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 3fee4aa..fbd909d 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -371,8 +371,10 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>          } else {
>              features.index = ldub_phys(&address_space_memory,
>                                         ccw.cda + sizeof(features.features));
> -            if (features.index < ARRAY_SIZE(dev->host_features)) {
> -                features.features = dev->host_features[features.index];
> +            if (features.index == 0) {
> +                features.features = (uint32_t)dev->host_features;
> +            } else if (features.index == 1) {
> +                features.features = (uint32_t)(dev->host_features >> 32);
>              } else {
>                  /* Return zeroes if the guest supports more feature bits. */
>                  features.features = 0;
> @@ -399,8 +401,14 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>              features.index = ldub_phys(&address_space_memory,
>                                         ccw.cda + sizeof(features.features));
>              features.features = ldl_le_phys(&address_space_memory, ccw.cda);
> -            if (features.index < ARRAY_SIZE(dev->host_features)) {
> -                virtio_set_features(vdev, features.features);
> +            if (features.index == 0) {
> +                virtio_set_features(vdev,
> +                                    (vdev->guest_features & 0xffffffff00000000) |
> +                                    features.features);
> +            } else if (features.index == 1) {
> +                virtio_set_features(vdev,
> +                                    (vdev->guest_features & 0x00000000ffffffff) |
> +                                    ((uint64_t)features.features << 32));

The long constants 0xffffffff00000000 and 0x00000000ffffffff should
probably get an ULL suffix.

...
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 5814433..7f74ae5 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -593,6 +593,7 @@ void virtio_reset(void *opaque)
>      }
> 
>      vdev->guest_features = 0;
> +

Unnecessary white space change?

>      vdev->queue_sel = 0;
>      vdev->status = 0;
>      vdev->isr = 0;
> @@ -924,7 +925,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      qemu_put_8s(f, &vdev->status);
>      qemu_put_8s(f, &vdev->isr);
>      qemu_put_be16s(f, &vdev->queue_sel);
> -    qemu_put_be32s(f, &vdev->guest_features);
> +    /* XXX features >= 32 */
> +    qemu_put_be32s(f, (uint32_t *)&vdev->guest_features);

Casting a uint64_t* to a uint32_t* here sounds very wrong - this likely
only works on little endian sytems, but certainly not on big-endian
systems.
If you do not want to extend this for 64-bit right from the beginning,
I think you've got to use a temporary 32-bit variable to get this right.

...
> @@ -1005,9 +1007,10 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>      }
>      qemu_get_be32s(f, &features);
> 
> +    /* XXX features >= 32 */
>      if (virtio_set_features(vdev, features) < 0) {
>          supported_features = k->get_features(qbus->parent);
> -        error_report("Features 0x%x unsupported. Allowed features: 0x%x",
> +        error_report("Features 0x%x unsupported. Allowed features: 0x%lx",
>                       features, supported_features);

You'll likely need the PRIx64 format here, too.

>          return -1;
>      }
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 070006c..81e5d0b 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -6,6 +6,7 @@
>  /*** qdev-properties.c ***/
> 
>  extern PropertyInfo qdev_prop_bit;
> +extern PropertyInfo qdev_prop_bit64;
>  extern PropertyInfo qdev_prop_bool;
>  extern PropertyInfo qdev_prop_uint8;
>  extern PropertyInfo qdev_prop_uint16;
> @@ -51,6 +52,17 @@ extern PropertyInfo qdev_prop_arraylen;
>          .defval    = (bool)_defval,                              \
>          }
> 
> +#define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {  \
> +        .name      = (_name),                                    \
> +        .info      = &(qdev_prop_bit64),                           \

No need for the paranthesis around qdev_prop_bit64 here?

> +        .bitnr    = (_bit),                                      \
> +        .offset    = offsetof(_state, _field)                    \
> +            + type_check(uint64_t,typeof_field(_state, _field)), \
> +        .qtype     = QTYPE_QBOOL,                                \
> +        .defval    = (bool)_defval,                              \
> +        }

 Thomas
