From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/virtgpu: fix double unregistration
Date: Tue, 12 Nov 2019 10:40:31 +0100
Message-ID: <20191112094031.GF23790__44981.2202876032$1573551646$gmane$org@phenom.ffwll.local>
References: <20191109075417.29808-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191109075417.29808-1-hslester96@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chuhong Yuan <hslester96@gmail.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Nov 09, 2019 at 03:54:17PM +0800, Chuhong Yuan wrote:
> drm_put_dev also calls drm_dev_unregister, so dev will be unregistered
> twice.
> Replace it with drm_dev_put to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Nice catch, I'll apply.

Since this is so confusing, we actually have a todo to remove drm_put_dev
completely from the codebase (and open-code it with explicit
unregister+put). Want to do that little patch series to update the
remaining few drivers and then remove drm_put_dev from core code?

Thanks, Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 0fc32fa0b3c0..fccc24e21af8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -138,7 +138,7 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
>  
>  	drm_dev_unregister(dev);
>  	virtio_gpu_deinit(dev);
> -	drm_put_dev(dev);
> +	drm_dev_put(dev);
>  }
>  
>  static void virtio_gpu_config_changed(struct virtio_device *vdev)
> -- 
> 2.23.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
