From: Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH 2/5] drm/virtio: add uapi for in and out explicit fences
Date: Wed, 31 Oct 2018 09:38:43 +0000
Message-ID: <CACvgo51LU3dAfO-jNcV02ZyYBOv8fKLhG_2QyRrB9XYfGJrzHQ__27366.1280320541$1540978702$gmane$org@mail.gmail.com>
References: <20181025183739.9375-1-robert.foss@collabora.com>
	<20181025183739.9375-3-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181025183739.9375-3-robert.foss@collabora.com>
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
> Add a new field called fence_fd that will be used by userspace to send
> in-fences to the kernel and receive out-fences created by the kernel.
>
> This uapi enables virtio to take advantage of explicit synchronization of
> dma-bufs.
>
> There are two new flags:
>
> * VIRTGPU_EXECBUF_FENCE_FD_IN to be used when passing an in-fence fd.
> * VIRTGPU_EXECBUF_FENCE_FD_OUT to be used when requesting an out-fence fd
>
> The execbuffer IOCTL is now read-write to allow the userspace to read the
> out-fence.
>
> On error -1 should be returned in the fence_fd field.
>
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> ---
> Changes since v2:
>  - Since exbuf-flags is a new flag, check that unsupported
>    flags aren't set.
>
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  5 +++++
>  include/uapi/drm/virtgpu_drm.h         | 13 ++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index d01a9ed100d1..1af289b28fc4 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -116,9 +116,14 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
>         struct ww_acquire_ctx ticket;
>         void *buf;
>
> +       exbuf->fence_fd = -1;
> +
Move this after the sanity checking.

>         if (vgdev->has_virgl_3d == false)
>                 return -ENOSYS;
>
> +       if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
> +               return -EINVAL;
> +
I assume this did this trigger when using old userspace?

With those the patch is
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Thanks
Emil
