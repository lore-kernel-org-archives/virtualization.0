Return-Path: <SRS0=Dilt=KZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DF3C47091
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:37:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071D1610FC
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071D1610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF35240159;
	Sun, 30 May 2021 08:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pSRqk_cr787U; Sun, 30 May 2021 08:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B2294010E;
	Sun, 30 May 2021 08:37:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ECFBC000D;
	Sun, 30 May 2021 08:37:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F780C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E11E83B46
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:37:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V19x2Xa0u60I
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:37:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD55A83B35
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622363865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7rqctKhoICHjp9iSUtNIx5KUFyzc0TpaGiXHDc7I/jo=;
 b=aNM785XsMNk0UtUZ0UBhPiY3U8NzowvP+xLOrQscQBl2OzjQCGuk+26I/pIExfChObEUXw
 mTD16jJcZtDLGmp+WDHlOmLLc4qMKB9/WW7k3IymhrbSUzp5QZvayRTb3DIvh80mWL5ewy
 2zJah9R1i70a96qcCIPgfSnAtXo5J08=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-H5EEc9HvM2qAn4ofL3fwOg-1; Sun, 30 May 2021 04:37:43 -0400
X-MC-Unique: H5EEc9HvM2qAn4ofL3fwOg-1
Received: by mail-wm1-f72.google.com with SMTP id
 19-20020a05600c2313b0290193637766d9so3482857wmo.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 01:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7rqctKhoICHjp9iSUtNIx5KUFyzc0TpaGiXHDc7I/jo=;
 b=O5Dm4/6QVKdIf8X8uBcbqKiFTlcLr4/iMCWCgJgTORkhUx5rMhufqDcbm+ylda1CTI
 zW+ddxDjOXwIdY8xoV86Vcc1AxO9EDPP4ZhUBLbdRF52kxrKnOD3FxgwVG9OMOV1l5OX
 IECngG5U15CuZhAuKHFN4jjw6PhivTbf4g1n8HmkMrGijQW24GuaOnYM8CsfHfoNI95Z
 /h0PUCdVFc+BozxZ6ShMhSz2n3xtMqgcEG0d2TwEifsrmphsBOTkB/2ClHSNMqhxwClY
 JYQH9xEk3YsdZDN7iXXBjnO0HK5REAR8eOXQ5L9TYN3WCJWolArheZKRyUit+c57SNjf
 ajHg==
X-Gm-Message-State: AOAM533B4uMvnoLqJN76hEYGo59+0LdCdOOA06EfU7qv0W60aWmHzb5x
 u/mey9fZrAgyJeFXfJltZzrkfwMQ+32V+I1PJ0jPNwjQ+eSsRyxy9JH7fV32oXnKNYK1N+5dvyV
 aNg+90kIWoL/QhjvbOVvTl+3/86VH+GCKG1zTy8Z8Ag==
X-Received: by 2002:adf:d841:: with SMTP id k1mr10069384wrl.193.1622363862712; 
 Sun, 30 May 2021 01:37:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1U8xwRNt+X8PjA3ahWySkMBG5NHinYPh7n/TG9N62+RkeXncyT1J8vzojlFGX7/MoL/Bj1w==
X-Received: by 2002:adf:d841:: with SMTP id k1mr10069373wrl.193.1622363862586; 
 Sun, 30 May 2021 01:37:42 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
 by smtp.gmail.com with ESMTPSA id 25sm2268339wmk.20.2021.05.30.01.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 01:37:42 -0700 (PDT)
Date: Sun, 30 May 2021 04:37:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530043721-mutt-send-email-mst@kernel.org>
References: <20210530083548.6545-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210530083548.6545-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, May 30, 2021 at 11:35:48AM +0300, Eli Cohen wrote:
> Fix copy paste bug assigning umem1 size to umem2 and umem3. The issue
> was discovered when trying to use a 1:1 MR that covers the entire
> address space where firmware complained that provided sizes are not
> large enough.

.. creating the virtqueue then fails?

> 1:1 MRs are requied to support virtio_vdpa.

typo

> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> V0 --> V1:
> Add more information in changelog
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 189e4385df40..53312f0460ad 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
>  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
>  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
>  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
>  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
>  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
>  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
>  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
