Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3245BC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 13:29:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B354461053;
	Wed, 21 Dec 2022 13:29:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B354461053
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KR+8L/cX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dq787Rcka5ZC; Wed, 21 Dec 2022 13:29:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B85160AA0;
	Wed, 21 Dec 2022 13:29:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B85160AA0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73020C0071;
	Wed, 21 Dec 2022 13:29:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3F53C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D90380DAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:29:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D90380DAD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=KR+8L/cX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hllze9tTejyP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:29:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C7F6680C83
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7F6680C83
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 13:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671629378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ExJ8LKwiPYZ7ICDIfMLKGDc4/w+9b39VLWD/GNS2Unc=;
 b=KR+8L/cXXLwuL14nx62be7Oz9ZBZGEgoSKxN06zMuq/jOHQ5IvoBHWQxtgMQnYDmWpg7tE
 V7wC2/8QnvijHoBfOzAYHFyE9+IvWGoYElsUFweo/9L+8/BqXL5qsH1Gv44G9rJAHZgEhA
 smgvwRDSk2J27+7RF6IOWbM4MVgDViw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-ol2ObaiYNsCzYX7iLLGiyg-1; Wed, 21 Dec 2022 08:29:37 -0500
X-MC-Unique: ol2ObaiYNsCzYX7iLLGiyg-1
Received: by mail-wm1-f70.google.com with SMTP id
 v188-20020a1cacc5000000b003cf76c4ae66so938867wme.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 05:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExJ8LKwiPYZ7ICDIfMLKGDc4/w+9b39VLWD/GNS2Unc=;
 b=uSNnPo39xgvOg92F5201eBxcF+iSFPcio6IYrZokpN+g19YirMDxg/PHy7OdPN6gTF
 hPN8RWg8/nlRiDK2xR/IcLw1gqLAX0y4TWfCF9QaVWnW/nKj5LvwzNZCmhLcXTg3iuUi
 Mt009Jj5xuId5AK9NaaKH4MgAmyXffkCEnt0yBUwhWyYo3f8YAPYYkDGdfu2c/YQR33j
 gOhyTxMcUR1myBVP3XgKx+34YDYWFxBqohUeJ+yHSCU+wvjK7FuVMKQv49dv6/X81Nyy
 4lYg2bD9T/dOrgD1aaAj/OsOwu+bZPOP6Yr7qjwxivq2aePxNyRdyMCfOcsLg1/zI7KI
 X76Q==
X-Gm-Message-State: AFqh2kpFFREH9+duDAQFtiVc7egcrLn1U4ajgNKjmyte0tAZQjeLWLA/
 hCDcRQEBpvhsEThjhzUARCr7vHqjk1UYv5ubThLtXZkhEvem6AqqBNWuGhlwPrHn3vJMjaNKYSu
 NXxGIi6fQ5atvvTZHYbIA3jPuSM940/R/A7t4mzbn3w==
X-Received: by 2002:a7b:c7c8:0:b0:3d7:889:7496 with SMTP id
 z8-20020a7bc7c8000000b003d708897496mr1654902wmk.17.1671629376193; 
 Wed, 21 Dec 2022 05:29:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvW6AH9BLD+Zo2jmVGceaMPUsMGAeTaSMzanQMfKKe98G9pT4EaDNsQGgFdg1UaM1DhAfxUsA==
X-Received: by 2002:a7b:c7c8:0:b0:3d7:889:7496 with SMTP id
 z8-20020a7bc7c8000000b003d708897496mr1654895wmk.17.1671629375963; 
 Wed, 21 Dec 2022 05:29:35 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b003d1d5a83b2esm2501080wmq.35.2022.12.21.05.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Dec 2022 05:29:35 -0800 (PST)
Date: Wed, 21 Dec 2022 14:29:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/4] vdpa_sim: switch to use __vdpa_alloc_device()
Message-ID: <20221221132933.zne6afpxgcpceijt@sgarzare-redhat>
References: <20221221061652.15202-1-jasowang@redhat.com>
 <20221221061652.15202-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221221061652.15202-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com
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

On Wed, Dec 21, 2022 at 02:16:49PM +0800, Jason Wang wrote:
>This allows us to control the allocation size of the structure.
>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 ++++++++-----
> 1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index b071f0d842fb..757afef86ba0 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -250,6 +250,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 			       const struct vdpa_dev_set_config *config)
> {
> 	const struct vdpa_config_ops *ops;
>+	struct vdpa_device *vdpa;
> 	struct vdpasim *vdpasim;
> 	struct device *dev;
> 	int i, ret = -ENOMEM;
>@@ -267,14 +268,16 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> 	else
> 		ops = &vdpasim_config_ops;
>
>-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
>-				    dev_attr->ngroups, dev_attr->nas,
>-				    dev_attr->name, false);
>-	if (IS_ERR(vdpasim)) {
>-		ret = PTR_ERR(vdpasim);
>+	vdpa = __vdpa_alloc_device(NULL, ops,
>+				   dev_attr->ngroups, dev_attr->nas,
>+				   sizeof(struct vdpasim),
>+				   dev_attr->name, false);
>+	if (IS_ERR(vdpa)) {
>+		ret = PTR_ERR(vdpa);
> 		goto err_alloc;
> 	}
>
>+	vdpasim = vdpa_to_sim(vdpa);
> 	vdpasim->dev_attr = *dev_attr;
> 	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
> 	spin_lock_init(&vdpasim->lock);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
