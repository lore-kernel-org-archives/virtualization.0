Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344BAC07E95
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:28:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3ED6136E
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3ED6136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A92F440502;
	Wed, 14 Jul 2021 02:28:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xzli1zIpOZC; Wed, 14 Jul 2021 02:28:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 50DFA4050C;
	Wed, 14 Jul 2021 02:28:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13465C0010;
	Wed, 14 Jul 2021 02:28:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A1D3C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A898402DD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:28:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nkJArZURbM61
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:28:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A6B240280
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:28:41 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 i16-20020a17090acf90b02901736d9d2218so642992pju.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 19:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=q3Mse/Qf9kH6kL3f+V/QegEz6PSgmpb/uOwCZ33NNho=;
 b=aHKYrK2Cxt4RWF9gLC6HBDZEdoBg/7Fa6O0Wao7w+RGUFtK5uQwcvN82pIwLDVlNDf
 LzBQZumX2tOjCErjDVmaKsMEqm7UBoF+ymz/sc/V/dNM5BOWYV0GG8ngvsb/OFlZX4SE
 /MxCCTFkKFuOkIWLAFxVaO448KIw+tsxmLGjeTSaTbDFVr5Oqit3LL+QKcOh0vqKbhPT
 DIQ1BP1fuV/3LBAiNABT2wJScLUvH1+GVavKGTqnWAX1mwu5NeuasY8mBufXVFCZa5LT
 knWmK+ljj0vpUYdqITiFCT/RfLrGW2x0IqI8ViZ6F7VxHnWfKU663QCIQYcyscUNdJoC
 ySGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=q3Mse/Qf9kH6kL3f+V/QegEz6PSgmpb/uOwCZ33NNho=;
 b=oqD2uWhkjqCkUAwLUCdXal//4eyoKIa+WWAmP8otsjIPutSRlGgpG2D4sPgwEKWRW3
 Yx0a4OFgQ2isSd+T+ZdkJj0VZ9TOgjltBNHTiwtW8is++2D9GpnYj7+RBHtBijgMO/n+
 /uJH2DS58+lEwctCFycBqTFRl/gGHwVaxElXbgGFyZBK9sXiI813UX7SMxfepgvGTFzX
 rSIbh62qiK5riPQriknyqnqxdHX8iR/MhKZ0MCbB4Mkzh5QIc8XyN9TEM2oUoV1j7dOJ
 kX9zI58fZeWaESPyboXP513xEQX6FAQnjtca6Ez5zk9NiwkeYY6FNZbQ6RdvjPD54G0c
 kfUw==
X-Gm-Message-State: AOAM531KnYHqrSWH3821roZBKTRr7L6+ZGsoFLE0Pqyppe4pf03tByxE
 T0rRcGqbIjLDNyzTjJiQ2Sy3aA==
X-Google-Smtp-Source: ABdhPJyt4NHsC3qOWPB9o2tHUAeBKYlYoHdwMOIAoYDCLLFljAqMtU6kHp2eOuJwsLQb9fy5g6WHxQ==
X-Received: by 2002:a17:902:8bc3:b029:124:919f:6213 with SMTP id
 r3-20020a1709028bc3b0290124919f6213mr5940902plo.51.1626229721486; 
 Tue, 13 Jul 2021 19:28:41 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id q4sm501078pfn.23.2021.07.13.19.28.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 19:28:41 -0700 (PDT)
Date: Wed, 14 Jul 2021 07:58:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <20210714022839.izxkrezgaobmkixy@vireshk-i7>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAK8P3a2MZzTpdp8rb1rUEXpx9OChLJJX5Sq+e=hc8hs25iQMsg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2MZzTpdp8rb1rUEXpx9OChLJJX5Sq+e=hc8hs25iQMsg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, DTML <devicetree@vger.kernel.org>,
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

On 13-07-21, 14:32, Arnd Bergmann wrote:
> On Tue, Jul 13, 2021 at 12:51 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > +
> > +    virtio@3200 {
> > +        compatible = "virtio,mmio";
> > +        reg = <0x3200 0x100>;
> > +        interrupts = <43>;
> > +
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        i2c-virtio@0 {
> > +            reg = <VIRTIO_ID_I2C_ADAPTER>;
> > +        };
> > +    };
> 
> This works, but it seems oddly inconsistent with the way we do the same thing
> for PCI, USB and MMC devices that normally don't need device tree properties but
> can optionally have those.
> 
> All of the above use the "compatible" property to identify the device,
> rather than
> using the "reg" property. Neither of them is actually great here,
> since we already
> know what the device is and how to talk to it, but I'd still prefer doing this
> with
> 
>        compatible = "virtio,34";
> 
> or similar, where 34 is the numerical value of VIRTIO_ID_I2C_ADAPTER.
> This would then be required in the virtio-i2c binding.
> I think you can skip the #address-cells/#size-cells then.

That works, sure.

I think I misunderstood it when you said it earlier and thought that
you are asking to add compatible in the parent node itself and so did
it this way.

Though that may be the way we will end up doing it now :)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
