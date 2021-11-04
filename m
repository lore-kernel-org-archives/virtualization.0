Return-Path: <SRS0=bIcn=PX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A892C43219
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 19:57:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0067B60ED5
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 19:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0067B60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD13160B61;
	Thu,  4 Nov 2021 19:57:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ym01BSboG7AY; Thu,  4 Nov 2021 19:57:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 52F1060B5A;
	Thu,  4 Nov 2021 19:57:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31EF8C0012;
	Thu,  4 Nov 2021 19:57:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75A10C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 19:57:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55DB7403AF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 19:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3jD3TlTlCIdD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 19:57:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9ED3E402D7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 19:57:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="292618577"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; d="scan'208";a="292618577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 12:57:18 -0700
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; d="scan'208";a="501676017"
Received: from mihaelac-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.32.21])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 12:57:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
In-Reply-To: <20211104160707.1407052-2-javierm@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com>
Date: Thu, 04 Nov 2021 21:57:08 +0200
Message-ID: <87ilx7ae3v.fsf@intel.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Javier Martinez Canillas <javierm@redhat.com>, amd-gfx@lists.freedesktop.org,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Peter Robinson <pbrobinson@gmail.com>, nouveau@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Ben Skeggs <bskeggs@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 virtualization@lists.linux-foundation.org,
 Pekka Paalanen <pekka.paalanen@collabora.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, spice-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 intel-gfx@lists.freedesktop.org,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 Zack Rusin <zackr@vmware.com>
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

On Thu, 04 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
> +/**
> + * drm_drv_enabled - Checks if a DRM driver can be enabled
> + * @driver: DRM driver to check
> + *
> + * Checks whether a DRM driver can be enabled or not. This may be the case
> + * if the "nomodeset" kernel command line parameter is used.
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int drm_drv_enabled(const struct drm_driver *driver)
> +{
> +	if (vgacon_text_force()) {
> +		DRM_INFO("%s driver is disabled\n", driver->name);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_drv_enabled);

The name implies a bool return, but it's not.

	if (drm_drv_enabled(...)) {
		/* surprise, it's disabled! */
	}


BR,
Jani.



-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
