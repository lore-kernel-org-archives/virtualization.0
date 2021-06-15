Return-Path: <SRS0=k2cl=LJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A65C48BDF
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 11:16:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574B761019
	for <virtualization@archiver.kernel.org>; Tue, 15 Jun 2021 11:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574B761019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1AEE9401C4;
	Tue, 15 Jun 2021 11:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRevQfMcf0NE; Tue, 15 Jun 2021 11:15:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9DC5740025;
	Tue, 15 Jun 2021 11:15:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A459C000E;
	Tue, 15 Jun 2021 11:15:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4C8BC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4534402CE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mdkARqUEYCly
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:15:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 63DC34027D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:15:55 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 k22-20020a17090aef16b0290163512accedso1643345pjz.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=i84JjlRo2D2f/v7VuRGvpKj9m4FZoDnu564HcAYYGaY=;
 b=VTHFnc+4SnsSRV0D5jDxumRtE49WlOQLlikQFoE39XX8Wb5j25weHyQksV4/4Bn/f/
 2BlH2QShf5TXe7zDKdkjS+Gs3tE+RPTxzPeLwN6/cgZpqkATlyaJxVgB4UH0wPf327ZK
 3sg02GpQY+QtWBfJzL0HKJd0UvY+5w37Y3noV/Tr0+AqPol3BIvomuMAHNODERgZAoqL
 i/Vs7+tAbxxbfDyLn0N9FCKTiBr4s+0yLA7s9wxgR5BNyxKwXe1WIRfmXQ9vO7+XwMz+
 fRkr+bY9h/tbHmcW6rwAiRQ/L8eR4C2H9AUb+8oXl5chJm9EhUjEwS6TWkLgYkE2AW3p
 2uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=i84JjlRo2D2f/v7VuRGvpKj9m4FZoDnu564HcAYYGaY=;
 b=lPb0mmv3TgZR12RZAX2Sy7RCC7ZOyOyUFG/sQygk68H6wOjERDJmg5HExnyXB8m+IX
 FrDAPaDVtoJR6WNF/lmS9q3rx3mr/zSbEoJ8lFoWjK5J+53qFeuQAyM1BXeK8yh7/50Z
 3pcO9i4AOTqhvWhjvQEP1ftaf5pm2hWpObKnfZVsnz4X/woiAnuKwTQE3eXBxPz3NX3A
 IW771J2vjCBRrQKNGpBefOJL8WgFgKPqT68BM6+kXEsd/rYgy9hwVq4kIzEj1ppHkWla
 hymq7uU9QVTpAmiNxRKD/ilbKWo5aszfkYYl7hJ4Lc8pnWqeCNDfHJi0xIrLj5AWpCpW
 SAJg==
X-Gm-Message-State: AOAM5303FEJ26txD86sjwMXEM53Vd8OY2xxgXY+HU6PXxiuh95Y89cL9
 GljSEiysSO8Hyp1HkcmPn1R2Zg==
X-Google-Smtp-Source: ABdhPJyprFGOjuuA6oVBkx5SM8o2ljPT3jBLG+8fzP8YN3F1g2qb2jzWJ2heaZFu4ovB1sQ+xoLJ2A==
X-Received: by 2002:a17:90b:2504:: with SMTP id
 ns4mr4466637pjb.39.1623755754669; 
 Tue, 15 Jun 2021 04:15:54 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id g8sm15949343pgo.10.2021.06.15.04.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 04:15:53 -0700 (PDT)
Date: Tue, 15 Jun 2021 16:45:51 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210615111551.7tcz7teqp4olhodf@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 stratos-dev@op-lists.linaro.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>
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

On 11-06-21, 10:22, Geert Uytterhoeven wrote:
> The same reasoning can apply to your backend daemon, so when using
> the GPIO aggregator, you can just control a full gpiochip, without
> having to implement access control on individual GPIO lines.

I tried to look at it and it surely looks very temping and may fit
well and reduce size of my backend :)

I am now wondering how interrupts can be made to work here. Do you
have anything in mind for that ?

GPIO sysfs already supports interrupts, just that you need to register
irq for the specific GPIO pins inside the aggregator ?

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
