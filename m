From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/4] drm/virtio: switch virtio_gpu_wait_ioctl() to gem
	helper.
Date: Mon, 17 Jun 2019 16:15:16 +0200
Message-ID: <20190617141516.GF12905__736.200616096028$1560780934$gmane$org@phenom.ffwll.local>
References: <20190617111406.14765-1-kraxel@redhat.com>
	<20190617111406.14765-3-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190617111406.14765-3-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 17, 2019 at 01:14:04PM +0200, Gerd Hoffmann wrote:
> Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().

Would be good to mention here that with this the wait becomes lockless, we
don't call ttm_bo_reserve/unreserve anymore.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index c0ba1ead740f..e38a6bb46cc7 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -464,23 +464,13 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
>  			    struct drm_file *file)
>  {
>  	struct drm_virtgpu_3d_wait *args = data;
> -	struct drm_gem_object *gobj = NULL;
> -	struct virtio_gpu_object *qobj = NULL;
> -	int ret;
> -	bool nowait = false;
> -
> -	gobj = drm_gem_object_lookup(file, args->handle);
> -	if (gobj == NULL)
> -		return -ENOENT;
> -
> -	qobj = gem_to_virtio_gpu_obj(gobj);
> +	long timeout = 15 * HZ;
>  
>  	if (args->flags & VIRTGPU_WAIT_NOWAIT)
> -		nowait = true;
> -	ret = virtio_gpu_object_wait(qobj, nowait);
> +		timeout = 0;

timeout of 0 gets upgrade to a 1 jiffy wait, which is probably not what
you want here. You need to open-code ttm_bo_wait here and call
reservation_object_test_signaled_rcu() for this case.

With that fixed Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  
> -	drm_gem_object_put_unlocked(gobj);
> -	return ret;
> +	return drm_gem_reservation_object_wait(file, args->handle,
> +					       true, timeout);
>  }
>  
>  static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
