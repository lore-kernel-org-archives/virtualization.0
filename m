From: =?UTF-8?Q?Sjur_Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH 03/22] virtio_config: make transports implement accessors.
Date: Fri, 22 Mar 2013 15:43:00 +0100
Message-ID: <CAJK669aihduWvc216GdvFth3QTzbnQCcfVouYU1yntVUrXNJOQ@mail.gmail.com>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-4-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-4-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Pawel Moll <pawel.moll@arm.com>, Brian Swetland <swetland@google.com>, Linus Walleij <linus.walleij@linaro.org>, Erwan YVIN <Erwan.Yvin@stericsson.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 9:29 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> All transports just pass through at the moment.
>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Brian Swetland <swetland@google.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/lguest/lguest_device.c |   79 ++++++++++++++++++++++++++++++++++------
>  drivers/net/caif/caif_virtio.c |    2 +-
>  drivers/s390/kvm/kvm_virtio.c  |   78 +++++++++++++++++++++++++++++++++------
>  drivers/s390/kvm/virtio_ccw.c  |   39 +++++++++++++++++++-
>  drivers/virtio/virtio_mmio.c   |   35 +++++++++++++++++-
>  drivers/virtio/virtio_pci.c    |   39 +++++++++++++++++---
>  include/linux/virtio_config.h  |   70 +++++++++++++++++++++--------------
>  7 files changed, 283 insertions(+), 59 deletions(-)
>

> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -127,7 +127,7 @@ static void vp_finalize_features(struct virtio_device *vdev)
>         iowrite32(vdev->features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
>  }
>
> -/* virtio config->get() implementation */
> +/* Device config access: we use guest endian, as per spec. */
>  static void vp_get(struct virtio_device *vdev, unsigned offset,
>                    void *buf, unsigned len)
>  {
> @@ -141,8 +141,19 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>                 ptr[i] = ioread8(ioaddr + i);
>  }
>
> -/* the config->set() implementation.  it's symmetric to the config->get()
> - * implementation */
> +#define VP_GETx(bits)                                                  \
> +static u##bits vp_get##bits(struct virtio_device *vdev, unsigned int offset) \
> +{                                                                      \
> +       u##bits v;                                                      \
> +       vp_get(vdev, offset, &v, sizeof(v));                            \
> +       return v;                                                       \
> +}
> +
> +VP_GETx(8)
> +VP_GETx(16)
> +VP_GETx(32)
> +VP_GETx(64)
> +
>  static void vp_set(struct virtio_device *vdev, unsigned offset,
>                    const void *buf, unsigned len)
>  {
> @@ -156,6 +167,18 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>                 iowrite8(ptr[i], ioaddr + i);
>  }
>
> +#define VP_SETx(bits)                                                  \
> +static void vp_set##bits(struct virtio_device *vdev, unsigned int offset, \
> +                        u##bits v)                                     \
> +{                                                                      \
> +       vp_set(vdev, offset, &v, sizeof(v));                            \
> +}
> +
> +VP_SETx(8)
> +VP_SETx(16)
> +VP_SETx(32)
> +VP_SETx(64)
> +
>  /* config->{get,set}_status() implementations */
>  static u8 vp_get_status(struct virtio_device *vdev)
>  {
> @@ -653,8 +676,14 @@ static int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
>  }
>
>  static const struct virtio_config_ops virtio_pci_config_ops = {
> -       .get            = vp_get,
> -       .set            = vp_set,
> +       .get8           = vp_get8,
> +       .set8           = vp_set8,
> +       .get16          = vp_get16,
> +       .set16          = vp_set16,
> +       .get32          = vp_get32,
> +       .set32          = vp_set32,
> +       .get64          = vp_get64,
> +       .set64          = vp_set64,
>         .get_status     = vp_get_status,
>         .set_status     = vp_set_status,
>         .reset          = vp_reset,

Would it be possible to make this simpler and less verbose somehow?
At least three virtio devices: virtio_pci_legacy.c, virtio_mmio.c and
soon remoteproc_virtio.c will duplicate variants of the code above.

What if set8/get8 was mandatory, and the 16,32,64 variants where optional,
and then virtio_creadX() virtio_cwriteX did the magic to make things work?

Regards,
Sjur
