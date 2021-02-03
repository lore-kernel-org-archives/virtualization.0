Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A59C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:01:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BAD64E43
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 14:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BAD64E43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6651487100;
	Wed,  3 Feb 2021 14:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y8qemKbI8eOF; Wed,  3 Feb 2021 14:01:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1E23E86632;
	Wed,  3 Feb 2021 14:01:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1486BC0174;
	Wed,  3 Feb 2021 14:01:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 256CDC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1DBB5860F1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:01:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id adEwydbDdDwG
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:01:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 04E8F85D5F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 14:01:38 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id z6so24365278wrq.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Feb 2021 06:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qp1ZS2C3a2H6RR+kbrD6UQmK5VG+chJxmV+ybDJHeoU=;
 b=J8Avg2U2/1dSPzRa+fOMaLfFY7CzF3DXHNtP0IGcN7ZgqsUNtrMkZC+lqdan7q3J+b
 5PXaqIhIkiYk6kW0dlLU0I3sU4pQ0zVkz+7misLxMKOn86VE2wKxSsYUntJXEbh/Re3s
 azipschk9MJiheCUh8f1fVggrBxf2641ko2j0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qp1ZS2C3a2H6RR+kbrD6UQmK5VG+chJxmV+ybDJHeoU=;
 b=OaqK+9YWPUW6crNBhKXOnp8eyAP+gywPk/bh7T+kJdka72i2XXbMs+A6B+i2xsufvh
 IpR/qDly6FE1utEtimJmfjHUzuVbFQrilS+IyuQwRoVUFdNST9b+Sl64XX3HzAxN9sYo
 AzWSav1c6XNE6yLJW11nKOwkVwz7jm5oXQSeAGq4tQN98dIWQdZvyJS1m6o/qk0gyHUo
 9mo1QDk6uXogOxzTZsxrGxbQ9Kr9Z2HssGYpwOuiW/T+pJjCij7Gz270aLxA6ANx4dsf
 joBFwQv6A9vUm5SuYCAEONmWYmmz98RZ88kOPtbP9uRxpvKCTdgthlV7cIdr93DX3str
 fVdQ==
X-Gm-Message-State: AOAM533mhHjnQfFjunGJrv+AdLslkPMHn1nh++KZqxlmVbVH+mN5+qUO
 gzWh9u+I8rXGxlxiQQl6bCYRmg==
X-Google-Smtp-Source: ABdhPJyGPow7xjOb2Be+AMWFlZ+jZtdYuDErvlYy/bLYOtdl0jbVeUThMk5BEf/Zr3ASM2kkSLmzeQ==
X-Received: by 2002:a5d:640c:: with SMTP id z12mr3723740wru.342.1612360897279; 
 Wed, 03 Feb 2021 06:01:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id o12sm3861260wrx.82.2021.02.03.06.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 06:01:36 -0800 (PST)
Date: Wed, 3 Feb 2021 15:01:34 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/6] drm/shmem-helper: Add additional KMS helpers
Message-ID: <YBqsvhIROEVLnC2L@phenom.ffwll.local>
References: <20210203131046.22371-1-tzimmermann@suse.de>
 <20210203131046.22371-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210203131046.22371-3-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: airlied@linux.ie, sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, hdegoede@redhat.com,
 noralf@tronnes.org, daniel@ffwll.ch, sean@poorly.run
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Feb 03, 2021 at 02:10:42PM +0100, Thomas Zimmermann wrote:
> Several drivers use GEM SHMEM buffer objects as shadow buffers for
> the actual framebuffer memory. Right now, drivers do these vmap
> operations in their commit tail, which is actually not allowed by the
> locking rules for the dma-buf reservation lock. The involved SHMEM
> BO has to be vmapped in the plane's prepare_fb callback and vunmapped
> in cleanup_fb.
> 
> This patch introduces a DRM library that implements KMS helpers for
> GEM SHMEM buffer objects. The first set of helpers is the plane state
> for shadow planes. The provided implementations for prepare_fb and
> cleanup_fb vmap and vunmap all BOs of struct drm_plane_state.fb. The
> mappings are afterwards available in the plane's commit-tail functions.
> 
> All rsp drivers use the simple KMS helpers, so we add the plane callbacks
> and wrappers for simple KMS.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/Kconfig                    |   7 +
>  drivers/gpu/drm/Makefile                   |   1 +
>  drivers/gpu/drm/drm_gem_shmem_kms_helper.c | 159 +++++++++++++++++++++
>  include/drm/drm_gem_shmem_kms_helper.h     |  56 ++++++++
>  4 files changed, 223 insertions(+)
>  create mode 100644 drivers/gpu/drm/drm_gem_shmem_kms_helper.c
>  create mode 100644 include/drm/drm_gem_shmem_kms_helper.h
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 8bf103de1594..b8d8b00ab5d4 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -214,6 +214,13 @@ config DRM_GEM_SHMEM_HELPER
>  	help
>  	  Choose this if you need the GEM shmem helper functions
>  
> +config DRM_GEM_SHMEM_KMS_HELPER
> +	bool
> +	depends on DRM_GEM_SHMEM_HELPER
> +	help
> +	help
> +	  Choose this if you need the GEM SHMEM helper functions for KMS

