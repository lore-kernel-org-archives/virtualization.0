Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A76CC433F5
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 03:31:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8F961284
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 03:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B8F961284
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D62B640224;
	Mon,  8 Nov 2021 03:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yn9_tPhPWcrj; Mon,  8 Nov 2021 03:31:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9FA5040221;
	Mon,  8 Nov 2021 03:31:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81BA5C0019;
	Mon,  8 Nov 2021 03:31:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA629C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 03:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BEE460777
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 03:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6PmwBY8NayTv
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 03:30:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCADA60769
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 03:30:59 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 w9-20020a17090a1b8900b001a6b3b7ec17so7607797pjc.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Nov 2021 19:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=g2PQ6C+FR5hJWiqWPGZRyR8q4wNDTf7CmMs7qJQULxc=;
 b=ypH6yPWgnEHzQ/nzEzuFR1UHC/JDbLCq6QxJuFwHznzSvyA+KEInRyo0mW64LN7G39
 pIlLxp0F8XPNHUYp+6lIxm4dIwF85FjEJDR1RNjfBJugQA3ushLqDs4R4SE89Pty/P1D
 VNke3D7YhY7yzbOjWBCp8sPw7pQ7PYWqaIu76cNsxTRVaERx2igHMWiMABrkpeuh1y8x
 UoJXi8+xjMceIpW8Em6se176NDwDrtfgGvS0kWBwE2Ssi62Sm7+RM0cdc87yw/Y6G2O8
 Dy+IRrl0zXk32meGbJaf0LoSFu5UdsSUt8nL1IJNjjGE5eGA6S9Hsul+VR8CmOgs5F18
 m0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g2PQ6C+FR5hJWiqWPGZRyR8q4wNDTf7CmMs7qJQULxc=;
 b=pL0rh2XX3ihaln7w9gtnqN4delOavPvn4yxMDfsj3TQd0Gxt8IV+tpgRmWLpZGf3B5
 +PixGea5LaP0s4iDnjseQXJyJJ5j94isO0+QUlNX9Xqs6HyXIHAe/uTmhj9BCBPMVSKL
 yI24b9UP6UL+T3obJvZDTnQpgFU91jOzlwzZAItBkjsZ5pqCuVw4a9nqv5pgqcmSWFEW
 5M1/u5XycvE6423UaRbbAL4oxAQGpma1rNyBXmILY2gaAVRwnOQp8CgcjGi45eEjBlMq
 3aWMJYXZR4h/0VaMtm/E/BoYq8hY8qBVMSmNsQMinYdlCnH0aVc4bN2iYjYSzXqehq1e
 gryQ==
X-Gm-Message-State: AOAM5324tUkZYet3ofs4BzUMYxJ3Ay2ge46tX3GUgSnPHtCBJQ+6jVWL
 pqXl8ZXS/dY9q+gj+zXzmBSTZw==
X-Google-Smtp-Source: ABdhPJyghMeimTOuGNkOw96lKUav/KH8HAFXBfKsgjwu7gPty/HHoV837fxU8OqGbGchOXl+m2qoDg==
X-Received: by 2002:a17:90a:1190:: with SMTP id
 e16mr48859089pja.209.1636342259167; 
 Sun, 07 Nov 2021 19:30:59 -0800 (PST)
Received: from localhost ([223.226.77.81])
 by smtp.gmail.com with ESMTPSA id e8sm11008595pgn.46.2021.11.07.19.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Nov 2021 19:30:58 -0800 (PST)
Date: Mon, 8 Nov 2021 09:00:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH V7] gpio: virtio: Add IRQ support
Message-ID: <20211108033056.gdslnxjp4fc7473i@vireshk-i7>
References: <ae639da42050ee0ffd9ba1fffc2c86a38d66cec4.1634813977.git.viresh.kumar@linaro.org>
 <20211022060746-mutt-send-email-mst@kernel.org>
 <20211025034645.liblqgporc53lkg2@vireshk-i7>
 <CAMRc=MfPtRiBYxsTzz06qpUiNTSw4kPjz3B5YbH_WJ7zN6jvYg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMRc=MfPtRiBYxsTzz06qpUiNTSw4kPjz3B5YbH_WJ7zN6jvYg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
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

On 04-11-21, 16:37, Bartosz Golaszewski wrote:
> I picked up the v7 I see in patchwork (but not in my inbox :( )

I did send it to and can see both in the --to field:

Bartosz Golaszewski <bgolaszewski@baylibre.com>,
Bartosz Golaszewski <brgl@bgdev.pl>,

Anything wrong there ?

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
