Return-Path: <SRS0=Dilt=KZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED1C47091
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:06:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8695961107
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8695961107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50F166066F;
	Sun, 30 May 2021 08:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2uejoY3__Pyw; Sun, 30 May 2021 08:06:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD63E60611;
	Sun, 30 May 2021 08:06:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6EAAC000E;
	Sun, 30 May 2021 08:06:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50384C0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E57A403F3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Js_Gynau3U9I
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:06:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4019B403F2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622361964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NX5CisLnC1pyP4PekqKqumzxuKrlCViEzhuLDUOe43Y=;
 b=Y3mGqribvm7xm34TJ3DBISVSl034H42WeuuAE0bxK8e+x8F7P3GHaYytINW6X5VumxtUYN
 0YjulxH4IIsvtiyNs+Y3E0vgeYjgWUEqnXXvIPQ48huJB5LnfFnFNS6h3hrLh7L58d2WI8
 NXfUBk0GVIV3KNgqmbvwehTZANdSmnI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-EfMs9WQ3N8KLUCm_SvVWGw-1; Sun, 30 May 2021 04:06:02 -0400
X-MC-Unique: EfMs9WQ3N8KLUCm_SvVWGw-1
Received: by mail-wm1-f72.google.com with SMTP id
 h18-20020a05600c3512b029018434eb1bd8so3457489wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 01:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NX5CisLnC1pyP4PekqKqumzxuKrlCViEzhuLDUOe43Y=;
 b=S6GgCNsGgo1sP0cjKw0PywQJ8Vk5lbQiNYMkdjncwZ3IesDVS4UtfKXBxlh7J1fn0E
 eggkHH2lj9qeVcMkZCI+YI7hn/Gvs9jb4yTM9Z1PkK4mVbkO3lm/aPIMi/qi7q6HxGzw
 UPHyH0ONtYL8CtolutXEA68xtNDl9ArGZ6kz0xsb09anuQZvhdIN59g6Cb9O5a+aOp4v
 GiDmHRin7wx4JTsYxprTlME5d/3yQZt6GUUDUAjECwI257UBnx/r+o2sTPgDsRbGlpJ2
 iRf0zMUkCG0mBeBl0BFnw31ac211uGCRzHidQjlMJd82e6SPFNEMkpND320gnTUumxyg
 dbvQ==
X-Gm-Message-State: AOAM531FarDQcC1fbkIgnScFNVBg1MQbweJUL3d6YP5aHHJz45yMZ0sA
 RXQuC8mb7HZrogWV4xEU4YAQniAr/3O+GdmIqNC7WSrjKhob6imFgnywDtbj5LAEc4OL6rZsjKW
 Rm9ZmwBEheJdw8YVGMlzzFrH4DmhirIx7YeulMwwgbQ==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16856545wrr.37.1622361960974; 
 Sun, 30 May 2021 01:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzV9Wt0dtS5PjEX5+L92Ox40mbwufjCbQO/9Ony6WmOrZN5hMvfaOO8dN5dDeyPSfRFSHKAw==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16856533wrr.37.1622361960784; 
 Sun, 30 May 2021 01:06:00 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
 by smtp.gmail.com with ESMTPSA id g23sm1945301wmk.3.2021.05.30.01.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 01:06:00 -0700 (PDT)
Date: Sun, 30 May 2021 04:05:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size
 calculation
Message-ID: <20210530040523-mutt-send-email-mst@kernel.org>
References: <20210530063214.183335-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210530063214.183335-1-elic@nvidia.com>
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

On Sun, May 30, 2021 at 09:32:14AM +0300, Eli Cohen wrote:
> umem size is a 32 bit unsigned value so assigning it to an int could
> cause false failures. Set the calculated value inside the function and
> modify function name to reflect the fact it updates the size.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

could you clarify the impact of the bug please?


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 53312f0460ad..fdf3e74bffbd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
>  	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
>  }
>  
> -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> -		     struct mlx5_vdpa_umem **umemp)
> +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> +			  struct mlx5_vdpa_umem **umemp)
>  {
>  	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
>  	int p_a;
> @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
>  		*umemp = &mvq->umem3;
>  		break;
>  	}
> -	return p_a * mvq->num_ent + p_b;
> +	(*umemp)->size = p_a * mvq->num_ent + p_b;
>  }
>  
>  static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
>  	void *in;
>  	int err;
>  	__be64 *pas;
> -	int size;
>  	struct mlx5_vdpa_umem *umem;
>  
> -	size = umem_size(ndev, mvq, num, &umem);
> -	if (size < 0)
> -		return size;
> -
> -	umem->size = size;
> -	err = umem_frag_buf_alloc(ndev, umem, size);
> +	set_umem_size(ndev, mvq, num, &umem);
> +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
>  	if (err)
>  		return err;
>  
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
