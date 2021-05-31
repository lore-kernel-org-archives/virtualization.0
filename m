Return-Path: <SRS0=j1Zo=K2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5AFC47080
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 22:17:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A456061287
	for <virtualization@archiver.kernel.org>; Mon, 31 May 2021 22:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A456061287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5EA9F403D9;
	Mon, 31 May 2021 22:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oQZlLHLU7Bx4; Mon, 31 May 2021 22:17:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C07F9403CF;
	Mon, 31 May 2021 22:17:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98E6CC000E;
	Mon, 31 May 2021 22:17:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 176C3C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 22:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3F7560698
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 22:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pPlO88F_cLgd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 22:17:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CD1060674
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 22:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622499438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vWZ8xCrJBhMcZuS98MgK+sFxBqjVnSvSx0xIJ+voYlE=;
 b=CskQYOD4fFsTJcHd8j3X8htYAzwmpL6s/uwV6Ci8HxWgcX6rF4pxUaA74FRWIAogW8qRN/
 dlavnhFKgMJ73UT8DOWprNk82uHK/kfIyxgBAam65Uppu4yiFWFVfPi9IlGGNLsjO8E6Nc
 o2tW+miXyYmcotbtTU7b1mZOYqb4VoQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-qMwEzmaIPu-o1bupXBMKWQ-1; Mon, 31 May 2021 18:17:17 -0400
X-MC-Unique: qMwEzmaIPu-o1bupXBMKWQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 v20-20020a05600c2154b029019a6368bfe4so468352wml.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 May 2021 15:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vWZ8xCrJBhMcZuS98MgK+sFxBqjVnSvSx0xIJ+voYlE=;
 b=tGn4muUreiibgmHxtLb/VqaKzbx71YdVbRpxWCsNy1juUCORlwMsiIviD44fLh+uom
 R2QI/JZLTZLJgwzSX+3lUurEQ1GQKnpo5c1tpbET+bcAfGxiU9T5LjzotGO1dtYJ0G4h
 kx8ZFecqYysrdYVQLN0HYan8jblxYHzWUO9mdAbfDOnCYGKvXk9SpfyEhCdCHyFYqqld
 MKloSGElZaUXsL6Z8Nb8mmcDvfeIdrKx2KgCPrOTKz5JCL/6MAr0e/Q7pKDox66Mk+q4
 uHOCn6v0RyHXCKwRKWKTVbHsjZsKTQdBMeM9LQFMpBcnqKaNuOOhDOmRS017AQRopOEg
 2OVA==
X-Gm-Message-State: AOAM5314pWqawG612sQRumoll+ve60+5nUTngG9ZOuZ8av4E4daN4/0P
 P45G1MZpv1o0KOTKAhVSYqegmAY0FVY2pak7cjdIVFxjiNmKwVpS5+lqZCkqwUeTwsU2TGg2Lyh
 S5n/f7Qx3OhxdstBmlCGDzmvi2RNsC56QM8A+toFzmQ==
X-Received: by 2002:a5d:53cc:: with SMTP id a12mr23446294wrw.99.1622499436068; 
 Mon, 31 May 2021 15:17:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXRodfWnHB+31Age1AmUO6iZTwwVWYMIm4yUA9myLBI4/b7iTAjqbakreBdELXdp88iTeueQ==
X-Received: by 2002:a5d:53cc:: with SMTP id a12mr23446288wrw.99.1622499435962; 
 Mon, 31 May 2021 15:17:15 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1001])
 by smtp.gmail.com with ESMTPSA id m5sm649897wmq.6.2021.05.31.15.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 May 2021 15:17:15 -0700 (PDT)
Date: Mon, 31 May 2021 18:17:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1 1/2] vdpa/mlx5: Support creating resources with uid == 0
Message-ID: <20210531181704-mutt-send-email-mst@kernel.org>
References: <20210531160404.31368-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210531160404.31368-1-elic@nvidia.com>
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

On Mon, May 31, 2021 at 07:04:04PM +0300, Eli Cohen wrote:
> Currently all resources must be created with uid != 0 which is essential
> when userspace processes are allocating virtquueue resources. Since this
> is a kernel implementation, it is perfectly legal to open resources with
> uid == 0.
> 
> In case firmware supports, avoid allocating user context.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 --> v1:
>   Fix typo and modify phrasing

threading's broken now

>  drivers/vdpa/mlx5/core/resources.c | 6 ++++++
>  include/linux/mlx5/mlx5_ifc.h      | 4 +++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 6521cbd0f5c2..836ab9ef0fa6 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev *mvdev, u16 *uid)
>  	void *in;
>  	int err;
>  
> +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
> +		return 0;
> +
>  	/* 0 means not supported */
>  	if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
>  		return -EOPNOTSUPP;
> @@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev *mvdev, u32 uid)
>  	u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
>  	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
>  
> +	if (!uid)
> +		return;
> +
>  	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
>  	MLX5_SET(destroy_uctx_in, in, uid, uid);
>  
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index 9c68b2da14c6..606d2aeacad4 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
>  	u8         uar_4k[0x1];
>  	u8         reserved_at_241[0x9];
>  	u8         uar_sz[0x6];
> -	u8         reserved_at_250[0x8];
> +	u8         reserved_at_248[0x2];
> +	u8         umem_uid_0[0x1];
> +	u8         reserved_at_250[0x5];
>  	u8         log_pg_sz[0x8];
>  
>  	u8         bf[0x1];
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
