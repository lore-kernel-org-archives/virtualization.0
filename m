From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 4/5] drm/virtio: add out-fences support for explicit
	synchronization
Date: Wed, 31 Oct 2018 09:39:31 +0000
Message-ID: <CACvgo52oG3uMPj2ASqPWvBYS7mUwm=nzKwMYSs8xZWq_OAL_2w__14811.9372818202$1540978741$gmane$org@mail.gmail.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-5-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181025183739.9375-5-robert.foss@collabora.com>
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
> On the out-fence side we get fence returned by the submitted draw call
> and attach it to a sync_file and send the sync_file fd to userspace. On
> error -1 is returned to userspace.
>
Can we have both an IN and OUT fence at the same time? Either way, please
mention that in the commit message.

> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 50 +++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 0368195966aa..32e714a1c753 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -106,7 +106,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         struct virtio_gpu_device *vgdev = dev->dev_private;
>         struct virtio_gpu_fpriv *vfpriv = drm_file->driver_priv;
>         struct drm_gem_object *gobj;
> -       struct virtio_gpu_fence *fence;
> +       struct virtio_gpu_fence *out_fence;
>         struct virtio_gpu_object *qobj;
>         int ret;
>         uint32_t *bo_handles = NULL;
> @@ -116,7 +116,9 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         int i;
>         struct ww_acquire_ctx ticket;
>         struct dma_fence *in_fence = NULL;
> +       struct sync_file *sync_file;
>         int in_fence_fd = exbuf->fence_fd;
> +       int out_fence_fd = -1;
>         void *buf;
>
>         exbuf->fence_fd = -1;
> @@ -143,6 +145,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>                 }
>         }
>
> +       if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
> +               out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
> +               if (out_fence_fd < 0) {
> +                       ret = out_fence_fd;
> +                       goto out_in_fence;
> +               }
> +       }
> +
If the answer to the above is "no" we want a check around here.

With that the patch is
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
