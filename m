From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/virtio: fix mode_valid's return type
Date: Wed, 25 Apr 2018 09:40:02 +0200
Message-ID: <20180425074002.GP25142__30147.8491900072$1524641896$gmane$org@phenom.ffwll.local>
References: <20180424131524.2510-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180424131524.2510-1-luc.vanoostenryck@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 24, 2018 at 03:15:24PM +0200, Luc Van Oostenryck wrote:
> The method struct drm_connector_helper_funcs::mode_valid is defined
> as returning an 'enum drm_mode_status' but the driver implementation
> for this method uses an 'int' for it.
> 
> Fix this by using 'enum drm_mode_status' in the driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Ok, applied all the others that have been stuck in moderation or
something, except for any patch touching nouveau/radeon/amdgpu. Those need
ot go in through other trees.

All merged into drm-misc-next.

Thanks, Daniel
> ---
>  drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
> index 8cc8c34d6..a5edd8660 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
> @@ -208,7 +208,7 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
>  	return count;
>  }
>  
> -static int virtio_gpu_conn_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status virtio_gpu_conn_mode_valid(struct drm_connector *connector,
>  				      struct drm_display_mode *mode)
>  {
>  	struct virtio_gpu_output *output =
> -- 
> 2.17.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
