From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] drm/cirrus: add drm_driver.release callback.
Date: Tue, 11 Feb 2020 09:34:14 +0100
Message-ID: <20200211083414.GT43062@phenom.ffwll.local>
References: <20200210095310.22082-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200210095310.22082-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Feb 10, 2020 at 10:53:10AM +0100, Gerd Hoffmann wrote:
> Move final cleanups from cirrus_pci_remove() to the new callback.
> Add drm_atomic_helper_shutdown() call to cirrus_pci_remove().
> 
> Set pointers to NULL after iounmap() and check them before using
> them to make sure we don't touch released hardware.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/cirrus/cirrus.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
> index a91fb0d7282c..128db11ed4d3 100644
> --- a/drivers/gpu/drm/cirrus/cirrus.c
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -154,6 +154,9 @@ static void cirrus_set_start_address(struct cirrus_device *cirrus, u32 offset)
>  	u32 addr;
>  	u8 tmp;
>  
> +	if (!cirrus->mmio)
> +		return;

Same as with the previous one, I think you're looking for
drm_dev_enter/exit. And missing patch changelog. remove/release split
looks good otherwise.
-Daniel

> +
>  	addr = offset >> 2;
>  	wreg_crt(cirrus, 0x0c, (u8)((addr >> 8) & 0xff));
>  	wreg_crt(cirrus, 0x0d, (u8)(addr & 0xff));
> @@ -179,6 +182,9 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
>  	int tmp;
>  	int sr07 = 0, hdr = 0;
>  
> +	if (!cirrus->mmio)
> +		return -1;
> +
>  	htotal = mode->htotal / 8;
>  	hsyncend = mode->hsync_end / 8;
>  	hsyncstart = mode->hsync_start / 8;
> @@ -301,6 +307,9 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
>  	struct cirrus_device *cirrus = fb->dev->dev_private;
>  	void *vmap;
>  
> +	if (!cirrus->vram)
> +		return -ENODEV;
> +
>  	vmap = drm_gem_shmem_vmap(fb->obj[0]);
>  	if (!vmap)
>  		return -ENOMEM;
> @@ -502,6 +511,14 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
>  
>  /* ------------------------------------------------------------------ */
>  
> +static void cirrus_release(struct drm_device *dev)
> +{
> +	struct cirrus_device *cirrus = dev->dev_private;
> +
> +	drm_mode_config_cleanup(dev);
> +	kfree(cirrus);
> +}
> +
>  DEFINE_DRM_GEM_FOPS(cirrus_fops);
>  
>  static struct drm_driver cirrus_driver = {
> @@ -515,6 +532,7 @@ static struct drm_driver cirrus_driver = {
>  
>  	.fops		 = &cirrus_fops,
>  	DRM_GEM_SHMEM_DRIVER_OPS,
> +	.release         = cirrus_release,
>  };
>  
>  static int cirrus_pci_probe(struct pci_dev *pdev,
> @@ -599,11 +617,12 @@ static void cirrus_pci_remove(struct pci_dev *pdev)
>  	struct cirrus_device *cirrus = dev->dev_private;
>  
>  	drm_dev_unregister(dev);
> -	drm_mode_config_cleanup(dev);
> +	drm_atomic_helper_shutdown(dev);
>  	iounmap(cirrus->mmio);
> +	cirrus->mmio = NULL;
>  	iounmap(cirrus->vram);
> +	cirrus->vram = NULL;
>  	drm_dev_put(dev);
> -	kfree(cirrus);
>  	pci_release_regions(pdev);
>  }
>  
> -- 
> 2.18.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
