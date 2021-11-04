Return-Path: <SRS0=bIcn=PX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A96C433F5
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 17:57:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD6260D07
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 17:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FD6260D07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 283618195C;
	Thu,  4 Nov 2021 17:57:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZvrrzMzLuzyx; Thu,  4 Nov 2021 17:57:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC549818B5;
	Thu,  4 Nov 2021 17:57:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 913D2C0012;
	Thu,  4 Nov 2021 17:57:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFDFBC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 17:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 832A4818C2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 17:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KUnCTbep7lx7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 17:57:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4B21818B5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 17:57:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="231606807"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; d="scan'208";a="231606807"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 10:57:39 -0700
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; d="scan'208";a="501633554"
Received: from mihaelac-mobl.ger.corp.intel.com (HELO localhost)
 ([10.249.32.21])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 10:57:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sam Ravnborg <sam@ravnborg.org>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
In-Reply-To: <YYQaYsCr+piMlRpS@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com> <YYQaYsCr+piMlRpS@ravnborg.org>
Date: Thu, 04 Nov 2021 19:57:29 +0200
Message-ID: <87r1bvajna.fsf@intel.com>
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 Dave Airlie <airlied@redhat.com>, amd-gfx@lists.freedesktop.org,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Peter Robinson <pbrobinson@gmail.com>, nouveau@lists.freedesktop.org,
 spice-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Ben Skeggs <bskeggs@redhat.com>,
 Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
 Hans de Goede <hdegoede@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 virtualization@lists.linux-foundation.org,
 Pekka Paalanen <pekka.paalanen@collabora.com>, "Pan, 
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
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

On Thu, 04 Nov 2021, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Javier,
>
> On Thu, Nov 04, 2021 at 05:07:06PM +0100, Javier Martinez Canillas wrote:
>> Some DRM drivers check the vgacon_text_force() function return value as an
>> indication on whether they should be allowed to be enabled or not.
>> 
>> This function returns true if the nomodeset kernel command line parameter
>> was set. But there may be other conditions besides this to determine if a
>> driver should be enabled.
>> 
>> Let's add a drm_drv_enabled() helper function to encapsulate that logic so
>> can be later extended if needed, without having to modify all the drivers.
>> 
>> Also, while being there do some cleanup. The vgacon_text_force() function
>> is guarded by CONFIG_VGA_CONSOLE and there's no need for callers to do it.
>> 
>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>> ---
>> 
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index 8214a0b1ab7f..3fb567d62881 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
>> @@ -975,6 +975,26 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
>>  }
>>  EXPORT_SYMBOL(drm_dev_set_unique);
>>  
>> +/**
>> + * drm_drv_enabled - Checks if a DRM driver can be enabled
>> + * @driver: DRM driver to check
>> + *
>> + * Checks whether a DRM driver can be enabled or not. This may be the case
>> + * if the "nomodeset" kernel command line parameter is used.
>> + *
>> + * Return: 0 on success or a negative error code on failure.
>> + */
>> +int drm_drv_enabled(const struct drm_driver *driver)
>> +{
>> +	if (vgacon_text_force()) {
>> +		DRM_INFO("%s driver is disabled\n", driver->name);
>
> DRM_INFO is deprecated, please do not use it in new code.
> Also other users had an error message and not just info - is info
> enough?
>
>
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_drv_enabled);
>> +
>>  /*
>>   * DRM Core
>>   * The DRM core module initializes all global DRM objects and makes them
>> diff --git a/drivers/gpu/drm/i915/i915_module.c b/drivers/gpu/drm/i915/i915_module.c
>> index ab2295dd4500..45cb3e540eff 100644
>> --- a/drivers/gpu/drm/i915/i915_module.c
>> +++ b/drivers/gpu/drm/i915/i915_module.c
>> @@ -18,9 +18,12 @@
>>  #include "i915_selftest.h"
>>  #include "i915_vma.h"
>>  
>> +static const struct drm_driver driver;
> Hmmm...
>
>> +
>>  static int i915_check_nomodeset(void)
>>  {
>>  	bool use_kms = true;
>> +	int ret;
>>  
>>  	/*
>>  	 * Enable KMS by default, unless explicitly overriden by
>> @@ -31,7 +34,8 @@ static int i915_check_nomodeset(void)
>>  	if (i915_modparams.modeset == 0)
>>  		use_kms = false;
>>  
>> -	if (vgacon_text_force() && i915_modparams.modeset == -1)
>> +	ret = drm_drv_enabled(&driver);
>
> You pass the local driver variable here - which looks wrong as this is
> not the same as the driver variable declared in another file.

Indeed.

> Maybe move the check to new function you can add to init_funcs,
> and locate the new function in i915_drv - so it has access to driver?

We don't really want that, though. This check is pretty much as early as
it can be, and there's a ton of useless initialization that would happen
if we waited until drm_driver is available.

From my POV, drm_drv_enabled() is a solution that creates a worse
problem for us than it solves.


BR,
Jani.


>
>
> 	Sam

-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
