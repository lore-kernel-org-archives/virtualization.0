Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DC5C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 18:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D8F281421;
	Mon,  8 Aug 2022 18:45:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1D8F281421
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ravnborg.org header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=GtQqhoHA;
	dkim=fail reason="signature verification failed" header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256 header.s=ed1 header.b=Lg6i8ut8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0w8xVxIl_RjO; Mon,  8 Aug 2022 18:45:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B53B0813D5;
	Mon,  8 Aug 2022 18:45:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B53B0813D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BD06C0033;
	Mon,  8 Aug 2022 18:45:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A60EFC0033
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 714EA40358
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 714EA40358
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ravnborg.org
 header.i=@ravnborg.org header.a=rsa-sha256 header.s=rsa1 header.b=GtQqhoHA; 
 dkim=pass header.d=ravnborg.org header.i=@ravnborg.org header.a=ed25519-sha256
 header.s=ed1 header.b=Lg6i8ut8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 28tBe3jqsJk6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:45:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A43240357
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com
 (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A43240357
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=znjEl5VfC+8Kaxye8Js4NPDQxl9vLldFAak2/swvHqo=;
 b=GtQqhoHAZQN5+X66fu82JLWoBx6jsaDo4f6PJOQWpzMMwn0uSiyDxqatFus+UHqprWZc4XQy6bfPk
 aJ6/vEpGo9oRO0A+FM4E1wzKwpuD/B6Cdo//NkGSnMjp0ctS2yJuf/7l7usDfVzTZBKHf7I+JDwwxy
 08D55tBMGKczIpUh/c6rsayjD/gc/lVV3XDq1+FA1GniotyHiiFITWMSzHvjwtqI0i3d4MEcPdpHR1
 U6QeRKxUaB/2VmDanQOwhzFLi2k+xrkr/XPZ9YQ4BBB+qjUau8z4MPclwrxby8ManSEVRpYS4hIIyB
 Gyn4X8iHzWeqiUIs7qSkEGRbEhcXe6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=znjEl5VfC+8Kaxye8Js4NPDQxl9vLldFAak2/swvHqo=;
 b=Lg6i8ut8jnH97SkyD0rutzDuY6+02W2opCKRClkUXVgv9giahUcr4WCo35+sMkDbkIRWD/02IUp5A
 cOMNZRaDQ==
X-HalOne-Cookie: 86a13594f40cf3c3d336840213eb4d6a9dddbf2f
X-HalOne-ID: 3c007d1e-174a-11ed-be82-d0431ea8bb03
Received: from mailproxy3.cst.dirpod3-cph3.one.com
 (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
 id 3c007d1e-174a-11ed-be82-d0431ea8bb03;
 Mon, 08 Aug 2022 18:45:12 +0000 (UTC)
Date: Mon, 8 Aug 2022 20:45:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 04/14] drm/format-helper: Convert drm_fb_swab() to
 struct iosys_map
Message-ID: <YvFZtnKaeOoDSCVD@ravnborg.org>
References: <20220808125406.20752-1-tzimmermann@suse.de>
 <20220808125406.20752-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220808125406.20752-5-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, david@lechnology.com, airlied@linux.ie,
 lucas.demarchi@intel.com, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, javierm@redhat.com, mripard@kernel.org,
 virtualization@lists.linux-foundation.org, drawat.floss@gmail.com,
 noralf@tronnes.org, daniel@ffwll.ch, jose.exposito89@gmail.com
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

Hi Thomas,

On Mon, Aug 08, 2022 at 02:53:56PM +0200, Thomas Zimmermann wrote:
> Convert drm_fb_swab() to use struct iosys_map() and convert users. The
> new interface supports multi-plane color formats, but implementation
> only supports a single plane for now.
> 
> v2:
> 	* use drm_format_info_bpp() (Sam)
> 	* update documentation (Sam)
> 	* add TODO on vaddr location (Sam)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
