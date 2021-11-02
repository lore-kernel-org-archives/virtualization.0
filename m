Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D3FC433F5
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:33:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0248F60F0F
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 03:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0248F60F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9FBAA400C7;
	Tue,  2 Nov 2021 03:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VawGHjc6TrWU; Tue,  2 Nov 2021 03:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2E6FC401CA;
	Tue,  2 Nov 2021 03:33:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 011A4C0012;
	Tue,  2 Nov 2021 03:33:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AB6DC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C178402B5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D5u-SUgHv7qd
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:33:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C28B402AF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 03:33:28 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id g11so6879442pfv.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Nov 2021 20:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=a1lXUR6SQ/hD6znen9JgIoQ/BqqL7K0xRUGaDryk68I=;
 b=fDv8r6JcJVMfIdN1DY+fvOCubW1/T4KMG8OpFRuNA7E1WcPkfwCCMv3Yee5QwmoOcV
 4MVv14+urzbcwNqRSWA66Ky8VqbzrTFe8DHYZ0+qSfmcCZxHJeF6EzLzgAJM1dRvr16v
 oO9OEegl8oRX11NZjUJdAr5KC3w36lHqnios0M8p/2+lTa3wkfnVxUN6Sw0NPWbiOoM8
 VBppoS1bPQeyt9qk6sc3cwEX421Clumks+bCXpw3vDYWnyZWy14yJGbv43EwDyQ4CZtE
 6iiBDwBb559risFbjnm4sbjn3jMHvr8fDNTiCdyuZaPaBHuxauVFkRtTmgWnPYH4yPQF
 1WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=a1lXUR6SQ/hD6znen9JgIoQ/BqqL7K0xRUGaDryk68I=;
 b=kjgjdEN2jZ0Yhj2mTleqxZVvkjjnL+A/FDaddrZyz/qZySkO/nxlhACRa2twlj1Vmz
 Ht6mKfuDGOWxYUCe7umw3iOpdsZuKmZE66HGU5e3dUc/vGWBVTPezhhMvXlMueqHLVVh
 GHNoLoizz2f3iEClPwNVvvOpLcb9a/84E7nBSReLdmoiOZGgGaGelk5pZvothGReSbYs
 FWuBVICLsP57KI+kNTJgW6ZLiliI35VsORSIrY+En5jj6N6teBxJk7jYtAvqM1b78bH0
 2j6yK8dho1BNM4BRicjkJTCMBFUam4Ue1MPvT/55dtIuFM2zeDihNvsXpzY4OzBzqgBn
 XWsA==
X-Gm-Message-State: AOAM530V5wgHoxNQ+FRwd82MAwtrOUpGmblb868aatajq8WSJB/nSbkx
 0ynjV6/nwH9bKzMz4aE1q/1Fbg==
X-Google-Smtp-Source: ABdhPJy4IoDlvp7DZL85+0EmaBuTHCvSx5BaTfRfxNq3AqWLrcAJqM+saZjZj61Da9g/a3H4u6KF8w==
X-Received: by 2002:a63:7881:: with SMTP id
 t123mr24852203pgc.150.1635824007531; 
 Mon, 01 Nov 2021 20:33:27 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id d20sm5475136pfu.189.2021.11.01.20.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Nov 2021 20:33:26 -0700 (PDT)
Date: Tue, 2 Nov 2021 09:03:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH] i2c: virtio: update the maintainer to Conghui
Message-ID: <20211102033324.5x2sd7ezcmbk427e@vireshk-i7>
References: <00fadb64713aebd752dca3156e37c8f01c5ac184.1635736816.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <00fadb64713aebd752dca3156e37c8f01c5ac184.1635736816.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: vincent.whitchurch@axis.com, mst@redhat.com, jiedeng@alumni.sjtu.edu.cn,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, linux-i2c@vger.kernel.org, conghui.chen@intel.com
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

On 01-11-21, 13:24, Jie Deng wrote:
> Due to changes in my work, I'm passing the virtio-i2c driver
> maintenance to Conghui.
> 
> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b79fd4..8c9a677 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19944,7 +19944,7 @@ F:	include/uapi/linux/virtio_snd.h
>  F:	sound/virtio/*
>  
>  VIRTIO I2C DRIVER
> -M:	Jie Deng <jie.deng@intel.com>
> +M:	Conghui Chen <conghui.chen@intel.com>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-i2c@vger.kernel.org
>  L:	virtualization@lists.linux-foundation.org

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
