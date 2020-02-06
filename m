From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH] drm/virtio: fix ring free check
Date: Thu, 6 Feb 2020 10:27:56 -0800
Message-ID: <CAPaKu7Tfp-thov9xCe-Gbq1zZe_uvDAno8SV_3tc=tU0gse=uA@mail.gmail.com>
References: <20200206111416.31269-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206111416.31269-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: ML dri-devel <dri-devel@lists.freedesktop.org>, Gurchetan Singh <gurchetansingh@chromium.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 6, 2020 at 3:14 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> If the virtio device supports indirect ring descriptors we need only one
> ring entry for the whole command.  Take that into account when checking
> whenever the virtqueue has enough free entries for our command.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 41e475fbd67b..a2ec09dba530 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -328,7 +328,8 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>  {
>         struct virtqueue *vq = vgdev->ctrlq.vq;
>         bool notify = false;
> -       int ret;
> +       bool indirect;
> +       int vqcnt, ret;
>
>  again:
>         spin_lock(&vgdev->ctrlq.qlock);
> @@ -341,9 +342,11 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>                 return;
>         }
>
> -       if (vq->num_free < elemcnt) {
> +       indirect = virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC);
> +       vqcnt = indirect ? 1 : elemcnt;
Is the feature dynamic and require the lock held?  If not, the result
can be cached and the fixup can happen before grabbing the lock

  if (vgdev->has_indirect_desc)
    elemcnt = 1;

Either way, patch is

  Reviewed-by: Chia-I Wu <olvaffe@gmail.com>


> +       if (vq->num_free < vqcnt) {
>                 spin_unlock(&vgdev->ctrlq.qlock);
> -               wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
> +               wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= vqcnt);
>                 goto again;
>         }
>
> --
> 2.18.1
>