I think we should just stuff this into simple pipe helpers directly. Also
needs some kerneldoc and ideally intro section of some sorts, but I guess
that was just missing for RFC.

Thinking a bit bigger and looking at the first patch, I wonder whether we
shouldn't outright integrate this simple pipe helpers. Adding all the
hooks for plane_state (instead of a simple_pipe_state or something like
that) feels a bit icky to me. But on the driver side the integration with
just the single macro line is very neat, so that's redeeming feature.

Note doing a drm_simple_display_pipe_state would be a bit tricky to do,
since we'd need custome duplicate_state functions to make sure there's
only ever exactly one:

struct drm_simple_display_pipe_state {
	struct drm_crtc_state crtc_state;
	struct drm_plane_state plane_state;

	struct dma_buf_map map[4];
};

But that's a bit a bigger step, maybe when we also need to subclass crtc
stuff we can look into this. Or maybe that's then too much feature creep,
dunno. Implemenation shouldn't be too tricky:
- crtc state just duplicates itself (including plane_state duplication).
  In release it also cleans up the plane state.
- plane state grabs the crtc state instead, and then does a cast. destroy
  hook does nothing (to avoid touching freed memory, since we always dupe
  the crtc state when the plane state exists we know the crtc destroy hook
  will clean things up).

That means drm_atomic_state has 2 pointers pointing into the same
allocation, but that should be all fine.

Aside from this bikeshed here pondering a bit how this best first into our
simple pipe helpers I think this all looks very clean.
-Daniel

