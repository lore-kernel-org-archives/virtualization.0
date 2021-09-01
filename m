Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2A1C432BE
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 06:28:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C89D60295
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 06:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C89D60295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F06E64015C;
	Wed,  1 Sep 2021 06:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4sKSAE5-uTzM; Wed,  1 Sep 2021 06:28:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7B476401BE;
	Wed,  1 Sep 2021 06:28:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A655C0010;
	Wed,  1 Sep 2021 06:28:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB12EC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C91A8401BE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:28:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id msHZ-kLZEmH6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:28:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC0364015C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 06:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630477722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13+6GGuujafCJ6d7vfvCn9dSviEdofS8K878FjlroFQ=;
 b=eAy7m0Vd6hZIhQ8w5BTZnC/MHbIun8wMqmMBHdIBQ8Wyw/nVj1mBb4qE/qouKSYz4/SNBa
 FxUR1eOiVdS29bvw/Mi65isNTqtNTH/t8ZcdFC0lO7C6jyMh88R/7x4L+e1jL6UVrZTyQ8
 8b1Y++Shm7qXmXGB/UK1UlHaj1vlXKs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-dYAMxw06NyOwIL1H_VSRYA-1; Wed, 01 Sep 2021 02:28:41 -0400
X-MC-Unique: dYAMxw06NyOwIL1H_VSRYA-1
Received: by mail-lj1-f198.google.com with SMTP id
 q9-20020a2e9689000000b001b964fa10b3so660174lji.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 23:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=13+6GGuujafCJ6d7vfvCn9dSviEdofS8K878FjlroFQ=;
 b=qA+CS1STPGA5azCjzGnR0EukE7qpJmHX8Y9s64bX1QN0MQuQmNaW3l8D+RYjF6yo9R
 1ZP03PRgoNefpbxMNQ5B2KcGusIQTvnU0G0Nc0iMH0tdUJDY5aDsi7OFHm8F/0EzNq0x
 tzV6W1GXGrAEljsVOS2KjUIRNPA0ITLyJmvg3KRBxh/WW4CR/Ni34tZ8QQFTPp51Ch4z
 +OhL39/ica2CHp2gyU1sp18bu8r3qy91NMSK3lJITOvmm2Q4GxW7xp20aZbzqOphQp47
 M7RAfgyAVFKVF1GlVquhSx+HRcaSQIpte14Y+I/vk4WGRgzdgrFWo2U/X8zVwPReYA4q
 kiqg==
X-Gm-Message-State: AOAM532RAzRJ310qZmT5TEQyM8a51MRvMLcpThOijbsY9aRo4OUXXPwa
 OfaO08/NuTdtv7Ja9endo/YTnDBsGVJJ5J7i+/3dL+7XrAHZVe8Lz5efuxsal12eB7ZdCDpIQ4m
 q7EPk5Gj1nZmuXQmpRpDLZO4hcaB0eJNkSDSoqvokTMhuxKudVvUTUd1Suw==
X-Received: by 2002:a2e:9549:: with SMTP id t9mr18598451ljh.404.1630477720064; 
 Tue, 31 Aug 2021 23:28:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi6gJEpE+qC75ucZJpi1mRAapU20JsMY0ZMLHK2VDqDNaXZwkJgcb1a2Mm5JzMblditU1d1EEj06vpxsYdR9g=
X-Received: by 2002:a2e:9549:: with SMTP id t9mr18598438ljh.404.1630477719863; 
 Tue, 31 Aug 2021 23:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210829183138.574915-1-elic@nvidia.com>
In-Reply-To: <20210829183138.574915-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 1 Sep 2021 14:28:29 +0800
Message-ID: <CACGkMEuvv1dV2Mfptd8LLFbOr2N_b83tcCZJd4VePmXQo3=RaQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix required dependency on vhost vring
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kernel test robot <lkp@intel.com>, mst <mst@redhat.com>,
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

On Mon, Aug 30, 2021 at 2:31 AM Eli Cohen <elic@nvidia.com> wrote:
>
> With the introduction of control virtqueue support, selecting VHOST_RING
> is required.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 63078736419b ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/vdpa/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index a503c1b2bfd9..e48e2b10ca36 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -53,6 +53,7 @@ config MLX5_VDPA
>  config MLX5_VDPA_NET
>         tristate "vDPA driver for ConnectX devices"
>         select MLX5_VDPA
> +       select VHOST_RING
>         depends on MLX5_CORE
>         help
>           VDPA network driver for ConnectX6 and newer. Provides offloading
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
