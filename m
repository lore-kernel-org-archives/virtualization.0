From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH 2/2] drm/virtio: notify virtqueues without holding spinlock
Date: Tue, 27 Aug 2019 09:45:27 -0700
Message-ID: <CAPaKu7T2AA83wLchMDmLEEb-VgvdfCP3_Dz8drrH9hptgXPn9g__28067.3913237237$1566924351$gmane$org@mail.gmail.com>
References: <20190813082509.29324-1-kraxel@redhat.com>
	<20190813082509.29324-3-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190813082509.29324-3-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 13, 2019 at 1:25 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Split virtqueue_kick() call into virtqueue_kick_prepare(), which
> requires serialization, and virtqueue_notify(), which does not.  Move
> the virtqueue_notify() call out of the critical section protected by the
> queue lock.  This avoids triggering a vmexit while holding the lock and
> thereby fixes a rather bad spinlock contention.
>
> Suggested-by: Chia-I Wu <olvaffe@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Series is

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index ca91e83ffaef..e41c96143342 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -252,7 +252,7 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
>         wake_up(&vgdev->cursorq.ack_queue);
>  }
>
> -static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
> +static bool virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>                                                 struct virtio_gpu_vbuffer *vbuf)
>                 __releases(&vgdev->ctrlq.qlock)
>                 __acquires(&vgdev->ctrlq.qlock)
> @@ -260,10 +260,11 @@ static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>         struct virtqueue *vq = vgdev->ctrlq.vq;
>         struct scatterlist *sgs[3], vcmd, vout, vresp;
>         int outcnt = 0, incnt = 0;
> +       bool notify = false;
>         int ret;
>
>         if (!vgdev->vqs_ready)
> -               return;
> +               return notify;
>
>         sg_init_one(&vcmd, vbuf->buf, vbuf->size);
>         sgs[outcnt + incnt] = &vcmd;
> @@ -292,16 +293,21 @@ static void virtio_gpu_queue_ctrl_buffer_locked(struct virtio_gpu_device *vgdev,
>                 trace_virtio_gpu_cmd_queue(vq,
>                         (struct virtio_gpu_ctrl_hdr *)vbuf->buf);
>
> -               virtqueue_kick(vq);
> +               notify = virtqueue_kick_prepare(vq);
>         }
> +       return notify;
>  }
>
>  static void virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
>                                          struct virtio_gpu_vbuffer *vbuf)
>  {
> +       bool notify;
> +
>         spin_lock(&vgdev->ctrlq.qlock);
> -       virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
> +       notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
>         spin_unlock(&vgdev->ctrlq.qlock);
> +       if (notify)
> +               virtqueue_notify(vgdev->ctrlq.vq);
>  }
>
>  static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
> @@ -310,6 +316,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>                                                 struct virtio_gpu_fence *fence)
>  {
>         struct virtqueue *vq = vgdev->ctrlq.vq;
> +       bool notify;
>
>  again:
>         spin_lock(&vgdev->ctrlq.qlock);
> @@ -330,8 +337,10 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>
>         if (fence)
>                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> -       virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
> +       notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
>         spin_unlock(&vgdev->ctrlq.qlock);
> +       if (notify)
> +               virtqueue_notify(vgdev->ctrlq.vq);
>  }
>
>  static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
> @@ -339,6 +348,7 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>  {
>         struct virtqueue *vq = vgdev->cursorq.vq;
>         struct scatterlist *sgs[1], ccmd;
> +       bool notify;
>         int ret;
>         int outcnt;
>
> @@ -361,10 +371,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
>                 trace_virtio_gpu_cmd_queue(vq,
>                         (struct virtio_gpu_ctrl_hdr *)vbuf->buf);
>
> -               virtqueue_kick(vq);
> +               notify = virtqueue_kick_prepare(vq);
>         }
>
>         spin_unlock(&vgdev->cursorq.qlock);
> +
> +       if (notify)
> +               virtqueue_notify(vq);
>  }
>
>  /* just create gem objects for userspace and long lived objects,
> --
> 2.18.1
>
