Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A3C4338F
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:21:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1468A60E09
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 09:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1468A60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBBF4400D7;
	Mon, 26 Jul 2021 09:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id brEi_RiU-dQC; Mon, 26 Jul 2021 09:21:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 80881402A2;
	Mon, 26 Jul 2021 09:21:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46ADDC001A;
	Mon, 26 Jul 2021 09:21:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 200B7C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DDBF8293F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2BiLN0eQuvLl
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:21:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3891482925
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 09:21:04 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id l19so12155303pjz.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Q2bTbIzuNR8Z17qVedSx5UTI8m+JO41tvc9PLnzRbyY=;
 b=tWadrVNRyXQFNGcdGTy5ELi21BrWtCSXF2pYOfvz+nc3S8H4LMjdd+tv3d9Iys2qJK
 SYG89iS7msEv/oK+ffbBpjZEHWbSeeY4HvxrGgxVSTOUK169+A80wnQpUgxCljEy3Ayi
 f9n2Va62XCW/Pa67igB8NGzQMZlwvacjQYsMoP48fBsyZTsBfOCqOAj0wRsSyXLsp42D
 UyJU0z+F8truVI1Z8B912kOWtfKVLodOQhu8TYxU54UqXaU+UPfwcpWHoEy+wE3z/LgZ
 zTdqlJc0ZXc7wnAcNK4B7l2I+MpZTAwE3ji0W1lO9yRGvNaCjeH1Jt34qVToIz4XAX9X
 00lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Q2bTbIzuNR8Z17qVedSx5UTI8m+JO41tvc9PLnzRbyY=;
 b=jwEtS2/2r4bEsUTr4OLF/BbfIwL24frTBdGJvXUUPGgWHL5xNtU1MJGK4yRCrWHgxU
 uXEmD+MUEahNqJWBxToYlrAhFblsgdm5RxMWqG6sYqJ+x69GhavFlVgtvCJpkdNShZ/T
 Jb1g9w9zIf374aUBJfg5C7DuFuV2CuhCRAcaiS3A69tDs14wvzNetoYQRWynYLH2GP7u
 XmoCAI53Ebijh4KQ7F645+NljMORVOT5Ir2eRueXWgmgk4TpnuBSO89/oFLrMNc5Hrjt
 aD/xUrO9Y+4Hl1hUmZRccKOF2yyDzb7Mp/w07xt8lc3aSUQ2oKG4i6EDkCb1ddZHWRQe
 Dzuw==
X-Gm-Message-State: AOAM530br/Sh5w8hG1yMS3K+5v18qf8MgCaPe4Pd5s+tS51rYBWXQIu5
 QVXQm4+1wuIQzEOSmA9+Ua3kCg==
X-Google-Smtp-Source: ABdhPJzmUDnTNUKbWGwqSdm7aMIzCwtdu9YyEc3FRNxnsh53o+Wpv+9lXdE9a+3TxmU5FRPAMdta1A==
X-Received: by 2002:a17:90a:940e:: with SMTP id
 r14mr25446503pjo.41.1627291263269; 
 Mon, 26 Jul 2021 02:21:03 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id t9sm49619360pgc.81.2021.07.26.02.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 02:21:02 -0700 (PDT)
Date: Mon, 26 Jul 2021 14:51:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH V3 2/5] dt-bindings: i2c: Add bindings for i2c-virtio
Message-ID: <20210726092100.y4kuwzgzb2dhcwpf@vireshk-i7>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <4182aff2d1437b30025f3d17d11e5fdc21845239.1627273794.git.viresh.kumar@linaro.org>
 <CAK8P3a3FniCgQJ0UCvrwZ8F=f11mLAwe7XH5CcrqxL8TTMUvVg@mail.gmail.com>
 <CAK8P3a2m3BB2=4gkHXZD+=y1C47Og0QvfTWuA7e28oAonMyvzw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2m3BB2=4gkHXZD+=y1C47Og0QvfTWuA7e28oAonMyvzw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, Wolfram Sang <wsa@kernel.org>,
 DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linux I2C <linux-i2c@vger.kernel.org>, Bill Mills <bill.mills@linaro.org>
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

On 26-07-21, 10:11, Arnd Bergmann wrote:
> On Mon, Jul 26, 2021 at 10:06 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Mon, Jul 26, 2021 at 6:52 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > This patch adds binding for virtio I2C device, it is based on
> > > virtio-device bindings.
> > >
> > > Acked-by: Wolfram Sang <wsa@kernel.org>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Too quick, after seeing the same issue in the gpio binding I saw it here too:
> 
> > +        i2c-virtio {
> > +            compatible = "virtio,22";
> 
> The node name "i2c-virtio" looks wrong. According to
> https://github.com/devicetree-org/dt-schema/blob/master/schemas/i2c/i2c-controller.yaml,
> this needs to be plain "i2c".

Okay, I will move back to simple node names then.

Thanks.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
