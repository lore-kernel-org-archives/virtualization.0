Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D1FC4320A
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:28:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC1760E09
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EC1760E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36BF660905;
	Mon, 26 Jul 2021 09:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n8bzd0ICPJZl; Mon, 26 Jul 2021 09:28:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBD43608EC;
	Mon, 26 Jul 2021 09:28:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 968DAC001A;
	Mon, 26 Jul 2021 09:28:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED814C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF0BC608EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:28:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sqX2xsrg5JDo
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:28:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEA9F600B4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627291721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RpEimmbDo4aEMkM3vqcFaTpt6N3ZuHHkK6+swTTSQGg=;
 b=dsRTJBZnUm+l6cQiSVEZ0G69hmo//Co1VE1l+BkaLnXSj2wjCFaO+xSiDfzJSd62DrJPPK
 KfCdF4/BNwhxVqCCca63OHWitTcgXOOhhXavC6Dkz6n2l5OrFKp5P6clHKGTc9S3nL80Mn
 h+kU61eCPuLc5WQx4f3+p3C5HHgb/I4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-pTECbVulMzWb0wxP48nN4A-1; Mon, 26 Jul 2021 05:28:40 -0400
X-MC-Unique: pTECbVulMzWb0wxP48nN4A-1
Received: by mail-ed1-f71.google.com with SMTP id
 b88-20020a509f610000b02903ab1f22e1dcso4392549edf.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 02:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RpEimmbDo4aEMkM3vqcFaTpt6N3ZuHHkK6+swTTSQGg=;
 b=lcBk2Leu03vGDHK4+m9X1857t/Q0G1zsFZLI3DJHdAnFohCg/DiFqWOmf+ZZXsAgAu
 1dTZh+xI9dS4147kCjo5IMp2H1kh2VVwA0alveBVOXM+cnBolq8+g+puLic5dINTrfN7
 1fD/bZ2pjUJSSIjvpotG9KaTYVBiyTTwvdJyLnTAMKYGxmAJ8k7hxCGTMe+tyBxmNp+a
 b9CWh3e2/sA1ig9/6oY6NhxeGAKphvupdqgPic9vcKceiSEmLPhb1SK+OHEGv/XIrCSA
 LQgFcgHUQw1p6Qie2GYPViuuuGBC/n9e50Z0I4AJ0vUrP+ewCAN+yFL9QkAtOn67iCaT
 6DUQ==
X-Gm-Message-State: AOAM530toMmDLrf4RHhKqwSYcu9/FJOWpfNZpiTmd5MlReTSB6J5tDy5
 znuPIdYzHuWqRx0m0mcACNC1g3y6+KEcrgDmlKpSot4x3dpmbm1jZ0v78LfEeDhxXIHXiT+hPxr
 ze+jex7QBba7fX7kwRt3nm1vbLGyV+H/g5ctPLndH0g==
X-Received: by 2002:a05:6402:b8a:: with SMTP id
 cf10mr20061222edb.61.1627291718740; 
 Mon, 26 Jul 2021 02:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlLHEa+X6F8XlAdINKvSd7LbBvwznspuSlArmjdXhgPjvf+vEJs5F8ESJ/Jy+za1FvvHAEyw==
X-Received: by 2002:a05:6402:b8a:: with SMTP id
 cf10mr20061212edb.61.1627291718632; 
 Mon, 26 Jul 2021 02:28:38 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id i14sm14026380eja.91.2021.07.26.02.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 02:28:38 -0700 (PDT)
Date: Mon, 26 Jul 2021 11:28:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 2/4] vp_vdpa: Fix return value check for
 vdpa_alloc_device()
Message-ID: <20210726092836.3iokq436ffwpwt3q@steredhat>
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-2-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 dan.carpenter@oracle.com, mst@redhat.com
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

On Thu, Jul 15, 2021 at 04:00:24PM +0800, Xie Yongji wrote:
>The vdpa_alloc_device() returns an error pointer upon
>failure, not NULL. To handle the failure correctly, this
>replaces NULL check with IS_ERR() check and propagate the
>error upwards.
>
>Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index 7b4a6396c553..fe0527329857 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -436,9 +436,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
> 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> 				    dev, &vp_vdpa_ops, NULL);
>-	if (vp_vdpa == NULL) {
>+	if (IS_ERR(vp_vdpa)) {
> 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
>-		return -ENOMEM;
>+		return PTR_ERR(vp_vdpa);
> 	}
>
> 	mdev = &vp_vdpa->mdev;
>-- 
>2.11.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
