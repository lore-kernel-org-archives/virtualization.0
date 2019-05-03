From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH] drm/virtio: Remove redundant return type
Date: Fri, 3 May 2019 09:40:58 -0700
Message-ID: <CAPaKu7SfkUN4FBQ5Xm3zfdvvbcvBAWDz0k2FVdn8TNZWwiV-tg__46352.6919180126$1556910046$gmane$org@mail.gmail.com>
References: <20190503163804.31922-1-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190503163804.31922-1-robert.foss@collabora.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 3, 2019 at 9:38 AM Robert Foss <robert.foss@collabora.com> wrote:
>
> virtio_gpu_fence_emit() always returns 0, since it
> has no error paths.
>
> Consequently no calls for virtio_gpu_fence_emit()
> use the return value, and it can be removed.
>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Suggested-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>
> This patch was suggested in this email thread:
>
> [PATCH] drm/virtio: allocate fences with GFP_KERNEL
> https://www.spinics.net/lists/dri-devel/msg208536.html
>
>  drivers/gpu/drm/virtio/virtgpu_drv.h   | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_fence.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index d577cb76f5ad..9bc56887fbdb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -334,7 +334,7 @@ int virtio_gpu_mmap(struct file *filp, struct vm_area_struct *vma);
>  /* virtio_gpu_fence.c */
>  struct virtio_gpu_fence *virtio_gpu_fence_alloc(
>         struct virtio_gpu_device *vgdev);
> -int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
> +void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>                           struct virtio_gpu_ctrl_hdr *cmd_hdr,
>                           struct virtio_gpu_fence *fence);
>  void virtio_gpu_fence_event_process(struct virtio_gpu_device *vdev,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fence.c b/drivers/gpu/drm/virtio/virtgpu_fence.c
> index 21bd4c4a32d1..e0744ac768cc 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fence.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fence.c
> @@ -81,7 +81,7 @@ struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev)
>         return fence;
>  }
>
> -int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
> +void virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>                           struct virtio_gpu_ctrl_hdr *cmd_hdr,
>                           struct virtio_gpu_fence *fence)
>  {
> @@ -96,7 +96,6 @@ int virtio_gpu_fence_emit(struct virtio_gpu_device *vgdev,
>
>         cmd_hdr->flags |= cpu_to_le32(VIRTIO_GPU_FLAG_FENCE);
>         cmd_hdr->fence_id = cpu_to_le64(fence->seq);
> -       return 0;
>  }
>
>  void virtio_gpu_fence_event_process(struct virtio_gpu_device *vgdev,
> --
> 2.20.1
>
