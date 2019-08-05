From: Frediano Ziglio <fziglio@redhat.com>
Subject: Re: [Spice-devel] [PATCH] drm/qxl: get vga ioports
Date: Mon, 5 Aug 2019 05:18:13 -0400 (EDT)
Message-ID: <1869747233.4556840.1564996693878.JavaMail.zimbra__42142.4244342902$1564996710$gmane$org@redhat.com>
References: <20190805085355.12527-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190805085355.12527-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>
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
> Reporducer: Boot kvm guest with both qxl and i915 vgpu, with qxl being

typo: "Reporducer"

> first in pci scan order.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index b57a37543613..8a2e86adc423 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -87,9 +87,15 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	if (ret)
>  		goto disable_pci;
>  
> +	ret = vga_get_interruptible(pdev, VGA_RSRC_LEGACY_IO);
> +	if (ret) {
> +		DRM_ERROR("can't get legacy vga ports\n");
> +		goto put_vga;

I suppose that if this fails it's secondary so should continue.
What happen configuring 2 QXL devices?
Only a card should provide VGA registers in the system so
if any other card provide them QXL won't work.

> +	}
> +
>  	ret = qxl_device_init(qdev, &qxl_driver, pdev);
>  	if (ret)
> -		goto disable_pci;
> +		goto put_vga;
>  
>  	ret = qxl_modeset_init(qdev);
>  	if (ret)
> @@ -109,6 +115,8 @@ qxl_pci_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  	qxl_modeset_fini(qdev);
>  unload:
>  	qxl_device_fini(qdev);
> +put_vga:
> +	vga_put(pdev, VGA_RSRC_LEGACY_IO);

What happen if you didn't get the I/O? Maybe it's safe to
just call vga_put and avoid adding an additional label here?

>  disable_pci:
>  	pci_disable_device(pdev);
>  free_dev:
> @@ -126,6 +134,7 @@ qxl_pci_remove(struct pci_dev *pdev)
>  
>  	qxl_modeset_fini(qdev);
>  	qxl_device_fini(qdev);
> +	vga_put(pdev, VGA_RSRC_LEGACY_IO);
>  
>  	dev->dev_private = NULL;
>  	kfree(qdev);

Frediano
