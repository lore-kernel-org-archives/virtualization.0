Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634F6C19F2B
	for <virtualization@archiver.kernel.org>; Fri, 29 Jul 2022 08:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE9778124C;
	Fri, 29 Jul 2022 08:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CE9778124C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dQDIp1nn
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZL2YuemMqyO; Fri, 29 Jul 2022 08:53:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DF9980F2C;
	Fri, 29 Jul 2022 08:53:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DF9980F2C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3548CC0033;
	Fri, 29 Jul 2022 08:53:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E33FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 08:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 72E3E80F2C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 08:53:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72E3E80F2C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s6GpMggbRpTk
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 08:53:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B466880E7E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B466880E7E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659084815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKNzy1wNl3/wszEHWiuWje3QkhM8MgHzTske10APxFw=;
 b=dQDIp1nn8vdY17mCtyS5vGbng53PrUINbh6nbNXnPFI+zv1bGsM2IwPy8LU7o0KQybFti+
 X7gInZnXl++Inc1pHmuy9pTexQhCCUfj59PM4EG5XqtsOVnE0XFZ3Z5dqBNleHw8mED+0F
 +/l3VmnyLpykbzmqwuU9sWF5zOnuP2s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-SGA9Aio1Md6cupak80Yqvg-1; Fri, 29 Jul 2022 04:53:32 -0400
X-MC-Unique: SGA9Aio1Md6cupak80Yqvg-1
Received: by mail-ej1-f69.google.com with SMTP id
 s4-20020a170906500400b006feaccb3a0eso1566051ejj.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jul 2022 01:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=UKNzy1wNl3/wszEHWiuWje3QkhM8MgHzTske10APxFw=;
 b=dslWVtX2GUjr7AF/nahvDK0LGB80Nr+n5beB+DYJkIe5iELu0gWpYcmKip1iDIFri4
 9Aczz6i2szMYWoR2x8wHq/XwRAz/QlPs4sVC6tZgy1Yh7wSStY5lfRjGQZ86yMS0/iRN
 cQkHykA4CKvJU3KYMpAB4sppD3HL2JKJwBmLhyb4fo+Uqz1L0iTUhUPrJnoD0l+CdIOp
 DUEHxS5qbGRTeRZJNfFOZE54+uxn/xyf3Onqpf0NMob1CWvbvBemnmTrpvcEpMn82cON
 mE28f/bZ/5tP2svMUq/akXS0bIDHmNPkwiZVPxqKawHZDQCX5J4JszijGk4av1u79Hyt
 H3oA==
X-Gm-Message-State: AJIora+jnbmlld3QJOfLeA20AYcMOUUcf4JqksfSzkBkyQUTs58fstei
 a6fkO6LaDcodjn/dV+tgap5QG9UI8pmPxkwoC5lO4/+bYrCDehbTzXj0nX5w4Wva0vFAWXW885W
 vGJHkFHUdRxncE4eXBweJFc3Gs53Tep9ySU+2xr1YSA==
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id
 fj4-20020a1709069c8400b006e07c756f01mr2189880ejc.103.1659084811120; 
 Fri, 29 Jul 2022 01:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tFzt9/6A2RKYxMe6RJ6gz+kx2jnpmTWONPTb+1sLKKtOLsSJuA19N97kaMBeYyhN7fjcnflw==
X-Received: by 2002:a17:906:9c84:b0:6e0:7c75:6f01 with SMTP id
 fj4-20020a1709069c8400b006e07c756f01mr2189861ejc.103.1659084810678; 
 Fri, 29 Jul 2022 01:53:30 -0700 (PDT)
Received: from redhat.com ([2.54.183.236]) by smtp.gmail.com with ESMTPSA id
 q15-20020a17090676cf00b006fed93bf71fsm1446122ejn.18.2022.07.29.01.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jul 2022 01:53:30 -0700 (PDT)
Date: Fri, 29 Jul 2022 04:53:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V3 6/6] vDPA: fix 'cast to restricted le16' warnings in
 vdpa.c
Message-ID: <20220729045039-mutt-send-email-mst@kernel.org>
References: <20220701132826.8132-1-lingshan.zhu@intel.com>
 <20220701132826.8132-7-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220701132826.8132-7-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, gautam.dawar@amd.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jul 01, 2022 at 09:28:26PM +0800, Zhu Lingshan wrote:
> This commit fixes spars warnings: cast to restricted __le16
> in function vdpa_dev_net_config_fill() and
> vdpa_fill_stats_rec()
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 846dd37f3549..ed49fe46a79e 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -825,11 +825,11 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>  		    config.mac))
>  		return -EMSGSIZE;
>  
> -	val_u16 = le16_to_cpu(config.status);
> +	val_u16 = __virtio16_to_cpu(true, config.status);
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
>  		return -EMSGSIZE;
>  
> -	val_u16 = le16_to_cpu(config.mtu);
> +	val_u16 = __virtio16_to_cpu(true, config.mtu);
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>  		return -EMSGSIZE;
>  

Wrong on BE platforms with legacy interface, isn't it?
We generally don't handle legacy properly in VDPA so it's
not a huge deal, but maybe add a comment at least?


> @@ -911,7 +911,7 @@ static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
>  	}
>  	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
>  
> -	max_vqp = le16_to_cpu(config.max_virtqueue_pairs);
> +	max_vqp = __virtio16_to_cpu(true, config.max_virtqueue_pairs);
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, max_vqp))
>  		return -EMSGSIZE;
>  
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
