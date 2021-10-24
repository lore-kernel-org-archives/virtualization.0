Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183CAC433EF
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 08:31:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0B160F0F
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 08:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC0B160F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DD3580DC8;
	Sun, 24 Oct 2021 08:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A9qR3m25GTH0; Sun, 24 Oct 2021 08:31:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 28A4780DDB;
	Sun, 24 Oct 2021 08:31:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E50ACC0012;
	Sun, 24 Oct 2021 08:31:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4F99C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB32440333
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AAzWc8QTh1r1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:31:13 +0000 (UTC)
X-Greylist: delayed 00:05:53 by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E26FC40326
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fwJDIpeHcoTCjW6d/WqsB8/Thoo6o3AVkcfg+s98K0I=; b=qehNJuPVO9T/ZFjxGZ8o0QEU7g
 SUqvQak6gweJzXhpOH25ANz86m7hjBj9YiBeupYHPY8ns9hKV6fkmqYlxtQotrx0MoFEwYPU0bKBM
 oN1lzdHLNYuuPdAQnyJUaleZM4aUqb8Ef+Azn9F388Q9Eg/iZUiKOkV1HgnWa05yMfqnrHOjTX69r
 KLhvaUxHOSzuA/S1TB7N+pqUI9nyiE0brWZC5bo0sqdGZxHfLXuYdbleH9ZVq11T8mFlb7yVvhDN0
 h8Ktf9+/tXJoM2whsU8hFEYwMKhLCu2AKcjRK9o6EHZ7eyf/LBEjUSJxrijxXcbYKosnBoylPY0Gh
 i5lNMmEw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:56181
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1meYof-0005AL-35; Sun, 24 Oct 2021 10:25:17 +0200
Subject: Re: [PATCH 1/9] drm/format-helper: Export drm_fb_clip_offset()
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211022132829.7697-1-tzimmermann@suse.de>
 <20211022132829.7697-2-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <6ed5fba0-72d5-7fb8-338c-230bf69e2c03@tronnes.org>
Date: Sun, 24 Oct 2021 10:25:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022132829.7697-2-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
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



Den 22.10.2021 15.28, skrev Thomas Zimmermann:
> Provide a function that computes the offset into a blit destination
> buffer. This will allow to move destination-buffer clipping into the
> format-helper callers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 10 ++++++++--
>  include/drm/drm_format_helper.h     |  4 ++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 69fde60e36b3..28e9d0d89270 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -17,12 +17,18 @@
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_rect.h>
>  
> -static unsigned int clip_offset(struct drm_rect *clip,
> -				unsigned int pitch, unsigned int cpp)
> +static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
>  {
>  	return clip->y1 * pitch + clip->x1 * cpp;
>  }
>  
> +unsigned long drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,

Like Sam I wonder about the unsigned long here.

Noralf.

> +				 const struct drm_rect *clip)
> +{
> +	return clip_offset(clip, pitch, format->cpp[0]);
> +}
> +EXPORT_SYMBOL(drm_fb_clip_offset);
> +

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
