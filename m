Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D240EC2BB41
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 08:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 54DAB408A8;
	Tue, 16 Aug 2022 08:27:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54DAB408A8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GIpurIl3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HrR_Qvm17SpR; Tue, 16 Aug 2022 08:27:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CC0CC40635;
	Tue, 16 Aug 2022 08:27:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC0CC40635
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B710C0033;
	Tue, 16 Aug 2022 08:27:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6D97C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B16398142E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:27:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B16398142E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GIpurIl3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t9axGzVT-5QD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:27:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FC6E813F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FC6E813F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660638426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xlaUERvp+zs5kPw+c06DNvHieNVGFOSBUrox4OfWakY=;
 b=GIpurIl36BY2mpOU0Lrk+8h7sV0JgAdKhTgR2LacF9A3Qy6ncAUqsyQWu38sYczL5bajlD
 DLYOb9Fv6od+ZLpo5L08TzRzrOEFwpRymh201ayCd4YHJPgvcyE3lgdZNNVW/SvprF4MXt
 G765j1uYj6YBvjKlnccLkmruI6u6MdA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-388-o1szGK8nOV2CFVm-q0pNrA-1; Tue, 16 Aug 2022 04:27:04 -0400
X-MC-Unique: o1szGK8nOV2CFVm-q0pNrA-1
Received: by mail-wr1-f70.google.com with SMTP id
 r17-20020adfa151000000b00224f8e2a2edso1235212wrr.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 01:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=xlaUERvp+zs5kPw+c06DNvHieNVGFOSBUrox4OfWakY=;
 b=lJ/WJYMAHOecknaK03eUjCNNQRyuzM63e/izkPWvmv3nYg1ED+9IpyA7eZrVV6DIYd
 cSuArcR8jC9t66M1AwpqfAWgjXKGjqhboqIkNtaCop+Z56dyhxIxiYQ6ETZw+5XjPn0e
 70cNPJxabpeFY3r6QNWiB8YZ/z17cf+5GcjuEKiS2S8qqz8fMGlevjYhKe2aNbT0ZCPi
 CmY6RAWzDGAMr8CvtBNkPNEUrrBU7yzjMA4jvf972nEO2dDP9pF7VC0NxSuA4OMsuYSb
 DSSntMS93ziXUswFM66aUO3q+f22Igx+DTvHyyoeDpOCZ62bCoCp3tiA19gsZCJ0glOY
 wd8Q==
X-Gm-Message-State: ACgBeo2tGRweedaldNB1in9o85WpdFNc9ezfGXVKc0fBU9WZIo/ugGlW
 xr3Fb1rUB3QuqFtav7I2ua8F75r12P1YPIE4NtIxI7C92HnedeBla4d183bhEpfLNEUKXHph4g/
 gYHFB5wlMua5M+0du7HutjkrJZ4qeNeU9SaR42QE7gw==
X-Received: by 2002:a1c:f217:0:b0:3a4:bfd4:21b4 with SMTP id
 s23-20020a1cf217000000b003a4bfd421b4mr12126489wmc.96.1660638423636; 
 Tue, 16 Aug 2022 01:27:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7Dx1479h2uT2MEAR+v1zdQYYNdERgRPEwjdOVBT7N7cS7NDq85P51eBVJafCyj3BeyQrMa3w==
X-Received: by 2002:a1c:f217:0:b0:3a4:bfd4:21b4 with SMTP id
 s23-20020a1cf217000000b003a4bfd421b4mr12126483wmc.96.1660638423457; 
 Tue, 16 Aug 2022 01:27:03 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c3b8600b003a608d69a64sm1119994wms.21.2022.08.16.01.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Aug 2022 01:27:03 -0700 (PDT)
Date: Tue, 16 Aug 2022 04:26:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] vduse:  Remove include of rwlock.h
Message-ID: <20220816042557-mutt-send-email-mst@kernel.org>
References: <20220816074816.173227-1-bigeasy@linutronix.de>
MIME-Version: 1.0
In-Reply-To: <20220816074816.173227-1-bigeasy@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xie Yongji <xieyongji@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, Aug 16, 2022 at 09:48:16AM +0200, Sebastian Andrzej Siewior wrote:
> rwlock.h should not be included directly. Instead linux/splinlock.h
> should be included. Including it directly will break the RT build.
> 
> Remove the rwlock.h include.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

in fact


#ifndef __LINUX_SPINLOCK_H
# error "please don't include this file directly"
#endif

I wonder how does it build.


> ---
>  drivers/vdpa/vdpa_user/iova_domain.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
> index 4e0e50e7ac153..173e979b84a93 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -14,7 +14,6 @@
>  #include <linux/iova.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/vhost_iotlb.h>
> -#include <linux/rwlock.h>
>  
>  #define IOVA_START_PFN 1
>  
> -- 
> 2.37.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
