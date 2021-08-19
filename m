Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B590FC4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:50:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FB66109F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 03:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60FB66109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13BC360BB1;
	Thu, 19 Aug 2021 03:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLkjyKWVXuz5; Thu, 19 Aug 2021 03:50:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C436060771;
	Thu, 19 Aug 2021 03:50:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0F36C001A;
	Thu, 19 Aug 2021 03:50:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDD5CC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:50:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE6404075C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:50:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fzb3X1-VNGaF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:49:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBF534039D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 03:49:58 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 cp15-20020a17090afb8fb029017891959dcbso10412066pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 20:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aurVUmLs+p4Znti5XIA6A55s5ceMtli0jCbz2S39Zbg=;
 b=nZK7041w0ZL90M9pCULpJXAOJYxCud8d5A7969Q5IIil+0vh4AOQP8RgZJ41aOLw/p
 NRDpTkSuGMIfZsv8BNk6ILmWhkKUxHbQvsde5dUXjuWE4PwhPycL+eWiqt/+Vz8VXsPN
 cr2EFQ3jCwIMLgSeHs7l93dYH/JVw1aFDC3amn7DdOu/GCPaY67mw+N7L3efXrniIKTQ
 9MjsSOaesnXyXI/swCKL6o5KAznYtVlkSTPpvllNzVBtVWZdT1JDARjd/CKZWkcq73Yw
 572zF5vgvJrGgRNzCN2bu1r3gD2FEe5/oNjTlR4lVKyBQlD48A+4dd4G7Hz6+KMnvX8N
 QgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aurVUmLs+p4Znti5XIA6A55s5ceMtli0jCbz2S39Zbg=;
 b=p1gJqzFnBjaDILDRRIKf/Hv1SOdyoGj+alqL7uRaFTCJCeu1OBt/yplur0g5m2fZ5k
 Wbyi2SD7HdpY7tQyT1Wap8tDRvRRhzTCfNGHiYGw+RgFa958R6eNJWegcLJg1s2p5Iry
 PQKNomDg2VTNtBOnHPY6BxgTol6z5YrO5d0ukchEakD5l4wTchADkCSjsXO+hDi0qnz6
 bPit+AL2QDd4dBEhk/L1I3BiK6R7Rw/qm1ZroTutXvOFA+5cMta4g9dGrsAy4dS3RadC
 /oP9CXRNaTkPMuy+JnogKaanqgrbBwkLDA5K0Erpc/QmmJ8rL0GSQf/Tfwt55PmXzgDo
 9S7g==
X-Gm-Message-State: AOAM533wH8+fq6Yb1pNZkOQ5hU5GW64cQF6QEq0Nc37tRfyfIXJc46K9
 Mrf8Vwzdv1b6LHGdrFqrY/cqjQ==
X-Google-Smtp-Source: ABdhPJx8SzcYq0vkhmOzl9Df2qv4O2agtmOynlOTH1sKsC3YNHjw/GsNbcaYyO9zYgnDVTJ7AiLPQA==
X-Received: by 2002:a17:902:ea02:b0:12f:65d7:47eb with SMTP id
 s2-20020a170902ea0200b0012f65d747ebmr4229503plg.3.1629344998215; 
 Wed, 18 Aug 2021 20:49:58 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id y5sm1341336pfa.5.2021.08.18.20.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 20:49:57 -0700 (PDT)
Date: Thu, 19 Aug 2021 09:19:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH] i2c: virtio: Fix the compiler warning when CONFIG_ACPI
 is not set
Message-ID: <20210819034952.vunr5v5xqcu4m4zg@vireshk-i7>
References: <4309f869890e70810f2c40a8d60495240e318303.1629333590.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4309f869890e70810f2c40a8d60495240e318303.1629333590.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 linux-i2c@vger.kernel.org, conghui.chen@intel.com
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

On 19-08-21, 08:48, Jie Deng wrote:
> Fix the compiler warning "drivers/i2c/busses/i2c-virtio.c:208:17:
> warning: unused variable 'pdev' [-Wunused-variable]" when CONFIG_ACPI
> is not set.
> 
> Fixes: 8fb12751ac78 ("i2c: virtio: add a virtio i2c frontend driver")
> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index d3e60d9..964c601 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -205,7 +205,6 @@ static const struct i2c_adapter_quirks virtio_i2c_quirks = {
>  
>  static int virtio_i2c_probe(struct virtio_device *vdev)
>  {
> -	struct device *pdev = vdev->dev.parent;
>  	struct virtio_i2c *vi;
>  	int ret;
>  
> @@ -234,7 +233,7 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
>  	 * Setup ACPI node for controlled devices which will be probed through
>  	 * ACPI.
>  	 */
> -	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(pdev));
> +	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(vdev->dev.parent));
>  
>  	ret = i2c_add_adapter(&vi->adap);
>  	if (ret)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
