Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D1BC433FE
	for <virtualization@archiver.kernel.org>; Wed, 12 Oct 2022 17:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72C6E61081;
	Wed, 12 Oct 2022 17:22:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72C6E61081
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=AE8z8KD6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V5Ftb-nG-LD3; Wed, 12 Oct 2022 17:22:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9CD36107B;
	Wed, 12 Oct 2022 17:22:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9CD36107B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCC7DC0033;
	Wed, 12 Oct 2022 17:22:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBEFEC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 17:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8F92983495
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 17:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F92983495
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=AE8z8KD6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TizXfaHC5XoU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 17:22:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E50CC83438
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E50CC83438
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 17:22:25 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 j6-20020a4ab1c6000000b004809a59818cso74306ooo.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRYFk+9yyHZHAcB/2rwgdrsgnigrvHFKirKgHeDmUno=;
 b=AE8z8KD6uwSVMiRp4ABm0Kn9UkMq8P+bk8+Y1ITmg3vl1hYmjp6k8LU6URk5HzGGQF
 2/fqw2HhcOa/gTcb1tS3SQgcP9XK2z4BjeVToHve1GXn4ay7pgmzQA+nKS017UcVgGKS
 Udydt9y4k+dIUSNMddvtmXX3tSMn7byJOqVUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZRYFk+9yyHZHAcB/2rwgdrsgnigrvHFKirKgHeDmUno=;
 b=0m6QmFq3HSfRyfTZnksPXKzAp9ro+7JW2Cdi3zKClujiANcgueKZdzo4UhHIj13nOW
 3tJGUH1kxWAxgYEpgUAJcNkT61V00vbLW2ZYi+oxXunVtsth8AWPt13AdRTk+oob7ddS
 mfTU0RvFhHZ4icXhW2ZBf4K+15mgEuVzqG+wA66qjj8jfLh98vfDshYx6BXw8GpwBwlf
 vz0Rie4AuNhiGCEpiYTD8Q/8nv4j0CLvO22rr8ge7hFKUmhR7O1sYkAbY5mvq7iANorv
 1nG5lEpGAac7ltoIr+uUjmYXT5Zl1+0mZnwDvUIVFoJBl+hhtXznoGQfHgBa5rnpiXpA
 BdRg==
X-Gm-Message-State: ACrzQf2DdxWO7DOXq9noRzzDJCIpu/HJPoK/SgtgE5qn9o2MOnwTmOE+
 c44M3K6p2jdO5Px8wiemlotZ/rB3N+Yvib8R
X-Google-Smtp-Source: AMsMyM47d4zWL0/iX9p1oKK0coTDPfTL9GnfeTszDp2xB/zmV6SEU1IP3zTSK4WdHfICi9CMUAo3Xw==
X-Received: by 2002:a4a:aa4b:0:b0:47f:7ce6:5b29 with SMTP id
 y11-20020a4aaa4b000000b0047f7ce65b29mr11574256oom.17.1665595344929; 
 Wed, 12 Oct 2022 10:22:24 -0700 (PDT)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com.
 [209.85.160.48]) by smtp.gmail.com with ESMTPSA id
 l5-20020a4a8405000000b004805cfab0ffsm1146681oog.31.2022.10.12.10.22.24
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Oct 2022 10:22:24 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-136b5dd6655so8372822fac.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Oct 2022 10:22:24 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr3072194oad.126.1665595344160; Wed, 12
 Oct 2022 10:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221010132030-mutt-send-email-mst@kernel.org>
 <87r0zdmujf.fsf@mpe.ellerman.id.au>
 <20221012070532-mutt-send-email-mst@kernel.org>
 <87mta1marq.fsf@mpe.ellerman.id.au> <87edvdm7qg.fsf@mpe.ellerman.id.au>
 <20221012115023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221012115023-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Oct 2022 10:22:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
Message-ID: <CAHk-=wg2Pkb9kbfbstbB91AJA2SF6cySbsgHG-iQMq56j3VTcA@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: fixes, features
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xiujianfeng@huawei.com, kvm@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, angus.chen@jaguarmicro.com,
 wangdeming@inspur.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, lingshan.zhu@intel.com,
 linuxppc-dev@lists.ozlabs.org, gavinl@nvidia.com
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

On Wed, Oct 12, 2022 at 8:51 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Are you sure?

MichaelE is right.

This is just bogus historical garbage:

> arch/arm/include/asm/irq.h:#ifndef NO_IRQ
> arch/arm/include/asm/irq.h:#define NO_IRQ       ((unsigned int)(-1))

that I've tried to get rid of for years, but for some reason it just won't die.

NO_IRQ should be zero. Or rather, it shouldn't exist at all. It's a bogus thing.

You can see just how bogus it is from grepping for it - the users are
all completely and utterly confused, and all are entirely historical
brokenness.

The correct way to check for "no irq" doesn't use NO_IRQ at all, it just does

        if (dev->irq) ...

which is why you will only find a few instances of NO_IRQ in the tree
in the first place.

The NO_IRQ thing is mainly actually defined by a few drivers that just
never got converted to the proper world order, and even then you can
see the confusion (ie some drivers use "-1", others use "0", and yet
others use "((unsigned int)(-1)".

                   Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
