Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3366C433EF
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 08:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2782B4182E;
	Mon, 20 Jun 2022 08:48:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2782B4182E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtGrjTha
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IBJYldWf4bSY; Mon, 20 Jun 2022 08:48:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D8D14093D;
	Mon, 20 Jun 2022 08:48:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D8D14093D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4502DC0032;
	Mon, 20 Jun 2022 08:48:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCF04C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98ABE8308B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:48:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98ABE8308B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WtGrjTha
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OuY0c3ooBYqf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:48:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CF8382F6C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CF8382F6C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655714882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dTV1FjdagOn2blPRO899RL2TzF/ALoz6Mi1x3g7dZ+g=;
 b=WtGrjThaLnNXRcz+IZb7Z1OcdaTF/3tiw9K4fQkCG3KMMVH9lN1hOlfld9A5rmAgYwPlRC
 3Hf8lS/bUn4P6GzIb8sDrK8ngRnIHAMCNmY55qQFZfP3P57HIf1MtoFa9jdmRChXtnj7HV
 5EwthMSzS9gm+G++9Wfj8vHHTp+Ve40=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-Kp8s9ZeCPDS97WSa4G18og-1; Mon, 20 Jun 2022 04:48:01 -0400
X-MC-Unique: Kp8s9ZeCPDS97WSa4G18og-1
Received: by mail-lj1-f200.google.com with SMTP id
 g3-20020a2e9cc3000000b00253cc2b5ab5so1166842ljj.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 01:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dTV1FjdagOn2blPRO899RL2TzF/ALoz6Mi1x3g7dZ+g=;
 b=KA0qU/3Be5hNHJO1GEIVQoErHP4KtTVSNfwkgfA9awWh9lAxxH1IiSm3hI3NgJV+fK
 ghXNfGuL+Ac5z717kv0139/xmrhIO9ey4JOs1I0UDh40v3/cnzwUz2Nn5Gn4MJF1jrdz
 5uugm1moSw2OKy30KgQkkXaRM1TMHzqgtcleWDnIZP9wg53XIX52DV8EAXH/P82yYdff
 gd+f80B9IobaeEOWc7T8LQkxIkc+gLH0ZinfRXl1BgigL2upuvjaoZdNFVP0hpkhiYVr
 9zD8PHf/9fZ5rZh5gJT5QfkSxWRRjAZT2umVM44GjwIJQjX3TfmbFQja2ndCNuRVP3/g
 Me/Q==
X-Gm-Message-State: AJIora9gCzzPATGZiFzhvKEWZwF6Zit32+6L37o46YR1VCvtO8luiOtx
 Slw9eupZsPGiuwraEdliYkVJU91UkzOib0zhb5+z6zTfgm5XST66rP48d2WBeq6AXGjdfg/I1Jx
 mNReTFAx0rW8BsYYCRLD93OUT7b9NbVKwpSWp7jwwgS2z31H6mPtEwK24sw==
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id
 p16-20020a2e9ad0000000b0025a715626bbmr1150479ljj.141.1655714879455; 
 Mon, 20 Jun 2022 01:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/LDcG35w7DbXZQTaNe4ORqCwTHWzas403SEZk1fkPHDUk1WsNFgdf4HVm1WbWhZ7zTeeuxuJ6DXuvyewdpwQ=
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id
 p16-20020a2e9ad0000000b0025a715626bbmr1150470ljj.141.1655714879288; Mon, 20
 Jun 2022 01:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220616132725.50599-1-elic@nvidia.com>
 <20220616132725.50599-4-elic@nvidia.com>
In-Reply-To: <20220616132725.50599-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jun 2022 16:47:48 +0800
Message-ID: <CACGkMEsc+MCsRq6aA1vLXE3OJ0buX-0g73qaz72Px-ismfMKLA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] vdpa/mlx5: Disable VLAN support to support live
 migration
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst <mst@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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

On Thu, Jun 16, 2022 at 9:28 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Current qemu code does not support live migration for devices supporting
> VLAN. Disable it.

This looks like a bug that we need to fix in Qemu.

Thanks

>
> Note: this patch is provided just to enable testing with current qemu.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 34bd81cb697c..1568cfdf07e6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2172,7 +2172,6 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
>         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
>         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
>         mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> -       mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
>
>         return mlx_vdpa_features;
>  }
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
