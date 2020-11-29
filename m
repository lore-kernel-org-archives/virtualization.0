Return-Path: <SRS0=PU37=FD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524A7C3E8C5
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 20:08:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8782720756
	for <virtualization@archiver.kernel.org>; Sun, 29 Nov 2020 20:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWVt2NsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8782720756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3F5D487232;
	Sun, 29 Nov 2020 20:08:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mHjyOGJ4uD9g; Sun, 29 Nov 2020 20:08:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A267E87117;
	Sun, 29 Nov 2020 20:08:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84799C163C;
	Sun, 29 Nov 2020 20:08:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 140DCC0052
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 20:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 02C128707C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 20:08:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tqg5x6AHQgAr
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 20:08:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3F3E28706C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 20:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606680509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QxI+akPL+TVvqGXQqCSO9a4+uClCIKdg0MUm21BHJok=;
 b=fWVt2NsAHcLuzsadOASqsYvAmXmTPltVxpvhyU6ozjAa/7gUDL1bj3V90yofo4AIIWdrua
 DXSQCZHE4E+CuOjQIOHwaOzemu6GnZPR09YKuzGmCaTWPS6UQ9hY5OaDzEZiRLmwio8TBx
 EMXgMCVC0feLxSNChrZZ9rhzuYpGV4k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-H-yErZyuNwyhI_gOb9a_yA-1; Sun, 29 Nov 2020 15:08:27 -0500
X-MC-Unique: H-yErZyuNwyhI_gOb9a_yA-1
Received: by mail-wr1-f70.google.com with SMTP id p18so7023144wro.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Nov 2020 12:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QxI+akPL+TVvqGXQqCSO9a4+uClCIKdg0MUm21BHJok=;
 b=H2Zj1LZtoCUxmMIwbUhXSxzNmzpIEi48J+A0AlOVMHp8y2Hpa5aNnmGGgL4pdlYeKM
 gZyC74OPQm3ao/0jeBvfHNRRnHycKCOWBbVr4lph30QvxRt/EZPF90mEae9oCFjZRoTl
 nUAkHzlV5mskY8O1o4mk34s98QqiNMmTTHZOHJxz9T+l93g9/II4sgEWKdbXMYQPc9/f
 atYz6ucr0ePfyoymWDQFj0ww8mG0s7HuoDurCGa8ykp8T8lNbIxAC+2p86OQo/DdKoZ8
 l/Itt2hj1jT7UN0Rn24t4YTIXVVm/ZWu9+jrKSEAU75wYmLpx8L6JIhrpjOkDa5p4FtU
 Aomw==
X-Gm-Message-State: AOAM5337VM5PXJsF7Z7emwtZoZCbkVyHMHeRHQX6Lwc7LqAZ8iSl8Ekl
 2TcQShap9BaWPaloUB6OzKYs9Lv4cSV1Rhn418bG9AUjL1Ea/k9+Wedei9SkBf9O2ElLfdj0TvF
 HwBNdGGM3pe+LFj3Yu7hOhaopenNIEXE4ygdrTLRZew==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr24089358wrq.52.1606680506281; 
 Sun, 29 Nov 2020 12:08:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4Zj8VIghM/MlJoqfcfMhVOHFZnrUyaoXQhAaYqwHPALiKJBGd4W7o8bomBMGnHNhTo+rlKg==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr24089338wrq.52.1606680506079; 
 Sun, 29 Nov 2020 12:08:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id 34sm24064412wrh.78.2020.11.29.12.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Nov 2020 12:08:25 -0800 (PST)
Date: Sun, 29 Nov 2020 15:08:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Use random MAC for the vdpa net instance
Message-ID: <20201129150505-mutt-send-email-mst@kernel.org>
References: <20201129064351.63618-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20201129064351.63618-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, lulu@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Sun, Nov 29, 2020 at 08:43:51AM +0200, Eli Cohen wrote:
> We should not try to use the VF MAC address as that is used by the
> regular (e.g. mlx5_core) NIC implementation. Instead, use a random
> generated MAC address.
> 
> Suggested by: Cindy Lu <lulu@redhat.com>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

I didn't realise it's possible to use VF in two ways
with and without vdpa.
Could you include a bit more description on the failure
mode?
Is switching to a random mac for such an unusual
configuration really justified?
It looks like changing a MAC could break some guests,
can it not?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1fa6fcac8299..80d06d958b8b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1955,10 +1955,7 @@ void *mlx5_vdpa_add_dev(struct mlx5_core_dev *mdev)
>  	if (err)
>  		goto err_mtu;
>  
> -	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
> -	if (err)
> -		goto err_mtu;
> -
> +	eth_random_addr(config->mac);
>  	mvdev->vdev.dma_dev = mdev->device;
>  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>  	if (err)
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
