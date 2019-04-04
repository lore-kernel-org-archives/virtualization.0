From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 6/6] drm/cirrus: rewrite and modernize driver.
Date: Thu, 4 Apr 2019 19:41:14 +0200
Message-ID: <20190404174114.GG23897__8646.30943849392$1554400115$gmane$org@ravnborg.org>
References: <20190404152430.8263-1-kraxel@redhat.com>
	<20190404152430.8263-7-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190404152430.8263-7-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Gerd.

Very nice diffstat - good work indeed!

> I think it'll still be alot easier to review than a
> longish baby-step patch series.
Agreed.

Some random nits below.
With the relevant parts addressed you can add my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

> new file mode 100644
> index 000000000000..5060e3d854d3
> --- /dev/null
> +++ b/drivers/gpu/drm/cirrus/cirrus.c
> @@ -0,0 +1,621 @@
> +/*
> + * Copyright 2012-2019 Red Hat
> + *
> + * This file is subject to the terms and conditions of the GNU General
> + * Public License version 2. See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * Authors: Matthew Garrett
> + *	    Dave Airlie
> + *	    Gerd Hoffmann
> + *
> + * Portions of this code derived from cirrusfb.c:
> + * drivers/video/cirrusfb.c - driver for Cirrus Logic chipsets
> + *
> + * Copyright 1999-2001 Jeff Garzik <jgarzik@pobox.com>
> + */
Can we introduce an SPDX identifier?
(I am not good at the license stuff, so I cannot tell)

> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/console.h>
> +
> +#include <video/vga.h>
> +#include <video/cirrus.h>
> +
> +#include <drm/drm_drv.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_ioctl.h>
> +#include <drm/drm_vblank.h>
> +#include <drm/drm_connector.h>
> +
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_fb_helper.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_modeset_helper_vtables.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_atomic_state_helper.h>
Please sort again, you added a few new includes since last time

> +struct cirrus_device {
> +	struct drm_device	       dev;
> +	struct drm_simple_display_pipe pipe;
> +	struct drm_connector	       conn;
> +	unsigned int		       cpp;
> +	unsigned int		       pitch;
> +	void __iomem		       *vram;
> +	void __iomem		       *mmio;
> +};
> +
> +/* ------------------------------------------------------------------ */
> +/*
> + * The meat of this driver. The core passes us a mode and we have to program
> + * it. The modesetting here is the bare minimum required to satisfy the qemu
> + * emulation of this hardware, and running this against a real device is
> + * likely to result in an inadequately programmed mode. We've already had
> + * the opportunity to modify the mode, so whatever we receive here should
> + * be something that can be correctly programmed and displayed
> + */
> +
> +#define RREG8(reg) ioread8(((void __iomem *)cirrus->mmio) + (reg))
> +#define WREG8(reg, v) iowrite8(v, ((void __iomem *)cirrus->mmio) + (reg))
> +#define RREG32(reg) ioread32(((void __iomem *)cirrus->mmio) + (reg))
> +#define WREG32(reg, v) iowrite32(v, ((void __iomem *)cirrus->mmio) + (reg))

The cast of cirrus->mmio to (void __iomem *) should not be necessary as
this is the type is has in struct cirrus_device

There is not reason to use a define, use can use a static inline function

> +
> +#define SEQ_INDEX 4
> +#define SEQ_DATA 5
> +
> +#define WREG_SEQ(reg, v)					\
> +	do {							\
> +		WREG8(SEQ_INDEX, reg);				\
> +		WREG8(SEQ_DATA, v);				\
> +	} while (0)						\
This is only used once, drop the define?


> +#define CRT_INDEX 0x14
> +#define CRT_DATA 0x15
> +
> +#define WREG_CRT(reg, v)					\
> +	do {							\
> +		WREG8(CRT_INDEX, reg);				\
> +		WREG8(CRT_DATA, v);				\
> +	} while (0)						\
static inline?

