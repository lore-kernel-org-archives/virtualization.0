Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF41C433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49E2540673;
	Thu, 25 Nov 2021 07:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xnTCitgZKXnd; Thu, 25 Nov 2021 07:21:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EDD96405EE;
	Thu, 25 Nov 2021 07:21:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD8AFC002F;
	Thu, 25 Nov 2021 07:21:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D918C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F209F405F3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:21:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6Kk_Q6hF0Qd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:21:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E4FC405EE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637824913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8/9xPcC6DeKRL8lq91e0Lj3sO56CjCUpsQya2Bns/lE=;
 b=SpsEjQyDduw+pmyO+h2w9kSOO7R5YAgN6FY5cdR1kuG+l5VOOYsA4SJIO9ZUbSr7x6VYhH
 N8SqIFmFe+8lgIbbwDsuloMqd6x753rbqz8Kf6QEHttNNELik0cXjCuNg+j0lnF0kMBnij
 hrfCk/F3XY+fJDm255pCcD7GP9MfmUM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-evOXAeriNO2olOFAQkwDeQ-1; Thu, 25 Nov 2021 02:21:52 -0500
X-MC-Unique: evOXAeriNO2olOFAQkwDeQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 w18-20020a056402071200b003e61cbafdb4so4672714edx.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8/9xPcC6DeKRL8lq91e0Lj3sO56CjCUpsQya2Bns/lE=;
 b=USvUG474/CSHVcp0WydVm9wiWRtpuJtawsawewuPrJCwWbkcWj2ypTq1z5a6Mb4tzZ
 uMiIN5+o82OdxbJeMcZ+2ukjPGSZDmdScQrrpGbbc8DhDgvWKbOKbCjPiLIIcPgc4C3T
 EXNZrgPWzhf9d/KqgUDhGxcP3SsgjwulMB4dDdsYhm9vhrKkewqp+0CoF9kmjIKKVrRi
 rkEltngvE1sVhaBeR7RPIJeoP1kX3oZFQqLbuP1EFzmWogaeavOCT/aVmV5pzF+77GIm
 xfm0+CKR87nnFjKKnBzdFWwct3OfTfddt8TPGLbmejQy6U1INhSZrs1iVYOtvzBSFR4d
 h4xg==
X-Gm-Message-State: AOAM530t7xcWx74/8XgSrorI4CQGdkEFNhMaN06f2nVkpSb7GwW/2Uco
 9hDEnXYdpGLMvkLFrozuaSaQKJqMaXRcu1uTzUWE509sFsR4Qn2Qj0d4jO2QqibOLSC/w3r3aOR
 37sdadYvkfczEIQ6qIgh0zVrVAiT+0/4PxfxJOGAZuQ==
X-Received: by 2002:a50:c3c8:: with SMTP id i8mr36170722edf.317.1637824911122; 
 Wed, 24 Nov 2021 23:21:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBTXcMdmvh1F7B5V4no2HywR+kq/bVF3X5Bl0RbCz9hIQs9c3i83fl7F2nESM2+4BuElNa/Q==
X-Received: by 2002:a50:c3c8:: with SMTP id i8mr36170700edf.317.1637824910924; 
 Wed, 24 Nov 2021 23:21:50 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
 by smtp.gmail.com with ESMTPSA id hb10sm999563ejc.9.2021.11.24.23.21.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 23:21:50 -0800 (PST)
Date: Thu, 25 Nov 2021 02:21:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] net/mlx5_vdpa: Increase the limit on the number of
 virtuques
Message-ID: <20211125022011-mutt-send-email-mst@kernel.org>
References: <20211124171953.57858-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211124171953.57858-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, si-wei.liu@oracle.com
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

On Wed, Nov 24, 2021 at 07:19:53PM +0200, Eli Cohen wrote:
> Increase the limit on the maximum number of supported virtqueues to 256
> to match hardware capabilities.

Hmm and are we going to have to tweak it each time new hardware/firmware
is out? Can't this be queried in some way?
In fact there's a suggestion in code to remove the limitation -
any plans to do this?

> Signed-off-by: Eli Cohen <elic@nvidia.com>

typo in subject

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ed7a63e48335..8f2918a8efc6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -135,7 +135,7 @@ struct mlx5_vdpa_virtqueue {
>  /* We will remove this limitation once mlx5_vdpa_alloc_resources()
>   * provides for driver space allocation
>   */
> -#define MLX5_MAX_SUPPORTED_VQS 16
> +#define MLX5_MAX_SUPPORTED_VQS 256
>  
>  static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>  {
> -- 
> 2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
