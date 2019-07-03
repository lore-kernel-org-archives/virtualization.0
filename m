From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v6 06/18] drm/virtio: remove ttm calls from in
	virtio_gpu_object_{reserve, unreserve}
Date: Wed, 3 Jul 2019 11:02:33 -0700
Message-ID: <CAPaKu7RfLoB=K__wQd92=S20Mt0uqsfyU9oigr8CQ-=gH6OUuA@mail.gmail.com>
References: <20190702141903.1131-1-kraxel@redhat.com>
	<20190702141903.1131-7-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190702141903.1131-7-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 2, 2019 at 7:19 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Call reservation_object_* directly instead
> of using ttm_bo_{reserve,unreserve}.
>
> v4: check for EINTR only.
> v3: check for EINTR too.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 06cc0e961df6..07f6001ea91e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -402,9 +402,9 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>  {
>         int r;
>
> -       r = ttm_bo_reserve(&bo->tbo, true, false, NULL);
> +       r = reservation_object_lock_interruptible(bo->gem_base.resv, NULL);
Can you elaborate a bit about how TTM keeps the BOs alive in, for
example, virtio_gpu_transfer_from_host_ioctl?  In that function, only
three TTM functions are called: ttm_bo_reserve, ttm_bo_validate, and
ttm_bo_unreserve.  I am curious how they keep the BO alive.

>         if (unlikely(r != 0)) {
> -               if (r != -ERESTARTSYS) {
> +               if (r != -EINTR) {
>                         struct virtio_gpu_device *qdev =
>                                 bo->gem_base.dev->dev_private;
>                         dev_err(qdev->dev, "%p reserve failed\n", bo);
> @@ -416,7 +416,7 @@ static inline int virtio_gpu_object_reserve(struct virtio_gpu_object *bo)
>
>  static inline void virtio_gpu_object_unreserve(struct virtio_gpu_object *bo)
>  {
> -       ttm_bo_unreserve(&bo->tbo);
> +       reservation_object_unlock(bo->gem_base.resv);
>  }
>
>  /* virgl debufs */
> --
> 2.18.1
>