> +#define GFX_INDEX 0xe
> +#define GFX_DATA 0xf
> +
> +#define WREG_GFX(reg, v)					\
> +	do {							\
> +		WREG8(GFX_INDEX, reg);				\
> +		WREG8(GFX_DATA, v);				\
> +	} while (0)						\
Used twice - drop?
> +
> +#define VGA_DAC_MASK 0x6
> +
> +#define WREG_HDR(v)						\
> +	do {							\
> +		RREG8(VGA_DAC_MASK);				\
> +		RREG8(VGA_DAC_MASK);				\
> +		RREG8(VGA_DAC_MASK);				\
> +		RREG8(VGA_DAC_MASK);				\
> +		WREG8(VGA_DAC_MASK, v);				\
> +	} while (0)						\
Used once, drop?

> +static int cirrus_convert_to(struct drm_framebuffer *fb)
> +{
> +	if (fb->format->cpp[0] == 4 && fb->pitches[0] > CIRRUS_MAX_PITCH) {
> +		if (fb->width * 3 <= CIRRUS_MAX_PITCH)
> +			/* convert from XR24 to RG24 */
> +			return 3;
> +		else
> +			/* convert from XR24 to RG16 */
> +			return 2;
> +	}
> +	return 0;
> +}
> +
> +static int cirrus_cpp(struct drm_framebuffer *fb)
> +{
> +	int convert_cpp = cirrus_convert_to(fb);
> +
> +	if (convert_cpp)
> +		return convert_cpp;
> +	return fb->format->cpp[0];
> +}
> +
> +static int cirrus_pitch(struct drm_framebuffer *fb)
> +{
> +	int convert_cpp = cirrus_convert_to(fb);
> +
> +	if (convert_cpp)
> +		return convert_cpp * fb->width;
> +	return fb->pitches[0];
> +}
> +
> +static int cirrus_mode_set(struct cirrus_device *cirrus,
> +			   struct drm_display_mode *mode,
> +			   struct drm_framebuffer *fb)
> +{
> +	int hsyncstart, hsyncend, htotal, hdispend;
> +	int vtotal, vdispend;
> +	int tmp;
> +	int sr07 = 0, hdr = 0;
> +
> +	htotal = mode->htotal / 8;
> +	hsyncend = mode->hsync_end / 8;
> +	hsyncstart = mode->hsync_start / 8;
> +	hdispend = mode->hdisplay / 8;
> +
> +	vtotal = mode->vtotal;
> +	vdispend = mode->vdisplay;
> +
> +	vdispend -= 1;
> +	vtotal -= 2;
> +
> +	htotal -= 5;
> +	hdispend -= 1;
> +	hsyncstart += 1;
> +	hsyncend += 1;
> +
> +	WREG_CRT(VGA_CRTC_V_SYNC_END, 0x20);
> +	WREG_CRT(VGA_CRTC_H_TOTAL, htotal);
> +	WREG_CRT(VGA_CRTC_H_DISP, hdispend);
> +	WREG_CRT(VGA_CRTC_H_SYNC_START, hsyncstart);
> +	WREG_CRT(VGA_CRTC_H_SYNC_END, hsyncend);
> +	WREG_CRT(VGA_CRTC_V_TOTAL, vtotal & 0xff);
> +	WREG_CRT(VGA_CRTC_V_DISP_END, vdispend & 0xff);
> +
> +	tmp = 0x40;
> +	if ((vdispend + 1) & 512)
> +		tmp |= 0x20;
> +	WREG_CRT(VGA_CRTC_MAX_SCAN, tmp);
> +
> +	/*
> +	 * Overflow bits for values that don't fit in the standard registers
> +	 */
> +	tmp = 16;
> +	if (vtotal & 256)
> +		tmp |= 1;
> +	if (vdispend & 256)
> +		tmp |= 2;
> +	if ((vdispend + 1) & 256)
> +		tmp |= 8;
> +	if (vtotal & 512)
> +		tmp |= 32;
> +	if (vdispend & 512)
> +		tmp |= 64;
> +	WREG_CRT(VGA_CRTC_OVERFLOW, tmp);
> +
> +	tmp = 0;
> +
> +	/* More overflow bits */
> +
> +	if ((htotal + 5) & 64)
> +		tmp |= 16;
> +	if ((htotal + 5) & 128)
> +		tmp |= 32;
> +	if (vtotal & 256)
> +		tmp |= 64;
> +	if (vtotal & 512)
> +		tmp |= 128;
For bit operations / numbers above consider to hexadecimal numbers to increase readability.

> +
> +	WREG_CRT(CL_CRT1A, tmp);
> +
> +	/* Disable Hercules/CGA compatibility */
> +	WREG_CRT(VGA_CRTC_MODE, 0x03);
> +
> +	WREG8(SEQ_INDEX, 0x7);
> +	sr07 = RREG8(SEQ_DATA);
> +	sr07 &= 0xe0;
> +	hdr = 0;
> +
> +	cirrus->cpp = cirrus_cpp(fb);
> +	switch (cirrus->cpp * 8) {
> +	case 8:
> +		sr07 |= 0x11;
> +		break;
> +	case 16:
> +		sr07 |= 0x17;
> +		hdr = 0xc1;
> +		break;
> +	case 24:
> +		sr07 |= 0x15;
> +		hdr = 0xc5;
> +		break;
> +	case 32:
> +		sr07 |= 0x19;
> +		hdr = 0xc5;
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	WREG_SEQ(0x7, sr07);
> +
> +	/* Program the pitch */
> +	cirrus->pitch = cirrus_pitch(fb);
> +	tmp = cirrus->pitch / 8;
> +	WREG_CRT(VGA_CRTC_OFFSET, tmp);
> +
> +	/* Enable extended blanking and pitch bits, and enable full memory */
> +	tmp = 0x22;
> +	tmp |= (cirrus->pitch >> 7) & 0x10;
> +	tmp |= (cirrus->pitch >> 6) & 0x40;
> +	WREG_CRT(0x1b, tmp);
> +
> +	/* Enable high-colour modes */
> +	WREG_GFX(VGA_GFX_MODE, 0x40);
> +
> +	/* And set graphics mode */
> +	WREG_GFX(VGA_GFX_MISC, 0x01);
> +
> +	WREG_HDR(hdr);
> +	/* cirrus_crtc_do_set_base(crtc, old_fb, x, y, 0); */
> +
> +	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
> +	outb(0x20, 0x3c0);
> +	return 0;
> +}
> +
> +static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
> +			       struct drm_plane_state *old_state)
> +{
> +	struct cirrus_device *cirrus = pipe->crtc.dev->dev_private;
> +	struct drm_plane_state *state = pipe->plane.state;
> +	struct drm_crtc *crtc = &pipe->crtc;
> +	struct drm_rect rect;
> +
> +	if (pipe->plane.state->fb &&
> +	    cirrus->cpp != cirrus_cpp(pipe->plane.state->fb))
> +		cirrus_mode_set(cirrus, &crtc->mode,
> +				pipe->plane.state->fb);
> +
> +	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> +		cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
> +
> +	if (crtc->state->event) {
> +		spin_lock_irq(&crtc->dev->event_lock);
> +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +		spin_unlock_irq(&crtc->dev->event_lock);
> +		crtc->state->event = NULL;
Should you set crtc->state->event = NULL; before spin_unlock_irq()?

> +
> +/* only bind to the cirrus chip in qemu */
> +static const struct pci_device_id pciidlist[] = {
> +	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446,
> +	  PCI_SUBVENDOR_ID_REDHAT_QUMRANET, PCI_SUBDEVICE_ID_QEMU,
> +	  0, 0, 0 },

	PCI_DEVICE_SUB(PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446,
		       PCI_SUBVENDOR_ID_REDHAT_QUMRANET, PCI_SUBDEVICE_ID_QEMU)
????
Hmm, looks like an alternative way to say the same, that is hardly much improvement?!?


> +	{ PCI_VENDOR_ID_CIRRUS, PCI_DEVICE_ID_CIRRUS_5446,
> +	  PCI_VENDOR_ID_XEN, 0x0001,
> +	  0, 0, 0 },
> +	{ /* end if list */}
Add space before final } 
