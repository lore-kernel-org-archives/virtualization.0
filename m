Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C01E832D;
	Tue, 18 Feb 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907168; cv=none; b=nW83vIjMrN9VxUUOePJVJcBxYGPhG3Al0jotzKljksD8IwQ1giWUb7qratSFpE/IGjhZ4lzjOtwUoY6bQ3NTxq6S+s/EV2C8v+F5KsioXt/2IVnOnukkklNs57lcZFQkhaPaIpua/r4o0eFxFoL8g2eRNa6WuOfqG9Ln0dTAB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907168; c=relaxed/simple;
	bh=K639qySusfhqWVzkmR1NrpWaIuD4POoCyjA6d1Oq07g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEM3ujJTjd8p5N7bTjkcrU/Pyxzt8WJJTCsgF3KEKD736RRUseltnnZ5ZPD9LmjBbixxBBYkdihtqkFHDW/BWRWDUR52kHx0hWfy3ph++wNzYN6rS5oyg0XaJBJ+wfAGbbOYLz9JKj6WXQarQf8JEQe/s5kItEAlh2CZqNlMzl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4be55c93be1so524707137.0;
        Tue, 18 Feb 2025 11:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739907161; x=1740511961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb7jRjd6uguB9cG41rTvHpSN+ZVtgW/KmSvyau5JmeE=;
        b=aP3W/r37UtUYtm0JpEroI+F9SFg7k4u1IKTBTDErMtr/Xa9KAzf+V/3KkoGpWlOfb2
         0Cmekd8bUPBymIOS7Yf0gxe8eZGS34JlV2NhcpojX6V4X6mIM4UibI+L+HHdEg1F+a4a
         /QPPf5mstY8eMwErii3bvK+IyvN2xXc5sLewQtNDogbQgk/cb9fw0HHuiZ1b6xroVta+
         9usQ3unfcZYSBYtffR5m5gPm71wnFYr88SY1W5h7dB55QnYf6la2Jhcp9QoTqYVwPMll
         7TOINsAkWHQ5Mj/LqLXI+x6Lkt+f0jkvkSOk0/JiweP87wLsFCtcZq8Nfjw/dX/R9Oo6
         EMuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7VaAbgF8VMeyWURcNGPxZm6L29FmhQ/JFwuPPHb6gxJPCRSHuXg+n8+glr/g07OaXO8g=@lists.linux.dev, AJvYcCX0EW7Bbt0L4qjouckPnzp+BnCwZyUIzfCNTuS9TOJTKmxdTfhFJd4/qACrVHflS21mHA2JzQLk8NYTTu+8wCo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFfqCiZ9cmh3kr0hjzt66hoicMnpSdAooKWiFM7+m3SEcs0aIV
	xXaW0y5+ep3G5b28n0tvKXNJWMgeojZ36r9ThSsH0fhKyUaGfyanCTk2LylN
X-Gm-Gg: ASbGncteCYR9wdNxk8BOGAlWPzZvq5h4BjAVmlhZpxg6OmVYJcOWAoXApsveg+x1/iS
	KXKLtHv/OAuY9bWLPoyvgePF3WJS6NaxL39QNPlN9KK1G2qNBDhKwfQqXeGrna/HrYCgG3wWdMP
	xARpuYsFJH5n8MzajjoI7ALLG75hmddmE8y2ZltygEGr3ox3BPZtgPOS1uKCz/hBRfOxzGnYbwx
	EThIassX4hxCb10BcnZbyRCX3RQF3JxzlvoGliW4CLVyFlMijx1GXZEizkgnGOb01jGciyc6XBM
	2qYUe+n5sIvIzBr+TvDm+bgAsoz98IX/BL4Jmz1MTc/MrAklSqUSTg==
X-Google-Smtp-Source: AGHT+IFrzXvdfqrZTCi+yzsw5CXLkpnSoGhZVqj/BPTwpB3N1SRZ1sXYARUG9mYz9Q33GsXP7MU/yg==
X-Received: by 2002:a05:6102:4187:b0:4bb:cbbc:42 with SMTP id ada2fe7eead31-4be85b54fe8mr477917137.5.1739907161224;
        Tue, 18 Feb 2025 11:32:41 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e86bd469sm2536319241.25.2025.02.18.11.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 11:32:40 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4be633cacbbso688025137.3;
        Tue, 18 Feb 2025 11:32:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+EFonKnrRqvY43GMUxiUxz+H2efUwbR23IwphrNoriCr7H6/Lgq/gAvRE0hUT5NO3zvs=@lists.linux.dev, AJvYcCVxz9/C61gWEm9LL5r2QykTPC+bfPGiZpMWeeWCYbIKgSk4cJkR0hPxHNVsF45Fkoh9AWx8X7/G5Smr4nV2yPM=@lists.linux.dev
X-Received: by 2002:a05:6102:b10:b0:4bb:d394:46c5 with SMTP id
 ada2fe7eead31-4be85bb8970mr656557137.9.1739907160582; Tue, 18 Feb 2025
 11:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250218142542.438557-1-tzimmermann@suse.de> <20250218142542.438557-3-tzimmermann@suse.de>
