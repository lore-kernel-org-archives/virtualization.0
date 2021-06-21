Return-Path: <SRS0=vACO=LP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF6BC49EA6
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 17:25:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EC06109E
	for <virtualization@archiver.kernel.org>; Mon, 21 Jun 2021 17:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EC06109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6F04607C2;
	Mon, 21 Jun 2021 17:25:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6BTMbo8XApz; Mon, 21 Jun 2021 17:25:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6D9A760791;
	Mon, 21 Jun 2021 17:25:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32C1CC0010;
	Mon, 21 Jun 2021 17:25:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01203C000C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2F33403CF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:25:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jde5zUfFcuoi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:25:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EDF7403CE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:25:32 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id t40so20696524oiw.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PnPX+kMwwqow5LYukSPE/j5CcoTy7NRtog3utuQq2IE=;
 b=IlM4/QIr6kXMDieXq2favI4BOm+o5ZxnHdZwUYTjCqrBZSaWC4gwwIF+F4B9F5qSdf
 aixUjWQLgS/AXi3OR7McxgHlOKNSFUlc5g8bEKu9UXwxwf9AWPQ4i/9DyNe9ICC96o0z
 KXXcpuxr22bkxc2HK8qkfH9ZOQKs907KKN6SL4471gnxBZfLveRLtNG/2P3sUyGNT0K5
 tiK962EvGmj2OJ/2eAMO7IcauWF3j/t64jubulaqCaE5JZZ94PVrXN+lDT9dpBDyomDp
 IqPIGpw72Sz99ly/1y5ASkIq/xzK1JWnDxNmEiFazMrjkUnxkFj6UFfRxO4Cp/r+TIz8
 Tgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PnPX+kMwwqow5LYukSPE/j5CcoTy7NRtog3utuQq2IE=;
 b=pG38Vxs3CCipnmFIGxztH0b8NU8MZVAf1SOw6ljagUi/838J86c1SSks+g2MmWCfdw
 m/UUGshI0NZC9eLex/mfey6gb8jL0P3zXtdhMhFRRvx5wN7cvgX/cwe8qoLQWGY+Vk5x
 28miw0q866aYn8hlKBLjdkx4D6VBVw7HU9my8FKUK0GSzIQNGIVWLl+U1H1xsNOrc2RT
 byc/bSprjw1ZvbnovJGEl7gsK1+BR3OiF3gp+cYOu2ozSabnhMWTGRjert4Z0IQNanZ5
 ARBFiS8CraTLa14Z2Dfqi3mVwMD4HNOKSPBkbjlW3GwpWi25EAd/r0qzOZ1ubQ7lLTET
 6iMQ==
X-Gm-Message-State: AOAM533zAI0CWXweyvwbMw3RF/F4shNwERBhecBYwv9PPpMreBhNYY4/
 BLmwh+/yy4rxdQLDGh+BDKCE1A==
X-Google-Smtp-Source: ABdhPJyoXPEE4Y+PUiCrrS+ozWk1/WGyHTeIxyXg0SQgO/W4PkuHBbK13rxi4TsTt6HtaEnAmw6ebQ==
X-Received: by 2002:aca:b38a:: with SMTP id c132mr17388459oif.90.1624296331567; 
 Mon, 21 Jun 2021 10:25:31 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id u10sm4235029otj.75.2021.06.21.10.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 10:25:31 -0700 (PDT)
Date: Mon, 21 Jun 2021 12:25:28 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <YNDLiPYkmLZN076t@yoga>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <YMlwTiN4Y9bK3M4Q@yoga>
 <8d58da79-8e54-048b-db89-8c1caaa0320f@metux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d58da79-8e54-048b-db89-8c1caaa0320f@metux.net>
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, stratos-dev@op-lists.linaro.org,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bill Mills <bill.mills@linaro.org>
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

On Wed 16 Jun 10:52 CDT 2021, Enrico Weigelt, metux IT consult wrote:

> On 16.06.21 05:30, Bjorn Andersson wrote:
> 
> > Combined with the virtio-i2c effort this could provide an alternative by
> > simply tunneling the busses and GPIOs into Linux and use standard iio
> > drivers, for cases where this suits your product requirements better.
> 
> So, you wanna use virtio as logical interface between the two CPUs ?
> Interesting idea. Usually folks use rpmsg for those things.
> 

rpmsg is a layer on top of virtio, so this would be an extension of the
existing model.

There's been discussions (and I believe some implementations) related to
bridging I2C requests over rpmsg, but I think it's preferable to
standardize around the virtio based bearer directly.

> What is running on the secondary CPU ? Some OS like Linux or some bare
> metal stuff ? What kind of CPU is that anyways ?
> 

These ideas revolves around platforms that implements something like the
"Android Sensor Hub", which provides some resource constraint
co-processor that deals with sensor device interaction and processing of
the data without waking up the power-hungry ARM cores.

Given the focus on power consumption I would guess that these are not
going to run Linux. Core-wise I've seen this implemented using primarily
ARM and Hexagon cores.

Regards,
Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
