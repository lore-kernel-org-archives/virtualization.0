Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395B5C433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 11:39:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CA164D5D
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 11:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CA164D5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72C6D6F509
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 11:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LSSUNZIpGWHB for <virtualization@archiver.kernel.org>;
	Mon, 15 Feb 2021 11:39:25 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 98F906F512; Mon, 15 Feb 2021 11:39:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED4B36F4E9;
	Mon, 15 Feb 2021 11:39:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF149C0174;
	Mon, 15 Feb 2021 11:39:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E456EC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:39:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4FB36F4E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHsoI7dlVOae
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:39:19 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id EC9F26F527; Mon, 15 Feb 2021 11:39:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45BF26F512
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 11:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613389156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fK4/0lnxBbz2gapwmVgGB0yVDtW7AF3IpMy5Ovf8acs=;
 b=ZtoH/1Fu0oQlx1dtV6sdG1EIGNqU3SBoiAIP73dmGNjffuf8WmE/ze+m1DuoRo4zxh5IGA
 NLIBF3OFxF/YVfxsvEH/ABAfmhuYT8E4HVkeDTFuEp4dV8apYzLoABX4JZiuo+5iHQXOMN
 dVrLGc6jRYbY+wQ9IcEWIzqQBYOU2Uw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-5xhy0YEPPD-I9ZMkL7ASvQ-1; Mon, 15 Feb 2021 06:39:15 -0500
X-MC-Unique: 5xhy0YEPPD-I9ZMkL7ASvQ-1
Received: by mail-wm1-f70.google.com with SMTP id t128so6816600wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 03:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fK4/0lnxBbz2gapwmVgGB0yVDtW7AF3IpMy5Ovf8acs=;
 b=bO28ga5LKFk3zfoSJypWZmpCEBEjUkJo/Kk4Nk6nmTsMuPEMQtPRK/VkF2yh2TMdxr
 TLXortI4gMFYIC1MWc/ZQODqfcbgzYauMdZ73m11tSQyuYo6hosHoV4Xo3A95cOad6WH
 q0DfrnwVcvLXeGkl7xJ2G8X/zRwy5q194HIxsMCbbyCyxWTCatZsCUX4MOPYIIQz5ma8
 ae7xryFPziiMmRKxkywiKdH82UdAT+hzlzI502HXo9CJQiceEG4qtvRrVEM2whKA1MEm
 yxx40tNj59x0EgTb9r61YfSSf6oGIFIbr9yZ87m2dgRNf1Mpx/md1nDrvxVa8BKEIAu5
 rY9A==
X-Gm-Message-State: AOAM531wQn5gjokZCybOiw8gz36sHN2535jtfuRH8aOoQme1JT5bYJch
 V9Lp3DM6lCVBt6Z5/ckbfLjHO5G6qt8HRd5MTSi1csoiYrxypbknw0WKpbqvUxjY7eCzOFHwuoz
 ptoeoo+ImryZgIFXNb59i+wV7TACJc7K8tLdKaVXnhA==
X-Received: by 2002:a05:600c:4285:: with SMTP id
 v5mr14009633wmc.59.1613389153774; 
 Mon, 15 Feb 2021 03:39:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/bah7DYE+9uihSw+nJ5NqfKaxWCUTqONCvXSJ+0oJ7MuYvaVH2I2/K26x7vSXFMVDSsnt1A==
X-Received: by 2002:a05:600c:4285:: with SMTP id
 v5mr14009618wmc.59.1613389153620; 
 Mon, 15 Feb 2021 03:39:13 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o17sm2060496wrq.34.2021.02.15.03.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 03:39:13 -0800 (PST)
Date: Mon, 15 Feb 2021 12:39:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH] vdpa_sim: Skip typecasting from void*
Message-ID: <20210215113911.4egj2kzw4n46iy7y@steredhat>
References: <20210213183951.248324-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210213183951.248324-1-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
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

On Sat, Feb 13, 2021 at 08:39:51PM +0200, Parav Pandit wrote:
>Typecasting from void* to virtio_net_config* is not needed.
>Remove it.
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>index 240a5f1306b5..40d4df689b87 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>@@ -110,8 +110,7 @@ static void vdpasim_net_work(struct work_struct *work)
>
> static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
> {
>-	struct virtio_net_config *net_config =
>-		(struct virtio_net_config *)config;
>+	struct virtio_net_config *net_config = config;
>
> 	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
> 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>-- 
>2.26.2

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
