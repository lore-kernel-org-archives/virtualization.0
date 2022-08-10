Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E84BC25B07
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 16:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87F2140B6D;
	Wed, 10 Aug 2022 16:40:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87F2140B6D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=bFZVxwML
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GBmGwoONR8R4; Wed, 10 Aug 2022 16:40:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B69EC4018B;
	Wed, 10 Aug 2022 16:40:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B69EC4018B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 971F0C0032;
	Wed, 10 Aug 2022 16:40:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E8C8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE5C64148A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:40:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE5C64148A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=bFZVxwML
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M1MibSHc3grg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:40:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1515F40871
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1515F40871
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 16:40:29 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id
 i128-20020a1c3b86000000b003a536d58f73so1288416wma.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc;
 bh=KbtX/yuBejcio58S+wA08Oms/h9KupDVKtGMajir+nI=;
 b=bFZVxwML6mJ3CaDiAs9wOS/e9YwKjLEAUCUxScTXUw6F4xTgGbQyc3H64MGuPB/LKL
 yYe3gpoolXAbjnr/G7PT8nvgLnOYr7GkZ6vN/Kqt4wz+7XIuBIbwZXFToF78XtxpGXt4
 buGP/phsMI9Zcp9iPALfZ+I3HEGo6oRnrIMFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=KbtX/yuBejcio58S+wA08Oms/h9KupDVKtGMajir+nI=;
 b=jYyeTv9yOLODLDyONF3Bje1SSRu+DpJGlipXsQpzTEQFjmHvQqBhE0WWtIEnqzBFMX
 LGKUeh5B+4l838+qPoL49+iWy0g+tPK05NUUW9LN1cox8uHGa4MMGuyoQjIRGFGb/AA0
 EBnLP1U79N1iApV4yB8QtvM3yIIEWU8LNJR1Npqa/4z7bFMsHB5FAmJB3Jbckvuv65A5
 gYFhHI+B3tsF1YpIoG7OvhGNwnqRjr8s5V5TcHj6SdKdH6cPdNyQKhmfRVz8u8OvTarM
 t85Ax7Io6w/bTiKSU+0FBcz6mo30pN264N4oQGVT61mRLsTh0J1F3Km0GB2LA7w5DcNA
 dPQQ==
X-Gm-Message-State: ACgBeo3yVevwU/d1qIznzESU2rQEJBAkdkQ1O9oQam7zJQAuKTPbsq6A
 nUDvLkyGdL7VU08VR/RvhAZhVQ==
X-Google-Smtp-Source: AA6agR7OR5/6haEXj6Lu6d3vuxWkNY4kjEAXIlDMT8rqpnv17ZQu4lO/cHbzlO/KWtmhX8LvlvXJAQ==
X-Received: by 2002:a1c:7508:0:b0:3a5:923:3994 with SMTP id
 o8-20020a1c7508000000b003a509233994mr2991924wmc.173.1660149628232; 
 Wed, 10 Aug 2022 09:40:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 e3-20020adf9bc3000000b0020e6ce4dabdsm16817466wrc.103.2022.08.10.09.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 09:40:27 -0700 (PDT)
Date: Wed, 10 Aug 2022 18:40:25 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Zack Rusin <zackr@vmware.com>
Subject: Re: [PATCH v2 1/8] drm: Disable the cursor plane on atomic contexts
 with virtualized drivers
Message-ID: <YvPfedG/uLQNFG7e@phenom.ffwll.local>
References: <20220712033246.1148476-1-zack@kde.org>
 <20220712033246.1148476-2-zack@kde.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220712033246.1148476-2-zack@kde.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Hans de Goede <hdegoede@redhat.com>, David Airlie <airlied@linux.ie>,
 contact@emersion.fr, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 stable@vger.kernel.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 krastevm@vmware.com, ppaalanen@gmail.com, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, spice-devel@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org,
 Chia-I Wu <olvaffe@gmail.com>, mombasawalam@vmware.com
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

