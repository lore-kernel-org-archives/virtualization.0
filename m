Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B686C636CC
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 18:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF85840913;
	Tue,  7 Feb 2023 18:39:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF85840913
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OahfbeNWOSNM; Tue,  7 Feb 2023 18:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D4AFF408F9;
	Tue,  7 Feb 2023 18:39:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4AFF408F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A80F0C0032;
	Tue,  7 Feb 2023 18:39:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24486C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 18:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6774408F9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 18:39:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6774408F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPe8X-15i4qh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 18:39:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1884408DA
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1884408DA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 18:39:33 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 r34-20020a05683044a200b0068d4a8a8d2dso4486057otv.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 10:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnOOq9bnjd33c9I9u467kZfQTzJzMXOdinGlABSXslQ=;
 b=Moy9dmQratfBQAQNTzyHATa4Of16Ss7JeDe/ERJLO916kn/oKjOGClx9hEhpNRlYwn
 h3nRvkV1CMAXU9DiG3d5FNatdav71CxuYcky+Qb41vSx5WTSLXxngao3WdoeHbAlFQZT
 Zb+7/HVmrf8Oa8hbvwX3OV5keRxp1uD0Gp4bsQtiYMLkoC9rpOLFwywE6rFiRjtvQfOe
 gaCokgRI7Hmf4svZx/O4lRVclkAAbnM2ClHLf9Llv80KAxIYwR66eppm9IlLXbspqPs/
 8nqXrzMXYC8RhJhpND44EhFo1T1z09c0OuH0kCEk1a0Edy85S9jO2avpzv2wMldniPvH
 LZLA==
X-Gm-Message-State: AO0yUKWjmiBXTcmc04MmqxIxPTzBz3HX8yLdx5HK26uzyhERw2dopadO
 nUi3SBHGRNUpGAR6DVBviA==
X-Google-Smtp-Source: AK7set9o6FrcZ/UZLBqQivtYh8syeRwjj0znAHcKuQP7cKo9BOmXT6TonjdC18HOmcQGBizl1bIhEQ==
X-Received: by 2002:a9d:7d01:0:b0:68b:ce98:1f9f with SMTP id
 v1-20020a9d7d01000000b0068bce981f9fmr2911101otn.34.1675795172568; 
 Tue, 07 Feb 2023 10:39:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 t7-20020a9d7487000000b0068bce2c3e9esm6850234otk.14.2023.02.07.10.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Feb 2023 10:39:32 -0800 (PST)
Received: (nullmailer pid 3950307 invoked by uid 1000);
 Tue, 07 Feb 2023 18:39:31 -0000
Date: Tue, 7 Feb 2023 12:39:31 -0600
From: Rob Herring <robh@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v4 4/6] dt-bindings: hypervisor: Rename virtio to
 hypervisor
Message-ID: <20230207183931.GB3753062-robh@kernel.org>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-5-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1675756199-5917-5-git-send-email-ssengar@linux.microsoft.com>
Cc: devicetree@vger.kernel.org, wei.liu@kernel.org, ssengar@microsoft.com,
 mikelley@microsoft.com, linux-hyperv@vger.kernel.org, haiyangz@microsoft.com,
 daniel.lezcano@linaro.org, decui@microsoft.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, dphadke@linux.microsoft.com,
 krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de
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

On Mon, Feb 06, 2023 at 11:49:57PM -0800, Saurabh Sengar wrote:
> Rename virtio folder to more generic hypervisor, so that this can
> accommodate more devices of similar type.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-virtio.yaml               | 4 ++--
>  Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml    | 2 +-
>  .../devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml         | 2 +-
>  .../devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml     | 2 +-
>  Documentation/devicetree/bindings/i2c/i2c-virtio.yaml                 | 4 ++--
>  MAINTAINERS                                                           | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)

virtio is used for more than just an interface to hypervisors. I think 
this should remain. Instead, I'd put vmbus under bindings/bus/.

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
