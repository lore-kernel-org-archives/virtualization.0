Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDE3C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 10:24:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0AE87408B7;
	Tue,  8 Nov 2022 10:24:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AE87408B7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CjaDmi4y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXR-aziHzXiR; Tue,  8 Nov 2022 10:24:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82CE8402DC;
	Tue,  8 Nov 2022 10:24:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82CE8402DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A8DFC0032;
	Tue,  8 Nov 2022 10:24:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E22FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A82180FB9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:24:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A82180FB9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CjaDmi4y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nqqQSCUF_Zp4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:24:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8ECB281452
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8ECB281452
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667903065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V0f6miHyfdXlJNB+m5URvLSjup5N3IeFlLnjD/c/Qow=;
 b=CjaDmi4y38HkQGWPIVIl9Q4tITaVICvfuKjBgoXm2JCrULlWnMzrI3U9DcFPx9xXkMZOJI
 6xeFPEJDYCyMNG05514nSikcDtYEyL54c4LT9a/oEXQaHoU22iVvw1xqQ49bYWj2qfQNMh
 kAMM+OYoWJX02qUzOKn3XnDtFlb3mWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-403-iq6bhhdRMzClJu4MXWIYNg-1; Tue, 08 Nov 2022 05:24:24 -0500
X-MC-Unique: iq6bhhdRMzClJu4MXWIYNg-1
Received: by mail-wr1-f71.google.com with SMTP id
 j20-20020adfb314000000b002366d9f67aaso3798529wrd.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 02:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0f6miHyfdXlJNB+m5URvLSjup5N3IeFlLnjD/c/Qow=;
 b=D94i85YrJ5V1eYsxxNucFnyF/QqFDLFNugxHGS9UO2sNYHb62uRCcXUvbDXA2OX8UA
 u9mG93gTjp4XWrMW8NNzlpleB5AFSvxLlwSU0t+DwShhc2Sw63ahHG6SqSgrNHApqp5c
 oQDosUwro6oTK3KwRJ8+6PaxqCIZpIiiZFaOZpxvLWwqlQqYPT3JmOUfNmVyEtO8NioX
 1et5lgq1uRiy+CQffZQHFAukFrO020mZZhCZFBzI6sM+i/A38pSrQDkor41ed46rO6++
 8skCtOVggIZh+aOOFKRN2zGJT0s4jYlGqrjeYvnSKeh4ZmZKlQ2XzeEorhOQt4fx+4GR
 Hy/A==
X-Gm-Message-State: ACrzQf1aZ/Glhxoyzamhh/3PVTdykmjn4hxcedu+rODV/ms7GZObwZOh
 6kBSgRFtWFwv+H+erdROSfJd3tQDGg2YOmik0pxQSsECoAx9coQP9HYC69erL5fyhmsRrhuYZI5
 64Ry0a7h/9dOu6c3PSrbRvl5VGqeMEahBk+nPEHq+RA==
X-Received: by 2002:a05:600c:2242:b0:3cf:4ccc:7418 with SMTP id
 a2-20020a05600c224200b003cf4ccc7418mr45909506wmm.191.1667903063322; 
 Tue, 08 Nov 2022 02:24:23 -0800 (PST)
X-Google-Smtp-Source: AMsMyM63jNoqd/VARfO8cpeBbtfv5zYnABJ0tzkSvzQF3g0iN4WYdzewkQNJ5FZQKIEXIt6HCSt8Lw==
X-Received: by 2002:a05:600c:2242:b0:3cf:4ccc:7418 with SMTP id
 a2-20020a05600c224200b003cf4ccc7418mr45909493wmm.191.1667903063122; 
 Tue, 08 Nov 2022 02:24:23 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 f10-20020a05600c154a00b003a2f2bb72d5sm19230518wmg.45.2022.11.08.02.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 02:24:22 -0800 (PST)
Date: Tue, 8 Nov 2022 11:24:19 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yuan Can <yuancan@huawei.com>
Subject: Re: [PATCH v2] vhost/vsock: Fix error handling in vhost_vsock_init()
Message-ID: <20221108102419.tq4veo3h4xj3jr46@sgarzare-redhat>
References: <20221108101705.45981-1-yuancan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221108101705.45981-1-yuancan@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 davem@davemloft.net
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 08, 2022 at 10:17:05AM +0000, Yuan Can wrote:
>A problem about modprobe vhost_vsock failed is triggered with the
>following log given:
>
>modprobe: ERROR: could not insert 'vhost_vsock': Device or resource busy
>
>The reason is that vhost_vsock_init() returns misc_register() directly
>without checking its return value, if misc_register() failed, it returns
>without calling vsock_core_unregister() on vhost_transport, resulting the
>vhost_vsock can never be installed later.
>A simple call graph is shown as below:
>
> vhost_vsock_init()
>   vsock_core_register() # register vhost_transport
>   misc_register()
>     device_create_with_groups()
>       device_create_groups_vargs()
>         dev = kzalloc(...) # OOM happened
>   # return without unregister vhost_transport
>
>Fix by calling vsock_core_unregister() when misc_register() returns error.
>
>Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
>Signed-off-by: Yuan Can <yuancan@huawei.com>
>---
>Changes in v2:
>- change to the correct Fixes: tag

I forgot to mention that anyway the patch was okay for me :-) and so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
> drivers/vhost/vsock.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 5703775af129..10a7d23731fe 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -959,7 +959,14 @@ static int __init vhost_vsock_init(void)
> 				  VSOCK_TRANSPORT_F_H2G);
> 	if (ret < 0)
> 		return ret;
>-	return misc_register(&vhost_vsock_misc);
>+
>+	ret = misc_register(&vhost_vsock_misc);
>+	if (ret) {
>+		vsock_core_unregister(&vhost_transport.transport);
>+		return ret;
>+	}
>+
>+	return 0;
> };
>
> static void __exit vhost_vsock_exit(void)
>-- 
>2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
