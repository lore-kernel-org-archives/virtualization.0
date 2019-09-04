From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH] drm/virtio: fix command submission with objects but
	without fence.
Date: Wed, 4 Sep 2019 16:10:30 -0700
Message-ID: <CAPaKu7RWiEr5n_DWcg0H2PPnRs9CUn-ZgQV3NYe8VrdZgEAhTQ__31187.6211942703$1567638682$gmane$org@mail.gmail.com>
References: <20190904074828.32502-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190904074828.32502-1-kraxel@redhat.com>
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

On Wed, Sep 4, 2019 at 12:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Only call virtio_gpu_array_add_fence if we actually have a fence.
>
> Fixes: da758d51968a ("drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 595fa6ec2d58..7fd2851f7b97 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -339,11 +339,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>                 goto again;
>         }
>
> -       if (fence)
> +       if (fence) {
>                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> -       if (vbuf->objs) {
> -               virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> -               virtio_gpu_array_unlock_resv(vbuf->objs);
> +               if (vbuf->objs) {
> +                       virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> +                       virtio_gpu_array_unlock_resv(vbuf->objs);
> +               }
This leaks when fence == NULL and vbuf->objs != NULL (which can really
happen IIRC... not at my desk to check).


>         }
>         notify = virtio_gpu_queue_ctrl_buffer_locked(vgdev, vbuf);
>         spin_unlock(&vgdev->ctrlq.qlock);
> --
> 2.18.1
>
