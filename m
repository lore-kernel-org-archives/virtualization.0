From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4] drm/bochs: add edid support.
Date: Tue, 30 Oct 2018 10:35:54 +0100
Message-ID: <20181030093554.GP21967__13122.1721102067$1540892062$gmane$org@phenom.ffwll.local>
References: <20181029205048.13200-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20181029205048.13200-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Oct 29, 2018 at 09:50:48PM +0100, Gerd Hoffmann wrote:
> Recent qemu (latest master branch, upcoming 3.1 release) got support
> for EDID data.  This patch adds guest driver support.
> 
> EDID support in qemu is not (yet) enabled by default, so please use
> 'qemu -device VGA,edid=on' for testing.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

I liked v3 more, but Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch> on
either wone.
-Daniel

> ---
>  drivers/gpu/drm/bochs/bochs.h     |  2 ++
>  drivers/gpu/drm/bochs/bochs_hw.c  | 30 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/bochs/bochs_kms.c | 20 +++++++++++++++++---
>  3 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
> index e7a69077e4..577a8b917c 100644
> --- a/drivers/gpu/drm/bochs/bochs.h
> +++ b/drivers/gpu/drm/bochs/bochs.h
> @@ -66,6 +66,7 @@ struct bochs_device {
>  	u16 yres_virtual;
>  	u32 stride;
>  	u32 bpp;
> +	struct edid *edid;
>  
>  	/* drm */
>  	struct drm_device  *dev;
> @@ -126,6 +127,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
>  		      const struct drm_format_info *format);
>  void bochs_hw_setbase(struct bochs_device *bochs,
>  		      int x, int y, u64 addr);
> +int bochs_hw_load_edid(struct bochs_device *bochs);
>  
>  /* bochs_mm.c */
>  int bochs_mm_init(struct bochs_device *bochs);
> diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
> index cacff73a64..c90a0d492f 100644
> --- a/drivers/gpu/drm/bochs/bochs_hw.c
> +++ b/drivers/gpu/drm/bochs/bochs_hw.c
> @@ -69,6 +69,35 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
>  #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
>  #endif
>  
> +static int bochs_get_edid_block(void *data, u8 *buf,
> +				unsigned int block, size_t len)
> +{
> +	struct bochs_device *bochs = data;
> +	size_t i, start = block * EDID_LENGTH;
> +
> +	if (start + len > 0x400 /* vga register offset */)
> +		return -1;
> +
> +	for (i = 0; i < len; i++) {
> +		buf[i] = readb(bochs->mmio + start + i);
> +	}
> +	return 0;
> +}
> +
> +int bochs_hw_load_edid(struct bochs_device *bochs)
> +{
> +	if (!bochs->mmio)
> +		return -1;
> +
> +	kfree(bochs->edid);
> +	bochs->edid = drm_do_get_edid(&bochs->connector,
> +				      bochs_get_edid_block, bochs);
> +	if (bochs->edid == NULL)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  int bochs_hw_init(struct drm_device *dev)
>  {
>  	struct bochs_device *bochs = dev->dev_private;
> @@ -164,6 +193,7 @@ void bochs_hw_fini(struct drm_device *dev)
>  	if (bochs->fb_map)
>  		iounmap(bochs->fb_map);
>  	pci_release_regions(dev->pdev);
> +	kfree(bochs->edid);
>  }
>  
>  void bochs_hw_setmode(struct bochs_device *bochs,
> diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
> index 9bc5b438ae..f87c284dd9 100644
> --- a/drivers/gpu/drm/bochs/bochs_kms.c
> +++ b/drivers/gpu/drm/bochs/bochs_kms.c
> @@ -213,10 +213,17 @@ static void bochs_encoder_init(struct drm_device *dev)
>  
>  static int bochs_connector_get_modes(struct drm_connector *connector)
>  {
> -	int count;
> +	struct bochs_device *bochs =
> +		container_of(connector, struct bochs_device, connector);
> +	int count = 0;
>  
> -	count = drm_add_modes_noedid(connector, 8192, 8192);
> -	drm_set_preferred_mode(connector, defx, defy);
> +	if (bochs->edid)
> +		count = drm_add_edid_modes(connector, bochs->edid);
> +
> +	if (!count) {
> +		count = drm_add_modes_noedid(connector, 8192, 8192);
> +		drm_set_preferred_mode(connector, defx, defy);
> +	}
>  	return count;
>  }
>  
> @@ -271,6 +278,13 @@ static void bochs_connector_init(struct drm_device *dev)
>  	drm_connector_helper_add(connector,
>  				 &bochs_connector_connector_helper_funcs);
>  	drm_connector_register(connector);
> +
> +	bochs_hw_load_edid(bochs);
> +	if (bochs->edid) {
> +		DRM_INFO("Found EDID data blob.\n");
> +		drm_connector_attach_edid_property(connector);
> +		drm_connector_update_edid_property(connector, bochs->edid);
> +	}
>  }
>  
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