In-Reply-To: <20250218142542.438557-3-tzimmermann@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 20:32:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV939ibJTRSaO-oW2Jz4zbkXGRpUYrmA7e=yQfF7W-k_g@mail.gmail.com>
X-Gm-Features: AWEUYZnARFSxvjPUxC-uDBDfMGz-IvL-HNvEMBPwKo8soOA7GylWEHj75pA7v34
Message-ID: <CAMuHMdV939ibJTRSaO-oW2Jz4zbkXGRpUYrmA7e=yQfF7W-k_g@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] drm/dumb-buffers: Provide helper to set pitch
 and size
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
	linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-tegra@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

Hi Thomas,

On Tue, 18 Feb 2025 at 15:26, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Add drm_modes_size_dumb(), a helper to calculate the dumb-buffer
> scanline pitch and allocation size. Implementations of struct
> drm_driver.dumb_create can call the new helper for their size
> computations.
>
> There is currently quite a bit of code duplication among DRM's
> memory managers. Each calculates scanline pitch and buffer size
> from the given arguments, but the implementations are inconsistent
> in how they treat alignment and format support. Later patches will
> unify this code on top of drm_mode_size_dumb() as much as possible.
>
> drm_mode_size_dumb() uses existing 4CC format helpers to interpret
> the given color mode. This makes the dumb-buffer interface behave
> similar the kernel's video= parameter. Current per-driver implementations
> again likely have subtle differences or bugs in how they support color
> modes.
>
> The dumb-buffer UAPI is only specified for known color modes. These
> values describe linear, single-plane RGB color formats or legacy index
> formats. Other values should not be specified. But some user space
> still does. So for unknown color modes, there are a number of known
> exceptions for which drm_mode_size_dumb() calculates the pitch from
> the bpp value, as before. All other values work the same but print
> an error.
>
> v3:
> - document the UAPI semantics
> - compute scanline pitch from for unknown color modes (Andy, Tomi)
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks for your patch!

