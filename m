Return-Path: <SRS0=EgWE=L6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F8C11F67
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 18:08:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A86661076
	for <virtualization@archiver.kernel.org>; Tue,  6 Jul 2021 18:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A86661076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BBF440591;
	Tue,  6 Jul 2021 18:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S-RBBc1udS55; Tue,  6 Jul 2021 18:08:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91E6A4038B;
	Tue,  6 Jul 2021 18:08:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6091EC001A;
	Tue,  6 Jul 2021 18:08:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5111AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 18:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A82340111
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 18:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mlISAwRlK-nq
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 18:08:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2CA934010D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jul 2021 18:08:23 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 l17-20020a9d6a910000b029048a51f0bc3cso10702446otq.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jul 2021 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rFh4HQBpaw9ewOD7eKuJ7KI9YAzHhN8tlxJ6LopMKHs=;
 b=Sz6rE6fIxKghlltcLCE+UXPsQefAUgPvTMscjeRzq2kl6NTGV49umux5xM0XcDuF3f
 KuSKKfkZ8nSISGEXHz3w1v+CP9bxuRJkim+LBmkXAMBhskBSVWy4R8UYC7L1pwY+g7hz
 Zg3WKG3mRVhsusU5VFmdXh5UPocqhZf4lahEU95r9tDGNbsVfHF1Q4HkA+YZfm/i81fd
 v0xNi9dJEaEvf856OdG6fjSc31APYItT+IUiPzbg0w9QbfcYoXqLRo58SwLlUHuXr/Qb
 gjgu5RAVRwk/bKL57rYJjqGIxVt7qPeDusZUEamQ36NdV7/ZYwdc/uo7wSJkJLcpf0tD
 jOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rFh4HQBpaw9ewOD7eKuJ7KI9YAzHhN8tlxJ6LopMKHs=;
 b=mSZSeLzvx8qybQX6eFyoXqoCMHLiQ+QIigyKhoFoNcFwlN8wBTgK7gSpkBRYjWOyqc
 qBw8ltKNHa6KI3DQMu4xhZ0oFPW6t+eQwzEMDcySB54VkcDwa0GsqGy7UJK6dW6wSoTf
 SJMcTDF1lp6h2bKEj9rAqNx2VYqMK3ZjqOgMsF9OR6YJMzY9IEIe0SaEQCw5gDx40uin
 FCBEX6TbyBQuhEd1hHha+uSPUcPkTRFcbygMifV2FUcoV5/ZcS3ufL1fRUqM263juDpP
 9YCQUPz66qiFfPGlcCdZMTbkEHdwoeSNutWeZD9VRnpRHB4FS+2k7D/Biz7RomkiLkmX
 IzLw==
X-Gm-Message-State: AOAM530cCKWn3ToSSadH6EXV12K4lw/X3MkLCoH4MXpjI5J3p0MDbpLb
 gMNyavxdIgyI+EuLqqY1q3A4Ew==
X-Google-Smtp-Source: ABdhPJwwC8pa+wbm0v5SSaX+DFJoQ7jJmXTjdD3iH0933Y2rw8Y2+zYlxp2w0qjcBNkHXGnjSvRJ6w==
X-Received: by 2002:a9d:3d3:: with SMTP id f77mr16276146otf.43.1625594902170; 
 Tue, 06 Jul 2021 11:08:22 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id 68sm497113otd.74.2021.07.06.11.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jul 2021 11:08:21 -0700 (PDT)
Date: Tue, 6 Jul 2021 13:08:18 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/4] bus: Make remove callback return void
Message-ID: <YOSb1+yeVeLxiSRc@yoga>
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210706154803.1631813-5-u.kleine-koenig@pengutronix.de>
Cc: nvdimm@lists.linux.dev, linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-cxl@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 target-devel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net,
 linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-acpi@vger.kernel.org, industrypack-devel@lists.sourceforge.net,
 linux-input@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, greybus-dev@lists.linaro.org,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-spi@vger.kernel.org, kernel@pengutronix.de,
 dmaengine@vger.kernel.org, linux-ntb@googlegroups.com,
 linuxppc-dev@lists.ozlabs.org
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

On Tue 06 Jul 10:48 CDT 2021, Uwe Kleine-K?nig wrote:

> The driver core ignores the return value of this callback because there
> is only little it can do when a device disappears.
> 
> This is the final bit of a long lasting cleanup quest where several
> buses were converted to also return void from their remove callback.
> Additionally some resource leaks were fixed that were caused by drivers
> returning an error code in the expectation that the driver won't go
> away.
> 
> With struct bus_type::remove returning void it's prevented that newly
> implemented buses return an ignored error code and so don't anticipate
> wrong expectations for driver authors.
> 

Thanks for doing this!

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org> (rpmsg and apr)

[..]
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index c1404d3dae2c..7f6fac618ab2 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -530,7 +530,7 @@ static int rpmsg_dev_probe(struct device *dev)
>  	return err;
>  }
>  
> -static int rpmsg_dev_remove(struct device *dev)
> +static void rpmsg_dev_remove(struct device *dev)
>  {
>  	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>  	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
> @@ -546,8 +546,6 @@ static int rpmsg_dev_remove(struct device *dev)
>  
>  	if (rpdev->ept)
>  		rpmsg_destroy_ept(rpdev->ept);
> -
> -	return err;

This leaves err assigned but never used, but I don't mind following up
with a patch cleaning that up after this has landed.

>  }
>  
>  static struct bus_type rpmsg_bus = {

Regards,
Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
