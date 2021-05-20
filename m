Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4742C433ED
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 07:05:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A2B61279
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 07:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A2B61279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 251E24017E;
	Thu, 20 May 2021 07:05:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ASQBQV2HgGJ; Thu, 20 May 2021 07:05:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE058400AB;
	Thu, 20 May 2021 07:05:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0499C000D;
	Thu, 20 May 2021 07:05:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE6DC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7857B83BCA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C16M7W5NIjKq
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:05:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC42383A54
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 07:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621494343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KaliF5eDoHyShQ6pVk6nswV0QmddLwdx+Te1ge1ipyU=;
 b=EJy833z/OS0DN4fNa0ISFYTp82wigHe5/PgOlw2aQqdeg1I36YfMz44qHTON6E7DeGTSdD
 0+/bDKkbO9OS/g5FM6iNViKyUaLZW73E34avway0ND9Gvcm34i1jNFyOFIQ/HJJz1KxQwb
 QrfJqugR4whwg5p6MZVakXevup/O0A8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-q_zC7YRxOWqKY2L-8GIKOQ-1; Thu, 20 May 2021 03:05:42 -0400
X-MC-Unique: q_zC7YRxOWqKY2L-8GIKOQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 i3-20020aa7dd030000b029038ce772ffe4so9116312edv.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 00:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KaliF5eDoHyShQ6pVk6nswV0QmddLwdx+Te1ge1ipyU=;
 b=cRykpTm2y8h5PiG/ib23yh8MKPKIiiTTwTk5O4Cz0vU3nUbipNYtfdi8Qz+FyGMlMG
 bfBnooW36K1kMT+Lv3tALLMrvhc1cMMloxbOkCJaLjzM4WmV5jnvGsyAXg1c2rnYBJDD
 c5hMyh7wSGlikUDrVCZJOQHnbgXBCkYy2c0BD3mE8R69VlHtc8m/yt2WeYfB4MLu+AyB
 gxKbODqkTodBi2hQXSvV6b94HTt9TisBToR9kWz64cHfDmz32GHX4W3StW0KFGnHrrL7
 EK4XeTtdaFVeoUvXainyvdsLRkGOtQZO1SvM5vgDWnzjFLXmnvCc1M2uUtIY/aZZDf6X
 ZtiA==
X-Gm-Message-State: AOAM531CAkWh5JJLFiCqLQVrRoiBbwM7SWLd1EFgnaRDcm1cgdiRPxqK
 wnncqTQ0ZjfyFm+IpzQDaFOOVXjWm9+hSKRavM3voOlNjSEq4nsRSRzgJSqIX7EHnu12i//TeR1
 qajbaFw8NAtkdSAeccxWKLkKyvoscYpV6oP1eEcKxmA==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr3445590eds.166.1621494340849; 
 Thu, 20 May 2021 00:05:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxv5JoSB/zlPpuQMN8GuzvFJPHkuHmpfxSZN0QQJmqGyUr9a1onbpIw9MzbZAOgIOc+t4fM8A==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr3445576eds.166.1621494340688; 
 Thu, 20 May 2021 00:05:40 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id m10sm987322edp.48.2021.05.20.00.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 00:05:40 -0700 (PDT)
Date: Thu, 20 May 2021 09:05:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] vp_vdpa: fix error return code in vp_vdpa_probe()
Message-ID: <20210520070538.jniunk2rr3nyttuw@steredhat>
References: <20210519141646.3057093-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20210519141646.3057093-1-weiyongjun1@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Hulk Robot <hulkci@huawei.com>, Eli Cohen <elic@nvidia.com>
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

On Wed, May 19, 2021 at 02:16:46PM +0000, Wei Yongjun wrote:
>Fix to return negative error code -ENOMEM from the error handling
>case instead of 0, as done elsewhere in this function.
>
>Fixes: 11d8ffed00b2 ("vp_vdpa: switch to use vp_modern_map_vq_notify()")
>Reported-by: Hulk Robot <hulkci@huawei.com>
>Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
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
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
