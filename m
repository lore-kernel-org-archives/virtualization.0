Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9BCC4338F
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:29:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E5360F02
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 83E5360F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6050C8341E;
	Mon, 26 Jul 2021 09:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cF5jNFBFG8G0; Mon, 26 Jul 2021 09:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 037A283134;
	Mon, 26 Jul 2021 09:29:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D256FC001A;
	Mon, 26 Jul 2021 09:29:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B061C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:29:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 49A9D402A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NH_iaenl_xBI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:29:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5C7F401C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627291740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5MLQvS6lxg2D9sP+beeEnZvsI6R8MfRGKcYDHuWf39g=;
 b=iuiGyoZP4uWk7JiMFqeFxiseczJ+tw6QNcPOkcQIOXCfYuMsJKM0wdovUnTqYTb4vtKNqU
 iP6stIaZ3a5OL5SOTxH3+iRR9MdfmMLo5vXgH2/Y1bK8gS6dPwulf2g8hVCHDkUIYdTsGi
 KJqevCNfrI6LCR4vUEjp4My069ZONuw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-7528guWkMMaaa99wdnG8Ew-1; Mon, 26 Jul 2021 05:28:59 -0400
X-MC-Unique: 7528guWkMMaaa99wdnG8Ew-1
Received: by mail-ed1-f69.google.com with SMTP id
 h16-20020aa7de100000b02903a6620f87feso4408528edv.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 02:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5MLQvS6lxg2D9sP+beeEnZvsI6R8MfRGKcYDHuWf39g=;
 b=O/nk/0wwLlVbC7N+jf8eUleN09UxlQ0hd8FmK1B7xSkMfFRT/pUam41fI5CHxkIHpU
 VF+Cm4QEW6sAnryrvawJfW50uw0elqeBityAk4AzZup1dA+QKibfv8E9M5HChYsJV9FJ
 GD4RjXPQvRuGx60As7nrGQr98y9sZwQ8Gf+HEDc+x+psa63mhD0slcWVEEIckYLx4ja5
 lVWawymEKuSAOpG97fVPbuBNrTI/z2AFjnbbRCB2YWTR7QvA0305SMFob4rVd8yw3GVS
 q+s4GUTUTC0n7BF1wWOWAW9uaD2rOSSJfaYNI9mfxgIHkkDtD7e6OyIWUay50iuxVqkA
 UrXg==
X-Gm-Message-State: AOAM530044R6uta+Pa8WK16OVpEQARUuyoLXFG1NKus3lKDytohp/neA
 z4IeW4s2aYHiKcSR7qB1gtOcQNmhyx/st5MNCzRoLA35MAVmEfX3oxv8GHbrMePChsVHFHkrMN/
 Y57dkVXw8af5iqZnOGvLYZB/ZmGxcTWCwV9FwOU3U1g==
X-Received: by 2002:a17:906:7190:: with SMTP id
 h16mr16332008ejk.251.1627291738149; 
 Mon, 26 Jul 2021 02:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcwwxWV6IkV0YjMM6Irhh1zwz2Ur7YaVcKLlvQvdAoHQkOw7sodWQFSqQU5yBbZPHw0ts31A==
X-Received: by 2002:a17:906:7190:: with SMTP id
 h16mr16331991ejk.251.1627291738014; 
 Mon, 26 Jul 2021 02:28:58 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id em9sm14094434ejc.88.2021.07.26.02.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 02:28:57 -0700 (PDT)
Date: Mon, 26 Jul 2021 11:28:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 3/4] vDPA/ifcvf: Fix return value check for
 vdpa_alloc_device()
Message-ID: <20210726092855.xg3yicwltfwozz6y@steredhat>
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-3-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-3-xieyongji@bytedance.com>
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

On Thu, Jul 15, 2021 at 04:00:25PM +0800, Xie Yongji wrote:
>The vdpa_alloc_device() returns an error pointer upon
>failure, not NULL. To handle the failure correctly, this
>replaces NULL check with IS_ERR() check and propagate the
>error upwards.
>
>Fixes: 5a2414bc454e ("virtio: Intel IFC VF driver for VDPA")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 21b78f1cd521..351c6cfb24c3 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -493,9 +493,9 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
> 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
> 				    dev, &ifc_vdpa_ops, NULL);
>-	if (adapter == NULL) {
>+	if (IS_ERR(adapter)) {
> 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>-		return -ENOMEM;
>+		return PTR_ERR(adapter);
> 	}
>
> 	pci_set_master(pdev);
>-- 
>2.11.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
