Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A240C433FE
	for <virtualization@archiver.kernel.org>; Mon, 23 May 2022 10:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D80A2405D0;
	Mon, 23 May 2022 10:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I13x6F0NLgvf; Mon, 23 May 2022 10:45:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 599EC40003;
	Mon, 23 May 2022 10:45:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA1EC0039;
	Mon, 23 May 2022 10:45:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA67EC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA7A483FFC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qx06hrkpCo24
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F46983FEC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653302705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ro0AbdD3qiV64NTFTkLB8uvz3K/Lp6OAyllXm8fL7es=;
 b=AiXnCWdcidetuB/cq9oQUHnGGl+aJ7M95HN25OhqQ/+gYrMXyLImvaUdxML2fuw4HcMrhC
 xyEtCrEkkadRq6r2V/fmOolt7OC+El5vntf9NUzg3QZ7TGu5DzbLwRNGefRbthsc1uCSzJ
 hY3A4GO6RoqTH81UIOewClG+6dOK8nI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-HlMt_yaaPOuexMP-ATB7KA-1; Mon, 23 May 2022 06:45:04 -0400
X-MC-Unique: HlMt_yaaPOuexMP-ATB7KA-1
Received: by mail-wm1-f71.google.com with SMTP id
 v126-20020a1cac84000000b00396fe5959d2so5685385wme.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 03:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ro0AbdD3qiV64NTFTkLB8uvz3K/Lp6OAyllXm8fL7es=;
 b=mFjYDhZo8mSFWhWI29eXb4ZNgY54CM7SknFtlTL4CxZlq/1aQOUZqC/xdbV1e3pXg9
 opEU9hojxLCYDYrmW4WYEKXszYjJHCvxKA/G313nI+ixWxilCBhaYp2L+httTyXWsa5h
 vOwKsKdnBiiRF7yi7PO1e/zXeLGQNB4n6JbXJfCny2o8JpYFjnX44OvDGGnKU4OlR/UO
 MFHZhC9TkzpRHNlnr/ozpnYPf/dPx5HmMDAjMsOTaXJvMFjbgRKsp6fgxJOsYemG3PQt
 /uUKsA4Ewwgzlj01p7LdAFdXwze9oB9W9OyQPQvXnvyU4X/5Mnfnjt3pmznvf3m/CTbI
 hq9w==
X-Gm-Message-State: AOAM533A0F9lfh1RqwiqY7fr/+r+hBWMqxF3iaEqbgbVtjskCYUZw1nG
 y/ILlvy5tyoINehfVbK28xTUsGO3dZUxmjEakzl1q+7cra0+YVu0s4GqyNg7UEIas5fAre71ycf
 j9uQO2wFXb/OZ1tun+RY5RSVCK4NZwLpE58/PLYreYg==
X-Received: by 2002:a5d:6d8f:0:b0:20c:7fb7:d59c with SMTP id
 l15-20020a5d6d8f000000b0020c7fb7d59cmr19553216wrs.77.1653302701919; 
 Mon, 23 May 2022 03:45:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqmvkqQTTuxAVZdOZ/+3TrYKOlXX86OeWQQ0yzjlLLs+0xsSNUd2ZLXvr3yj3HjivcPxFqLg==
X-Received: by 2002:a5d:6d8f:0:b0:20c:7fb7:d59c with SMTP id
 l15-20020a5d6d8f000000b0020c7fb7d59cmr19553190wrs.77.1653302701675; 
 Mon, 23 May 2022 03:45:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 m10-20020adfc58a000000b0020e63ab5d78sm9696809wrg.26.2022.05.23.03.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 May 2022 03:45:01 -0700 (PDT)
Date: Mon, 23 May 2022 12:44:58 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] vhost-vdpa: return -EFAULT on copy_to_user() failure
Message-ID: <20220523104458.exaf2zb3lua76ibf@sgarzare-redhat>
References: <YotG1vXKXXSayr63@kili>
MIME-Version: 1.0
In-Reply-To: <YotG1vXKXXSayr63@kili>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Gautam Dawar <gautam.dawar@xilinx.com>
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

On Mon, May 23, 2022 at 11:33:26AM +0300, Dan Carpenter wrote:
>The copy_to_user() function returns the number of bytes remaining to be
>copied.  However, we need to return a negative error code, -EFAULT, to
>the user.
>
>Fixes: 87f4c217413a ("vhost-vdpa: introduce uAPI to get the number of virtqueue groups")
>Fixes: e96ef636f154 ("vhost-vdpa: introduce uAPI to get the number of address spaces")
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>---
> drivers/vhost/vdpa.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>index 3e86080041fc..935a1d0ddb97 100644
>--- a/drivers/vhost/vdpa.c
>+++ b/drivers/vhost/vdpa.c
>@@ -609,11 +609,13 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
> 		r = vhost_vdpa_get_vring_num(v, argp);
> 		break;
> 	case VHOST_VDPA_GET_GROUP_NUM:
>-		r = copy_to_user(argp, &v->vdpa->ngroups,
>-				 sizeof(v->vdpa->ngroups));
>+		if (copy_to_user(argp, &v->vdpa->ngroups,
>+				 sizeof(v->vdpa->ngroups)))
>+			r = -EFAULT;
> 		break;
> 	case VHOST_VDPA_GET_AS_NUM:
>-		r = copy_to_user(argp, &v->vdpa->nas, sizeof(v->vdpa->nas));
>+		if (copy_to_user(argp, &v->vdpa->nas, sizeof(v->vdpa->nas)))
>+			r = -EFAULT;
> 		break;
> 	case VHOST_SET_LOG_BASE:
> 	case VHOST_SET_LOG_FD:
>-- 
>2.35.1
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
