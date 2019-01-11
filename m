From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/virtio: drop prime import/export callbacks
Date: Sat, 12 Jan 2019 07:14:19 +1000
Message-ID: <CAPM=9txB+gB6Wy42V+5bPN6XvVbxbbSmmg1bkzbQWmCcVT5BiQ__2303.35211749679$1547693105$gmane$org@mail.gmail.com>
References: <20190110111545.26768-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190110111545.26768-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 10 Jan 2019 at 21:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> userspace.

Reviewed-by: Dave Airlie <airlied@redhat.com>
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  4 ----
>  drivers/gpu/drm/virtio/virtgpu_drv.c   |  4 ----
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 14 --------------
>  3 files changed, 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index cf896d8793..4f2f3c43a4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -354,10 +354,6 @@ int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
>  /* virtgpu_prime.c */
>  int virtgpu_gem_prime_pin(struct drm_gem_object *obj);
>  void virtgpu_gem_prime_unpin(struct drm_gem_object *obj);
> -struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
> -struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
> -       struct drm_device *dev, struct dma_buf_attachment *attach,
> -       struct sg_table *sgt);
>  void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj);
>  void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
>  int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index af92964b68..b996ac1d4f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -205,14 +205,10 @@ static struct drm_driver driver = {
>  #if defined(CONFIG_DEBUG_FS)
>         .debugfs_init = virtio_gpu_debugfs_init,
>  #endif
> -       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> -       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>         .gem_prime_export = drm_gem_prime_export,
>         .gem_prime_import = drm_gem_prime_import,
>         .gem_prime_pin = virtgpu_gem_prime_pin,
>         .gem_prime_unpin = virtgpu_gem_prime_unpin,
> -       .gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
> -       .gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
>         .gem_prime_vmap = virtgpu_gem_prime_vmap,
>         .gem_prime_vunmap = virtgpu_gem_prime_vunmap,
>         .gem_prime_mmap = virtgpu_gem_prime_mmap,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index 86ce0ae93f..c59ec34c80 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -39,20 +39,6 @@ void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
>         WARN_ONCE(1, "not implemented");
>  }
>
> -struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
> -{
> -       WARN_ONCE(1, "not implemented");
> -       return ERR_PTR(-ENODEV);
> -}
> -
> -struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
> -       struct drm_device *dev, struct dma_buf_attachment *attach,
> -       struct sg_table *table)
> -{
> -       WARN_ONCE(1, "not implemented");
> -       return ERR_PTR(-ENODEV);
> -}
> -
>  void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
>  {
>         struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