> +
>  config DRM_SCHED
>  	tristate
>  	depends on DRM
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 926adef289db..37a73dee5baf 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -53,6 +53,7 @@ drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
>  drm_kms_helper-$(CONFIG_DRM_KMS_CMA_HELPER) += drm_fb_cma_helper.o
>  drm_kms_helper-$(CONFIG_DRM_DP_AUX_CHARDEV) += drm_dp_aux_dev.o
>  drm_kms_helper-$(CONFIG_DRM_DP_CEC) += drm_dp_cec.o
> +drm_kms_helper-$(CONFIG_DRM_GEM_SHMEM_KMS_HELPER) += drm_gem_shmem_kms_helper.o
>  
>  obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
>  obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
> diff --git a/drivers/gpu/drm/drm_gem_shmem_kms_helper.c b/drivers/gpu/drm/drm_gem_shmem_kms_helper.c
> new file mode 100644
> index 000000000000..8843c5837f98
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_gem_shmem_kms_helper.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <drm/drm_atomic_state_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_gem_shmem_helper.h>
> +#include <drm/drm_gem_shmem_kms_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +
> +/*
> + * Helpers for struct drm_plane_funcs
> + *
> + */
> +
> +static struct drm_plane_state *
> +drm_gem_shmem_duplicate_shadow_plane_state(struct drm_plane *plane,
> +					   struct drm_plane_state *plane_state)
> +{
> +	struct drm_gem_shmem_shadow_plane_state *new_shadow_plane_state;
> +
> +	if (!plane_state)
> +		return NULL;
> +
> +	new_shadow_plane_state = kzalloc(sizeof(*new_shadow_plane_state), GFP_KERNEL);
> +	if (!new_shadow_plane_state)
> +		return NULL;
> +	__drm_atomic_helper_plane_duplicate_state(plane, &new_shadow_plane_state->base);
> +
> +	return &new_shadow_plane_state->base;
> +}
> +
> +static void drm_gem_shmem_destroy_shadow_plane_state(struct drm_plane *plane,
> +						     struct drm_plane_state *plane_state)
> +{
> +	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
> +		to_drm_gem_shmem_shadow_plane_state(plane_state);
> +
> +	__drm_atomic_helper_plane_destroy_state(&shadow_plane_state->base);
> +	kfree(shadow_plane_state);
> +}
> +
> +static void drm_gem_shmem_reset_shadow_plane(struct drm_plane *plane)
> +{
> +	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state;
> +
> +	if (plane->state) {
> +		drm_gem_shmem_destroy_shadow_plane_state(plane, plane->state);
> +		plane->state = NULL; /* must be set to NULL here */
> +	}
> +
> +	shadow_plane_state = kzalloc(sizeof(*shadow_plane_state), GFP_KERNEL);
> +	if (!shadow_plane_state)
> +		return;
> +	__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
> +}
> +
> +/*
> + * Helpers for struct drm_plane_helper_funcs
> + */
> +
> +static int drm_gem_shmem_prepare_shadow_fb(struct drm_plane *plane,
> +					   struct drm_plane_state *plane_state)
> +{
> +	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
> +		to_drm_gem_shmem_shadow_plane_state(plane_state);
> +	struct drm_framebuffer *fb = plane_state->fb;
> +	struct drm_gem_object *obj;
> +	struct dma_buf_map map;
> +	int ret;
> +	size_t i;
> +
> +	if (!fb)
> +		return 0;
> +
> +	ret = drm_gem_fb_prepare_fb(plane, plane_state);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(shadow_plane_state->map); ++i) {
> +		obj = drm_gem_fb_get_obj(fb, i);
> +		if (!obj)
> +			continue;
> +		ret = drm_gem_shmem_vmap(obj, &map);
> +		if (ret)
> +			goto err_drm_gem_shmem_vunmap;
> +		shadow_plane_state->map[i] = map;
> +	}
> +
> +	return 0;
> +
> +err_drm_gem_shmem_vunmap:
> +	while (i) {
> +		--i;
> +		obj = drm_gem_fb_get_obj(fb, i);
> +		if (!obj)
> +			continue;
> +		drm_gem_shmem_vunmap(obj, &shadow_plane_state->map[i]);
> +	}
> +	return ret;
> +}
> +
> +static void drm_gem_shmem_cleanup_shadow_fb(struct drm_plane *plane,
> +					    struct drm_plane_state *plane_state)
> +{
> +	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
> +		to_drm_gem_shmem_shadow_plane_state(plane_state);
> +	struct drm_framebuffer *fb = plane_state->fb;
> +	size_t i = ARRAY_SIZE(shadow_plane_state->map);
> +	struct drm_gem_object *obj;
> +
> +	if (!fb)
> +		return;
> +
> +	while (i) {
> +		--i;
> +		obj = drm_gem_fb_get_obj(fb, i);
> +		if (!obj)
> +			continue;
> +		drm_gem_shmem_vunmap(obj, &shadow_plane_state->map[i]);
> +	}
> +}
> +
> +/*
> + * Simple KMS helpers
> + */
> +
> +int drm_gem_shmem_simple_kms_prepare_shadow_fb(struct drm_simple_display_pipe *pipe,
> +					       struct drm_plane_state *plane_state)
> +{
> +	return drm_gem_shmem_prepare_shadow_fb(&pipe->plane, plane_state);
> +}
> +EXPORT_SYMBOL(drm_gem_shmem_simple_kms_prepare_shadow_fb);
> +
> +void drm_gem_shmem_simple_kms_cleanup_shadow_fb(struct drm_simple_display_pipe *pipe,
> +						struct drm_plane_state *plane_state)
> +{
> +	drm_gem_shmem_cleanup_shadow_fb(&pipe->plane, plane_state);
> +}
> +EXPORT_SYMBOL(drm_gem_shmem_simple_kms_cleanup_shadow_fb);
> +
> +void drm_gem_shmem_simple_kms_reset_shadow_plane(struct drm_simple_display_pipe *pipe)
> +{
> +	drm_gem_shmem_reset_shadow_plane(&pipe->plane);
> +}
> +EXPORT_SYMBOL(drm_gem_shmem_simple_kms_reset_shadow_plane);
> +
> +struct drm_plane_state *
> +drm_gem_shmem_simple_kms_duplicate_shadow_plane_state(struct drm_simple_display_pipe *pipe,
> +						      struct drm_plane_state *plane_state)
> +{
> +	return drm_gem_shmem_duplicate_shadow_plane_state(&pipe->plane, plane_state);
> +}
> +EXPORT_SYMBOL(drm_gem_shmem_simple_kms_duplicate_shadow_plane_state);
> +
> +void drm_gem_shmem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pipe *pipe,
> +							 struct drm_plane_state *plane_state)
> +{
> +	drm_gem_shmem_destroy_shadow_plane_state(&pipe->plane, plane_state);
> +}
> +EXPORT_SYMBOL(drm_gem_shmem_simple_kms_destroy_shadow_plane_state);
> diff --git a/include/drm/drm_gem_shmem_kms_helper.h b/include/drm/drm_gem_shmem_kms_helper.h
> new file mode 100644
> index 000000000000..bd42c9c0a39e
> --- /dev/null
> +++ b/include/drm/drm_gem_shmem_kms_helper.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __DRM_GEM_SHMEM_KMS_HELPER_H__
> +#define __DRM_GEM_SHMEM_KMS_HELPER_H__
> +
> +#include <linux/dma-buf-map.h>
> +
> +#include <drm/drm_plane.h>
> +
> +struct drm_simple_display_pipe;
> +
> +struct drm_gem_shmem_shadow_plane_state {
> +	struct drm_plane_state base;
> +
> +	/* Transitional state - do not export or duplicate */
> +
> +	struct dma_buf_map map[4];
> +};
> +
> +static inline struct drm_gem_shmem_shadow_plane_state *
> +to_drm_gem_shmem_shadow_plane_state(struct drm_plane_state *state)
> +{
> +	return container_of(state, struct drm_gem_shmem_shadow_plane_state, base);
> +}
> +
> +/*
> + * Simple KMS helpers
> + */
> +
> +int drm_gem_shmem_simple_kms_prepare_shadow_fb(struct drm_simple_display_pipe *pipe,
> +					       struct drm_plane_state *plane_state);
> +void drm_gem_shmem_simple_kms_cleanup_shadow_fb(struct drm_simple_display_pipe *pipe,
> +						struct drm_plane_state *plane_state);
> +void drm_gem_shmem_simple_kms_reset_shadow_plane(struct drm_simple_display_pipe *pipe);
> +struct drm_plane_state *
> +drm_gem_shmem_simple_kms_duplicate_shadow_plane_state(struct drm_simple_display_pipe *pipe,
> +						      struct drm_plane_state *plane_state);
> +void
> +drm_gem_shmem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pipe *pipe,
> +						    struct drm_plane_state *plane_state);
> +
> +/**
> + * DRM_GEM_SHMEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS -
> + *	Initializes struct drm_simple_display_pipe_funcs for SHMEM shadow planes
> + *
> + * Drivers may use GEM SHMEM BOs as shadow buffers over the framebuffer memory. This
> + * macro initializes struct drm_simple_display_pipe_funcs to use the rsp helper functions.
> + */
> +#define DRM_GEM_SHMEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS \
> +	.prepare_fb = drm_gem_shmem_simple_kms_prepare_shadow_fb, \
> +	.cleanup_fb = drm_gem_shmem_simple_kms_cleanup_shadow_fb, \
> +	.reset_plane = drm_gem_shmem_simple_kms_reset_shadow_plane, \
> +	.duplicate_plane_state = drm_gem_shmem_simple_kms_duplicate_shadow_plane_state, \
> +	.destroy_plane_state   = drm_gem_shmem_simple_kms_destroy_shadow_plane_state
> +
> +#endif /* __DRM_GEM_SHMEM_KMS_HELPER_H__ */
> -- 
> 2.30.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
