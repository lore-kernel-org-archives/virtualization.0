Return-Path: <SRS0=YXi0=PY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A51C433F5
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 10:05:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603696128E
	for <virtualization@archiver.kernel.org>; Fri,  5 Nov 2021 10:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 603696128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20A1D61511;
	Fri,  5 Nov 2021 10:05:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WOcw6-ssX4SR; Fri,  5 Nov 2021 10:05:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C6B1B60633;
	Fri,  5 Nov 2021 10:05:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABDCAC0019;
	Fri,  5 Nov 2021 10:05:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34654C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 10:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 143EB6062E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 10:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spgaeKru9mcG
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 10:04:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 811A660633
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Nov 2021 10:04:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="318076605"
X-IronPort-AV: E=Sophos;i="5.87,211,1631602800"; d="scan'208";a="318076605"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2021 03:04:57 -0700
X-IronPort-AV: E=Sophos;i="5.87,211,1631602800"; d="scan'208";a="501887624"
Received: from jprisaca-mobl.ger.corp.intel.com (HELO localhost)
 ([10.251.214.70])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2021 03:04:51 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm: Add a drm_drv_enabled() to check if drivers
 should be enabled
In-Reply-To: <38dbcc8f-2f95-6846-537f-9b85468bfa87@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20211104160707.1407052-1-javierm@redhat.com>
 <20211104160707.1407052-2-javierm@redhat.com> <87ilx7ae3v.fsf@intel.com>
 <0c07f121-42d3-9f37-1e14-842fb685b501@redhat.com>
 <d4a64906-69e5-3250-2362-79f2afac0a23@suse.de>
 <38dbcc8f-2f95-6846-537f-9b85468bfa87@redhat.com>
Date: Fri, 05 Nov 2021 12:04:48 +0200
Message-ID: <877ddmapfj.fsf@intel.com>
MIME-Version: 1.0
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Hans de Goede <hdegoede@redhat.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, amd-gfx@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Ben Skeggs <bskeggs@redhat.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 spice-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 virtualization@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org,
 Michel =?utf-8?Q?D?= =?utf-8?Q?=C3=A4nzer?= <michel@daenzer.net>,
 Peter Robinson <pbrobinson@gmail.com>
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

On Fri, 05 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
> Hello Thomas,
>
> On 11/5/21 09:43, Thomas Zimmermann wrote:
>> Hi
>> 
>> Am 04.11.21 um 21:09 schrieb Javier Martinez Canillas:
>>> Hello Jani,
>>>
>>> On 11/4/21 20:57, Jani Nikula wrote:
>>>> On Thu, 04 Nov 2021, Javier Martinez Canillas <javierm@redhat.com> wrote:
>>>>> +/**
>>>>> + * drm_drv_enabled - Checks if a DRM driver can be enabled
>>>>> + * @driver: DRM driver to check
>>>>> + *
>>>>> + * Checks whether a DRM driver can be enabled or not. This may be the case
>>>>> + * if the "nomodeset" kernel command line parameter is used.
>>>>> + *
>>>>> + * Return: 0 on success or a negative error code on failure.
>>>>> + */
>>>>> +int drm_drv_enabled(const struct drm_driver *driver)
>> 
>> Jani mentioned that i915 absolutely wants this to run from the 
>> module_init function. Best is to drop the parameter.
>>
>
> Ok. I now wonder though how much value would add this function since
> it will just be a wrapper around the nomodeset check.
>
> We talked about adding a new DRIVER_GENERIC feature flag and check for
> this, but as danvet mentioned that is not really needed. We just need
> to avoid testing for nomodeset in the simpledrm driver.
>
> Do you envision other condition that could be added later to disable a
> DRM driver ? Or do you think that just from a code readability point of
> view makes worth it ?

Taking a step back for perspective.

I think there's broad consensus in moving the parameter to drm, naming
the check function to drm_something_something(), and breaking the ties
to CONFIG_VGA_CONSOLE. I appreciate the work you're doing to that
effect.

I think everything beyond that is still a bit vague and/or
contentious. So how about making the first 2-3 patches just that?
Something we can all agree on, makes good progress, improves the kernel,
and gives us something to build on?

BR,
Jani.


>
>>>>> +{
>>>>> +	if (vgacon_text_force()) {
>>>>> +		DRM_INFO("%s driver is disabled\n", driver->name);
>>>>> +		return -ENODEV;
>>>>> +	}
>> 
>> If we run this from within a module_init function, we'd get plenty of 
>> these warnings if drivers are compiled into the kernel. Maybe simply 
>> remove the message. There's already a warning printed by the nomodeset 
>> handler.
>>
>
> Indeed. I'll just drop it.
>
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL(drm_drv_enabled);
>>>>
>>>> The name implies a bool return, but it's not.
>>>>
>>>> 	if (drm_drv_enabled(...)) {
>>>> 		/* surprise, it's disabled! */
>>>> 	}
>>>>
>>>
>>> It used to return a bool in v2 but Thomas suggested an int instead to
>>> have consistency on the errno code that was returned by the callers.
>>>
>>> I should probably name that function differently to avoid confusion.
>> 
>> Yes, please.
>>
>
> drm_driver_check() maybe ?
>  
> Best regards,

-- 
Jani Nikula, Intel Open Source Graphics Center
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
