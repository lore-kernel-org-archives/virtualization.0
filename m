Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A18C47082
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 07:51:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF9F60FE9
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 07:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF9F60FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 53129607CB;
	Mon,  7 Jun 2021 07:51:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bIupxZ2FDJGw; Mon,  7 Jun 2021 07:51:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id EBC08605FA;
	Mon,  7 Jun 2021 07:51:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0C09C000E;
	Mon,  7 Jun 2021 07:51:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02F95C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 07:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E40C440359
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 07:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UJVDTptBk5nA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 07:51:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED09040335
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 07:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623052273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WZwPx+0mdB9vay+PeM7MPpH/J1hyyvQmU9gTmamKU2o=;
 b=N05uBuA4gGC2rKo1lAIfD/lQK0yBwP4qY2FGPYI2EWG0fUGnj3ySg82lPN/OgoNuFpMrW+
 sSiYuB9KHkLcRvIk1GkRSeFVyfokyO0Z53Mls0RWch9/rH5noTe/9DbOHGBTshjr47NmqR
 Rwj7vH/CZvX7t42SI1HPFbnjUEGNyQc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-GoZI6A37PJOk9UoiG6IIBg-1; Mon, 07 Jun 2021 03:51:12 -0400
X-MC-Unique: GoZI6A37PJOk9UoiG6IIBg-1
Received: by mail-ed1-f71.google.com with SMTP id
 j13-20020aa7de8d0000b029038fc8e57037so8895188edv.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Jun 2021 00:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WZwPx+0mdB9vay+PeM7MPpH/J1hyyvQmU9gTmamKU2o=;
 b=FrTjxlMWmckBd5rXekB0DVxiuoc0cI4prVB2CJ/AuvG5j0sB0D9s47J35ilXq+y+v2
 QiwS+Srf0LbcLD7Bv6omACM3bPsh0uL1SiZbiY9gyzIO+s4KCXfu7vBQdycapnymc4Mf
 YA3ylCqMbE33eZsADvc1XBoRquqo918j47vK0sYDw2yXBdXRCcOx3ehediN2+j5VKGbK
 hcAjdHDyzSAhQKNHhUmRul7ojocWdTFJTEVMseBAhKm4Qc2Wfy1EHMLa07DqMr/5z7y4
 +wtCPeXozGMpKJ4BZlbKuDMRvcHrE/+bFh8ua/ZPLLHtBwS/ydd9jYKz0vyEWy49xd5h
 T7BQ==
X-Gm-Message-State: AOAM532E2RBzKuuq7JQwCLsDRAuLzC0YXhgq5UIFbpcwkcalnfP95kMe
 npohWaJdJuRBBmqDp5hqfEzybHdC7gJsfhd2k71kpn4LoL/vC9uQgHqnEvDLLbs3cao5X7gTGVV
 yImQWQCKVAuF/l6T1JTupuWoLGuWK2mAlHRUgoKnWOg==
X-Received: by 2002:a05:6402:26ce:: with SMTP id
 x14mr18886319edd.104.1623052270898; 
 Mon, 07 Jun 2021 00:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZPY7vqZq91osddVP7kT08CGyWsn3gu1ZzEt0v2pDJ1mKDFwYoa8lOXRspqGfqQB7sGlDKag==
X-Received: by 2002:a05:6402:26ce:: with SMTP id
 x14mr18886303edd.104.1623052270703; 
 Mon, 07 Jun 2021 00:51:10 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id q9sm7174628edw.51.2021.06.07.00.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 00:51:10 -0700 (PDT)
Date: Mon, 7 Jun 2021 09:51:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] vdpa: fix error code in vp_vdpa_probe()
Message-ID: <20210607075108.dujhjrt2anis252l@steredhat>
References: <YLtyYE8TinOl3IhO@mwanda>
MIME-Version: 1.0
In-Reply-To: <YLtyYE8TinOl3IhO@mwanda>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, kernel-janitors@vger.kernel.org,
 Eli Cohen <elic@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

On Sat, Jun 05, 2021 at 03:47:28PM +0300, Dan Carpenter wrote:
>Return -ENOMEM if vp_modern_map_vq_notify() fails.  Currently it
>returns success.
>
>Fixes: 11d8ffed00b2 ("vp_vdpa: switch to use vp_modern_map_vq_notify()")
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index c76ebb531212..e5d92db728d3 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -442,6 +442,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 			vp_modern_map_vq_notify(mdev, i,
> 						&vp_vdpa->vring[i].notify_pa);
> 		if (!vp_vdpa->vring[i].notify) {
>+			ret = -ENOMEM;
> 			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
> 			goto err;
> 		}
>-- 
>2.30.2
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
