From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/qxl: Replace ttm_bo_unref with ttm_bo_put
Date: Thu, 9 Aug 2018 17:30:51 +0200
Message-ID: <20180809153051.vj3kqtey7qhe3mqz__32414.0745135539$1533828530$gmane$org@sirius.home.kraxel.org>
References: <20180731063559.11629-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180731063559.11629-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
> index f5c1e7872e92..89606c819d82 100644
> --- a/drivers/gpu/drm/qxl/qxl_gem.c
> +++ b/drivers/gpu/drm/qxl/qxl_gem.c
> @@ -40,7 +40,7 @@ void qxl_gem_object_free(struct drm_gem_object *gobj)
>  	qxl_surface_evict(qdev, qobj, false);
>  
>  	tbo = &qobj->tbo;
> -	ttm_bo_unref(&tbo);
> +	ttm_bo_put(tbo);

Same here (using drm-misc-next btw).

cheers,
  Gerd
