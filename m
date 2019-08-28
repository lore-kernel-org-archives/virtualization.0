From: Chia-I Wu <olvaffe@gmail.com>
Subject: Re: [PATCH v8 02/18] drm/virtio: switch virtio_gpu_wait_ioctl() to
	gem helper.
Date: Wed, 28 Aug 2019 14:13:44 -0700
Message-ID: <CAPaKu7Tbv+JgPLy4GLDU8qwx-X7mA0eFT-Sjxb4CaV5Zr4beXA__48491.1911234789$1567026865$gmane$org@mail.gmail.com>
References: <20190823095503.2261-1-kraxel@redhat.com>
	<20190823095503.2261-3-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190823095503.2261-3-kraxel@redhat.com>
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

On Fri, Aug 23, 2019 at 2:55 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
> This also makes the ioctl run lockless.
>
> v5: handle lookup failure.
> v2: use reservation_object_test_signaled_rcu for VIRTGPU_WAIT_NOWAIT.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 0a88ef11b9d3..74b6bad01d7f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -466,23 +466,20 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *file)
>  {
>         struct drm_virtgpu_3d_wait *args = data;
> -       struct drm_gem_object *gobj = NULL;
> -       struct virtio_gpu_object *qobj = NULL;
> +       struct drm_gem_object *obj;
> +       long timeout = 15 * HZ;
>         int ret;
> -       bool nowait = false;
>
> -       gobj = drm_gem_object_lookup(file, args->handle);
> -       if (gobj == NULL)
> -               return -ENOENT;
> +       if (args->flags & VIRTGPU_WAIT_NOWAIT) {
> +               obj = drm_gem_object_lookup(file, args->handle);
> +               if (obj == NULL)
> +                       return -ENOENT;
> +               ret = dma_resv_test_signaled_rcu(obj->resv, true);
> +               drm_gem_object_put_unlocked(obj);
> +               return ret ? 0 : -EBUSY;
> +       }
>
> -       qobj = gem_to_virtio_gpu_obj(gobj);
> -
> -       if (args->flags & VIRTGPU_WAIT_NOWAIT)
> -               nowait = true;
> -       ret = virtio_gpu_object_wait(qobj, nowait);
> -
> -       drm_gem_object_put_unlocked(gobj);
> -       return ret;
> +       return drm_gem_dma_resv_wait(file, args->handle, true, timeout);
This changes the return value from -EBUSY to -ETIME when the wait
times out.  I think we can use dma_resv_wait_timeout_rcu directly
here.



>  }
>
>  static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
> --
> 2.18.1
>
