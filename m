From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/3] drm/bochs: add missing drm_atomic_helper_shutdown()
	call.
Date: Tue, 2 Apr 2019 09:54:02 +0200
Message-ID: <20190402075402.GA2665__21951.3897480041$1554191658$gmane$org@phenom.ffwll.local>
References: <20190401140306.28063-1-kraxel@redhat.com>
	<20190401140306.28063-3-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190401140306.28063-3-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 01, 2019 at 04:03:05PM +0200, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 9e7cd6b34106..93cb27f93d39 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -293,6 +293,7 @@ int bochs_kms_init(struct bochs_device *bochs)
>  void bochs_kms_fini(struct bochs_device *bochs)
>  {
>  	if (bochs->mode_config_initialized) {

This mode_config_initialized is hilarious. I think (from looking at git
history and all) this started in radeon, back when kms was an add-on, and
radeon.ko still supported ums. Then it was dutifully copypasted into
cirrus, bochs, mgag200, hisilicon and also amdgpu.

Afaict none of these drivers need this (but I didn't bother to review
amdgpu and radeon fully). Would be nice little cleanup to follow up with.

Anyway, on your 3 patches here:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +		drm_atomic_helper_shutdown(bochs->dev);
>  		drm_mode_config_cleanup(bochs->dev);
>  		bochs->mode_config_initialized = false;
>  	}
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
