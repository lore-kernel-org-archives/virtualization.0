Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288FAC4320E
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 03:56:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A5661037
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 03:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7A5661037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B4F483DB2;
	Wed,  4 Aug 2021 03:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8KV6ggoZ03w8; Wed,  4 Aug 2021 03:56:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3107683DA1;
	Wed,  4 Aug 2021 03:56:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05408C001A;
	Wed,  4 Aug 2021 03:56:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F349C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 03:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48C4A83DAA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 03:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7uO8DlRrMnN
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 03:56:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2238583DA1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 03:56:26 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 e2-20020a17090a4a02b029016f3020d867so1725500pjh.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Aug 2021 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0ZHYwmuwBB2HtOoKEULFjho6JxP6yZHRiPr37fJbra4=;
 b=hl3XdlB4jYy+wT1mdMb8yurr9oZXxti9oqh96q80dPuJJF/Yq+NLcAsFU04oNDtSkD
 /YyxOcvDDixL+wIRumzrx/wtV7hbWudOPV0de0xzY7Ci3OgQYTmX3aby0hACRe7JMytr
 MAIx2lvf/rhNZ4/sGTlxWkPnjhkDmnPgnprTf/1AQRV12jGmQ0GGTq8zhewY4fGlrpu0
 s92TpMZXI3V9KbWV1SFxIvMvXpIKcNRfD1EZ133zkkhq7K9S39ejxti1vTlneWC5H4uG
 dro0H3VInrzzA+lFf4NAm7rJrV9K4PM7/doxeiBvy4E+IE145vm3So/6OVwP7mtlzDY1
 3Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0ZHYwmuwBB2HtOoKEULFjho6JxP6yZHRiPr37fJbra4=;
 b=UhlyvAGEbXpGEi8Qgts6XwsHDkh0WIMFenHCB610xcHGxzSIu65Lj/cqwKlYQkP7BZ
 xs8GeyN9iDaMzBvwdhLKkr0zPxFLz/iihuKEVx2D7SVpzf4zmk1hjr7XgmyTd08AplUF
 OET7FR5t2d3mIPtIdW6SrfCnZ9NjVQIQ7LNZGk+il2eMHjkmqzVXdNUGwFZdcn1LBuAu
 AjrWdW5VAPuFqda1NFBFCZe1zmJdjfeBiamP9yJLV8zba+ODnU51t6vcx8yFtv5hHTDi
 cTRbJJiFGEp2FTlWgrdsQxGhxsIc3YHUz3YupiAsQptZfbpKYXN+xOka0MpFJLgnmevN
 xk7Q==
X-Gm-Message-State: AOAM5335ZNJ9PiSqjBriUU90z25e7hfGmq9GI2zCRW2U4RlMcL4paeds
 SjJM1vGcIkxNNRZIB2WFxNe8qA==
X-Google-Smtp-Source: ABdhPJyWbX7rhBTYZkB+2/CNdO7HVuodEfPZIWRtTfENeVnwx7K5DDQjjk4B2l/Qr4+ABKbp6VpteQ==
X-Received: by 2002:a17:902:6a82:b029:12c:58c0:1af3 with SMTP id
 n2-20020a1709026a82b029012c58c01af3mr39186plk.50.1628049385534; 
 Tue, 03 Aug 2021 20:56:25 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id j15sm736558pfu.171.2021.08.03.20.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Aug 2021 20:56:25 -0700 (PDT)
Date: Wed, 4 Aug 2021 09:26:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V4 0/5] virtio: Add virtio-device bindings
Message-ID: <20210804035623.flacrogemvjina3o@vireshk-i7>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1627362340.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, "Enrico Weigelt, metux IT consult" <info@metux.net>
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

On 27-07-21, 10:53, Viresh Kumar wrote:
> Hi,
> 
> Currently the DT only provides support for following node types for virtio-mmio
> nodes:
> 
>         virtio_mmio@a000000 {
>                 dma-coherent;
>                 interrupts = <0x00 0x10 0x01>;
>                 reg = <0x00 0xa000000 0x00 0x200>;
>                 compatible = "virtio,mmio";
>         };
> 
> Here, each virtio-mmio corresponds to a virtio-device. But there is no way for
> other users in the DT to show their dependency on virtio devices.
> 
> This patchset provides that support.
> 
> The first patch adds virtio-device bindings to allow for device sub-nodes to be
> present and the second patch updates the virtio core to update the of_node.
> 
> Other patches add bindings for i2c and gpio devices.
> 
> Tested on x86 with qemu for arm64.

Michael,

I hope you will be picking this series (Now that it is reviewed by
others) ? Just so you know, Wolfram needs the 4th patch, 4/5, to base
the virtio-i2c driver over it and has requested an immutable branch
for the same.

Thanks.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
