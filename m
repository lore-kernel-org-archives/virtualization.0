From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] drm/virtio: fix error check
Date: Fri, 14 Feb 2020 09:57:23 +0100
Message-ID: <20200214095723.0c489524.cohuck@redhat.com>
References: <20200214080100.1273-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214080100.1273-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, olvaffe@gmail.com, smitterl@redhat.com, gurchetansingh@chromium.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 14 Feb 2020 09:01:00 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> The >= compare op must happen in cpu byte order, doing it in
> little endian fails on big endian machines like s390.
> 
> Reported-by: Sebastian Mitterle <smitterl@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index cfe9c54f87a3..67caecde623e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -222,7 +222,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>  		trace_virtio_gpu_cmd_response(vgdev->ctrlq.vq, resp);
>  
>  		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
> -			if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
> +			if (le32_to_cpu(resp->type) >= VIRTIO_GPU_RESP_ERR_UNSPEC) {
>  				struct virtio_gpu_ctrl_hdr *cmd;
>  				cmd = virtio_gpu_vbuf_ctrl_hdr(entry);
>  				DRM_ERROR_RATELIMITED("response 0x%x (command 0x%x)\n",

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Endianness continues to be fun.
