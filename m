From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH 7/8] drm/virtio: move virtio_gpu_object_{attach,
	detach} calls.
Date: Thu, 18 Oct 2018 11:41:52 +1000
Message-ID: <CAPM=9tx3vX_HLyGqvSitCTb=v5QN4tk4TjbwhreLhnT8BytHEg@mail.gmail.com>
References: <20181001103222.11924-1-kraxel@redhat.com>
	<20181001103222.11924-8-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181001103222.11924-8-kraxel@redhat.com>
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
> Remove the virtio_gpu_object_{attach,detach} calls from move_notify()
> callback.  Add them to the ttm_tt_{populate,unpopulate} callbacks, which
> is the correct place to handle this.
>
> The new ttm_tt_{populate,unpopulate} callbacks call the
> ttm_pool_populate()/unpopulate() functions (which are the default
> implementation in case the callbacks not present) for the actual ttm
> work.  Additionally virtio_gpu_object_{attach,detach} is called to
> update the state on the host.

This to me feels more like a bind/unbind operation rather than a
populate/unpopulate operation,

bind is " Bind the backend pages into the aperture in the location"

whereas populate is

allocate pages for a ttm.

Dave.

>
> With that in place the move and move_notify callbacks are not needed
> any more, so drop them.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ttm.c | 70 +++++++++++-------------------------
>  1 file changed, 21 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> index cd63dffa6d..96fb17e0fc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -250,33 +250,24 @@ static void virtio_gpu_ttm_io_mem_free(struct ttm_bo_device *bdev,
>   */
>  struct virtio_gpu_ttm_tt {
>         struct ttm_dma_tt               ttm;
> -       struct virtio_gpu_device        *vgdev;
> -       u64                             offset;
> +       struct virtio_gpu_object        *obj;
>  };
>
>  static int virtio_gpu_ttm_backend_bind(struct ttm_tt *ttm,
>                                        struct ttm_mem_reg *bo_mem)
>  {
> -       struct virtio_gpu_ttm_tt *gtt = (void *)ttm;
> -
> -       gtt->offset = (unsigned long)(bo_mem->start << PAGE_SHIFT);
> -       if (!ttm->num_pages)
> -               WARN(1, "nothing to bind %lu pages for mreg %p back %p!\n",
> -                    ttm->num_pages, bo_mem, ttm);
> -
> -       /* Not implemented */
>         return 0;
>  }
>
>  static int virtio_gpu_ttm_backend_unbind(struct ttm_tt *ttm)
>  {
> -       /* Not implemented */
>         return 0;
>  }
>
>  static void virtio_gpu_ttm_backend_destroy(struct ttm_tt *ttm)
>  {
> -       struct virtio_gpu_ttm_tt *gtt = (void *)ttm;
> +       struct virtio_gpu_ttm_tt *gtt =
> +               container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
>
>         ttm_dma_tt_fini(&gtt->ttm);
>         kfree(gtt);
> @@ -299,7 +290,7 @@ static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
>         if (gtt == NULL)
>                 return NULL;
>         gtt->ttm.ttm.func = &virtio_gpu_backend_func;
> -       gtt->vgdev = vgdev;
> +       gtt->obj = container_of(bo, struct virtio_gpu_object, tbo);
>         if (ttm_dma_tt_init(&gtt->ttm, bo, page_flags)) {
>                 kfree(gtt);
>                 return NULL;
> @@ -307,49 +298,30 @@ static struct ttm_tt *virtio_gpu_ttm_tt_create(struct ttm_buffer_object *bo,
>         return &gtt->ttm.ttm;
>  }
>
> -static void virtio_gpu_move_null(struct ttm_buffer_object *bo,
> -                                struct ttm_mem_reg *new_mem)
> -{
> -       struct ttm_mem_reg *old_mem = &bo->mem;
> -
> -       BUG_ON(old_mem->mm_node != NULL);
> -       *old_mem = *new_mem;
> -       new_mem->mm_node = NULL;
> -}
> -
> -static int virtio_gpu_bo_move(struct ttm_buffer_object *bo, bool evict,
> -                             struct ttm_operation_ctx *ctx,
> -                             struct ttm_mem_reg *new_mem)
> +static int virtio_gpu_ttm_tt_populate(struct ttm_tt *ttm, struct ttm_operation_ctx *ctx)
>  {
> +       struct virtio_gpu_ttm_tt *gtt =
> +               container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
> +       struct virtio_gpu_device *vgdev =
> +               (struct virtio_gpu_device *)gtt->obj->gem_base.dev->dev_private;
>         int ret;
>
> -       ret = ttm_bo_wait(bo, ctx->interruptible, ctx->no_wait_gpu);
> +       ret = ttm_pool_populate(ttm, ctx);
>         if (ret)
>                 return ret;
> -
> -       virtio_gpu_move_null(bo, new_mem);
> -       return 0;
> +       virtio_gpu_object_attach(vgdev, gtt->obj, NULL);
> +       return ret;
>  }
>
> -static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
> -                                     bool evict,
> -                                     struct ttm_mem_reg *new_mem)
> +static void virtio_gpu_ttm_tt_unpopulate(struct ttm_tt *ttm)
>  {
> -       struct virtio_gpu_object *bo;
> -       struct virtio_gpu_device *vgdev;
> +       struct virtio_gpu_ttm_tt *gtt =
> +               container_of(ttm, struct virtio_gpu_ttm_tt, ttm.ttm);
> +       struct virtio_gpu_device *vgdev =
> +               (struct virtio_gpu_device *)gtt->obj->gem_base.dev->dev_private;
>
> -       bo = container_of(tbo, struct virtio_gpu_object, tbo);
> -       vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
> -
> -       if (!new_mem || (new_mem->placement & TTM_PL_FLAG_SYSTEM)) {
> -               if (bo->hw_res_handle)
> -                       virtio_gpu_object_detach(vgdev, bo);
> -
> -       } else if (new_mem->placement & TTM_PL_FLAG_TT) {
> -               if (bo->hw_res_handle) {
> -                       virtio_gpu_object_attach(vgdev, bo, NULL);
> -               }
> -       }
> +       virtio_gpu_object_detach(vgdev, gtt->obj);
> +       ttm_pool_unpopulate(ttm);
>  }
>
>  static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
> @@ -366,15 +338,15 @@ static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
>
>  static struct ttm_bo_driver virtio_gpu_bo_driver = {
>         .ttm_tt_create = &virtio_gpu_ttm_tt_create,
> +       .ttm_tt_populate = &virtio_gpu_ttm_tt_populate,
> +       .ttm_tt_unpopulate = &virtio_gpu_ttm_tt_unpopulate,
>         .invalidate_caches = &virtio_gpu_invalidate_caches,
>         .init_mem_type = &virtio_gpu_init_mem_type,
>         .eviction_valuable = ttm_bo_eviction_valuable,
>         .evict_flags = &virtio_gpu_evict_flags,
> -       .move = &virtio_gpu_bo_move,
>         .verify_access = &virtio_gpu_verify_access,
>         .io_mem_reserve = &virtio_gpu_ttm_io_mem_reserve,
>         .io_mem_free = &virtio_gpu_ttm_io_mem_free,
> -       .move_notify = &virtio_gpu_bo_move_notify,
>         .swap_notify = &virtio_gpu_bo_swap_notify,
>  };
>
> --
> 2.9.3
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
