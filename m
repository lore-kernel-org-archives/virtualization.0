Return-Path: <SRS0=+b5l=LW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526CFC49EA3
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 15:16:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE36A6197F
	for <virtualization@archiver.kernel.org>; Mon, 28 Jun 2021 15:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE36A6197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B304C82A2D;
	Mon, 28 Jun 2021 15:16:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yz5DN2yiDhCK; Mon, 28 Jun 2021 15:16:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 73136829C5;
	Mon, 28 Jun 2021 15:16:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32312C0010;
	Mon, 28 Jun 2021 15:16:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9C89C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 15:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C90A640391
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 15:16:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hdSfz8sTHrXp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 15:16:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6942A4032D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624893378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f3U919sa8lNb7vV6JsVUpYBDy/niNjT2AdvpDrnRy9s=;
 b=FOugfhsiOiR5C8Fgd3V2vWlRTtEgk+DYbRARyvS8SKF/8oSAdAsS4liOpG9dtaErF8fsRi
 cCrdp/4bO9ElSoz8SVvzQy8a31cU2PVuxYpb6MBvrJ41nyKEpav9sVNgnHxh78XhTlA3Kq
 /7qOj6/KVLoIuahds68T2qyGxa45gj8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-TFtDiLcVPs2ptELgDzpDhg-1; Mon, 28 Jun 2021 11:16:16 -0400
X-MC-Unique: TFtDiLcVPs2ptELgDzpDhg-1
Received: by mail-ej1-f72.google.com with SMTP id
 l6-20020a1709062a86b029046ec0ceaf5cso4540235eje.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 08:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f3U919sa8lNb7vV6JsVUpYBDy/niNjT2AdvpDrnRy9s=;
 b=uB8g6V+0ZrGwZm9t5iM6BTbJS7iGexbUaMPaJkr6Avy/dy2ARPhxvnSqDO9e0aRE4G
 4GN9X6oCcULdE4vkZPbWEMXTLYzygsEfc/Durk2x0mUpyEGW74oRYGNY1EFdUaz8+sYG
 z4mWXz8ROkWEF2wX6WRd2l/HHj33RtFhKRvOhOoNp2o3bJmXQ/NGwyJFTlU9T94nX6gT
 tyoru09sJ7hmioAbhY/22adJVsn+oNEoDYMsKZd7UBNyT90XsWYgjdnUr9Ai8Smr5sRJ
 AkJHRATygS9qhmUsHEKdJxDJAp/PtQ3iMa0Gr9pe+eZata7rP08eHSsjACOE+FWAhpCc
 8y+Q==
X-Gm-Message-State: AOAM530AX0ZDYUokKZg0uF0NcIHkWcI0ls6OvcmlZUHvYRASaG9ibwNU
 uGRbWw6cUf+kqiJgaA4krYgwDlgalPQiB/DThL7VNASMyZtgiHCJaJtpf102cZyOd7cq6yIyKUZ
 VPlCz1tlgeXqHI6oinAH6kxcxEWvRRExd1hhye1I19g==
X-Received: by 2002:a05:6402:4316:: with SMTP id
 m22mr33796767edc.316.1624893375314; 
 Mon, 28 Jun 2021 08:16:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp1SSZvTlLkSF9hZBOks1djPGKi5UsUwUmX2C268COINPVulrBnVHYSkRuBwjGh1BeQI+cuQ==
X-Received: by 2002:a05:6402:4316:: with SMTP id
 m22mr33796741edc.316.1624893375113; 
 Mon, 28 Jun 2021 08:16:15 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id j22sm7354669ejt.11.2021.06.28.08.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jun 2021 08:16:14 -0700 (PDT)
Date: Mon, 28 Jun 2021 17:16:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vp_vdpa: correct the return value when fail to map
 notification
Message-ID: <20210628151612.h4il4c4ivljapi6v@steredhat>
References: <20210624035939.26618-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210624035939.26618-1-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kernel test robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 mst@redhat.com
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

On Thu, Jun 24, 2021 at 11:59:39AM +0800, Jason Wang wrote:
>We forget to assign a error value when we fail to map the notification
>during prove. This patch fixes it.
>
>Reported-by: kernel test robot <lkp@intel.com>
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Fixes: 11d8ffed00b23 ("vp_vdpa: switch to use vp_modern_map_vq_notify()")
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index c76ebb531212..9145e0624565 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -442,6 +442,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 			vp_modern_map_vq_notify(mdev, i,
> 						&vp_vdpa->vring[i].notify_pa);
> 		if (!vp_vdpa->vring[i].notify) {
>+			ret = -EINVAL;
> 			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
> 			goto err;
> 		}
>-- 
>2.25.1

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