On Mon, Jul 11, 2022 at 11:32:39PM -0400, Zack Rusin wrote:
> From: Zack Rusin <zackr@vmware.com>
> 
> Cursor planes on virtualized drivers have special meaning and require
> that the clients handle them in specific ways, e.g. the cursor plane
> should react to the mouse movement the way a mouse cursor would be
> expected to and the client is required to set hotspot properties on it
> in order for the mouse events to be routed correctly.
> 
> This breaks the contract as specified by the "universal planes". Fix it
> by disabling the cursor planes on virtualized drivers while adding
> a foundation on top of which it's possible to special case mouse cursor
> planes for clients that want it.
> 
> Disabling the cursor planes makes some kms compositors which were broken,
> e.g. Weston, fallback to software cursor which works fine or at least
> better than currently while having no effect on others, e.g. gnome-shell
> or kwin, which put virtualized drivers on a deny-list when running in
> atomic context to make them fallback to legacy kms and avoid this issue.
> 
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> Fixes: 681e7ec73044 ("drm: Allow userspace to ask for universal plane list (v2)")
> Cc: <stable@vger.kernel.org> # v5.4+
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/drm_plane.c          | 11 +++++++++++
>  drivers/gpu/drm/qxl/qxl_drv.c        |  2 +-
>  drivers/gpu/drm/vboxvideo/vbox_drv.c |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.c |  3 ++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c  |  2 +-
>  include/drm/drm_drv.h                | 10 ++++++++++
>  include/drm/drm_file.h               | 12 ++++++++++++
>  7 files changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 726f2f163c26..e1e2a65c7119 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -667,6 +667,17 @@ int drm_mode_getplane_res(struct drm_device *dev, void *data,
>  		    !file_priv->universal_planes)
>  			continue;
>  
> +		/*
> +		 * Unless userspace supports virtual cursor plane
> +		 * then if we're running on virtual driver do not
> +		 * advertise cursor planes because they'll be broken
> +		 */
> +		if (plane->type == DRM_PLANE_TYPE_CURSOR &&
> +		    drm_core_check_feature(dev, DRIVER_VIRTUAL)	&&
> +		    file_priv->atomic &&
> +		    !file_priv->supports_virtual_cursor_plane)
> +			continue;
> +
>  		if (drm_lease_held(file_priv, plane->base.id)) {
>  			if (count < plane_resp->count_planes &&
>  			    put_user(plane->base.id, plane_ptr + count))
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 1cb6f0c224bb..0e4212e05caa 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -281,7 +281,7 @@ static const struct drm_ioctl_desc qxl_ioctls[] = {
>  };
>  
>  static struct drm_driver qxl_driver = {
> -	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> +	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_VIRTUAL,
>  
>  	.dumb_create = qxl_mode_dumb_create,
>  	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> index f4f2bd79a7cb..84e75bcc3384 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> @@ -176,7 +176,7 @@ DEFINE_DRM_GEM_FOPS(vbox_fops);
>  
>  static const struct drm_driver driver = {
>  	.driver_features =
> -	    DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
> +	    DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC | DRIVER_VIRTUAL,
>  
>  	.lastclose = drm_fb_helper_lastclose,
>  
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index 5f25a8d15464..3c5bb006159a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -198,7 +198,8 @@ MODULE_AUTHOR("Alon Levy");
>  DEFINE_DRM_GEM_FOPS(virtio_gpu_driver_fops);
>  
>  static const struct drm_driver driver = {
> -	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC,
> +	.driver_features =
> +		DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_VIRTUAL,
>  	.open = virtio_gpu_driver_open,
>  	.postclose = virtio_gpu_driver_postclose,
>  
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> index 01a5b47e95f9..712f6ad0b014 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1581,7 +1581,7 @@ static const struct file_operations vmwgfx_driver_fops = {
>  
>  static const struct drm_driver driver = {
>  	.driver_features =
> -	DRIVER_MODESET | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_GEM,
> +	DRIVER_MODESET | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_GEM | DRIVER_VIRTUAL,
>  	.ioctls = vmw_ioctls,
>  	.num_ioctls = ARRAY_SIZE(vmw_ioctls),
>  	.master_set = vmw_master_set,
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index f6159acb8856..c4cd7fc350d9 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -94,6 +94,16 @@ enum drm_driver_feature {
>  	 * synchronization of command submission.
>  	 */
>  	DRIVER_SYNCOBJ_TIMELINE         = BIT(6),
> +	/**
> +	 * @DRIVER_VIRTUAL:
> +	 *
> +	 * Driver is running on top of virtual hardware. The most significant
> +	 * implication of this is a requirement of special handling of the
> +	 * cursor plane (e.g. cursor plane has to actually track the mouse
> +	 * cursor and the clients are required to set hotspot in order for
> +	 * the cursor planes to work correctly).
> +	 */
> +	DRIVER_VIRTUAL                  = BIT(7),

I think the naming here is unfortunate, because people will vonder why
e.g. vkms doesn't set this, and then add it, and confuse stuff completely.

Also it feels a bit wrong to put this onto the driver, when really it's a
cursor flag. I guess you can make it some kind of flag in the drm_plane
structure, or a new plane type, but putting it there instead of into the
"random pile of midlayer-mistake driver flags" would be a lot better.

Otherwise I think the series looks roughly how I'd expect it to look.
-Daniel

>  
>  	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
>  
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index e0a73a1e2df7..3e5c36891161 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -223,6 +223,18 @@ struct drm_file {
>  	 */
>  	bool is_master;
>  
> +	/**
> +	 * @supports_virtual_cursor_plane:
> +	 *
> +	 * This client is capable of handling the cursor plane with the
> +	 * restrictions imposed on it by the virtualized drivers.
> +	 *
> +	 * The implies that the cursor plane has to behave like a cursor
> +	 * i.e. track cursor movement. It also requires setting of the
> +	 * hotspot properties by the client on the cursor plane.
> +	 */
> +	bool supports_virtual_cursor_plane;
> +
>  	/**
>  	 * @master:
>  	 *
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
