Return-Path: <SRS0=Dilt=KZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFACC47091
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:05:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812BA610CC
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812BA610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 487C840389;
	Sun, 30 May 2021 08:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TDiCqXnCviRi; Sun, 30 May 2021 08:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A564F40381;
	Sun, 30 May 2021 08:05:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 764FDC000E;
	Sun, 30 May 2021 08:05:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F9B0C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6151860637
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:05:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ryW06PhDcHaH
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F43E60611
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622361924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tReJm3Ow3/2+blqVFpQuF41IER1CEjyexFjR1pvGmUI=;
 b=IUmmqnP6p1y849nI8NbhfDNvBoLMhoFnWbskdLr0MFJ3gFRATrCX5RtTvjKr/2mFoJGHAM
 s2gXBSvO5pIa1hgMQIrGOEDuOZEI1xiqcGivq8gptwTOyk7I8RhsCZuX3yymKpMFMyELvk
 9fOC5xVaprwEfFSOzFO1yH3UUXKIsXg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-0bx37yXEN2qsl6qo3RYVvg-1; Sun, 30 May 2021 04:05:21 -0400
X-MC-Unique: 0bx37yXEN2qsl6qo3RYVvg-1
Received: by mail-wm1-f72.google.com with SMTP id
 r15-20020a05600c35cfb029017cc4b1e9faso3441470wmq.8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tReJm3Ow3/2+blqVFpQuF41IER1CEjyexFjR1pvGmUI=;
 b=D1KTmEbKzz5FaiL/ELkQkURHEwTc/An4eFopo3ovpuQBUpQuJaK/1f9wpC1g726AIP
 ucDR4vqMGCkvXJxAy+onwWRaledbImWYuziu/y+9oDs6ghDZpvV7oAErcateIjg72jOR
 YWEllbTPjimC9N4/MkA3U5p2OV++cS3543BWJrRlb0RyFU8aVwCOpJAfr06VPtxImX0L
 fhEpZB9q0BvVL002pyBtOVIXukDqTGV0orh72FlMVdeiqf9SEs7uVQhqfqKEeDwh4xaM
 mPcJw9VhMGNmxMErpf/E45s4pwh3HpJRoPi0z7ITrhYbYwL97i1F2dtqTnTbRbB+KNHT
 qA9Q==
X-Gm-Message-State: AOAM5314ot3RGERKW0ZnRmAGKTG0SEjKqlxHgZSXICdlELRy6/zXaSCd
 xsbWrszT27dul+KGLPJJ3qn7fCXxvj9WwBfXnSF1Xt+/uLWYBYOWn44ob4bc0R/g5O004ABE3mO
 vYc7kE0fdLuaoU2Xyxt5eLbhzvlT/bwmOCYCVnFw2yw==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr743512wro.223.1622361920195; 
 Sun, 30 May 2021 01:05:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3YZyoXl4vPpKtwFqJkPaieEu99nqVfKrgR4uhLGUlDtCIVD6ILm7Z7HET2KJNYvxCHfOkPw==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr743497wro.223.1622361920084; 
 Sun, 30 May 2021 01:05:20 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
 by smtp.gmail.com with ESMTPSA id b10sm13137948wrt.24.2021.05.30.01.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 01:05:19 -0700 (PDT)
Date: Sun, 30 May 2021 04:05:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530040458-mutt-send-email-mst@kernel.org>
References: <20210530063128.183258-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210530063128.183258-1-elic@nvidia.com>
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

On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> Fix copy paste bug assigning umem1 size to umem2 and umem3.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

could you clarify the impact of the bug please?

> ---
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
