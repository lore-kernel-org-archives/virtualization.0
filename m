Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D8DC49360
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 09:24:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7712C61370
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 09:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7712C61370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37E3F4026E;
	Mon, 14 Jun 2021 09:24:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fo-I9gGIIpOM; Mon, 14 Jun 2021 09:24:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5766240219;
	Mon, 14 Jun 2021 09:24:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3069BC000D;
	Mon, 14 Jun 2021 09:24:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2385CC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:24:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0478F60654
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:24:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4s0IGEcN0fLt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:24:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 36FF8605C1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 09:24:26 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id i34so8120799pgl.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zMkdb6UnzsmFoGQuydSUH9T+jo8wlm34o+dnsVNGaOY=;
 b=yj58aZCITvmYsGGj7Nk7gTFZgHtEggMHzWZ75qNOIRRTEuNfBJ51g2pH/ybeSJ1SwD
 QJKQQJ4431wv40jvILOT2zTpLY37Pmb79CZJvSH9WHYT8yESH/hcwodGpHJ7gNkzhqCZ
 6rK4tGwNcv/UNi3KOr5c8YYV7WaX7n3MlyFNONQPvGHS2n4KZq9R+KlFTnoCPbERBwo0
 CR/lqpjYEGcAVnQmENHr7EYajipilph4sbUz3rXzXsYYkck9f+B6Z6kqIA0bNpjbuhvH
 eoPjDL+Ot1oOiVyu34IiHe6hfhvBVP4ManGNNsyv7dUYrYolzHjOSubEfP+hSrWQeAdf
 s+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zMkdb6UnzsmFoGQuydSUH9T+jo8wlm34o+dnsVNGaOY=;
 b=ILr4Fny0rvBQHKCzjwo8lzTr/CtEFocT0iofSuQnMrD2BJnWG5qT6XePx7pe1CB+3r
 347IFpjlXWolSvyHwWy4D31PGTGgdphEzTMTcZ7A0UJCWtwLDN9vPx6RiuU6ZUs6NdN7
 qDnUG85v9ir1EMqpaHhHd0HufBIM0SqmC5CDCLtqyw5bcD4p0b0l+epkBTwW2zNeVkYj
 rOEBk2ZHWORqNe2Y3OAsXTwpNmf9y+aSDtvqt+yvTKQlWzi4eeLW14HmzO9u73Dfwoz2
 MJ309NmIiQKjSWaKNtk9MByIVYyl744vOzB94CvH8tMLOWA3r473jpmYBBJuK5H2frkh
 w7CA==
X-Gm-Message-State: AOAM531G9dxUORVkBereNNWNEC7payHY0Lzyn9AgErVz1QdrnIHk3CXK
 q96+h2xoA1Ya5+qiJ0YFjdsBeA==
X-Google-Smtp-Source: ABdhPJxlNHDHLzS1JN+AlXEDxsg1diObJaCyoiXgBPZpknYyUf1Rtey2rbTHk5lENDG3Si5HyrUmKw==
X-Received: by 2002:a63:5057:: with SMTP id q23mr16171557pgl.271.1623662665642; 
 Mon, 14 Jun 2021 02:24:25 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id ge13sm17169989pjb.2.2021.06.14.02.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jun 2021 02:24:24 -0700 (PDT)
Date: Mon, 14 Jun 2021 14:54:22 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210614092422.jmq2i3vlkjmy6cvf@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <db2d29fd-ff27-0c75-2472-dd031564dbf1@metux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <db2d29fd-ff27-0c75-2472-dd031564dbf1@metux.net>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On 14-06-21, 10:03, Enrico Weigelt, metux IT consult wrote:
> for qemu side you might be interested in my patch queue from last year
> (including the virtio-gpio implementation) - it also introduces an
> gpio backend subsys that allows attaching simulation gpio's to various
> backends. so far just implemented a dummy backend (that can be
> manipulated by qemu console) and using it just in the virtio-gpio
> device emulation.
> 
> https://github.com/oss-qm/qemu/tree/wip/gpio-v2

Interesting, so this is a qemu-specific backend you have here.

The way we are looking to write the backend (in Project Stratos at
Linaro) is to make it hypervisor agnostic. So any hypervisor that
understands the vhost protocol can use our backend without changing a
single line of code. The backend will not be part of any
hypervisor's/VMM's source code. FWIW, this doesn't add anything
special to the virtio protocol (like GPIO).

Here is a C based backend we have for I2C:

https://yhbt.net/lore/all/cover.1617278395.git.viresh.kumar@linaro.org/T/#m3b5044bad9769b170f505e63bd081eb27cef8db2

I started with keeping code in QEMU itself but now replaced it with
one in RUST.

https://github.com/vireshk/vhost-device/tree/master/src/i2c

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
