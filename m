From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v3 3/4] drm/virtio: batch resource creation
Date: Thu, 13 Feb 2020 10:54:21 -0800
Message-ID: <CAPaKu7TgvBtgPuJaeesCUP4zxDOO=xxtun48P=bT0VBF4-dNFg@mail.gmail.com>
References: <20200213132203.23441-1-kraxel@redhat.com> <20200213132203.23441-4-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200213132203.23441-4-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 13, 2020 at 5:22 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Move virtio_gpu_notify() to higher-level functions for
> virtio_gpu_cmd_create_resource(), virtio_gpu_cmd_resource_create_3d()
> and virtio_gpu_cmd_resource_attach_backing().
>
> virtio_gpu_object_create() will batch commands and notify only once when
> creating a resource.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 8870ee23ff2b..65d6834d3c74 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -224,6 +224,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
>                 return ret;
The virtqueue might become full without ever being notified on errors.
We should notify on errors, or better yet, virtio_gpu_queue_ctrl_sgs
should notify before waiting.


>         }
>
> +       virtio_gpu_notify(vgdev);
>         *bo_ptr = bo;
>         return 0;
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 9d4ca0fafa5f..778b7acf2f7f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -514,7 +514,6 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>         cmd_p->height = cpu_to_le32(params->height);
>
>         virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
> -       virtio_gpu_notify(vgdev);
>         bo->created = true;
>  }
>
> @@ -643,7 +642,6 @@ virtio_gpu_cmd_resource_attach_backing(struct virtio_gpu_device *vgdev,
>         vbuf->data_size = sizeof(*ents) * nents;
>
>         virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
> -       virtio_gpu_notify(vgdev);
>  }
>
>  static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
> @@ -1010,7 +1008,6 @@ virtio_gpu_cmd_resource_create_3d(struct virtio_gpu_device *vgdev,
>         cmd_p->flags = cpu_to_le32(params->flags);
>
>         virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
> -       virtio_gpu_notify(vgdev);
>
>         bo->created = true;
>  }
> --
> 2.18.2
>
