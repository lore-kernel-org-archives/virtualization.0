Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98689C07E95
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:26:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C07E6128E
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C07E6128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F073460A49;
	Wed, 14 Jul 2021 02:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6z583mDlcfKB; Wed, 14 Jul 2021 02:26:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 716E1608EA;
	Wed, 14 Jul 2021 02:26:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 35C5EC001C;
	Wed, 14 Jul 2021 02:26:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F16A1C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF3EE60905
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:26:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ub8F6ZPfAyqn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:26:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13784608E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:26:32 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id v7so699620pgl.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 19:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=aLOOUxsNuJzrisjcRZgamS/BIZMhFQu6M3e4Y30uR0Y=;
 b=vktLsQdD1T+XZaWFZlM+oLSx8DcvuVKrB3G/zetKYDvGAQifvvuAT+70hcekKu5a6n
 O6h2dCjsiUI1iulV9zJ/7vu1yEolfCOkvzpVsFSOVWeAGx/JzArOPmk77K2PH84RcOJ5
 fcJzs1TBUk3KG9x7I3GQqTsYqgmBCYkl3BWjJLX7hYoMfQVDnryLfCM2ScYD/L8ZnWv5
 zYoS4YJpvaCrrRHEXl8Jb31PIfXryjdcLLsXacnNWnDG65hWyjPNJH6rdVP0NzmZ0ER8
 EpJ/IszoDHZtmMaRiOSBaZQtF79WAtgi21j/s86rzv1NTu96zX4RIy2x83E9bN37VKXk
 w1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=aLOOUxsNuJzrisjcRZgamS/BIZMhFQu6M3e4Y30uR0Y=;
 b=rWAUZULxQ8SdnqQECeDFAKvES0FbrdSzCVqr3Ud6qeo/M3H6QD5PWN3hFhz9O68/Es
 KmLhkwSN5FhCoXG4pGEP0wShOEYxdIKEVsjeTa1XGI5Z8WeywNQzJTxYQZ/OM6U+IZiF
 PQGStMaFWX/pDI5y7gnJi2t/ATktQ5tL93S24HwDIFJXap0pqxv4gdV1SqijUEhbSZRV
 t+CpzglPmkCWHpBNHxsqTK7Aul0EV4KwuGQDHm2wd5CxQ38Qm7e+pR4L8Zlt6c7f0Xif
 Yrv3U+AYLZ0eyKRiXMlAG3WeWiqAdbGO8jN7Y//MXXRtKg7qJQEBIawAZr8h1l3/oqHt
 H8XA==
X-Gm-Message-State: AOAM531jhUUPFD0sQsDZTsF6S7RAhNm8YTC/hSnUsjDQQqm05v1edAaZ
 5iNelTmBDe+cqF98ETusyzHdfg==
X-Google-Smtp-Source: ABdhPJy6+4rpbrfnR4e8usInKISk1VWBWA8IDr8PyYcnfj+Yoar6cVYPjxczpgOa4x4kBz8KXAA0RA==
X-Received: by 2002:a62:3344:0:b029:25e:a0a8:1c51 with SMTP id
 z65-20020a6233440000b029025ea0a81c51mr7560777pfz.58.1626229592462; 
 Tue, 13 Jul 2021 19:26:32 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id v27sm477952pfi.166.2021.07.13.19.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 19:26:31 -0700 (PDT)
Date: Wed, 14 Jul 2021 07:56:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210714022630.d7vrazygmbooflcf@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, DTML <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>
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

On 13-07-21, 22:34, Arnd Bergmann wrote:
> On Tue, Jul 13, 2021 at 9:35 PM Rob Herring <robh+dt@kernel.org> wrote:
> > There shouldn't be. We have nodes be multiple providers (e.g clocks
> > and resets) already.
> 
> I think this would be a little different, but it can still work. There is in
> fact already some precedent of doing this, with Jean-Philippe's virtio-iommu
> binding, which is documented in both
> 
> Documentation/devicetree/bindings/virtio/iommu.txt
> Documentation/devicetree/bindings/virtio/mmio.txt
> 
> Unfortunately, those are still slightly different from where I think we should
> be going here, but it's probably close enough to fit into the general
> system.
> 
> What we have with virtio-iommu is two special hacks:
>  - on virtio-mmio, a node with 'compatible="virtio,mmio"' may optionally
>    have an '#iommu-cells=<1>', in which case we assume it's an iommu.
>  - for virtio-pci, the node has the standard PCI 'reg' property but a special
>    'compatible="virtio,pci-iommu"' property that I think is different from any
>    other PCI node.
> 
> I think for other virtio devices, we should come up with a way to define a
> binding per device (i2c, gpio, ...) without needing to cram this into the
> "virtio,mmio" binding or coming up with special compatible strings for
> PCI devices.
> 
> Having a child device for the virtio device type gives a better separation
> here, since it lets you have two nodes with 'compatible' strings that each
> make sense for their respective parent buses: The parent is either a PCI
> device or a plain mmio based device, and the child is a virtio device with
> its own namespace for compatible values. As you say, the downside is
> that this requires an extra node that is redundant because there is always
> a 1:1 relation with its parent.
> 
> Having a combined node gets rid of the redundancy but if we want to
> identify the device for the purpose of defining a custom binding, it would have
> to have two compatible strings, something like
> 
> compatible="virtio,mmio", "virtio,device34";
> 
> for a virtio-mmio device of device-id 34 (i2c), or a PCI device with
> 
> compatible="pci1af4,1041", "virtio,device34";
> 
> which also does not quite feel right.

I agree that even if the device is discoverable at runtime, we should
still have some sort of stuff in DT to distinguish the devices, and
"virtio,deviceDID" sounds good enough for that, considering that we
already do it for USB, etc.

And I am fine with both the ways, a new node or just using the parent
node. So whatever you guys decide is fine.

> > Direct userspace access to I2C, GPIO, etc. has its issues, we're going
> > to repeat that with guests?
> 
> Passing through the i2c or gpio access from a Linux host is just one
> way to use it, you could do the same with an emulated i2c device
> from qemu, and you could have a fake i2c device behind a virtio-i2c
> controller.

Or it can be firmware controlled device as well, as Rob said earlier.
I think that's what Vincent will be doing for SCMI.

Though all I have tested until now is direct userspace access.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
