From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/qxl: unbind vgacon
Date: Thu, 21 Feb 2019 10:57:51 +0100
Message-ID: <20190221095751.GN2665__30549.0353073523$1550743280$gmane$org@phenom.ffwll.local>
References: <20190220143640.9970-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190220143640.9970-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 20, 2019 at 03:36:40PM +0100, Gerd Hoffmann wrote:
> Problem:  qxl switches from native mode back into vga compatibility mode
> when it notices someone is accessing vga registers.  And vgacon does
> exactly that before fbcon takes over.
> 
> Before qxl switched to the generic fbdev emulation that didn't cause any
> problems.  With the generic fbdev emulation the switch to vga mode
> happens now and then, probably caused by a initialization order change
> and triggered by a printk in a bad moment.
> 
> So make sure we take vgacon out of the picture by making dummycon
> taking over the console early enough.
> 
> Not entriely happy with the approach, I'm open to better ideas.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index bb81e310eb..88349dc13e 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -30,6 +30,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/console.h>
> +#include <linux/vt_kern.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm.h>
> @@ -89,6 +90,11 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	drm_kms_helper_poll_init(&qdev->ddev);
>  
> +	/* unbind vgacon to make sure it doesn't touch our vga registers */
> +	console_lock();
> +	ret = do_take_over_console(&dummy_con, 0, MAX_NR_CONSOLES - 1, true);
> +	console_unlock();

Still seems very late, in i915 we kick out vgacon as pretty much the first
thing in driver load. See i915_kick_out_vgacon.

I wonder whether we should integrate that logic into
drm_fb_helper_remove_conflicting_pci_framebuffers, by checking whether
that pci device can decode VGA and kick out vgacon in that case. Instead
of sprinkling the same logic over all drivers.
-Daniel

> +
>  	/* Complete initialization. */
>  	ret = drm_dev_register(&qdev->ddev, ent->driver_data);
>  	if (ret)
> -- 
> 2.9.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
