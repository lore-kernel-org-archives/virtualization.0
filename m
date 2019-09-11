From: Frediano Ziglio <fziglio@redhat.com>
Subject: Re: [PATCH v2] drm/qxl: get vga ioports
Date: Wed, 11 Sep 2019 11:40:34 -0400 (EDT)
Message-ID: <964578816.11586547.1568216434638.JavaMail.zimbra__39003.7907216296$1568216447$gmane$org@redhat.com>
References: <20190805105401.29874-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190805105401.29874-1-kraxel@redhat.com>
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

> 
> qxl has two modes: "native" (used by the drm driver) and "vga" (vga
> compatibility mode, typically used for boot display and firmware
> framebuffers).
> 
> Accessing any vga ioport will switch the qxl device into vga mode.
> The qxl driver never does that, but other drivers accessing vga ports
> can trigger that too and therefore disturb qxl operation.  So aquire
> the legacy vga ioports from vgaarb to avoid that.
> 
> Reproducer: Boot kvm guest with both qxl and i915 vgpu, with qxl being
> first in pci scan order.
> 
> v2: Skip this for secondary qxl cards which don't have vga mode in the
>     first place (Frediano).
> 
> Cc: Frediano Ziglio <fziglio@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Acked-by: Frediano Ziglio <fziglio@redhat.com>

> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index b57a37543613..fcb48ac60598 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -63,6 +63,11 @@ module_param_named(num_heads, qxl_num_crtc, int, 0400);
>  static struct drm_driver qxl_driver;
>  static struct pci_driver qxl_pci_driver;
>  
> +static bool is_vga(struct pci_dev *pdev)
> +{
> +	return pdev->class == PCI_CLASS_DISPLAY_VGA << 8;
> +}
> +
>  static int
>  qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
> @@ -87,9 +92,17 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	if (ret)
>  		goto disable_pci;
>  
> +	if (is_vga(pdev)) {
> +		ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
> +		if (ret) {
> +			DRM_ERROR("can't get legacy vga ioports\n");
> +			goto disable_pci;
> +		}
> +	}
> +
>  	ret = qxl_device_init(qdev, &qxl_driver, pdev);
>  	if (ret)
> -		goto disable_pci;
> +		goto put_vga;
>  
>  	ret = qxl_modeset_init(qdev);
>  	if (ret)
> @@ -109,6 +122,9 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	qxl_modeset_fini(qdev);
>  unload:
>  	qxl_device_fini(qdev);
> +put_vga:
> +	if (is_vga(pdev))
> +		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  disable_pci:
>  	pci_disable_device(pdev);
>  free_dev:
> @@ -126,6 +142,8 @@ qxl_pci_remove(struct pci_dev *pdev)
>  
>  	qxl_modeset_fini(qdev);
>  	qxl_device_fini(qdev);
> +	if (is_vga(pdev))
> +		vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  
>  	dev->dev_private = NULL;
>  	kfree(qdev);

Frediano
