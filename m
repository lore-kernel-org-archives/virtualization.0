Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8510C433F5
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 09:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B104401E9;
	Tue, 15 Mar 2022 09:38:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQm78HQ12zel; Tue, 15 Mar 2022 09:38:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 07A1D401C4;
	Tue, 15 Mar 2022 09:38:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7945C0012;
	Tue, 15 Mar 2022 09:38:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1CC1C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF9B7401C7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:38:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FgeovI3qdmaG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:38:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED60C401C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 09:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647337091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K47SKj8REwLbfMI9yH8wvkO0kp+/XEGwzSW8IdK+acE=;
 b=UBfd2xnZQpBegglEESO9Sk+KjYYmahxgA2SMI217X4TosJO+7cdcJwrAfnUJGZHYAL90d0
 ClLfWXB6rEuqg/yxF2d3vCc0LbBtzNDAmrryQcjCSF7WHUFIEbT9y0qbxktNFv6COBc0lb
 cCwiZ/zJ2TIReqsGOQAp8WnyxE137yk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-YmLYEzURNIuosPMbeQXaog-1; Tue, 15 Mar 2022 05:38:08 -0400
X-MC-Unique: YmLYEzURNIuosPMbeQXaog-1
Received: by mail-qv1-f70.google.com with SMTP id
 dw13-20020a0562140a0d00b00435ab868167so16009523qvb.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 02:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=K47SKj8REwLbfMI9yH8wvkO0kp+/XEGwzSW8IdK+acE=;
 b=VfD42KoSgx2Mt/e/dDqPTZzYYv8xxIH1DLvlO3nG4bBu28APc/TqdRNB8aZrLcCQbD
 i66YsQT71Ulgea+i5q11Acnzq2MV4SEbMNEqyFm+Cpwp6pHkQT0dMntGVKlSxhzdtbNb
 xuNPoXFiXTn5Rf4xbqCieJlKr2DUo+oToo8AMRtvrX1vUTuy5OluqyTFM0C+CndwYdKk
 0Z+nntjHM4gPcA+ew4HHPuunNrcz8DiAmWvucY8SIeENut82jmnQ8LG59RePq2zLPb8P
 ufVW0bkKlVNpiAoG0dQTsFJsM3Ae60dw2IaE/MT4Z0wsFPuVHZnhFyghMaTb4ujAsyA0
 9uQg==
X-Gm-Message-State: AOAM533tg2mViVHZPQWlPRi5+B57n5EoGDZASBjy2brv1DOkjQ8D5LNV
 EVWPjm23AjBaolEt1YFm/RpyCsA4f0FIulFkvcEia9I9zEy4WzibmKC2cN0DYEQFXkNoyNX19WC
 FBk8DHF+ToVFHUYEtXJUGEOF46e+KI5ceHORTO37qVg==
X-Received: by 2002:a05:6214:1c87:b0:42d:20cb:e484 with SMTP id
 ib7-20020a0562141c8700b0042d20cbe484mr19923069qvb.10.1647337087871; 
 Tue, 15 Mar 2022 02:38:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhF9QDkgfvW6/9vLgmCoy3wh/Jj8hmyEKNU4aC+B4FAY1JaTiHxB1dMqDy5xYqVzFmJloaeA==
X-Received: by 2002:a05:6214:1c87:b0:42d:20cb:e484 with SMTP id
 ib7-20020a0562141c8700b0042d20cbe484mr19923055qvb.10.1647337087684; 
 Tue, 15 Mar 2022 02:38:07 -0700 (PDT)
Received: from sgarzare-redhat
 (host-212-171-187-184.pool212171.interbusiness.it. [212.171.187.184])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a05620a16b500b0067b1205878esm8908043qkj.7.2022.03.15.02.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 02:38:07 -0700 (PDT)
Date: Tue, 15 Mar 2022 10:38:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Subject: Re: [PATCH v2 1/3] vdpa: support exposing the config size to userspace
Message-ID: <20220315093801.ngyizwf7blkhutug@sgarzare-redhat>
References: <20220315032553.455-1-longpeng2@huawei.com>
 <20220315032553.455-2-longpeng2@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220315032553.455-2-longpeng2@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yechuan@huawei.com, huangzhichao@huawei.com,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Tue, Mar 15, 2022 at 11:25:51AM +0800, Longpeng(Mike) wrote:
>From: Longpeng <longpeng2@huawei.com>
>
>- GET_CONFIG_SIZE: return the size of the virtio config space.
>
>The size contains the fields which are conditional on feature
>bits.
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Longpeng <longpeng2@huawei.com>
>---
> drivers/vhost/vdpa.c       | 17 +++++++++++++++++
> include/linux/vdpa.h       |  3 ++-
> include/uapi/linux/vhost.h |  4 ++++
> 3 files changed, 23 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index ec5249e..605c7ae 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -355,6 +355,20 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
> 	return 0;
> }
>
>+static long vhost_vdpa_get_config_size(struct vhost_vdpa *v, u32 __user *argp)
>+{
>+	struct vdpa_device *vdpa = v->vdpa;
>+	const struct vdpa_config_ops *ops = vdpa->config;
>+	u32 size;
>+
>+	size = ops->get_config_size(vdpa);

get_config_size() returns a size_t, perhaps we could have a comment here 
where we say we don't expect there to be an overflow.

I don't have a strong opinion on this, and I wouldn't want to get you to 
repin just for that, so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
