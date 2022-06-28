Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4894DCCA479
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 20:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD1D360B2B;
	Tue, 28 Jun 2022 20:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD1D360B2B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XGJ4V51o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2dvjCSR5J5cp; Tue, 28 Jun 2022 20:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5305060AC1;
	Tue, 28 Jun 2022 20:40:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5305060AC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 264F7C0039;
	Tue, 28 Jun 2022 20:40:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F27DFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 20:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BCA4440866
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 20:40:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BCA4440866
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XGJ4V51o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SzHiK5wHDqoG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 20:40:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A683140877
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A683140877
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656448805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGLaXyxLtS2RSX+ruaLC5L5b9q7shHcOM9kFn/gAU+s=;
 b=XGJ4V51oQCzRJHDQ1EsSm1JMjihLg57tMOtgol/zduZrERVftCB6auf20CUhEeXppb+Grs
 bG63GrXNxPinJTYpTKDq6fgM+1OeXe6lFbIRWczyuuaAJt/pk+SF2X6Nfm69yTr9BELncz
 0TAUq4QB2lnSXtMrrB4NQ9TzSAMviZk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-KYVtX6BzPsayKpLTYLloFA-1; Tue, 28 Jun 2022 16:40:02 -0400
X-MC-Unique: KYVtX6BzPsayKpLTYLloFA-1
Received: by mail-wr1-f69.google.com with SMTP id
 y18-20020adfdf12000000b0021b94ba4c37so2009459wrl.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 13:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CGLaXyxLtS2RSX+ruaLC5L5b9q7shHcOM9kFn/gAU+s=;
 b=y89oesKTFqBBkBRdTpcAXIQ7VbGIsFF+G/CYnuFSDF3XfsjlZlwM4VSJoBH3OD3n+w
 77igpqw/X1XEhfVDtlhBNQWx+AUHlHi6lCZmC4kIdUnoFhVHblxzWSXKt1wFhhmdShiA
 d8cNmNadPaWttWOP/sKDkTlzJ8sKMjgA03otD6UBsevm+40EBYg6FZ7UXOqd3+IiYD8F
 jOtUnNyqCbtvRRGwOIgB/n2JKuqg3Vbqi6lUq2pyfCh+0zqqov+4bYl190Rbe6BCQAIK
 JzPTWBaG1m7+MtEMcuSGBmPmOCeXs7zjwTOSJV7RqYQfgWX7ubZaaiR6LX5OIbSA4W3u
 7pEg==
X-Gm-Message-State: AJIora/IkqHviGSrjScvffiyN6afgN+pquUNkKnJnxEZq/jecudkZ0ST
 Z0+FJaJe0nodhzqLCL1/FLaBzaWlKVBT9P409lbPjqBZ7vTDtK9nL8/ZtK4C3NfpYAxsOZR1fSW
 A4/hU/L+oA0iqvnVZJwk7AQHvVyisK1qSsezf/OxuHQ==
X-Received: by 2002:a5d:4205:0:b0:21b:89ea:b5e3 with SMTP id
 n5-20020a5d4205000000b0021b89eab5e3mr18403183wrq.103.1656448800864; 
 Tue, 28 Jun 2022 13:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stXRbnYj9xa9v+Dh058tTTbo+XuIUckpFFfQHVMfNz/XwZpJF2tJtQ/iyTQoS3Mc1VNz2gcw==
X-Received: by 2002:a5d:4205:0:b0:21b:89ea:b5e3 with SMTP id
 n5-20020a5d4205000000b0021b89eab5e3mr18403174wrq.103.1656448800651; 
 Tue, 28 Jun 2022 13:40:00 -0700 (PDT)
Received: from redhat.com ([2.52.23.204]) by smtp.gmail.com with ESMTPSA id
 c3-20020adfef43000000b0021bab0ba755sm15121087wrp.106.2022.06.28.13.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jun 2022 13:40:00 -0700 (PDT)
Date: Tue, 28 Jun 2022 16:39:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xu Qiang <xuqiang36@huawei.com>
Subject: Re: [PATCH v2 -next] vdpa/mlx5: Use eth_zero_addr() to assign zero
 address
Message-ID: <20220628163950-mutt-send-email-mst@kernel.org>
References: <20220628123457.90884-1-xuqiang36@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20220628123457.90884-1-xuqiang36@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 rui.xiang@huawei.com, elic@nvidia.com
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

On Tue, Jun 28, 2022 at 12:34:57PM +0000, Xu Qiang wrote:
> Using eth_zero_addr() to assign zero address instead of memset().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2:
> - fix typo in commit log
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index e85c1d71f4ed..f738c78ef446 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1457,8 +1457,8 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>  
>  	*ucast = rule;
>  
> -	memset(dmac_c, 0, ETH_ALEN);
> -	memset(dmac_v, 0, ETH_ALEN);
> +	eth_zero_addr(dmac_c);
> +	eth_zero_addr(dmac_v);
>  	dmac_c[0] = 1;
>  	dmac_v[0] = 1;
>  	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> -- 
> 2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
