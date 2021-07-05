Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09ACC07E98
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:52:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911A360238
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 03:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911A360238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DC646081C;
	Mon,  5 Jul 2021 03:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KGAScUH-9ugq; Mon,  5 Jul 2021 03:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A074C60817;
	Mon,  5 Jul 2021 03:51:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70942C001A;
	Mon,  5 Jul 2021 03:51:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1565AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAE6A4045B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:51:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O-gi7swKYuUY
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:51:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8451D4045A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 03:51:56 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id d12so15580887pfj.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 20:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=YUiMviEM4qWdeD7ggunch8ZPUKg+2qZoar2m+NNRGS8=;
 b=uNOJqNlVsqFRp5V3Dtzs3LyZ4JxAhvTmnE2809JkV8BYzbjdgNXFu/SCqBZDhETWtO
 UxCzhkRR3gQ9LF2lJDo5jlBbXhNOIpCTWJcJC11PU3INIgaXe2QcHww5gjZXuPFWDjNJ
 /GwAKJfmf+1yV11uKI1brbUqXQGZUM0DqsCjdMD/F05M83wDT87QoJe0N/HgWS/Nwnhy
 /y1aMKg7oUZy07MQjOeIRCkOVeKjvYcASAUb7Fygz0e4Dp9TnbkpE/Z/mQKeK7ASxeCc
 AYYz7glhgtksIRljwLiWrvk+WHYi20dA2hwcZqR+hXZwhiB0ZMObCtEleUrCAoSdapiA
 RQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=YUiMviEM4qWdeD7ggunch8ZPUKg+2qZoar2m+NNRGS8=;
 b=M4BBoTQbtX1+kYAH8BHXAagGmfW1XnFfrR4Z7lVI7nsbcn4wxovM/rd0dfzWgIoaEK
 g+xgyjCQj0y66UHkjjdDS05cgxzh+pH/Fa1H3KX8W8AOY23nWF/xWlHX3yXwXR+pNmqN
 cxvrUH82+ZH1TIRGCazWWIPt1r2MBZaitzbL80p8IpjXawvRMSmPU4VJ4Cv/FymiETx6
 523dVz6dZhROyqIaaq+e7tqO0D0ddZi+ysFXtIAc1GTP9zTg3Atu8Lmym/eFwIJG3AVZ
 jYqD30+W8FCzF2CfmBVa8p6BB9qEL8zpYSh/TIuQCcqpagDVufvDCQCQZ52Sqritra0Y
 B+KQ==
X-Gm-Message-State: AOAM533Gtt+9rEk6CpHYvfCr5PmnKnuAtqtI6j26hUe3MvyOU9+RZpli
 F77SpVkGRy8YKUs1DfW6QIKSLw==
X-Google-Smtp-Source: ABdhPJz+JXkVhZeNayxLP5SNBpR8ubLc6ozNA5fTH8fBBTnhakkXSO8gz+YOe0X4leyKkb5WHzk6hA==
X-Received: by 2002:a63:d60b:: with SMTP id q11mr13345118pgg.270.1625457115683; 
 Sun, 04 Jul 2021 20:51:55 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id m2sm20299200pja.9.2021.07.04.20.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 20:51:55 -0700 (PDT)
Date: Mon, 5 Jul 2021 09:21:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20210705035153.rceytdfbmvj5tvdt@vireshk-i7>
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <CAOh2x=kcM351ObubnQSzUa=FVBQUmAUhz4u8ExORUthQQ0WbGQ@mail.gmail.com>
 <253f218d-07ac-1963-75e1-9ac2d035437a@metux.net>
 <20210526033206.5v362hdywb55msve@vireshk-i7>
 <20210703040504-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210703040504-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
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

On 03-07-21, 04:05, Michael S. Tsirkin wrote:
> On Wed, May 26, 2021 at 09:02:06AM +0530, Viresh Kumar wrote:
> > On 25-05-21, 14:59, Enrico Weigelt, metux IT consult wrote:
> > > On 24.05.21 13:27, Viresh Kumar wrote:
> > > 
> > > Hi,
> > > 
> > > 
> > > > We (Linaro's Project Stratos
> > > > https://linaro.atlassian.net/wiki/spaces/STR/overview)
> > > >   are interested in this stuff. I was trying to look at the last status
> > > > of all this. Few
> > > > questions for you:
> > > > 
> > > > - Was the spec ever posted to virtio-dev list ? I thought that's the
> > > > very first step before
> > > > we merge the code.
> > > 
> > > I had posted some spec quite some time ago, but it wasn't in the form
> > > of patches against the .tex documentation files yet. It's been laying
> > > aside for quite a while, since I've been busy w/ other things.
> > 
> > Will you be fine if I take that up and restart the thread ?
> 
> It's been a while - why not right?

Yeah, we went past that and here is the last version I posted.

https://lists.oasis-open.org/archives/virtio-comment/202106/msg00033.html

which I took back later on to let Enrico do it, as he wanted to.

And here is the last version from Enrico:

https://lists.oasis-open.org/archives/virtio-comment/202106/msg00048.html

Lets see how this goes in coming days.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
