From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 5/8] drm/virtio: track created object state
Date: Thu, 18 Oct 2018 11:25:22 +1000
Message-ID: <CAPM=9tzpzxv9TorRDWX3=sj_=EEqu3gyU2+AyWAFVHLPzZVcew@mail.gmail.com>
References: <20181001103222.11924-1-kraxel@redhat.com>
	<20181001103222.11924-6-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181001103222.11924-6-kraxel@redhat.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 1 Oct 2018 at 20:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Track whenever the virtio_gpu_object is already created (i.e. host knows
> about it) in a new variable.  Add checks to virtio_gpu_object_attach()
> to do nothing on objects not created yet.
>
> Make virtio_gpu_ttm_bo_destroy() use the new variable too, instead of
> expecting hw_res_handle indicating the object state.

Is there a potential patch ordering issue here? If this patch changes
the code to avoid using hw_res_handle,
is after patches that start filling in hw_res_handle in places we
haven't filled it in before.

Maybe this patch should happen earlier.

Dave.

>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 3 ++-
>  drivers/gpu/drm/virtio/virtgpu_fb.c     | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_gem.c    | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 3 ++-
>  drivers/gpu/drm/virtio/virtgpu_object.c | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 8 ++++++--
>  6 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 9b26e8ee84..4a39877ce6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -65,6 +65,7 @@ struct virtio_gpu_object {
>         struct ttm_placement            placement;
>         struct ttm_buffer_object        tbo;
>         struct ttm_bo_kmap_obj          kmap;
> +       bool created;
>  };
>  #define gem_to_virtio_gpu_obj(gobj) \
>         container_of((gobj), struct virtio_gpu_object, gem_base)
> @@ -263,7 +264,7 @@ void virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
>                                uint32_t *resid);
>  void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id);
>  void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
> -                                   uint32_t resource_id,
> +                                   struct virtio_gpu_object *bo,
>                                     uint32_t format,
>                                     uint32_t width,
>                                     uint32_t height);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
> index b16c62c4d8..c22a8246b6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fb.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
> @@ -232,7 +232,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
>                 return PTR_ERR(obj);
>
>         virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
> -       virtio_gpu_cmd_create_resource(vgdev, obj->hw_res_handle, format,
> +       virtio_gpu_cmd_create_resource(vgdev, obj, format,
>                                        mode_cmd.width, mode_cmd.height);
>
>         ret = virtio_gpu_object_kmap(obj);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
> index 5450f7ab5b..665d18a49d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -104,7 +104,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
>         format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
>         obj = gem_to_virtio_gpu_obj(gobj);
>         virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
> -       virtio_gpu_cmd_create_resource(vgdev, obj->hw_res_handle, format,
> +       virtio_gpu_cmd_create_resource(vgdev, obj, format,
>                                        args->width, args->height);
>
>         /* attach the object to the resource */
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 44c9160c14..f9c55ecfca 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -256,7 +256,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>         virtio_gpu_resource_id_get(vgdev, &qobj->hw_res_handle);
>
>         if (!vgdev->has_virgl_3d) {
> -               virtio_gpu_cmd_create_resource(vgdev, qobj->hw_res_handle, rc->format,
> +               virtio_gpu_cmd_create_resource(vgdev, qobj, rc->format,
>                                                rc->width, rc->height);
>
>                 ret = virtio_gpu_object_attach(vgdev, qobj, NULL);
> @@ -285,6 +285,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>                 rc_3d.flags = cpu_to_le32(rc->flags);
>
>                 virtio_gpu_cmd_resource_create_3d(vgdev, &rc_3d, NULL);
> +               qobj->created = true;
>                 ret = virtio_gpu_object_attach(vgdev, qobj, &fence);
>                 if (ret) {
>                         ttm_eu_backoff_reservation(&ticket, &validate_list);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index eca7655374..6611c487d7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -33,7 +33,7 @@ static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
>         bo = container_of(tbo, struct virtio_gpu_object, tbo);
>         vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
>
> -       if (bo->hw_res_handle)
> +       if (bo->created)
>                 virtio_gpu_cmd_unref_resource(vgdev, bo->hw_res_handle);
>         if (bo->pages)
>                 virtio_gpu_object_free_sg_table(bo);
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index dd4464ccb1..45da3c87b6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -388,7 +388,7 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>
>  /* create a basic resource */
>  void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
> -                                   uint32_t resource_id,
> +                                   struct virtio_gpu_object *bo,
>                                     uint32_t format,
>                                     uint32_t width,
>                                     uint32_t height)
> @@ -400,12 +400,13 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
>         memset(cmd_p, 0, sizeof(*cmd_p));
>
>         cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_CREATE_2D);
> -       cmd_p->resource_id = cpu_to_le32(resource_id);
> +       cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
>         cmd_p->format = cpu_to_le32(format);
>         cmd_p->width = cpu_to_le32(width);
>         cmd_p->height = cpu_to_le32(height);
>
>         virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
> +       bo->created = true;
>  }
>
>  void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
> @@ -868,6 +869,9 @@ int virtio_gpu_object_attach(struct virtio_gpu_device *vgdev,
>         struct scatterlist *sg;
>         int si, nents;
>
> +       if (!obj->created)
> +               return 0;
> +
>         if (!obj->pages) {
>                 int ret;
>
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
