Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38ECFC25B06
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 19:24:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0A1A40893;
	Tue,  9 Aug 2022 19:24:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0A1A40893
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Gh4Uq2ja
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hi52KoqcPGIN; Tue,  9 Aug 2022 19:24:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D86AB40442;
	Tue,  9 Aug 2022 19:24:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D86AB40442
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86C23C0032;
	Tue,  9 Aug 2022 19:24:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70EEEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41D634071B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:24:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41D634071B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id azlQH3aHaJqy
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:24:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E874640442
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E874640442
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 19:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660073067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/3RbxJxGVSsLcMA8L1qFPTYGOuc2TNATaWYB7KmkbBM=;
 b=Gh4Uq2jaDmgcMAdz2tMcvhl4dPusrOaahpPwy1v3eLa4nDi4LcMvfmiKDTgFiW/qePbCqh
 2uCs5JAeySMhNNV0NESXJbpit/LiBz3raBL7bh6d+TIeLtQJpki4KKl/0++HHTYHXpzsce
 AHkLFLq4AIETY+h+FJWDtkdmxMifAAA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-DoNYW81aPjioB1J1H2oiBw-1; Tue, 09 Aug 2022 15:24:26 -0400
X-MC-Unique: DoNYW81aPjioB1J1H2oiBw-1
Received: by mail-ed1-f72.google.com with SMTP id
 l19-20020a056402255300b0043df64f9a0fso7821337edb.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 12:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=/3RbxJxGVSsLcMA8L1qFPTYGOuc2TNATaWYB7KmkbBM=;
 b=NQKIdv+Mb1OLHBo+0JTyHmRAi0f+mcWXr2r0ms1/ME+X3R4natKZfDl888XXEZjwFN
 LW3NJDZ7H0UoSzLMUHk3yzWA/Ms/OeGQydsvliCQArhPHqoJxpW2dYBiV6Afc0iRwtYo
 k/lsO1ynw6rlxqceHDWD0/GnXaZu/57qAW2UKfBUibBuBLjhxS7RDD+2sE9gRt3xaozD
 Hq2O6TBrERterrg1cyQQorqQ5xR97LVfWUdQLNvYccv6MQq1azGEseVjj85j/CqQPJ60
 Yf6QplGaVZ6KmjuD6FfCwf8yUdamwjFTPb29S1xN9TmuSGuCnHBwzRzHthE2nhkAFqOQ
 uvpw==
X-Gm-Message-State: ACgBeo0XLLliX9dZX9/KYC84PltPNUnhCDiBAQGx/JKJhFnXNrQih4wK
 1baGqVbSK2UOfFaU5oloQi2GROL7lbY4PUJyLPkwZhlBycLXxFR3N4DqtJALJ5e4kTTLlDY+GoN
 zsML5NP5E8cC5xVNoLivuwLmsVtvvVZEURBZZ5S0A2A==
X-Received: by 2002:a05:6402:3220:b0:43d:ca4f:d2b9 with SMTP id
 g32-20020a056402322000b0043dca4fd2b9mr23094734eda.177.1660073065072; 
 Tue, 09 Aug 2022 12:24:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5brrr+dQboK5ThN120g3Cj1H0pvT2rB9K/dhmHA5Z9w4zkI9/s3kRN1cm78F0pypjDI4qxFQ==
X-Received: by 2002:a05:6402:3220:b0:43d:ca4f:d2b9 with SMTP id
 g32-20020a056402322000b0043dca4fd2b9mr23094728eda.177.1660073064880; 
 Tue, 09 Aug 2022 12:24:24 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 a3-20020a170906670300b0072ee7b51d9asm1463010ejp.39.2022.08.09.12.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 12:24:24 -0700 (PDT)
Date: Tue, 9 Aug 2022 15:24:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH V4 3/6] vDPA: allow userspace to query features of a vDPA
 device
Message-ID: <20220809152259-mutt-send-email-mst@kernel.org>
References: <20220722115309.82746-1-lingshan.zhu@intel.com>
 <20220722115309.82746-4-lingshan.zhu@intel.com>
MIME-Version: 1.0
In-Reply-To: <20220722115309.82746-4-lingshan.zhu@intel.com>
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

On Fri, Jul 22, 2022 at 07:53:06PM +0800, Zhu Lingshan wrote:
> This commit adds a new vDPA netlink attribution
> VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES. Userspace can query
> features of vDPA devices through this new attr.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>


I think at least some discussion and documentation
of this attribute versus VDPA_ATTR_DEV_SUPPORTED_FEATURES
is called for.

Otherwise how do people know which one to use?

We can't send everyone to go read the lkml thread.

> ---
>  drivers/vdpa/vdpa.c       | 13 +++++++++----
>  include/uapi/linux/vdpa.h |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index ebf2f363fbe7..9b0e39b2f022 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -815,7 +815,7 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>  static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>  {
>  	struct virtio_net_config config = {};
> -	u64 features;
> +	u64 features_device, features_driver;
>  	u16 val_u16;
>  
>  	vdpa_get_config_unlocked(vdev, 0, &config, sizeof(config));
> @@ -832,12 +832,17 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>  	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>  		return -EMSGSIZE;
>  
> -	features = vdev->config->get_driver_features(vdev);
> -	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> +	features_driver = vdev->config->get_driver_features(vdev);
> +	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features_driver,
> +			      VDPA_ATTR_PAD))
> +		return -EMSGSIZE;
> +
> +	features_device = vdev->config->get_device_features(vdev);
> +	if (nla_put_u64_64bit(msg, VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES, features_device,
>  			      VDPA_ATTR_PAD))
>  		return -EMSGSIZE;
>  
> -	return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> +	return vdpa_dev_net_mq_config_fill(vdev, msg, features_driver, &config);
>  }
>  
>  static int
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 25c55cab3d7c..39f1c3d7c112 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -47,6 +47,7 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_NEGOTIATED_FEATURES,	/* u64 */
>  	VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,		/* u32 */
>  	VDPA_ATTR_DEV_SUPPORTED_FEATURES,	/* u64 */
> +	VDPA_ATTR_VDPA_DEV_SUPPORTED_FEATURES,	/* u64 */
>  
>  	VDPA_ATTR_DEV_QUEUE_INDEX,              /* u32 */
>  	VDPA_ATTR_DEV_VENDOR_ATTR_NAME,		/* string */
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
