From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v2] drm/virtio: make resource id workaround runtime
	switchable.
Date: Mon, 26 Aug 2019 15:06:07 -0700
Message-ID: <CAPaKu7Q+T1qf4jboXSV-jsXHrvqSxG+MrJGJzFf7qNisaZj3Wg__44154.0461777308$1566857188$gmane$org@mail.gmail.com>
References: <20190822102614.18164-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190822102614.18164-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 22, 2019 at 3:26 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Also update the comment with a reference to the virglrenderer fix.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 44 ++++++++++++++-----------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index b2da31310d24..e98aaa00578d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -27,34 +27,38 @@
>
>  #include "virtgpu_drv.h"
>
> +static int virtio_gpu_virglrenderer_workaround = 1;
> +module_param_named(virglhack, virtio_gpu_virglrenderer_workaround, int, 0400);
> +
>  static int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev,
>                                        uint32_t *resid)
>  {
> -#if 0
> -       int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
> -
> -       if (handle < 0)
> -               return handle;
> -#else
> -       static int handle;
> -
> -       /*
> -        * FIXME: dirty hack to avoid re-using IDs, virglrenderer
> -        * can't deal with that.  Needs fixing in virglrenderer, also
> -        * should figure a better way to handle that in the guest.
> -        */
> -       handle++;
> -#endif
> -
> -       *resid = handle + 1;
> +       if (virtio_gpu_virglrenderer_workaround) {
> +               /*
> +                * Hack to avoid re-using resource IDs.
> +                *
> +                * virglrenderer versions up to (and including) 0.7.0
> +                * can't deal with that.  virglrenderer commit
> +                * "f91a9dd35715 Fix unlinking resources from hash
> +                * table." (Feb 2019) fixes the bug.
> +                */
> +               static int handle;
> +               handle++;
> +               *resid = handle + 1;
> +       } else {
> +               int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
> +               if (handle < 0)
> +                       return handle;
> +               *resid = handle + 1;
> +       }
>         return 0;
>  }
>
>  static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
>  {
> -#if 0
> -       ida_free(&vgdev->resource_ida, id - 1);
> -#endif
> +       if (!virtio_gpu_virglrenderer_workaround) {
> +               ida_free(&vgdev->resource_ida, id - 1);
> +       }
>  }
>
>  static void virtio_gpu_ttm_bo_destroy(struct ttm_buffer_object *tbo)
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
