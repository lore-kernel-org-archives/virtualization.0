Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65E9C433EF
	for <virtualization@archiver.kernel.org>; Tue, 24 May 2022 05:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61389404F1;
	Tue, 24 May 2022 05:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QoWGEZq9J0vR; Tue, 24 May 2022 05:58:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0EB45400AF;
	Tue, 24 May 2022 05:58:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D57DEC0032;
	Tue, 24 May 2022 05:58:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2139FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 05:58:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ECA754182B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 05:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PUzuB-zmQLym
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 05:58:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0379B4174F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 May 2022 05:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653371882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRsHIOR007k/L1XQpNezvwZ0qtxHfPjrnmZz0DariKE=;
 b=ZyKJle5bEeN4eOMGxQbgZJuFBslrhGdDNDb+ZQTCwpHLuyawPhfbuPmgzPjlkj0gaJekhA
 u738vGRSe+JdEf50V9kzTCDA5bqaWvPGvXazM+6NSogXQAD0TCtXJiA9oYBlzixznXnzbR
 wEgLxUhPH4a3/cIYNBJ3v16cZXxw+Dk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-HiQ_R-WuMQmAbZ5jTpEV0w-1; Tue, 24 May 2022 01:58:01 -0400
X-MC-Unique: HiQ_R-WuMQmAbZ5jTpEV0w-1
Received: by mail-lj1-f199.google.com with SMTP id
 g3-20020a2e9cc3000000b00253cc2b5ab5so3241027ljj.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 May 2022 22:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iRsHIOR007k/L1XQpNezvwZ0qtxHfPjrnmZz0DariKE=;
 b=cn8KI6fNIH7tO0UBJpsw77F6n97TLqBKUgRQqmfy/fM5PmycPTi3ypYqqNrLe4cLCs
 A3buTfC00/uxxBczyG6pc2nupdRYT5IEHDcz5Ii6LU9xEaAeQWeX4C/7HmeWf2IhZESS
 7K43xwXRYBfRfkuP9SgikxRQ93emU6psmYnUiu08qORBfcQ/gMWhxbX0sl5oIJF+AtQy
 f7rxL3I8dCkgbBADPSrG15HT7BpDW3AAy+2ebWl7UfIeplcTsZzXhSwCUgQWUsxv7ip3
 uRou9HOpasViQDsYTydFgLhRmM+0VBd+hmjRiy40W80+M0Qv2EBYSjJSFoNZMGjP+3gF
 yaeQ==
X-Gm-Message-State: AOAM530sagksPZKc0Knufq7rQFndPQUEVHZ/gSQbE2MW4l3Xn2J3jOtF
 Fcv7GolbUSNVWgQheiptXp5JqKpJBAUrDq5H3oKiM02IuIRRoOekKgt/4ZMcwT/g+S12fjgUms3
 Gh8DKt1g3n6fluB6agjoqXzNsmSRCKDy8jrmf5pepSzNmm0sTrnHCRkhhYg==
X-Received: by 2002:a05:6512:a95:b0:478:82fb:7783 with SMTP id
 m21-20020a0565120a9500b0047882fb7783mr2719325lfu.471.1653371878707; 
 Mon, 23 May 2022 22:57:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdIOa1D3s+m3Tp1eQDuX1Gh0Mpm9SPH0wyM3HX3XlwtkdZpXZEMGlf2l4NS4ke0tLB60DGtq+EgfSWK3afyAE=
X-Received: by 2002:a05:6512:a95:b0:478:82fb:7783 with SMTP id
 m21-20020a0565120a9500b0047882fb7783mr2719307lfu.471.1653371878497; Mon, 23
 May 2022 22:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <YotGQU1q224RKZR8@kili>
In-Reply-To: <YotGQU1q224RKZR8@kili>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 May 2022 13:57:47 +0800
Message-ID: <CACGkMEsgkTWsCsNa+igLCoKm0uVNV=RywB_nVOKiXb3Hu4yUQg@mail.gmail.com>
Subject: Re: [PATCH] vdpasim: Off by one in vdpasim_set_group_asid()
To: Dan Carpenter <dan.carpenter@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kernel-janitors@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>, Gautam Dawar <gautam.dawar@xilinx.com>,
 Eli Cohen <elic@nvidia.com>
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

On Mon, May 23, 2022 at 4:31 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The > comparison needs to be >= to prevent an out of bounds access
> of the vdpasim->iommu[] array.  The vdpasim->iommu[] is allocated in
> vdpasim_create() and it has vdpasim->dev_attr.nas elements.
>
> Fixes: 87e5afeac247 ("vdpasim: control virtqueue support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 50d721072beb..0f2865899647 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -567,7 +567,7 @@ static int vdpasim_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
>         if (group > vdpasim->dev_attr.ngroups)
>                 return -EINVAL;
>
> -       if (asid > vdpasim->dev_attr.nas)
> +       if (asid >= vdpasim->dev_attr.nas)
>                 return -EINVAL;
>
>         iommu = &vdpasim->iommu[asid];
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
