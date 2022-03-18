Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BA2C433F5
	for <virtualization@archiver.kernel.org>; Fri, 18 Mar 2022 09:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA35960BAE;
	Fri, 18 Mar 2022 09:54:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id caUoK-gqUSSP; Fri, 18 Mar 2022 09:54:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7695560B44;
	Fri, 18 Mar 2022 09:54:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DBB2C0033;
	Fri, 18 Mar 2022 09:54:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6989AC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 09:54:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 527CA409DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 09:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L7KReP1q5-QQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 09:54:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B35A8409C3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647597269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0N2tqLbrUYXG1JSQlScpTqqNArTVktmTNzG3PVVQ64=;
 b=KSNa1vkL5p7Eq2AnvtKNmWV5edLGovzXZqUAPllatqyY330F6R0rdPpuhhsE0RFJ4HuZyO
 oVB0xeuiTBwaGt959gxQra9qcUH7PNwjG0y3wnIXdZtaxoXq6Sk+YYxo5KOkLU5oZLXVlD
 y2WDomVTSQ1BNhOw3ZLco6r8Dk31YUo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-YiyVf27DNqeRE8FIM1cAFA-1; Fri, 18 Mar 2022 05:54:28 -0400
X-MC-Unique: YiyVf27DNqeRE8FIM1cAFA-1
Received: by mail-qk1-f199.google.com with SMTP id
 u17-20020a05620a431100b004765c0dc33cso5028359qko.14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 02:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B0N2tqLbrUYXG1JSQlScpTqqNArTVktmTNzG3PVVQ64=;
 b=0C0BAIC5i/aChoR7sz50ZSwO0yudYpN8Fkk74XO6Y5rkMPTJ5fl+KKarQQbq6JQ+Ay
 FwECGwR+Apcaie6sVeFtmc6DS9sd63GTJGBdnhilrSanBA0pw8Lh2XNQwgn3cGLpV2EB
 KGF9yTF/5yJYbJmD2J0EqrQfxuM/l3vUemq0WtCJrL4GHwTB771wX0aaBzxzQbAB+Yg5
 lswup62LqjkU52riNYt2Nmn67OBnJOZOuZw37t7ZDFzEJCB69s/JWKxn16/WhjKsXdM5
 Ck9RptxBbAxZPJqdTQeQDzaNtJS1CZJNbytmlfSp+zp2Yhf4ckxPO9WRw+ct1054gdmB
 3iMg==
X-Gm-Message-State: AOAM530f5wzqu7JmE7ryomTCvLZ5WsSQeJWpWBKs5/kZ9FPzb7ESEExs
 K7a8bawHfrA04Hg4rCPm5+A1l8vTNUmLPyrFnxML7npMQoj4q1gUx7GOSDv+z7iwQxeqeNRDAst
 vafvcL5z4vvY99jHuPnMZ26qRZCdil3me3Nu6QJDGng==
X-Received: by 2002:a0c:c404:0:b0:431:31c3:3d15 with SMTP id
 r4-20020a0cc404000000b0043131c33d15mr6517882qvi.116.1647597267946; 
 Fri, 18 Mar 2022 02:54:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww4OeEttXpHADmj/zwubxQlNCZdF6Q1KI9KtTuFS5WVsX1Yj8sug1rDI4IQP0gxF1xEeAyKQ==
X-Received: by 2002:a0c:c404:0:b0:431:31c3:3d15 with SMTP id
 r4-20020a0cc404000000b0043131c33d15mr6517872qvi.116.1647597267762; 
 Fri, 18 Mar 2022 02:54:27 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 de26-20020a05620a371a00b0067dc7923b14sm3642875qkb.132.2022.03.18.02.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Mar 2022 02:54:27 -0700 (PDT)
Date: Fri, 18 Mar 2022 10:54:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Anirudh Rayabharam <mail@anirudhrb.com>
Subject: Re: [PATCH] vhost: handle error while adding split ranges to iotlb
Message-ID: <20220318095422.a37g7vxaiwqo5wxx@sgarzare-redhat>
References: <20220312141121.4981-1-mail@anirudhrb.com>
MIME-Version: 1.0
In-Reply-To: <20220312141121.4981-1-mail@anirudhrb.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Mar 12, 2022 at 07:41:21PM +0530, Anirudh Rayabharam wrote:
>vhost_iotlb_add_range_ctx() handles the range [0, ULONG_MAX] by
>splitting it into two ranges and adding them separately. The return
>value of adding the first range to the iotlb is currently ignored.
>Check the return value and bail out in case of an error.
>

We could add:

Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")

>Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
>---
> drivers/vhost/iotlb.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
>index 40b098320b2a..5829cf2d0552 100644
>--- a/drivers/vhost/iotlb.c
>+++ b/drivers/vhost/iotlb.c
>@@ -62,8 +62,12 @@ int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
> 	 */
> 	if (start == 0 && last == ULONG_MAX) {
> 		u64 mid = last / 2;
>+		int err = vhost_iotlb_add_range_ctx(iotlb, start, mid, addr,
>+				perm, opaque);
>+
>+		if (err)
>+			return err;
>
>-		vhost_iotlb_add_range_ctx(iotlb, start, mid, addr, perm, opaque);
> 		addr += mid + 1;
> 		start = mid + 1;
> 	}
>-- 
>2.35.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
