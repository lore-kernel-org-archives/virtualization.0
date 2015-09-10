From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 3/5] update virtio gpu driver: add 3d/virgl support
Date: Thu, 10 Sep 2015 09:56:22 +0100
Message-ID: <CACvgo51Y7j0ka46Rfq2eBvXzP4q8Jc6x4j-JrYHDLkH6_xOh7w__29451.2046654292$1441900568$gmane$org@mail.gmail.com>
References: <1441798946-26233-1-git-send-email-kraxel@redhat.com>
	<1441798946-26233-4-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441798946-26233-4-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "open list:ABI/API" <linux-api@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello Gert,

On 9 September 2015 at 12:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Add the bits needed for opengl rendering support: query
> capabilities, new virtio commands, drm ioctls.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

> +
> +struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_MAP, virtio_gpu_map_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),
> +
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_EXECBUFFER, virtio_gpu_execbuffer_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),
> +
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_GETPARAM, virtio_gpu_getparam_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),
> +
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_CREATE,
> +                         virtio_gpu_resource_create_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),
> +
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_RESOURCE_INFO, virtio_gpu_resource_info_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),
> +
> +       /* make transfer async to the main ring? - no sure, can we
> +          thread these in the underlying GL */
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_FROM_HOST,
> +                         virtio_gpu_transfer_from_host_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_TO_HOST,
> +                         virtio_gpu_transfer_to_host_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),
> +
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_WAIT, virtio_gpu_wait_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),
> +
> +       DRM_IOCTL_DEF_DRV(VIRTGPU_GET_CAPS, virtio_gpu_get_caps_ioctl,
> +                         DRM_AUTH|DRM_UNLOCKED),

Just a FYI - Daniel Vetter has a series in flight which deprecates
DRM_UNLOCKED for KMS drivers.

> --- /dev/null
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -0,0 +1,163 @@

> +
> +struct drm_virtgpu_3d_box {
> +       uint32_t x, y, z;
> +       uint32_t w, h, d;
> +};
> +
There was a similar case (multiple variables declared on a single
line) in drm core that caused confusion and we broke the 32bit compat.
I thought I mention it - not advocating for/against the above declaration.

> +struct drm_virtgpu_3d_transfer_to_host {
> +       uint32_t bo_handle;
> +       struct drm_virtgpu_3d_box box;
> +       uint32_t level;
> +       uint32_t offset;
> +};
> +
> +struct drm_virtgpu_3d_transfer_from_host {
> +       uint32_t bo_handle;
> +       struct drm_virtgpu_3d_box box;
> +       uint32_t level;
> +       uint32_t offset;
> +};
> +
Afaics these seems to be used by the ioctls. If so the current
declarations are not 32bit compat safe. Things will also go badly if
you consider expanding struct drm_virtgpu_3d_box in the distant
future. A u32 pad after bo_handle and a 'pointer' to struct
drm_virtgpu_3d_box might be the more flexible solution.

I believe the original idea is to use __[su]XX types in the public drm
headers, although it seems that most drivers opted for [u]intXX_t
ones. Don't quote me on that last one :)

Cheers,
Emil
