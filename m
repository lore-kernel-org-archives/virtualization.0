Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BBDC12002
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:33:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF2A61026
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 10:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF2A61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0E436073B;
	Mon, 19 Jul 2021 10:33:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WmEi1UvC5gAA; Mon, 19 Jul 2021 10:33:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82C5F606F9;
	Mon, 19 Jul 2021 10:33:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48C2AC0010;
	Mon, 19 Jul 2021 10:33:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BACFAC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8CF4606F9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:33:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mqt5NVtS0ffK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:33:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 90A38606DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 10:33:40 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 o3-20020a17090a6783b0290173ce472b8aso13872293pjj.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=K40Jyf6F4VypIX0uQQ58aazesoLZiATF2ozlOf/u82E=;
 b=tm6QKxQaVJ1rfx4hcKqkfQh+kNZs1qfo7yu8WQJ/aS2+N/K/j3hAC7EJoGOLcI7mki
 RbXLpX3EUAsaeCKfy7dK+lsB9pV6bpejySCGNZ0YrrUbjtL9cXrDtvYSaEOtKyH8Yl2h
 pQwq59Y80QoFdRlHXZ8BxNEhIWPeZUnsy31tQXJKRws0GQIqiqzGSSdf27UDzkXZs8WU
 e1QslQq68CgzpzJ9WZD1zQIK/3f5QCVmqRqT17KzPkbNDIEwoysrIasghiLrG6lc43/K
 0V/1IrT6lyVKAbt3+yYq/dWQNyTPcSMQk5oAmymYYQz6722hEl9bSCG0440pYjIpbs0r
 hcZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=K40Jyf6F4VypIX0uQQ58aazesoLZiATF2ozlOf/u82E=;
 b=Ur2r1+UTtjUU8vRcRK2LG1eDpvbJwvcbYo7UVlbLhjs4Q4bLkgBUHD+rOkz3Q23VFt
 sX/jseeIkfMGF9rdN+R7irt0mqF4pE2lvksAIspm/Jgg46kp111fy48fJazhyRHDYmqs
 3AcAI5wQI7nnWVRuuuRg2qbYYfVS0k91NZniQEvodwAulBKpf0hjpX+enxg8MPVb5Xc3
 lJi1B6M53sSbO97O0VTNFUvkn6IheVSYtDnTjcfMvAe7xMjfRV+rpsyZ7fbjwk5DXHGi
 4+QBc0iyLoeLVHEixijylv8aZLTmmWoqJhvMFK40X8xdMVmvI7pGRM3KzQ8Cza/v3GZ6
 BRrg==
X-Gm-Message-State: AOAM530eiotnnI4w9zCsGfjma3n/52RZfU6zMmnwLXUZ3HlqISIL9qsC
 jlATDF9o4c/AFeajIn+Xgmnyhg==
X-Google-Smtp-Source: ABdhPJwl4MXidm+h6UyC6mKBdXmjy/5RSub0SZcKsJot16gWN5QT/b3nRghByFFqbqrk8t4XWLYxlA==
X-Received: by 2002:a17:90a:b284:: with SMTP id
 c4mr24363136pjr.213.1626690819793; 
 Mon, 19 Jul 2021 03:33:39 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id w5sm19850101pfq.130.2021.07.19.03.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jul 2021 03:33:38 -0700 (PDT)
Date: Mon, 19 Jul 2021 16:03:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210719103336.oyz6dppd5jf65w4m@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
 <CAL_JsqKLjFx9AOcMiyxdQvDU7V8Sak8YPyrJm2TuSE-TTqvREw@mail.gmail.com>
 <CAK8P3a2mS3GoW9MXdDNK7-EbnRH-9Kn4_k_TgnGSCycSez8Xow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2mS3GoW9MXdDNK7-EbnRH-9Kn4_k_TgnGSCycSez8Xow@mail.gmail.com>
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

On 14-07-21, 23:07, Arnd Bergmann wrote:
> On Wed, Jul 14, 2021 at 5:43 PM Rob Herring <robh+dt@kernel.org> wrote:
> > I guess it comes down to is 'virtio,mmio' providing a bus or is it
> > just a device? I guess a bus (so 2 nodes) does make sense here.
> > 'virtio,mmio' defines how you access/discover the virtio queues (the
> > bus) and the functional device (i2c, gpio, iommu, etc.) is accessed
> > via the virtio queues.
> 
> It's not really a bus since there is only ever one device behind it.
> A better analogy would be your 'serdev' framework: You could
> have a 8250 or a pl011 uart, and behind that have a mouse, GPS
> receiver or bluetooth dongle.
> 
> In Documentation/devicetree/bindings/serial/serial.yaml, you also
> have two nodes for a single device, so we could follow that
> example.

So two device nodes is final then ? Pretty much like how this patchset did it
already ? I need to get rid of reg thing and use "virtio,DID" though.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
