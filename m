Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121E9C48BE5
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 03:30:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A446361369
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 03:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A446361369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63AA5406A1;
	Wed, 16 Jun 2021 03:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZgBlZRQgynl1; Wed, 16 Jun 2021 03:30:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C94704066F;
	Wed, 16 Jun 2021 03:30:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E007C000E;
	Wed, 16 Jun 2021 03:30:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E79DEC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 03:30:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CECB3606BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 03:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Em9RucdG6W7b
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 03:30:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC24260690
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 03:30:26 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 l15-20020a05683016cfb02903fca0eacd15so1103399otr.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 20:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=i86DmE+FsyrX62awkaAfzqwF7YB8JnFdUJaPY+I8i5I=;
 b=Qfat5UX9GV6c1Wcj/DNLp0BklvW/aL4PZmlQGmMT8PBMP3705UmFoBLCfCrelJbc4y
 moGxOAKoAQcQax47jPSfd5Rv3vKiemgt/Li6txlGUBX06uIYw/pA+1QB+psYJLstFFPS
 BRo7zqKLNQFn2V8xlKnTiRgCbLFNFCSH2PjyF2oT5v1rt3mhT0O7wdaLzuMqVd76fiP8
 KezhGLs4e8NeKHF+o5VhG8nXGGxVA4LmxO21N9FPJgk/z2zw/DuuC/Yq3yfUGAkZ6yHF
 l5vyY3pioS41p6KtwHqJDUlK3ZWKWG+Bi3Agri8YqthjQmMIocqPgsQQNMan6Hrg+dY6
 hspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i86DmE+FsyrX62awkaAfzqwF7YB8JnFdUJaPY+I8i5I=;
 b=Vx9lijEWRIF5kDBol3/lr2K7R1sM7k7lWi1V2y65iKuWAh1pecOoe7KLUqtEkxTtql
 fBCVEqL22XVcG7DfczkUMKeGfu1uqAtNIb3lZNZmhmP3M40Wz9Dc46tNmp/9xG8CZ+D0
 /B7eo9Lcq6Djgkn+OtPw/OXj09SMgwHWXrUB7GIegBShJCydftv93nBScsOqZP4JLmeM
 YqiIj1R26KJExN0eNCmZVxnfRXJ2EbFz8dY3X0YgsnSg++dPqRcyToylJFXOYNdTxiQD
 BkWctYS10lYC3Pab6DE6KOa511k9pBjYb5mppy0g3m/NTYiH7Dulb9w7T2p0eULcXo9R
 65Jg==
X-Gm-Message-State: AOAM530dPaE2ShlFCQfUfDrmNNcbnxNHIzE/dzDeZTdHysRXC51mG0Jy
 ENNAnO+ozZAkrtMVl/iN1v+dXA==
X-Google-Smtp-Source: ABdhPJxhs/9jElwXtk+L4DLc2u6ZKRZCiYLWJIWb/AnDz3/Z91d0jV126dADdblLKuA65fRJfmQaAA==
X-Received: by 2002:a05:6830:22e9:: with SMTP id
 t9mr2019636otc.327.1623814225341; 
 Tue, 15 Jun 2021 20:30:25 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net.
 [104.57.184.186])
 by smtp.gmail.com with ESMTPSA id q6sm247309oth.10.2021.06.15.20.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 20:30:24 -0700 (PDT)
Date: Tue, 15 Jun 2021 22:30:22 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <YMlwTiN4Y9bK3M4Q@yoga>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Viresh Kumar <vireshk@kernel.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>,
 stratos-dev@op-lists.linaro.org
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

On Thu 10 Jun 15:46 CDT 2021, Linus Walleij wrote:
[..]
> Yet another usecase would be to jit this with remoteproc/rpmsg
> and let a specific signal processor or real-time executive on
> another CPU with a few GPIOs around present these to
> Linux using this mechanism. Well that would certainly interest
> Bjorn and other rpmsg stakeholders, so they should have
> a look so that this provides what they need they day they
> need it. (CCed Bjorn and also Google who may want this for
> their Android emulators.)
> 

Right, your typical Qualcomm platform has a dedicated sensor subsystem,
with some CPU core with dedicated I2C controllers and GPIOs for
processing sensor input while the rest of the SoC is in deep sleep.

Combined with the virtio-i2c effort this could provide an alternative by
simply tunneling the busses and GPIOs into Linux and use standard iio
drivers, for cases where this suits your product requirements better.


And I've seen similar interest from others in the community as well.

Regards,
Bjorn
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
