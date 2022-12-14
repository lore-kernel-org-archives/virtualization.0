Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13924C4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 11:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90FCF81E50;
	Wed, 14 Dec 2022 11:37:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90FCF81E50
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hV7wauMJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hTjpizoCESr; Wed, 14 Dec 2022 11:37:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 203A481E28;
	Wed, 14 Dec 2022 11:37:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 203A481E28
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB267C0032;
	Wed, 14 Dec 2022 11:37:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD01FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 11:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9CB14162C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 11:37:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9CB14162C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hV7wauMJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HhX8_juJnWvC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 11:37:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CEF614161C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CEF614161C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671017870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xbb/OYb347XWt0aChq9WW/A++3VBOQvZVK9Cr0CpKIU=;
 b=hV7wauMJcT32u7WGMdTfBsnHQ2QrymfsK3IoF9pWdX+bPIrwOB1+QEH7g/zIcrOI3110Ni
 72O50rpltU0L4FGT1gFPmU1BfvHalq3yD+WRtBaG+GXyTrAn6jEYVeghLldtHIJLX1v1O6
 txlGMuV9KuUkg0FLfUnjPKFG4HLvL8Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-5toDZhrIPeevAwDAJdAy_Q-1; Wed, 14 Dec 2022 06:37:49 -0500
X-MC-Unique: 5toDZhrIPeevAwDAJdAy_Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 b47-20020a05600c4aaf00b003d031aeb1b6so7097904wmp.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 03:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xbb/OYb347XWt0aChq9WW/A++3VBOQvZVK9Cr0CpKIU=;
 b=tANoXAKT2tAsXChFYgm/mcqDQxIytG+3mIbkAw/BgdiJ68v3zpZ60RHptY8ziUP6bJ
 +NcX9Qftr9YVBDtXx+19+Av3aZDMVrj1Md2exOOXEZuZ8xyg+UCei+8TYoj/QGwZNDOZ
 SgPeFf326REkBvOcEceTg+f4qnrGYOcbQI8EsmE4sHJxCLiL+myLshoDwfImM5NsKnxO
 BQbFb0e+ZUzSCAD5ySrfwywCpMoTXzYuBQSciWAW8bKcX0+0hhMfATzfsZBtpFjed0Ge
 080f+DtW22CPBiHxRMKhhtN16anZU2dbRSp6Jp+A5xhs5AVJuPx2Nnz/STausXh5OFbE
 RoWg==
X-Gm-Message-State: ANoB5pm1VrZBKvV/XQR8TeN5aix4+KmPe6LiGJEw6hhD+ESWEe1r/ARw
 065HmSia+iwzNbWVFZHLj9QeAQOFHnQFxaFA9yLSeG2xicOk4YkNGULs3BtvhCTfkXx11atMZ8h
 /H53bCpbgMd7VTF6V3AIMiU1n5oaZRpJmlsKYnUZfsQ==
X-Received: by 2002:a05:600c:1e8c:b0:3d2:381f:2db5 with SMTP id
 be12-20020a05600c1e8c00b003d2381f2db5mr2852486wmb.22.1671017868267; 
 Wed, 14 Dec 2022 03:37:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7+/bU1un/JpJM4ymOe9NfhDvrRwq4OTL101Vo082S4gqBPPhwQb2YjlTNDwe3J9cq8jj9gYA==
X-Received: by 2002:a05:600c:1e8c:b0:3d2:381f:2db5 with SMTP id
 be12-20020a05600c1e8c00b003d2381f2db5mr2852461wmb.22.1671017868013; 
 Wed, 14 Dec 2022 03:37:48 -0800 (PST)
Received: from redhat.com (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a05600c4ecc00b003cf9bf5208esm2429840wmq.19.2022.12.14.03.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 03:37:47 -0800 (PST)
Date: Wed, 14 Dec 2022 06:37:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Conghui <conghui.chen@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221214063352-mutt-send-email-mst@kernel.org>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
MIME-Version: 1.0
In-Reply-To: <20221214053631.3225164-1-conghui.chen@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: asowang@redhat.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 linux-i2c@vger.kernel.org, Jian Jun Chen <jian.jun.chen@intel.com>
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

On Wed, Dec 14, 2022 at 01:36:31PM +0800, Conghui wrote:
> This updates the maintainer for virtio i2c drvier

I got that, but what is going on here exactly?
I generally expect a new maintainer to be active in the
project for a while first.
I don't see contributions or reviews for this driver or
for that matter for any virtio or i2c drivers from Jian Jun Chen.
It looks like you are no longer interested in maintaining
this? In that case pls just send a patch removing yourself.

Jian Jun Chen, if you are interested in reviewing
patches please start doing so, you don't need to
be listed as a maintainer for this to happen.
Once you do this for a while and write some patches,
you can become a maintainer, this is not a high bar
to clear.

> Signed-off-by: Conghui <conghui.chen@intel.com>
> Acked-by: Jian Jun Chen <jian.jun.chen@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8c8f6b42436..44747f4641a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21920,7 +21920,7 @@ F:	include/uapi/linux/virtio_snd.h
>  F:	sound/virtio/*
>  
>  VIRTIO I2C DRIVER
> -M:	Conghui Chen <conghui.chen@intel.com>
> +M:	Jian Jun Chen <jian.jun.chen@intel.com>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-i2c@vger.kernel.org
>  L:	virtualization@lists.linux-foundation.org
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
