Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73E5C4332F
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 06:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2FCC240124;
	Wed, 14 Dec 2022 06:31:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2FCC240124
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hObCXhW5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vTetPFT6q7KP; Wed, 14 Dec 2022 06:31:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AD863400C8;
	Wed, 14 Dec 2022 06:31:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD863400C8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 861F7C0033;
	Wed, 14 Dec 2022 06:31:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 406E6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 06:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E895840124
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 06:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E895840124
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P7IsKa9l9VDM
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 06:31:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BFA1400C8
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3BFA1400C8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 06:31:11 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id x66so3783679pfx.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 22:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HQixYPUGx3dNHQMvwFeapmdpykALcgOAixIE0qar/eQ=;
 b=hObCXhW5iEBR2JFX/mOosGX4M4dNVoaPDKLQuYphAMJR2iH1N0ZyLeowQm8rX0Tp6p
 NEQqrI4Pkpj2tITzrxE1la/qkpmrpXzeqiB6D4LWqaCOMG2dn7yXC9JCDb4VW5yCWqQ9
 zynVEqWHHjV3Lu/urILjfNimtEABgHwDj6CJ9YsZxRIGUhMh48PgHPCPTKdcf/I8MQf1
 jwyoWmnci25Q6vx59fvkTEZdf5PRZ2Q6T8CNWfLTPaHj2y21FgZnVH5RMZpf71qzWE2w
 tif9t28PD/Aef+evFGr+dfo5S7DF0rruRHoG1VZ+UN6W6kzOGElYgoFEsCr5Kx3qtIrQ
 oXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQixYPUGx3dNHQMvwFeapmdpykALcgOAixIE0qar/eQ=;
 b=TT0+nmevGCzxLV3Q4Kn6sG3nQwzs7+tyPBA7mcnHZP5BCi4z5h1bRNwV2+iVQEZvhZ
 YymJ5Azb0c+WafwQItp+rtO2G/amJxT1Jt2vBYsc0tgAFUR37c+2hsuDWNuvpwK0VOXH
 ILv+yA+iBHpzrnQQOtz5t11v//wd+PqRLjuPMdVIlU5g7jz053u0XTbpp08aLz0p4/rZ
 nZaSuKC8o1vBxacl0Epj4jLANCQaVUG+LsXTAm9bD7qta6lGtCsPL2HADVPrr/IRdtAu
 FklWh2SWQIg4yF1HEB0U/fVjjZl/EsLCTLStoXBQytKO3XU54U2HH9tVvF25eKHg6dFS
 tAZw==
X-Gm-Message-State: ANoB5pn4Q/zVn8QI1aol63LwqZS7oLdfnijl3fdrNAXwNBYf2qtt6MYN
 dxXV89pnu2d7cp9XobEiNJobbg==
X-Google-Smtp-Source: AA0mqf70gvWGruQzLDmnl4KVdvtPjvp7ABTpAaEQSwPuOQ6LDXC2rUoVyUX0jd6/rE8xHeazM6qp3Q==
X-Received: by 2002:aa7:8f2d:0:b0:576:8027:a2fc with SMTP id
 y13-20020aa78f2d000000b005768027a2fcmr23462513pfr.12.1670999470608; 
 Tue, 13 Dec 2022 22:31:10 -0800 (PST)
Received: from localhost ([122.172.87.149]) by smtp.gmail.com with ESMTPSA id
 f5-20020aa79685000000b0057726bd7335sm8632515pfk.121.2022.12.13.22.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Dec 2022 22:31:09 -0800 (PST)
Date: Wed, 14 Dec 2022 12:01:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wsa@kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221214063107.fazrfq3n26hw4ndl@vireshk-i7>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221214053631.3225164-1-conghui.chen@intel.com>
Cc: asowang@redhat.com, mst@redhat.com, Jian Jun Chen <jian.jun.chen@intel.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-i2c@vger.kernel.org, Conghui <conghui.chen@intel.com>
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

On 14-12-22, 13:36, Conghui wrote:
> This updates the maintainer for virtio i2c drvier
> 
> Signed-off-by: Conghui <conghui.chen@intel.com>
> Acked-by: Jian Jun Chen <jian.jun.chen@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8c8f6b42436..44747f4641a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21920,7 +21920,7 @@ F:	include/uapi/linux/virtio_snd.h
>  F:	sound/virtio/*
>  
>  VIRTIO I2C DRIVER
> -M:	Conghui Chen <conghui.chen@intel.com>
> +M:	Jian Jun Chen <jian.jun.chen@intel.com>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-i2c@vger.kernel.org
>  L:	virtualization@lists.linux-foundation.org

Wolfram,

I understand that it is okay to pass the maintainership, within the
company, for platform specific parts from one person to another, since
they have the best knowledge of the code and are the only one
interested in maintaining it too.

But what is the rule for generic drivers like this one ?

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
