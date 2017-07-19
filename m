From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/4] drm/qxl: Drop fbdev hwaccel flags
Date: Wed, 19 Jul 2017 09:39:10 +0200
Message-ID: <20170719073910.kkhcrfmzz7c2jpzo__27794.1667162397$1500449961$gmane$org@phenom.ffwll.local>
References: <20170706125735.28299-1-daniel.vetter@ffwll.ch>
	<20170706125735.28299-4-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170706125735.28299-4-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: linux-fbdev@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 06, 2017 at 02:57:34PM +0200, Daniel Vetter wrote:
> It's not accelarated, just system memory. Note we don't even need to
> set the default flag since that's now always 0.
> 
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Merged with Dave's irc-ack + commit message amended that qxl once had
accel, but that was removed in 2015.
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_fb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
> index 573e7e9a5f98..69e7359b562a 100644
> --- a/drivers/gpu/drm/qxl/qxl_fb.c
> +++ b/drivers/gpu/drm/qxl/qxl_fb.c
> @@ -275,7 +275,7 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
>  
>  	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
>  
> -	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
> +	info->flags = FBINFO_DEFAULT;
>  	info->fbops = &qxlfb_ops;
>  
>  	/*
> -- 
> 2.13.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
