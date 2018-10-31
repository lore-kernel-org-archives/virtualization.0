From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 1/5] drm/virtio: add virtio_gpu_alloc_fence()
Date: Wed, 31 Oct 2018 09:38:31 +0000
Message-ID: <CACvgo516JGdfBZ8zM73bQ-TCeNEbOp9ioBy9jh0AAtpUsu5tOg__40546.9969301068$1540978670$gmane$org@mail.gmail.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-2-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181025183739.9375-2-robert.foss@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Robert Foss <robert.foss@collabora.com>
Cc: Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Gustavo Padovan <gustavo.padovan@collabora.com>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Rob,

On Thu, 25 Oct 2018 at 19:38, Robert Foss <robert.foss@collabora.com> wrote:
>
> From: Gustavo Padovan <gustavo.padovan@collabora.com>
>
> Refactor fence creation to remove the potential allocation failure from
> the cmd_submit and atomic_commit paths. Now the fence should be allocated
> first and just after we should proceed with the rest of the execution.
>

Commit does a bit more that what the above says:
 - dummy, factor out fence creation/destruction
 - use per virtio_gpu_framebuffer fence

Personally I'd keep the two separate patches and elaborate on the latter.
Obviously in that case, one will need to add 3 lines worth of
virtio_gpu_fence_alloc() in virtio_gpu_cursor_plane_update which will be nuked
with the next patch.

Not a big deal, but it's up-to the maintainer to make the final call if it's
worth splitting or not.

Couple of minor nitpicks below.

>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct virtio_gpu_output *output = NULL;
>         struct virtio_gpu_framebuffer *vgfb;
> -       struct virtio_gpu_fence *fence = NULL;
>         struct virtio_gpu_object *bo = NULL;
>         uint32_t handle;
>         int ret = 0;

Add the virtio_gpu_fence_alloc()? And yes it will be nuked with patch 2/...



> +struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
> +{
> +       struct virtio_gpu_fence_driver *drv = &vgdev->fence_drv;
> +       struct virtio_gpu_fence *fence = kzalloc(sizeof(struct virtio_gpu_fence), GFP_ATOMIC);
> +       if (!fence)
> +               return fence;
> +
> +       fence->drv = drv;
> +       dma_fence_init(&fence->f, &virtio_fence_ops, &drv->lock, drv->context, 0);
Oh no, lines over 80 col... while the original code is pretty and neat.

> +
> +       return fence;
> +}
> +
> +void virtio_gpu_fence_cleanup(struct virtio_gpu_fence *fence)
> +{
> +       if (!fence)
> +               return;
> +
> +       if (fence->drv)
> +               dma_fence_put(&fence->f);
> +       else
> +               kfree(fence);
I'm not sure if/how we reach the else case here?

> +}
> +
>  int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>                           struct virtio_gpu_ctrl_hdr *cmd_hdr,
> -                         struct virtio_gpu_fence **fence)
> +                         struct virtio_gpu_fence *fence)
>  {

With a follow-up commit, we can drop the no longer needed return type.
Which it turns out was never checked ...



> @@ -319,6 +332,8 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
>                 dma_fence_put(&fence->f);
>         }
>         return 0;
> +fail_fence:

The error labels seems to be called after what they do, not what
fails. fail_backoff seems better IMHO.

> +ttm_eu_backoff_reservation(&ticket, &validate_list);
Indentation seems off (or my client ate it)?


HTH
Emil
