Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239DCC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 04:04:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1162833C9;
	Wed,  6 Jul 2022 04:04:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1162833C9
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sf33WuwX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 83qrjUKhcMSr; Wed,  6 Jul 2022 04:04:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6858183372;
	Wed,  6 Jul 2022 04:04:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6858183372
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41821C0077;
	Wed,  6 Jul 2022 04:04:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 366ACC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 01B9740329
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:04:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01B9740329
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sf33WuwX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EzGmVaxJ-mnK
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:04:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B2D3400FE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B2D3400FE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Jul 2022 04:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657080276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PW1JA3IwMBbLhLVaMU9NmnNjjRdTnwQkFv7IrA803Lg=;
 b=Sf33WuwXzGjG3rZllLwDeSlBj4dACU/1wgfxw6e/xdjh6dBsZexXSS/KL7jXA0nBYBHOfm
 fT6skbWkuWlJdmgC8TwL9XANPW961djohDn9bNGGZh+OYZi4ltheELUhmrEHDaF2O5fghc
 Ox6FrX1pYW3Ep6GsrUFBC9QuH4bDkrg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-YUxHM6k2NbmM6_B_2Y5LZQ-1; Wed, 06 Jul 2022 00:04:35 -0400
X-MC-Unique: YUxHM6k2NbmM6_B_2Y5LZQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 br6-20020a056512400600b00482af9d63faso2389971lfb.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jul 2022 21:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PW1JA3IwMBbLhLVaMU9NmnNjjRdTnwQkFv7IrA803Lg=;
 b=QZyI/F1J6FF5qLoCsPau45d+XqMBfFG/M3fDc7+eL5Qu+M5ayJO5xTaiplO0Uq4+5N
 ScPQYFL1hCI/P5jHEEe1SlsdI8VFzy9LA4In9KicyOXGWxNjHJhtBXGIajMTF9P4+aOQ
 RNXD9Ocemr89kgk4DMEtePmNwhCoEhSULfP+d5y0jEUrAB/xWck3h+y201M0igRJxzZi
 qpgaopTk+f7l30u5Gm619zahQjEsrvEp77wiCEDe9Ov2U3Ob5EjNQn9v2+N7/IeTwr2c
 3tWQx9GOSiiRjlXtacOsNsjNHAhQ+5Gk1jD+GvIuzSaTP3Pb9Rj0NpiaMI0/oDaDbMPw
 pIeA==
X-Gm-Message-State: AJIora+dKLuep27zYyVbbkwjvhJ+INpNk7fY+iSst3yAn4ify9/Bdlgo
 50jLoZceBOIzP0bLb15tNbEA21/lY3OLsajxJIaAcmNugWgLHpMDv9VQ7x813QOVnFLdbXN3p/+
 WD9NUnxsjSzwrGP2JjI8jb+Ja7nVQZ1vOaYnhRTg0peCAMHPibkz81PNK4Q==
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id
 g14-20020a0565123b8e00b004811a750452mr26453596lfv.238.1657080273547; 
 Tue, 05 Jul 2022 21:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sZxUBY4tuH7mFPtCtHELBxvE6PGXQdNEbj5tf0whZsOUVsKDnhnVVzlPSuQPLU6ZjANs/FNXsiAqRSupm8HSE=
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id
 g14-20020a0565123b8e00b004811a750452mr26453582lfv.238.1657080273384; Tue, 05
 Jul 2022 21:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220704021405.64545-1-xuqiang36@huawei.com>
In-Reply-To: <20220704021405.64545-1-xuqiang36@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Jul 2022 12:04:22 +0800
Message-ID: <CACGkMEvGsJbR_vCfGfi_Stxw0kiLwJZMXy6m-YXOkj73Y1WEEQ@mail.gmail.com>
Subject: Re: [PATCH -next] vdpa/mlx5: Use eth_broadcast_addr() to assign
 broadcast address
To: Xu Qiang <xuqiang36@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 rui.xiang@huawei.com, Eli Cohen <elic@nvidia.com>
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

On Mon, Jul 4, 2022 at 10:16 AM Xu Qiang <xuqiang36@huawei.com> wrote:
>
> Using eth_broadcast_addr() to assign broadcast address instead
> of memset().
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index f738c78ef446..3b2929d4a819 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1440,7 +1440,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
>         dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
>         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
> -       memset(dmac_c, 0xff, ETH_ALEN);
> +       eth_broadcast_addr(dmac_c);
>         ether_addr_copy(dmac_v, mac);
>         MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
>         if (tagged) {
> --
> 2.17.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
