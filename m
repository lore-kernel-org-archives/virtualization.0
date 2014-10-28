From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 05/11] virtio: introduce legacy virtio
	devices
Date: Tue, 28 Oct 2014 16:40:18 +0100
Message-ID: <20141028164018.29d73d9f__6833.28074305809$1414514952$gmane$org@bahia.local>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
	<1412692807-12398-6-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692807-12398-6-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue,  7 Oct 2014 16:40:01 +0200
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> Introduce a helper function to indicate  whether a virtio device is
> operating in legacy or virtio standard mode.
> 
> It may be used to make decisions about the endianess of virtio accesses
> and other virtio-1 specific changes, enabling us to support transitional
> devices.
> 
> Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/virtio/virtio.c                |    6 +++++-
>  include/hw/virtio/virtio-access.h |    4 ++++
>  include/hw/virtio/virtio.h        |   13 +++++++++++--
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 7aaa953..e6ae3a0 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -883,7 +883,11 @@ static bool virtio_device_endian_needed(void *opaque)
>      VirtIODevice *vdev = opaque;
> 
>      assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> -    return vdev->device_endian != virtio_default_endian();
> +    if (virtio_device_is_legacy(vdev)) {
> +        return vdev->device_endian != virtio_default_endian();
> +    }
> +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +    return vdev->device_endian != VIRTIO_DEVICE_ENDIAN_LITTLE;
>  }
> 

Shouldn't we have some code doing the following somewhere ?

if (!virtio_device_is_legacy(vdev)) {
    vdev->device_endian = VIRTIO_DEVICE_ENDIAN_LITTLE;
}

also, since virtio-1 is LE only, do we expect device_endian to
be different from VIRTIO_DEVICE_ENDIAN_LITTLE ?


Cheers.

--
Greg

>  static const VMStateDescription vmstate_virtio_device_endian = {
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index 46456fd..c123ee0 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -19,6 +19,10 @@
> 
>  static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>  {
> +    if (!virtio_device_is_legacy(vdev)) {
> +        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +        return false;
> +    }
>  #if defined(TARGET_IS_BIENDIAN)
>      return virtio_is_big_endian(vdev);
>  #elif defined(TARGET_WORDS_BIGENDIAN)
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index b408166..40e567c 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -275,9 +275,18 @@ void virtio_queue_set_host_notifier_fd_handler(VirtQueue *vq, bool assign,
>  void virtio_queue_notify_vq(VirtQueue *vq);
>  void virtio_irq(VirtQueue *vq);
> 
> +static inline bool virtio_device_is_legacy(VirtIODevice *vdev)
> +{
> +    return !(vdev->guest_features[1] & (1 << (VIRTIO_F_VERSION_1 - 32)));
> +}
> +
>  static inline bool virtio_is_big_endian(VirtIODevice *vdev)
>  {
> -    assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> -    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
> +    if (virtio_device_is_legacy(vdev)) {
> +        assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
> +        return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
> +    }
> +    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> +    return false;
>  }
>  #endif
