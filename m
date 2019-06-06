From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 12/13] drm/virtio: drop DRM_AUTH usage from the driver
Date: Thu, 6 Jun 2019 11:59:15 +0100
Message-ID: <CACvgo51+WknrTjzEhc6EitJV5EA0f9SXznQMkw3Y_ixPHSOLPQ__47265.5147708551$1559818881$gmane$org@mail.gmail.com>
References: <20190527081741.14235-1-emil.l.velikov@gmail.com>
	<20190527081741.14235-12-emil.l.velikov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190527081741.14235-12-emil.l.velikov@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: ML dri-devel <dri-devel@lists.freedesktop.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 27 May 2019 at 09:19, Emil Velikov <emil.l.velikov@gmail.com> wrote:
>
> From: Emil Velikov <emil.velikov@collabora.com>
>
> The authentication can be circumvented, by design, by using the render
> node.
>
> From the driver POV there is no distinction between primary and render
> nodes, thus we can drop the token.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 949a264985fc..e72626faba52 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -553,34 +553,34 @@ static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
>
>  struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
>         DRM_IOCTL_DEF_DRV(VIRTGPU_MAP, virtio_gpu_map_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>
>         DRM_IOCTL_DEF_DRV(VIRTGPU_EXECBUFFER, virtio_gpu_execbuffer_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>
>         DRM_IOCTL_DEF_DRV(VIRTGPU_GETPARAM, virtio_gpu_getparam_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>
>         DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_CREATE,
>                           virtio_gpu_resource_create_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>
>         DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_INFO, virtio_gpu_resource_info_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>
>         /* make transfer async to the main ring? - no sure, can we
>          * thread these in the underlying GL
>          */
>         DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_FROM_HOST,
>                           virtio_gpu_transfer_from_host_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_TO_HOST,
>                           virtio_gpu_transfer_to_host_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>
>         DRM_IOCTL_DEF_DRV(VIRTGPU_WAIT, virtio_gpu_wait_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>
>         DRM_IOCTL_DEF_DRV(VIRTGPU_GET_CAPS, virtio_gpu_get_caps_ioctl,
> -                         DRM_AUTH | DRM_UNLOCKED | DRM_RENDER_ALLOW),
> +                         DRM_UNLOCKED | DRM_RENDER_ALLOW),
>  };
> --
> 2.21.0
>

Humble poke?

Thanks,
Emil
