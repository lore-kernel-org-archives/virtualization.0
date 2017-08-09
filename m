From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/virtio: make drm_fb_helper_funcs const
Date: Wed, 9 Aug 2017 18:40:10 +0200
Message-ID: <20170809164010.sff3ebprwpqv6axu@phenom.ffwll.local>
References: <1502205245-17365-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1502205245-17365-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, julia.lawall@lip6.fr
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 08, 2017 at 08:44:05PM +0530, Bhumika Goyal wrote:
> Make these structures const as they are only passed to the function
> drm_fb_helper_prepare and the corresponding argument is of type const.
> Done using Coccinelle
> 
> @match disable optional_qualifier@
> identifier s;
> @@
> static struct drm_fb_helper_funcs s = {...};
> 
> @ref@
> position p;
> identifier match.s;
> @@
> s@p
> 
> @good1@
> identifier match.s;
> expression e1,e2;
> position ref.p;
> @@
> drm_fb_helper_prepare(e1,e2,&s@p,...)
> 
> @bad depends on  !good1@
> position ref.p;
> identifier match.s;
> @@
> s@p
> 
> @depends on forall !bad disable optional_qualifier@
> identifier match.s;
> @@
> static
> + const
> struct drm_fb_helper_funcs s;
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

This and the previous one merged too.
-Daniel

> ---
>  drivers/gpu/drm/virtio/virtgpu_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
> index 046e28b..15d18fd 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_fb.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
> @@ -308,7 +308,7 @@ static int virtio_gpu_fbdev_destroy(struct drm_device *dev,
>  
>  	return 0;
>  }
> -static struct drm_fb_helper_funcs virtio_gpu_fb_helper_funcs = {
> +static const struct drm_fb_helper_funcs virtio_gpu_fb_helper_funcs = {
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
