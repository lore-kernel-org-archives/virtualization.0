Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37263C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 12:52:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE0521744
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 12:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3/QGZQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE0521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D17E187765;
	Wed,  5 Aug 2020 12:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hWC6BcXHQ-X9; Wed,  5 Aug 2020 12:52:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A47187758;
	Wed,  5 Aug 2020 12:52:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D027C0050;
	Wed,  5 Aug 2020 12:52:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD74C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 23EC3866AD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jZ-wMDG7zhZx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 86DB18651C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596631923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=STRPg9BVyZpQBUjxmFISwRqEbAWE+bVhgTrTRTM6kiY=;
 b=D3/QGZQSAA2OsI2V3OXp3qXlfCepHr7eShVLwK3GAyfcsZPviABBQCErZhYzlz1Sm4Z8rt
 UCwv/tzx57IEm60mmV+L/gXykoLpNsOQb9Dy5czbDGbys+RZD3LQUpgWNco0GseKDUOt0h
 VitRNoLCBiInqSE/Rljn/r4fZdDD8Hw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-joCC9CMIMBeYLwIXNL9cgA-1; Wed, 05 Aug 2020 08:52:01 -0400
X-MC-Unique: joCC9CMIMBeYLwIXNL9cgA-1
Received: by mail-wm1-f71.google.com with SMTP id t26so2686809wmn.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 05:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=STRPg9BVyZpQBUjxmFISwRqEbAWE+bVhgTrTRTM6kiY=;
 b=TFCCAjMBzn28kUAf2TyayMXGEtfQchYdXpsJ52E2UZzP3TXvx1PHUSBhgMHvbkzjJI
 M+6AirpVlWEcXHDXzf4GJjsZ/56pF+jItNRXH1RmbMXnWJxQy1CTHKAy460INIOV76x5
 kBEbs4CJGh+cnz1G2/d4jn35ACyyWpyhPT7HSHhNPX0rmalqytpzEgZnZ4K/qSdjWlA3
 4eZIEXyO1jU6YQeeGoqoeX8giXWGQHNOG4ivxazhydlALy9s8F0ysbBu/PRViRKoHhOg
 ZVI+N3B/6IZ1VRmFsyrVJ6RUf1x/HDLkO4LyGR40vMeQBhFp9tmG0oNarhUMREidIbLK
 BayQ==
X-Gm-Message-State: AOAM530Ozm7Z0XVVSchXVC98f58QpqCkEbqlSGHYLhYHREN/h2fI0XGJ
 gj72UONlAhr14Utz8HzlCS0X8KLFS63b216t5dXn5F8iUQSlci8MMu8Xvg1sp6Cp/l5PF+UPJNU
 U4iqQFgvfs0LLJqRzOrZyHulQI97oihldLaFYAStRQg==
X-Received: by 2002:adf:df91:: with SMTP id z17mr2983498wrl.149.1596631920759; 
 Wed, 05 Aug 2020 05:52:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6umQ9Sab+V6SIKbgtKo5j71BttoOfNgpgZYy1vFuI8eJ1cruGln/hlGyt7wK7Wd/qXgH6+A==
X-Received: by 2002:adf:df91:: with SMTP id z17mr2983483wrl.149.1596631920602; 
 Wed, 05 Aug 2020 05:52:00 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
 by smtp.gmail.com with ESMTPSA id
 p6sm2796795wmg.0.2020.08.05.05.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 05:51:59 -0700 (PDT)
Date: Wed, 5 Aug 2020 08:51:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200805085035-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200617032947.6371-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> This patch introduce a config op to get valid iova range from the vDPA
> device.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/vdpa.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 239db794357c..b7633ed2500c 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -41,6 +41,16 @@ struct vdpa_device {
>  	unsigned int index;
>  };
>  
> +/**
> + * vDPA IOVA range - the IOVA range support by the device
> + * @start: start of the IOVA range
> + * @end: end of the IOVA range
> + */
> +struct vdpa_iova_range {
> +	u64 start;
> +	u64 end;
> +};
> +


This is ambiguous. Is end in the range or just behind it?
How about first/last?



>  /**
>   * vDPA_config_ops - operations for configuring a vDPA device.
>   * Note: vDPA device drivers are required to implement all of the
> @@ -134,6 +144,9 @@ struct vdpa_device {
>   * @get_generation:		Get device config generation (optional)
>   *				@vdev: vdpa device
>   *				Returns u32: device generation
> + * @get_iova_range:		Get supported iova range (on-chip IOMMU)
> + *				@vdev: vdpa device
> + *				Returns the iova range supported by the device
>   * @set_map:			Set device memory mapping (optional)
>   *				Needed for device that using device
>   *				specific DMA translation (on-chip IOMMU)
> @@ -195,6 +208,7 @@ struct vdpa_config_ops {
>  	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
>  			   const void *buf, unsigned int len);
>  	u32 (*get_generation)(struct vdpa_device *vdev);
> +	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
>  
>  	/* DMA ops */
>  	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
