From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/cirrus: Replace ttm_bo_unref with ttm_bo_put
Date: Thu, 9 Aug 2018 17:29:02 +0200
Message-ID: <20180809152902.rotyb4necjid5lr3__26221.1677073084$1533828423$gmane$org@sirius.home.kraxel.org>
References: <20180731063128.11041-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180731063128.11041-1-tzimmermann@suse.de>
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

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/cirrus/cirrus_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/cirrus/cirrus_main.c b/drivers/gpu/drm/cirrus/cirrus_main.c
> index 60d54e10a34d..57f8fe6d020b 100644
> --- a/drivers/gpu/drm/cirrus/cirrus_main.c
> +++ b/drivers/gpu/drm/cirrus/cirrus_main.c
> @@ -269,7 +269,7 @@ static void cirrus_bo_unref(struct cirrus_bo **bo)
>  		return;
>  
>  	tbo = &((*bo)->bo);
> -	ttm_bo_unref(&tbo);
> +	ttm_bo_put(tbo);

Fails to build too.

cheers,
  Gerd
