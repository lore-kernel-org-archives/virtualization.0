Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD185C48BDF
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 01:45:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BACB611CE
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 01:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BACB611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC87E608E6;
	Wed, 16 Jun 2021 01:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JpfrqDYE7baI; Wed, 16 Jun 2021 01:45:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91DB7606AA;
	Wed, 16 Jun 2021 01:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC8CC000E;
	Wed, 16 Jun 2021 01:45:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0159AC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 01:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB24A4013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 01:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OyJ_EK-63bgF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 01:45:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABADB400CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 01:45:24 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 22-20020a17090a0c16b0290164a5354ad0so2998319pjs.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 18:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WiRCci0E3CBaTJSov8aP3aMirNDwvb95s8pJiMPbiLE=;
 b=wmQs8AlTFSXTCSysIARXEbA1F8qYDvxC/JZv9qRhUh+lThq4r3wrJRyXk8ugI38H86
 y0k+4ZB8zYKxutk1/McQ5pKFtXVdJueMYp/JakTazJjxEZADr3Wj8VcM1IHHygxxbqIW
 U9MePSdU1qpFSA98aNOtDswKC5P87uim45JLZPLaRvrxhjK0Sentrc+0CKxTk7uLKPrh
 49gkCG6Ee+woCarfrV7WwoUITP4+6Sfgmk14OUsutuFFamAOYvspOTdONtIxue2ILu3B
 aqOuEE+VXZLp0m1wTmZAel7OfkYiJfNuj6amtpSqZCemIEGWt8D97Xx/f4hs7wNgDLdm
 HBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WiRCci0E3CBaTJSov8aP3aMirNDwvb95s8pJiMPbiLE=;
 b=R5PVUs8ycMa3aFFAH0jDevcWyrSnpmiuofx48pmTruz/GzL71BVP2OP5fvVv0+4aXx
 OFaptuBrDvPOx55ubca8XNBgxc9zKw+maiNt5udJ1ViHts6b4jfkkHEt3h6y7UG/M9+m
 8F4l55k++WwkxIHLQG1AkMcN3eRdZbDGjf9Grz72XmyBMkfAp2Ef1uohG/LgYfrR8SeN
 UUqggkzRuYusfL7XDeJ5Fc/spmvKs35Qh5hI+UW4uaSSOT7a66c8UxCuiix8dhjDgwIF
 DF0MT0XVm91Czpa7j1eqbXVqHv4ozvbh75gzcR2mdljozNKVH3SC1Pe7IRN3WTbQyKFq
 Vnzg==
X-Gm-Message-State: AOAM533iwr5oSfQ3uPRyQwkv74dcaJwQHqOnKVBfdd5DIIV+nsr7WORb
 2QhdzbmKsNqeJaZWMghAHRX+9Q==
X-Google-Smtp-Source: ABdhPJx12mo0fmVKv0fY6g/xDgXHcWqG9HH/gLqDFpEh659OuHf2dlOFn7d4rv5WRJXC1HgIs7MVYA==
X-Received: by 2002:a17:90b:46c3:: with SMTP id
 jx3mr2257792pjb.206.1623807923967; 
 Tue, 15 Jun 2021 18:45:23 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id h8sm350000pfn.0.2021.06.15.18.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jun 2021 18:45:22 -0700 (PDT)
Date: Wed, 16 Jun 2021 07:15:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210616014520.dkkbdamgelptl3un@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <10442926ae8a65f716bfc23f32339a6b35e51d5a.1623326176.git.viresh.kumar@linaro.org>
 <CACRpkdZV2v2S5z7CZf_8DV=At9-oPSj7RYFH78hWy3ZX37QnDQ@mail.gmail.com>
 <20210611035623.z4f2ynumzozigqnv@vireshk-i7>
 <CAMuHMdVrtSnFpPbB0P3Wxqm1D6vU1_cnh3ypsZJRNF6ueKdAsw@mail.gmail.com>
 <20210611080122.tlkidv6bowuka6fw@vireshk-i7>
 <CAMuHMdVL4VH09ixPcpqqokNJeYd68Th2Y6Lz4PZTF7h06OOBGw@mail.gmail.com>
 <20210615111551.7tcz7teqp4olhodf@vireshk-i7>
 <CACRpkdbyybnxP9p3Jh2TbJMhK+kfLyed-YyrZq9JbOqu1csmww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdbyybnxP9p3Jh2TbJMhK+kfLyed-YyrZq9JbOqu1csmww@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Alistair Strachan <astrachan@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Viresh Kumar <vireshk@kernel.org>, virtualization@lists.linux-foundation.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, "Enrico Weigelt,
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

On 15-06-21, 22:03, Linus Walleij wrote:
> On Tue, Jun 15, 2021 at 1:15 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > I am now wondering how interrupts can be made to work here. Do you
> > have anything in mind for that ?
> 
> The aggregator does not aggregate interrupts only lines for now.
> 
> > GPIO sysfs already supports interrupts, (...)
> 
> I hope that doesn't make you tempted to use sysfs to get interrupts,
> those are awful, they use sysfs_notify_dirent() which means that
> if two IRQs happen in  fast succession you will miss one of them
> and think it was only one.
> 
> The GPIO character device supports low latency events forwarding
> interrupts to userspace including QEMU & similar, timestamps the
> events as close in time as possible to when they actually happen
> (which is necessary for any kind of industrial control) and will never
> miss an event if the hardware can register it. See:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/gpio/gpio-event-mon.c

The current version of backend (I am working on) will be Linux
userspace based, so I would be required to get an interrupt there.

I was planning to use /dev/gpiochipN only for now and not a sysfs
file, so yes it should be fine.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
