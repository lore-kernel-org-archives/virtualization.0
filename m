Return-Path: <SRS0=8Uya=NJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AEDC4338F
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 11:00:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A5760FBF
	for <virtualization@archiver.kernel.org>; Wed, 18 Aug 2021 11:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08A5760FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2C0060652;
	Wed, 18 Aug 2021 11:00:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tbS4wuKjMNYS; Wed, 18 Aug 2021 11:00:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 58471605DD;
	Wed, 18 Aug 2021 11:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 339C9C0010;
	Wed, 18 Aug 2021 11:00:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 980E9C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 11:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7D3144024B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 11:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsGXkihUgDB2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 11:00:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7117D401C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 11:00:39 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id a21so1740091pfh.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8C/in0krB+riQ0eZSSRSdP7EkmxB2WMWHtktCVN2wqQ=;
 b=B5S47QTtJ0TKz8xiiW7dUEgvBk/vW8gRuxTgStnQ8EQW3frKYCeVls+9FSzj3XDjgk
 pAHkPji3llkZ9ZLm4Q1xaT9Hk6mT9InN0qWbbvf4AcoK/cnXWKVtqy0NcghLEQSAvuwR
 MPpQlYin/FFiPKtv3dzH8O1j61FhMZ2JMGVC2m5lIz8Ki3K9w9fXOTPvbkwj6+wcH1Dx
 rysSEZ9J2Y61NCGVP6+WFCaIGqtqLumGAUkz63dS/kW7tR5crCwrxJVR7hHbrTYB60LM
 ZhTHvDu/ozuEjX3NzN1S1Bdu1eiYWzR/HpQMgEiKbzO+Kgp8heriROilo1G7o0bY9zdh
 HUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8C/in0krB+riQ0eZSSRSdP7EkmxB2WMWHtktCVN2wqQ=;
 b=DKDirJwllh5Tekdm/HekwwSJ9Wq7s88FvMT4eebQ1gmKvO0Xw7yd+J5zoDnoiulTnV
 cnhKwv/pO4lVOnR/fQ0ip/k7JMYEy4qPhrB16i1yWv2xUk6eiIS2d3OuIZjH5G2v2v/X
 /gdPT24oBCs3R9YH0QqLr9UkncphLY0ehvczi3fmGN03trsGXRO1nCfKH103B1I5THjk
 jXrX5w4S2IOSFkkIm28H3aUsObocUxhV/98sQ/yQBi6hjPAka9Oh7JA32DSaOuoypgXw
 hLoHlkkLrfVQOsyMWyJmQ8Vtf+mP5aVX8vzWUFdeT/KQtYbWBQoP/dBiK5i6za2yLbYV
 YFvg==
X-Gm-Message-State: AOAM5321XuB6TS5dzcFdC4lx+2C6fLc8EeHMI5Fi3gGgZdwu1R6ao7v6
 H89X+53a7OhHgQXAmIvRdPxEpg==
X-Google-Smtp-Source: ABdhPJwcDoOFfIzbJ+GjtEmN+5qujYZSrtK6wkrgL2lusIyF7Rfn+jMrdM3OuvseOINoaBvZjckVFg==
X-Received: by 2002:a05:6a00:238e:b029:35c:c5e:b82d with SMTP id
 f14-20020a056a00238eb029035c0c5eb82dmr8785069pfc.33.1629284438811; 
 Wed, 18 Aug 2021 04:00:38 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id gl12sm4938471pjb.40.2021.08.18.04.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 04:00:38 -0700 (PDT)
Date: Wed, 18 Aug 2021 16:30:35 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V5 2/2] gpio: virtio: Add IRQ support
Message-ID: <20210818110035.w6o2gpx5af5x2gm2@vireshk-i7>
References: <cover.1628590591.git.viresh.kumar@linaro.org>
 <96223fb8143a4eaa9b183d376ff46e5cd8ef54b4.1628590591.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <96223fb8143a4eaa9b183d376ff46e5cd8ef54b4.1628590591.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, Viresh Kumar <vireshk@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 stratos-dev@op-lists.linaro.org
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

On 10-08-21, 15:55, Viresh Kumar wrote:
> This patch adds IRQ support for the virtio GPIO driver. Note that this
> uses the irq_bus_lock/unlock() callbacks, since those operations over
> virtio may sleep. Also the notifications for the eventq are processed
> using a work item to allow sleep-able operations.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/gpio/Kconfig             |   1 +
>  drivers/gpio/gpio-virtio.c       | 301 ++++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_gpio.h |  25 +++
>  3 files changed, 323 insertions(+), 4 deletions(-)

Marc,

Will it be possible for you to have a look at this patch, it will help
us understand shortcomings of the specification better and this
implementation as well.

Thanks.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
