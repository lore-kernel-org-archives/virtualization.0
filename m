From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm: virtio: constify drm_fb_helper_funcs
Date: Tue, 22 Aug 2017 08:35:07 +0200
Message-ID: <20170822063507.2rof6p66h57qezkv__32326.1543446735$1503383720$gmane$org@phenom.ffwll.local>
References: <60db0ba6ddce08444299533e97c9adec3b3ef1bb.1503311145.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <60db0ba6ddce08444299533e97c9adec3b3ef1bb.1503311145.git.arvind.yadav.cs@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, daniel.vetter@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 21, 2017 at 04:37:32PM +0530, Arvind Yadav wrote:
> drm_fb_helper_funcs are not supposed to change at runtime.
> All functions working with drm_fb_helper_funcs provided
> by <drm/drm_fb_helper.h> work with const drm_fb_helper_funcs.
> So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
> index 33df067..61f33ec 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fb.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
> @@ -309,7 +309,7 @@ static int virtio_gpu_fbdev_destroy(struct drm_device *dev,
>  
>  	return 0;
>  }
> -static struct drm_fb_helper_funcs virtio_gpu_fb_helper_funcs = {
> +static const struct drm_fb_helper_funcs virtio_gpu_fb_helper_funcs = {

I have this patch already from someone else. Please create your patches
against linux-next to avoid this kind of duplicated work.

Thanks, Daniel
>  	.fb_probe = virtio_gpufb_create,
>  };
>  
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
