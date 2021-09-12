Return-Path: <SRS0=fv7C=OC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD4C433F5
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDC160F6F
	for <virtualization@archiver.kernel.org>; Sun, 12 Sep 2021 00:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BDC160F6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 266AE4020A;
	Sun, 12 Sep 2021 00:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v1uOnLFRMeWt; Sun, 12 Sep 2021 00:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 819EE400DB;
	Sun, 12 Sep 2021 00:53:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66F3AC0011;
	Sun, 12 Sep 2021 00:53:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9451FC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82F3640204
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IBvd1Xiy8Q08
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:53:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E4F740200
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Sep 2021 00:53:52 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id b10so5778377ejg.11
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 17:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fTtI1r5tPdIsG/NkIDSe/Aqz0eLPuMAYXLyyQSCQenY=;
 b=hfTvAxTgvh8dEvrrDxR1ts56KucOk9K49I6CwiyfT/tY2ZjzFKVA1lkSySAKreAWgo
 VhO/812N3vhm209MU9Q9V6tlHvzI9p8WifyBBoR0fSaGmuxPOrmttOegqVxG0p+D+3GY
 5ija9A2vsipX8mcMCJiZFFlb1VoRK5Mr5hWlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fTtI1r5tPdIsG/NkIDSe/Aqz0eLPuMAYXLyyQSCQenY=;
 b=Rt4n70vNIxYM7tO9e86UTn0S0RHWdaoF6qiMn9UQ8p0GyqXp4pzjRVIyluXkt4xfkb
 ZgA7KPg8sS8gFgK5aNbzvUmoBLcBNP1x8HYVG1GaQtQcNqLa0ZAkcWnxIe2FK7p7LG4r
 BGZhAsOrf2e4jjeyx0UTkCag+ztkTtwLFKrIAmreLsnzplqLt8m7cjUKiEDzUGt1xwLU
 /V7Vt/MhZnCeTWF7WZRm6Q8P0ZRNus9qwGT86W4mRUitsHMLt9lqLdQtXhHRLEYsdEZv
 jMajM6n9pOYFec+j4uvEhvfASnRfsa9NhIrAakUe0BTN6VDUnw9xXu5uqNaIPrxqMqCt
 Bz8Q==
X-Gm-Message-State: AOAM532iwTYd4Uz5Rqp0yQb2MNNBcxZzAQIa7Js2NNrn/YchtfySblgl
 hXVzJQWIZd2JFgkiztDzzrm9rxhRn66lcDwtsdiMnQ==
X-Google-Smtp-Source: ABdhPJyre/ZlAPDBO+ZZlNnQRleuiz+Oj9glkgMy0ObSTvjPyufqbApV8rTKmgiDZ/hN7t/MrEC4wg==
X-Received: by 2002:a17:906:7047:: with SMTP id
 r7mr5025978ejj.342.1631408030633; 
 Sat, 11 Sep 2021 17:53:50 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com.
 [209.85.221.41])
 by smtp.gmail.com with ESMTPSA id r16sm1607727edt.15.2021.09.11.17.53.50
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Sep 2021 17:53:50 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id x6so8515777wrv.13
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Sep 2021 17:53:50 -0700 (PDT)
X-Received: by 2002:a05:6512:3d04:: with SMTP id
 d4mr3696677lfv.474.1631407624560; 
 Sat, 11 Sep 2021 17:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210911200504-mutt-send-email-mst@kernel.org>
 <163140733123.30830.10283487707815357982.pr-tracker-bot@kernel.org>
In-Reply-To: <163140733123.30830.10283487707815357982.pr-tracker-bot@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 Sep 2021 17:46:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1Wd8yVyErBrG06jE+Q2rgjNB2N=MzEdjNVo9v0YRwAA@mail.gmail.com>
Message-ID: <CAHk-=wj1Wd8yVyErBrG06jE+Q2rgjNB2N=MzEdjNVo9v0YRwAA@mail.gmail.com>
Subject: Re: [GIT PULL V2] virtio,vdpa,vhost: features, fixes
To: pr-tracker-bot@kernel.org
Cc: mgurtovoy@nvidia.com, lingshan.zhu@intel.com,
 KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 xianting.tian@linux.alibaba.com, Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 xieyongji@bytedance.com, Viresh Kumar <viresh.kumar@linaro.org>,
 arseny.krasnov@kaspersky.com, elic@nvidia.com
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

On Sat, Sep 11, 2021 at 5:42 PM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Sat, 11 Sep 2021 20:05:04 -0400:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus_v2
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/a93a962669cdbe56bb0bcd88156f0f1598f31c88

Note that pr-tracker-bot is confused, but not entirely wrong.

Because this was a subset of the pull request that was actually
merged, pr-tracker-bot reports that it was merged.

True.

But what was _really_ merged was the first version that contained this
and then some.

           Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
