From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Date: Wed, 9 Jan 2019 11:10:44 +0100
Message-ID: <20190109101044.GS21184__39019.2025145099$1547028527$gmane$org@phenom.ffwll.local>
References: <20190108112519.27473-1-kraxel@redhat.com>
	<20190108112519.27473-16-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190108112519.27473-16-kraxel@redhat.com>
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
Cc: andr2000@gmail.com, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 08, 2019 at 12:25:19PM +0100, Gerd Hoffmann wrote:
> The buffer object must be reserved before calling
> ttm_bo_validate for pinning/unpinning.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Seems a bit a bisect fumble in your series here: legacy kms code reserved
the ttm bo before calling boch_bo_pin/unpin, your atomic code doesn't. I
think pushing this into bochs_bo_pin/unpin makes sense for atomic, but to
avoid bisect fail I think you need to have these temporarily in your
cleanup/prepare_plane functions too.

Looked through the entire series, this here is the only issue I think
should be fixed before merging (making atomic_enable optional can be done
as a follow-up if you feel like it). With that addressed on the series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/bochs/bochs_mm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
> index cfe061c25f..970a591908 100644
> --- a/drivers/gpu/drm/bochs/bochs_mm.c
> +++ b/drivers/gpu/drm/bochs/bochs_mm.c
> @@ -223,7 +223,11 @@ int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
>  	bochs_ttm_placement(bo, pl_flag);
>  	for (i = 0; i < bo->placement.num_placement; i++)
>  		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
> +	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
> +	if (ret)
> +		return ret;
>  	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
> +	ttm_bo_unreserve(&bo->bo);
>  	if (ret)
>  		return ret;
>  
> @@ -247,7 +251,11 @@ int bochs_bo_unpin(struct bochs_bo *bo)
>  
>  	for (i = 0; i < bo->placement.num_placement; i++)
>  		bo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
> +	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
> +	if (ret)
> +		return ret;
>  	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
> +	ttm_bo_unreserve(&bo->bo);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
