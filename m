From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH 2/4] drm/virtio: resource teardown tweaks
Date: Wed, 5 Feb 2020 11:02:19 -0800
Message-ID: <CAPaKu7SCk_3yeTtzFTTU_y-tyo8EDS7vR8i+mk829=0D-UjLQA@mail.gmail.com>
References: <20200205105955.28143-1-kraxel@redhat.com> <20200205105955.28143-3-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200205105955.28143-3-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 5, 2020 at 3:00 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Add new virtio_gpu_cleanup_object() helper function for object cleanup.
> Wire up callback function for resource unref, do cleanup from callback
> when we know the host stopped using the resource.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    |  3 ++-
>  drivers/gpu/drm/virtio/virtgpu_object.c | 19 ++++++++++----
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 35 ++++++++++++++++++++++---
>  3 files changed, 48 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 7e69c06e168e..372dd248cf02 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -262,7 +262,7 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>                                     struct virtio_gpu_object_array *objs,
>                                     struct virtio_gpu_fence *fence);
>  void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
> -                                  uint32_t resource_id);
> +                                  struct virtio_gpu_object *bo);
>  void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>                                         uint64_t offset,
>                                         uint32_t width, uint32_t height,
> @@ -355,6 +355,7 @@ void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
>                                     u64 last_seq);
>
>  /* virtio_gpu_object */
> +void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo);
>  struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
>                                                 size_t size);
>  int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 017a9e0fc3bb..28a161af7503 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -61,6 +61,14 @@ static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t
>         }
>  }
>
> +void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
> +{
> +       struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
> +
> +       virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
> +       drm_gem_shmem_free_object(&bo->base.base);
> +}
> +
>  static void virtio_gpu_free_object(struct drm_gem_object *obj)
>  {
>         struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> @@ -68,11 +76,12 @@ static void virtio_gpu_free_object(struct drm_gem_object *obj)
>
>         if (bo->pages)
>                 virtio_gpu_object_detach(vgdev, bo);
> -       if (bo->created)
> -               virtio_gpu_cmd_unref_resource(vgdev, bo->hw_res_handle);
> -       virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
> -
> -       drm_gem_shmem_free_object(obj);
> +       if (bo->created) {
> +               virtio_gpu_cmd_unref_resource(vgdev, bo);
> +               /* completion handler calls virtio_gpu_cleanup_object() */
nitpick: we don't need this comment when virtio_gpu_cmd_unref_cb is
defined by this file and passed to virtio_gpu_cmd_unref_resource.

I happen to be looking at our error handling paths.  I think we want
virtio_gpu_queue_fenced_ctrl_buffer to call vbuf->resp_cb on errors.


> +               return;
> +       }
> +       virtio_gpu_cleanup_object(bo);
>  }
>
>  static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 6d6d55dc384e..6e8097e4c214 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -152,6 +152,15 @@ static void *virtio_gpu_alloc_cmd(struct virtio_gpu_device *vgdev,
>                                          sizeof(struct virtio_gpu_ctrl_hdr), NULL);
>  }
>
> +static void *virtio_gpu_alloc_cmd_cb(struct virtio_gpu_device *vgdev,
> +                                    struct virtio_gpu_vbuffer **vbuffer_p,
> +                                    int size,
> +                                    virtio_gpu_resp_cb cb)
> +{
> +       return virtio_gpu_alloc_cmd_resp(vgdev, cb, vbuffer_p, size,
> +                                        sizeof(struct virtio_gpu_ctrl_hdr), NULL);
> +}
> +
>  static void free_vbuf(struct virtio_gpu_device *vgdev,
>                       struct virtio_gpu_vbuffer *vbuf)
>  {
> @@ -494,17 +503,37 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>         bo->created = true;
>  }
>
> +static void virtio_gpu_cmd_unref_cb(struct virtio_gpu_device *vgdev,
> +                                   struct virtio_gpu_vbuffer *vbuf)
> +{
> +       struct virtio_gpu_object *bo;
> +
> +       bo = gem_to_virtio_gpu_obj(vbuf->objs->objs[0]);
> +       kfree(vbuf->objs);
> +       vbuf->objs = NULL;
> +
> +       virtio_gpu_cleanup_object(bo);
> +}
> +
>  void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
> -                                  uint32_t resource_id)
> +                                  struct virtio_gpu_object *bo)
>  {
>         struct virtio_gpu_resource_unref *cmd_p;
>         struct virtio_gpu_vbuffer *vbuf;
>
> -       cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
> +       cmd_p = virtio_gpu_alloc_cmd_cb(vgdev, &vbuf, sizeof(*cmd_p),
> +                                       virtio_gpu_cmd_unref_cb);
>         memset(cmd_p, 0, sizeof(*cmd_p));
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_UNREF);
> -       cmd_p->resource_id = cpu_to_le32(resource_id);
> +       cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
> +
> +       /*
> +        * We are in the release callback and do NOT want refcount
> +        * bo, so do NOT use virtio_gpu_array_add_obj().
> +        */
> +       vbuf->objs = virtio_gpu_array_alloc(1);
> +       vbuf->objs->objs[0] = &bo->base.base
This is an abuse of obj array.  Add "void *private_data;" to
virtio_gpu_vbuffer and use that maybe?

Otherwise, simply

  // abuse objs field to pass our private data; must reset in the resp_cb
  vbuf->objs = (virtio_gpu_object_array *) bo;

makes it easier to see what is going on.


>
>         virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
>  }
> --
> 2.18.1
>