> --- a/drivers/gpu/drm/drm_dumb_buffers.c
> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> +/**
> + * drm_mode_size_dumb - Calculates the scanline and buffer sizes for dumb buffers
> + * @dev: DRM device
> + * @args: Parameters for the dumb buffer
> + * @pitch_align: Scanline alignment in bytes
> + * @size_align: Buffer-size alignment in bytes
> + *
> + * The helper drm_mode_size_dumb() calculates the size of the buffer
> + * allocation and the scanline size for a dumb buffer. Callers have to
> + * set the buffers width, height and color mode in the argument @arg.
> + * The helper validates the correctness of the input and tests for
> + * possible overflows. If successful, it returns the dumb buffer's
> + * required scanline pitch and size in &args.
> + *
> + * The parameter @pitch_align allows the driver to specifies an
> + * alignment for the scanline pitch, if the hardware requires any. The
> + * calculated pitch will be a multiple of the alignment. The parameter
> + * @size_align allows to specify an alignment for buffer sizes. The
> + * returned size is always a multiple of PAGE_SIZE.
> + *
> + * Returns:
> + * Zero on success, or a negative error code otherwise.
> + */
> +int drm_mode_size_dumb(struct drm_device *dev,
> +                      struct drm_mode_create_dumb *args,
> +                      unsigned long pitch_align,
> +                      unsigned long size_align)
> +{
> +       u64 pitch = 0;
> +       u32 fourcc;
> +
> +       /*
> +        * The scanline pitch depends on the buffer width and the color
> +        * format. The latter is specified as a color-mode constant for
> +        * which we first have to find the corresponding color format.
> +        *
> +        * Different color formats can have the same color-mode constant.
> +        * For example XRGB8888 and BGRX8888 both have a color mode of 32.
> +        * It is possible to use different formats for dumb-buffer allocation
> +        * and rendering as long as all involved formats share the same
> +        * color-mode constant.
> +        */
> +       fourcc = drm_driver_color_mode_format(dev, args->bpp);
> +       if (fourcc != DRM_FORMAT_INVALID) {
> +               const struct drm_format_info *info = drm_format_info(fourcc);
> +
> +               if (!info)
> +                       return -EINVAL;
> +               pitch = drm_format_info_min_pitch(info, 0, args->width);
> +       } else if (args->bpp) {
> +               /*
> +                * Some userspace throws in arbitrary values for bpp and
> +                * relies on the kernel to figure it out. In this case we
> +                * fall back to the old method of using bpp directly. The
> +                * over-commitment of memory from the rounding is acceptable
> +                * for compatibility with legacy userspace. We have a number
> +                * of deprecated legacy values that are explicitly supported.
> +                */
> +               switch (args->bpp) {
> +               default:
> +                       drm_warn(dev, "Unknown color mode %d; guessing buffer size.\n",

%u

> +                                args->bpp);
> +                       fallthrough;
> +               case 12:
> +               case 15:
> +               case 30: /* see drm_gem_afbc_get_bpp() */
> +               case 10:

Perhaps keep them sorted numerically?

> +               case 64: /* used by Mesa */
> +                       pitch = args->width * DIV_ROUND_UP(args->bpp, SZ_8);
> +                       break;
> +               }
> +       }
> +
> +       if (!pitch || pitch > U32_MAX)
> +               return -EINVAL;
> +
> +       args->pitch = pitch;
> +
> +       return drm_mode_align_dumb(args, pitch_align, size_align);
> +}
> +EXPORT_SYMBOL(drm_mode_size_dumb);
> +
>  int drm_mode_create_dumb(struct drm_device *dev,
>                          struct drm_mode_create_dumb *args,
>                          struct drm_file *file_priv)
> diff --git a/include/drm/drm_dumb_buffers.h b/include/drm/drm_dumb_buffers.h
> new file mode 100644
> index 000000000000..6fe36004b19d
> --- /dev/null
> +++ b/include/drm/drm_dumb_buffers.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +#ifndef __DRM_DUMB_BUFFERS_H__
> +#define __DRM_DUMB_BUFFERS_H__
> +
> +struct drm_device;
> +struct drm_mode_create_dumb;
> +
> +int drm_mode_size_dumb(struct drm_device *dev,
> +                      struct drm_mode_create_dumb *args,
> +                      unsigned long pitch_align,
> +                      unsigned long size_align);
> +
> +#endif
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index c082810c08a8..eea09103b1a6 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -1058,7 +1058,7 @@ struct drm_mode_crtc_page_flip_target {
>   * struct drm_mode_create_dumb - Create a KMS dumb buffer for scanout.
>   * @height: buffer height in pixels
>   * @width: buffer width in pixels
> - * @bpp: bits per pixel
> + * @bpp: color mode
>   * @flags: must be zero
>   * @handle: buffer object handle
>   * @pitch: number of bytes between two consecutive lines
> @@ -1066,6 +1066,50 @@ struct drm_mode_crtc_page_flip_target {
>   *
>   * User-space fills @height, @width, @bpp and @flags. If the IOCTL succeeds,
>   * the kernel fills @handle, @pitch and @size.
> + *
> + * The value of @bpp is a color-mode number describing a specific format
> + * or a variant thereof. The value often corresponds to the number of bits
> + * per pixel for most modes, although there are exceptions. Each color mode
> + * maps to a DRM format plus a number of modes with similar pixel layout.
> + * Framebuffer layout is always linear.
> + *
> + * Support for all modes and formats is optional. Even if dumb-buffer
> + * creation with a certain color mode succeeds, it is not guaranteed that
> + * the DRM driver supports any of the related formats. Most drivers support
> + * a color mode of 32 with a format of DRM_FORMAT_XRGB8888 on their primary
> + * plane.
> + *
> + * +------------+------------------------+------------------------+
> + * | Color mode | Framebuffer format     | Compatibles            |
> + * +============+========================+========================+
> + * |     32     |  * DRM_FORMAT_XRGB8888 |  * DRM_FORMAT_XBGR8888 |
> + * |            |                        |  * DRM_FORMAT_RGBX8888 |
> + * |            |                        |  * DRM_FORMAT_BGRX8888 |
> + * +------------+------------------------+------------------------+
> + * |     24     |  * DRM_FORMAT_RGB888   |  * DRM_FORMAT_BGR888   |
> + * +------------+------------------------+------------------------+
> + * |     16     |  * DRM_FORMAT_RGB565   |  * DRM_FORMAT_BGR565   |
> + * +------------+------------------------+------------------------+
> + * |     15     |  * DRM_FORMAT_XRGB1555 |  * DRM_FORMAT_XBGR1555 |
> + * |            |                        |  * DRM_FORMAT_RGBX1555 |
> + * |            |                        |  * DRM_FORMAT_BGRX1555 |
> + * +------------+------------------------+------------------------+
> + * |      8     |  * DRM_FORMAT_C8       |  * DRM_FORMAT_R8       |

+ DRM_FORMAT_D8? (and 4/2/1 below)

And DRM_FORMAT_Y8, if/when Tomi's series introducing that is accepted...

> + * +------------+------------------------+------------------------+
> + * |      4     |  * DRM_FORMAT_C4       |  * DRM_FORMAT_R4       |
> + * +------------+------------------------+------------------------+
> + * |      2     |  * DRM_FORMAT_C2       |  * DRM_FORMAT_R2       |
> + * +------------+------------------------+------------------------+
> + * |      1     |  * DRM_FORMAT_C1       |  * DRM_FORMAT_R1       |
> + * +------------+------------------------+------------------------+
> + *
> + * Color modes of 10, 12, 15, 30 and 64 are only supported for use by
> + * legacy user space. Please don't use them in new code. Other modes
> + * are not support.
> + *
> + * Do not attempt to allocate anything but linear framebuffer memory
> + * with single-plane RGB data. Allocation of other framebuffer
> + * layouts requires dedicated ioctls in the respective DRM driver.
>   */
>  struct drm_mode_create_dumb {
>         __u32 height;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
