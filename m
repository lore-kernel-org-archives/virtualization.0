Return-Path: <SRS0=fqYQ=LL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F49EC2B9F4
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 03:59:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9943F61026
	for <virtualization@archiver.kernel.org>; Thu, 17 Jun 2021 03:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9943F61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47BF9400E9;
	Thu, 17 Jun 2021 03:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ZD1-dbXMII2; Thu, 17 Jun 2021 03:59:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D38B740150;
	Thu, 17 Jun 2021 03:59:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9694EC000D;
	Thu, 17 Jun 2021 03:59:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC561C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:59:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 931D260669
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:59:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wDas6rp-0BsL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:59:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 95FD4605D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 03:59:04 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 m15-20020a17090a5a4fb029016f385ffad0so226361pji.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=a5D+ny1Y0c3O7KxzHuyI+M5mGXvaRgQ84CvvtncVlG0=;
 b=fRcFPkiIxPDt9py7J1PQBOFWa8GEY8lHPvIBnBm1ce3CL3iHZHu/UZCEhEGJOVVCaA
 VHKOkUgSyIJQ2Ruk0A2HflJ0G72K5plXNdgLkY4e1ZUcxSzfYUKbwM5q0pG5lNePiwOv
 7FXxll2wYUEI85aVEsP19np7Ju9bEl8kDfsr25mfOtrQe07owDGhAhZzToqNsjeA/IPH
 E+9IHrMS1E0RR1+reFfHNJI5ouyJ2XoNtLzW9AM3mUdmwZItucn/6F40ftKaCGJEwq2c
 uQOFRr7oRd61zssn2NtqMyTC3iNCwKJ7UXnmUrPPz521WtPzXyoeZj+nlHxs99HDqXOZ
 4nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=a5D+ny1Y0c3O7KxzHuyI+M5mGXvaRgQ84CvvtncVlG0=;
 b=Sv51ACCDpjdYjilsYTByAmQWBUoQJCv47+rV8C4tGYlrKRfG/iBnZoOgYhlI2UBcSc
 tMX4QJdMPkqglDPCZH4/bfiy7HQ7AHBuowL/fLh3egPLZtwROgmcU1qqvQviFvUlztCb
 EkrUMgmnDjVkWEA16jVJ75Zd1z/v5eFcZMBCC4AyXfScjvmNPoHd1Yr6sIUsFQWA6WXm
 210ZKpLnsszpM441G3EHKwnC9HjkG6J2FcLzCy0qFrGc21seivSwUdbCwsdPMEz2ouYk
 f0JTBs3C6NNBgBYp3/jEDg1cXcVJrxhndv1CgGWsIqchGqY0TjcZ561ltDVJLdAIHxrP
 4+DQ==
X-Gm-Message-State: AOAM532NsGkKM+o+9qMgf4OoD1Nt+U3jma6WGmAtJBEAW3+dyWKGLDLr
 bkcrVNep8Q+V29N1l8BttBVE+A==
X-Google-Smtp-Source: ABdhPJyK8z8cdDdyBhx0CBSqDGBDOEf/ee2crujfR5xEIC5Ea+opK/+E62HCRvXJLb044uPARRa9xQ==
X-Received: by 2002:a17:902:8d97:b029:113:d891:2ea0 with SMTP id
 v23-20020a1709028d97b0290113d8912ea0mr2678159plo.61.1623902343697; 
 Wed, 16 Jun 2021 20:59:03 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id j10sm3388366pjb.36.2021.06.16.20.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 20:59:03 -0700 (PDT)
Date: Thu, 17 Jun 2021 09:29:01 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20210617035901.kfzps6kg2emthjf4@vireshk-i7>
References: <20210616114934.n3grzuh6c64wlaj6@vireshk-i7>
 <5cffb354-0d00-5ace-260d-61ac0c4c7491@metux.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5cffb354-0d00-5ace-260d-61ac0c4c7491@metux.net>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Anton Vorontsov <anton@enomsg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Kees Cook <keescook@chromium.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Tony Luck <tony.luck@intel.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Colin Cross <ccross@android.com>,
 linux-riscv <linux-riscv@lists.infradead.org>, "Enrico Weigelt,
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

On 16-06-21, 17:04, Enrico Weigelt, metux IT consult wrote:
> Half correct: I sent it to the list, but this wasn't tex'ified yet.
> 
> When we had an email conversation about this, it was about submitting
> the existing spec in a formal correct way. Don't get me wrong: I
> apreciate that somebody's doing the beaurocratic work. But still have
> no idea why you changed it completely, so there's quite nothing left
> but the name and that it somehow does gpio via virtio.

> The one I've resent (now texified) a few days ago. It had been submitted
> in ascii form last year. The answer from virtio TC folks whas that there
> are some formal steps to be done and it needs to be patched int their
> tex document.

Okay, we figured out now that you _haven't_ subscribed to virtio lists
and so your stuff never landed in anyone's inbox. But you did send
something and didn't completely went away.

Since you started this all and still want to do it, I will take my
patches back and let you finish with what you started. I will help
review them.

Please start with specification first, and resend them as soon as
possible. So we can start with reviews there.

Also please cc relevant people directly, like GPIO maintainers in
kernel and few more from CC list of this email, as most of these
people aren't subscribed to virtio lists, they will never get your
patches otherwise. Lets get over this once and for all.

> You sound like a politician that tries to push an hidden agenda,
> made by some secret interest group in the back room, against the
> people - like "resistance is futile".

:)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
