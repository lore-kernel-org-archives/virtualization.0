From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH] drm/virtio: ratelimit error logging
Date: Wed, 5 Feb 2020 12:20:12 -0800
Message-ID: <CAPaKu7SyqZU=ov4Atbedie6AGC52he0QQJZnGqr545mG-U7vvg@mail.gmail.com>
References: <20200205102552.21409-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200205102552.21409-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 5, 2020 at 2:26 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Avoid flooding the log in case we screw up badly.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 5914e79d3429..83f22933c3bb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -212,9 +212,9 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>                         if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
>                                 struct virtio_gpu_ctrl_hdr *cmd;
>                                 cmd = (struct virtio_gpu_ctrl_hdr *)entry->buf;
> -                               DRM_ERROR("response 0x%x (command 0x%x)\n",
> -                                         le32_to_cpu(resp->type),
> -                                         le32_to_cpu(cmd->type));
> +                               DRM_ERROR_RATELIMITED("response 0x%x (command 0x%x)\n",
> +                                                     le32_to_cpu(resp->type),
> +                                                     le32_to_cpu(cmd->type));
>                         } else
>                                 DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
>                 }
> --
> 2.18.1
>
