Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462D4C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 09:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C600060B74;
	Tue,  8 Nov 2022 09:34:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C600060B74
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuTBuDWc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OHhEnLJGXzz8; Tue,  8 Nov 2022 09:34:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FBC76079E;
	Tue,  8 Nov 2022 09:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FBC76079E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42B8EC0033;
	Tue,  8 Nov 2022 09:34:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76719C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:34:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57CC28188B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57CC28188B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuTBuDWc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v0MWq77vPahv
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:34:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E78E0817EB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E78E0817EB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667900044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Las2jwQInbTqaGESYtOqR8ORil6cZe276BySoHxkoJo=;
 b=YuTBuDWcbcz8d1Zj7+Es4/dgiwPJq+j94TKDaH+IpCE8ag5qaZi19wNm74Wcz3zxXMl81P
 B1xcRWe5/YJl+9A0Lb7Ml53Z5+JODfr32ykCF9jxIKeQAbbijJ7MXEXkIbWlCKHFfFwgA6
 VJIsD6lK6k71bRo2fbC2NhVGD0a60pg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-267-gefIRq9UOBKZO7-eGEuA0A-1; Tue, 08 Nov 2022 04:34:03 -0500
X-MC-Unique: gefIRq9UOBKZO7-eGEuA0A-1
Received: by mail-wm1-f70.google.com with SMTP id
 s7-20020a1cf207000000b003cf56bad2e2so3644537wmc.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 01:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Las2jwQInbTqaGESYtOqR8ORil6cZe276BySoHxkoJo=;
 b=HswkORfNDnJBZyspJZr7OcQz4F9KIXYRBJHyAyULTUyAx+/KX7lA8KdmgVEykh/8BE
 CO68LK7ZTSfn6fIeFdsd6UvoOiOyUqP7FrwE0KtZGImHcbxyw8TdVkINroFnUckEqkru
 loyrcZ1+9vjWx2RlkcWa0LSNp4H6MPlacfSkxpp/x8cZGSof9Cei9eYm+rufWHD47hci
 dcGBRdGulYWRBIQiImiSxBG52uxcg3Zc+vF3whWSO8bdzQveeN5mrsaj9IzD38+5yBKh
 43EZ9D599txEfZdF394rIrIEag9AOzQSJ5eWdODaDBXYZhx4/ElzGZvn0IcbEUSBhzrY
 I5yw==
X-Gm-Message-State: ACrzQf0782phtVqX1RiLx3kbM/WRW6UShs/xoh7oC/kF4c6bN6zflO5r
 FCGRH8gzowpI1zVDbHmC/844rgaJ7075UOTim/XMGXBk4mMYLkLu5gayJTWY8APQwaX4j/J2RGc
 aBS2zpnuLSa2KKJ10GNsThbnamnT1SQn7Swz8AzSw4A==
X-Received: by 2002:a05:6000:114e:b0:236:f365:b769 with SMTP id
 d14-20020a056000114e00b00236f365b769mr20584812wrx.266.1667900042449; 
 Tue, 08 Nov 2022 01:34:02 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7PUbxzyZyAh4lu3TeI5npdnQRCKbagPaMHNYMKPGGmR4cOee7DVWQzcDxDyrBEiBASAFOWdQ==
X-Received: by 2002:a05:6000:114e:b0:236:f365:b769 with SMTP id
 d14-20020a056000114e00b00236f365b769mr20584800wrx.266.1667900042228; 
 Tue, 08 Nov 2022 01:34:02 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 p20-20020a05600c359400b003a6a3595edasm11355392wmq.27.2022.11.08.01.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 01:34:01 -0800 (PST)
Date: Tue, 8 Nov 2022 10:33:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Yuan Can <yuancan@huawei.com>
Subject: Re: [PATCH] vhost/vsock: Fix error handling in vhost_vsock_init()
Message-ID: <20221108093358.4knnc6tlts7sm7a6@sgarzare-redhat>
References: <20221108091357.115738-1-yuancan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221108091357.115738-1-yuancan@huawei.com>
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

On Tue, Nov 08, 2022 at 09:13:57AM +0000, Yuan Can wrote:
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

Thanks for this fix!

>
>Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")

Is this the right tag?

It seems to me that since the introduction of vhost-vsock we have the 
same problem (to be solved differently, because with the introduction of 
multi-transport we refactored the initialization functions).

So should we use 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")?

Thanks,
Stefano

>Signed-off-by: Yuan Can <yuancan@huawei.com>
>---
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
