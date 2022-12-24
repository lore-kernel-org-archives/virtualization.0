Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F71C4332F
	for <virtualization@archiver.kernel.org>; Sat, 24 Dec 2022 06:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03CC560B20;
	Sat, 24 Dec 2022 06:10:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03CC560B20
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=h0YtYQKE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7SR03kvp9Ue; Sat, 24 Dec 2022 06:10:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 78C0760B0C;
	Sat, 24 Dec 2022 06:10:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 78C0760B0C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54E45C0077;
	Sat, 24 Dec 2022 06:10:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0752C0070
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 06:10:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B790C81EE2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 06:10:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B790C81EE2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux-foundation.org
 header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google
 header.b=h0YtYQKE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CDr4coSGpxnk
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 06:10:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD58481ED8
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD58481ED8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 06:10:49 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id i20so5181379qtw.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3E3YAkwQ1FMGK0G4c+k3cWhSC99qn+AW2e60BpLd48M=;
 b=h0YtYQKEi5AnsXB7utpqFRidFunGHv4v+XFF72sE8OGP438jrHeRtPo/jQdOSZ1pLE
 oegIRWAaL4+RlmtvXf3fWwBdtxMDrz9wbhjYKbUArB5tP0fzi7/cIsac8j32oj4Hz6Xj
 3+DSLdyaQWX2k4WvvXwK/zYvkz1jN+G7ah7Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3E3YAkwQ1FMGK0G4c+k3cWhSC99qn+AW2e60BpLd48M=;
 b=mCBWTvHOrv81fI0z2LnyAUyvUd4M2deZRGMb0vARirPaA4YN0TplzZsg0s526+10lB
 VRRcuF56v0SpeN6dmsIN+UOV4sHfLj4EY2rcZmQPxp4TqDSYaxRMVO3p6B9OUVbFQPUP
 7XghmDHaPigd0vjj9fEdVTwMPMR9U56CaSTocxkMI6+JAUk7oXDNW4jNfY0oifcUTZm8
 ki6KW3R9VxsSLIQHP4oOeUjF/YLFDPvp68LUBJJD2nPQhwNhWwPSWsxubEbgLiiX4WAp
 mtRlyDRMy4NnFHnHKmwM9Z1X/dU7TBzDFf4xmuJKbLlbe84BFcdIicadJIoHHJ+znNVi
 751Q==
X-Gm-Message-State: AFqh2kpD8zJCAwMDV9qCkj77annlB9Oo5lqgk0I7nvy4ynta5KZGitoI
 FobCgCyKTJvIA0iUq05THwRPTTz/ExdbXcmwBvY=
X-Google-Smtp-Source: AMrXdXvRxBdA+MKLIbbcsYrRSfX77KIQnMiBbJ6ICu1/txdrFSh21TjdVD/yWYauGJzCCLvsZYGDeg==
X-Received: by 2002:a05:622a:260c:b0:3a7:e0ba:7c23 with SMTP id
 ci12-20020a05622a260c00b003a7e0ba7c23mr16743205qtb.60.1671862248142; 
 Fri, 23 Dec 2022 22:10:48 -0800 (PST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com.
 [209.85.222.181]) by smtp.gmail.com with ESMTPSA id
 bk2-20020a05620a1a0200b006ff8ac9acfdsm3678862qkb.49.2022.12.23.22.10.46
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Dec 2022 22:10:47 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id pa22so3229865qkn.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Dec 2022 22:10:46 -0800 (PST)
X-Received: by 2002:ae9:ef49:0:b0:6fe:d4a6:dcef with SMTP id
 d70-20020ae9ef49000000b006fed4a6dcefmr506882qkg.594.1671862246626; Fri, 23
 Dec 2022 22:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
 <20221223172549-mutt-send-email-mst@kernel.org>
 <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
 <20221224003445-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221224003445-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Dec 2022 22:10:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_cyzZgYp1pL8MDA6sioB1RndQ_fref=9V+vm9faE7fg@mail.gmail.com>
Message-ID: <CAHk-=wh_cyzZgYp1pL8MDA6sioB1RndQ_fref=9V+vm9faE7fg@mail.gmail.com>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: bobby.eshleman@bytedance.com, kvm@vger.kernel.org, sunnanyong@huawei.com,
 yuancan@huawei.com, virtualization@lists.linux-foundation.org,
 weiyongjun1@huawei.com, elic@nvidia.com, set_pte_at@outlook.com,
 m.szyprowski@samsung.com, almasrymina@google.com, sfr@canb.auug.org.au,
 dave@stgolabs.net, anders.roxell@linaro.org, lulu@redhat.com,
 ruanjinjie@huawei.com, rafaelmendsr@gmail.com, pizhenwei@bytedance.com,
 eperezma@redhat.com, angus.chen@jaguarmicro.com, lkft@linaro.org,
 colin.i.king@gmail.com, sammler@google.com, nathan@kernel.org,
 leiyang@redhat.com, harshit.m.mogalapalli@oracle.com, wangjianli@cdjrlc.com,
 gautam.dawar@xilinx.com, pabeni@redhat.com, dengshaomin@cdjrlc.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 dmitry.fomichev@wdc.com, wangrong68@huawei.com
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

On Fri, Dec 23, 2022 at 9:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> They were in  next-20221220 though.

So, perfect for the *next* merge window.

Do you understand what the word "next" means? We don't call it
"linux-this", do we?

This is not a new rule. Things are supposed to be ready *before* the
merge window (that's what makes it "next", get it?).

I will also point you to to

  https://lore.kernel.org/lkml/CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com/

where I'm being pretty damn clear about things.

And before you start bleating about "I needed more heads up", never
mind that this isn't even a new rule, and never mind what that "next"
word means, let me just point to the 6.1-rc6 notice too:

  https://lore.kernel.org/lkml/CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com/

and if the meaning of "next" has eluded you all these years, maybe it
was high time you learnt. Hmm?

              Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
