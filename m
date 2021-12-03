Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9FDC433EF
	for <virtualization@archiver.kernel.org>; Fri,  3 Dec 2021 02:21:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4FC6583410;
	Fri,  3 Dec 2021 02:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PXkFdx_fvGmb; Fri,  3 Dec 2021 02:21:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0107683412;
	Fri,  3 Dec 2021 02:21:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3134C0012;
	Fri,  3 Dec 2021 02:20:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38E0BC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2835483412
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lV6Qy91U5jEx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:20:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C4F2983410
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 02:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638498056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B939E1I3InUJP/mUE6XG84CgxBtTe2OjIi5E6fRGXbE=;
 b=IolThux9+MPyI+7soMiL22T/t+0J5EdBIWf6/6o1qDo/oUj6IXzOyorPkXdm6fyFfmtLxo
 kYoOGOUW3cMd4NX4Aw9lgSWLT2tsdAwF3s6Jj4nlSSSrOtm5z3eNTbW3+pd8BeQnk3e6gj
 X/6RHdoYwGyzqcdgAkcf2vQOmXAPVq8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-TlRo4t4rNciQUtpG2pP8Tw-1; Thu, 02 Dec 2021 21:20:55 -0500
X-MC-Unique: TlRo4t4rNciQUtpG2pP8Tw-1
Received: by mail-lj1-f200.google.com with SMTP id
 p18-20020a2eb7d2000000b0021ba3ea3c42so608783ljo.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Dec 2021 18:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B939E1I3InUJP/mUE6XG84CgxBtTe2OjIi5E6fRGXbE=;
 b=100a1Jwx9E8wbFh+ElL3kaTcHP0idOgQGviTtJTwCp2bGw91xTzcBxe9bqpKkYCfNT
 dntiMQNBdDP8sGP/m015fLTdGjh0JOfeaiZb1iLP4kDi1sarf7WSxVugDFPI7o56U/50
 5FFUMPfxT6reb3siFiewYuyDjayoHYpuWKQbVgpUetxQQCZnQOhWOEk2pdsEQwVFAib6
 sJru3KfmqAw95OKBshAxOFka7e3nCLPynBHXrBJJqJqnoN++EOPqcJMR/OTV19bjvn5J
 GFJeKWKLA+VcKJPMytXsGU+6B6yL4Sr8m2KfQ6DUMUJQI0fD+V+uvqEU7welyAiYcRpK
 G8sg==
X-Gm-Message-State: AOAM531Pn8w3EiFUWTk54smWsUt2IjhWvycfV+8qqwzItQ15wlhxgLdH
 69oYnDh4Gk6mGavDNvfnrDntS902W1LBFRMA8IC6spmVjImBLRW1S0DKpiCEuDMItY5aHIQIsiX
 KsJ8hspK4UNbweWhdnexee6rKTdiQ0PODl0D7vYkamzUSX055lgw8ZZXw1w==
X-Received: by 2002:a2e:8507:: with SMTP id j7mr15281192lji.307.1638498054023; 
 Thu, 02 Dec 2021 18:20:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw08rddZN8Hjb+B+f+JYaVHYkUpE1BM68G24hHa4MfYdwSthygePe6KVsLPyzWIj6SDOGYvZlRTLqF2n7bD0zc=
X-Received: by 2002:a2e:8507:: with SMTP id j7mr15281177lji.307.1638498053850; 
 Thu, 02 Dec 2021 18:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20211201195724.17503-1-elic@nvidia.com>
 <20211201195724.17503-3-elic@nvidia.com>
In-Reply-To: <20211201195724.17503-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 3 Dec 2021 10:20:43 +0800
Message-ID: <CACGkMEto7hkx6ZCADBzFW0YXh633LnbzzEmFenmwGZKKohXyQw@mail.gmail.com>
Subject: Re: [PATCH 2/7] vdpa/mlx5: Fix config_attr_mask assignment
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Thu, Dec 2, 2021 at 3:58 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Fix VDPA_ATTR_DEV_NET_CFG_MACADDR assignment to be explicit 64 bit
> assignment.
>
> No issue was seen since the value is well below 64 bit max value.
> Nevertheless it needs to be fixed.
>
> Fixes: a007d940040c ("vdpa/mlx5: Support configuration of MAC")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 63813fbb5f62..b66f41ccbac2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2676,7 +2676,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>         mgtdev->mgtdev.ops = &mdev_ops;
>         mgtdev->mgtdev.device = mdev->device;
>         mgtdev->mgtdev.id_table = id_table;
> -       mgtdev->mgtdev.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +       mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
>         mgtdev->madev = madev;
>
>         err = vdpa_mgmtdev_register(&mgtdev->mgtdev);
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
