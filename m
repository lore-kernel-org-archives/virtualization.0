From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bochs: deinit bugfix
Date: Fri, 7 Feb 2020 14:45:36 +0100
Message-ID: <20200207134536.GC43062@phenom.ffwll.local>
References: <20200207124348.21641-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200207124348.21641-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 07, 2020 at 01:43:48PM +0100, Gerd Hoffmann wrote:
> Check whenever mode_config was actually properly
> initialized before trying to clean it up.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Really need to get managed drm cleanup going ...
-Daniel
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index cc93ff74fbd8..3a755c911342 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -164,6 +164,9 @@ int bochs_kms_init(struct bochs_device *bochs)
>  
>  void bochs_kms_fini(struct bochs_device *bochs)
>  {
> +	if (!bochs->dev->mode_config.num_connector)
> +		return;
> +
>  	drm_atomic_helper_shutdown(bochs->dev);
>  	drm_mode_config_cleanup(bochs->dev);
>  }
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
