From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/virtio: print a single line with device features
Date: Tue, 22 Oct 2019 11:05:33 +0200
Message-ID: <20191022090533.GB11828__48052.9063659318$1571735172$gmane$org@phenom.ffwll.local>
References: <20191018113832.5460-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191018113832.5460-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 18, 2019 at 01:38:32PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_kms.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 0b3cdb0d83b0..2f5773e43557 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -155,16 +155,15 @@ int virtio_gpu_init(struct drm_device *dev)
>  #ifdef __LITTLE_ENDIAN
>  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
>  		vgdev->has_virgl_3d = true;
> -	DRM_INFO("virgl 3d acceleration %s\n",
> -		 vgdev->has_virgl_3d ? "enabled" : "not supported by host");
> -#else
> -	DRM_INFO("virgl 3d acceleration not supported by guest\n");
>  #endif
>  	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
>  		vgdev->has_edid = true;
> -		DRM_INFO("EDID support available.\n");
>  	}
>  
> +	DRM_INFO("features: %cvirgl %cedid\n",
> +		 vgdev->has_virgl_3d ? '+' : '-',
> +		 vgdev->has_edid     ? '+' : '-');

Maybe we should move the various yesno/onoff/enableddisabled helpers from
i915_utils.h to drm_utils.h and use them more widely?

Anyway Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> +
>  	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
>  	if (ret) {
>  		DRM_ERROR("failed to find virt queues\n");
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
