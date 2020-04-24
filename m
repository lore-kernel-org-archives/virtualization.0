From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 59/59] drm/bochs: Remove explicit
 drm_connector_register
Date: Fri, 24 Apr 2020 20:11:18 +0200
Message-ID: <20200424181118.GN7074@ravnborg.org>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
 <20200415074034.175360-60-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20200415074034.175360-60-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Gerd Hoffmann <kraxel@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 15, 2020 at 09:40:34AM +0200, Daniel Vetter wrote:
> This is leftovers from the old drm_driver->load callback
> upside-down issues. It doesn't do anything for not-hotplugged
> connectors since drm_dev_register takes care of that.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/bochs/bochs_kms.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 7f4bcfad87e9..05d8373888e8 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -104,7 +104,6 @@ static void bochs_connector_init(struct drm_device *dev)
>  			   DRM_MODE_CONNECTOR_VIRTUAL);
>  	drm_connector_helper_add(connector,
>  				 &bochs_connector_connector_helper_funcs);
> -	drm_connector_register(connector);
>  
>  	bochs_hw_load_edid(bochs);
>  	if (bochs->edid) {
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
