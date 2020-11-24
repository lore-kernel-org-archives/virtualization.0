Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C5C56202
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 21:49:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5C120715
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 21:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5C120715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADC2C869D8;
	Tue, 24 Nov 2020 21:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JnK2nuGgTcyq; Tue, 24 Nov 2020 21:49:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EED3E84415;
	Tue, 24 Nov 2020 21:49:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C73CAC163C;
	Tue, 24 Nov 2020 21:49:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F32FC0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A32084525
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V6aQhwKIgiJL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:49:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from asavdk3.altibox.net (asavdk3.altibox.net [109.247.116.14])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E57C584415
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:49:45 +0000 (UTC)
Received: from ravnborg.org (unknown [188.228.123.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by asavdk3.altibox.net (Postfix) with ESMTPS id C44342001F;
 Tue, 24 Nov 2020 22:49:42 +0100 (CET)
Date: Tue, 24 Nov 2020 22:49:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/15] drm: Move struct drm_device.pdev to legacy
Message-ID: <20201124214941.GD93095@ravnborg.org>
References: <20201124113824.19994-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201124113824.19994-1-tzimmermann@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
 a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=4J4RqmOIUAWq8pQtltYA:9
 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Cc: airlied@linux.ie, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, spice-devel@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org
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

Hi Thomas.

Nice clean-up series - quite an effort to move one member to deprecated!

I have read through most of the patches. I left a few notes in my
replies but nothing buggy. Just nitpicks.


On Tue, Nov 24, 2020 at 12:38:09PM +0100, Thomas Zimmermann wrote:
> The pdev field in struct drm_device points to a PCI device structure and
> goes back to UMS-only days when all DRM drivers where for PCI devices.
> Meanwhile we also support USB, SPI and platform devices. Each of those
> uses the generic device stored in struct drm_device.dev.
> 
> To reduce duplications and remove the special case of PCI, this patchset
> converts all modesetting drivers from pdev to dev and makes pdev a field
> for legacy UMS drivers.
> 
> For PCI devices, the pointer in struct drm_device.dev can be upcasted to
> struct pci_device; or tested for PCI with dev_is_pci(). In several places
> the code can use the dev field directly.
> 
> After converting all drivers and the DRM core, the pdev fields becomes
> only relevant for legacy drivers. In a later patchset, we may want to
> convert these as well and remove pdev entirely.
> 
> The patchset touches many files, but the individual changes are mostly
> trivial. I suggest to merge each driver's patch through the respective
> tree and later the rest through drm-misc-next.
> 
> Thomas Zimmermann (15):
>   drm/amdgpu: Remove references to struct drm_device.pdev
>   drm/ast: Remove references to struct drm_device.pdev
>   drm/bochs: Remove references to struct drm_device.pdev
>   drm/cirrus: Remove references to struct drm_device.pdev
>   drm/gma500: Remove references to struct drm_device.pdev
>   drm/hibmc: Remove references to struct drm_device.pdev
>   drm/mgag200: Remove references to struct drm_device.pdev
>   drm/qxl: Remove references to struct drm_device.pdev
>   drm/vboxvideo: Remove references to struct drm_device.pdev
>   drm/virtgpu: Remove references to struct drm_device.pdev
>   drm/vmwgfx: Remove references to struct drm_device.pdev
>   drm: Upcast struct drm_device.dev to struct pci_device; replace pdev
All above are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

>   drm/nouveau: Remove references to struct drm_device.pdev
I lost my confidence in my reading of this code.

>   drm/i915: Remove references to struct drm_device.pdev
>   drm/radeon: Remove references to struct drm_device.pdev
I did not look at these at all. I hope someone else find time to do so.

	Sam
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
