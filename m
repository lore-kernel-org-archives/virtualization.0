Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E44C4332F
	for <virtualization@archiver.kernel.org>; Sat, 24 Dec 2022 11:28:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5920960A81;
	Sat, 24 Dec 2022 11:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5920960A81
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PC/L7zMi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6vzUsQM-9lLZ; Sat, 24 Dec 2022 11:28:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D4F3260AA7;
	Sat, 24 Dec 2022 11:28:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4F3260AA7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 712AAC0032;
	Sat, 24 Dec 2022 11:28:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDEB5C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 11:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B39CC4179D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 11:28:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B39CC4179D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PC/L7zMi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8BzOW-C1fgOt
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 11:28:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 415A44177D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 415A44177D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671881307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JQfHFluJStqMAVjm8YivW74tDU05oCwMWLpLFH2ZJDA=;
 b=PC/L7zMi5Z68Nwwo1wQmGo0FhDSWM1ckLAdTLi8Xbxcfp7E8qUxJZmxx1AQWZjBXafIsv1
 t2WhbVB7+sid5/ouS4laLlj0vFwNUBZzf3RVwCJW05r0JI3082UVTcvip6enG/UT02zBAI
 5MrbDq3U2+SCRgyPSMWhUjK5SLl5ID4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-2XCPHi_dM4GBO-C_-TOM8w-1; Sat, 24 Dec 2022 06:28:25 -0500
X-MC-Unique: 2XCPHi_dM4GBO-C_-TOM8w-1
Received: by mail-wm1-f70.google.com with SMTP id
 k42-20020a05600c1caa00b003d971135cd5so1768041wms.4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 24 Dec 2022 03:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQfHFluJStqMAVjm8YivW74tDU05oCwMWLpLFH2ZJDA=;
 b=iA7kqxV6VZcHnHDfXkVdTzg1+Uh6Vl/APaBI2BTRylg2PsXIcUlNwJziD5Eo33ma2F
 Y+VrzM+w2akeTctWwGfTO+Bpb+TzTAbGtQ6yFN5lpQtXFwfGxAaCG6eNa02X2DPOKO6K
 7VUx/DF9imcw7xBdS0h9CEsqWekI6e4X2OLWeKLyWfbsVzIyqUkHsMuurbMVJmGmkXsD
 dpLZeACVfcoUife5+n9bzmz313TvNv5YcI3Gx6aJUzhPNi9NXYDQiB8ziraFF3gDXbVL
 AN9YRaHrf/d2q5gpQb7jH43mShtbXqmSfEOnMdYkBGNkEqdo9XOzcscnM9HdGwthkibt
 mRIQ==
X-Gm-Message-State: AFqh2kqDfOB0c8FfCeQDZ+2KjIvoOTgJBKS5/28ci5NVRCY7xeVePoXp
 Cv5h4L4i8YiN32wF3c38NdFWSE/jSjY55WSyEmxFgqlM3Vx/pXd7JQymXKd3yE4hRcnoOgcAUgX
 JPW6lCQZnE2MrhJ8U/uDg8twXDEhi5ssHEfRIS7LspA==
X-Received: by 2002:a5d:49c3:0:b0:232:be5c:ec4a with SMTP id
 t3-20020a5d49c3000000b00232be5cec4amr11351837wrs.6.1671881304017; 
 Sat, 24 Dec 2022 03:28:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuzqzQuZiVw3dHitCdMvuaTddTiExV1+yb8w1dPWupnmnSH1RzpFeJq4F8DeQJZG9fQQBe56g==
X-Received: by 2002:a5d:49c3:0:b0:232:be5c:ec4a with SMTP id
 t3-20020a5d49c3000000b00232be5cec4amr11351824wrs.6.1671881303791; 
 Sat, 24 Dec 2022 03:28:23 -0800 (PST)
Received: from redhat.com ([2.52.27.62]) by smtp.gmail.com with ESMTPSA id
 h6-20020a056000000600b002423dc3b1a9sm5127678wrx.52.2022.12.24.03.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Dec 2022 03:28:22 -0800 (PST)
Date: Sat, 24 Dec 2022 06:28:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio,vhost,vdpa: features, fixes, cleanups
Message-ID: <20221224061932-mutt-send-email-mst@kernel.org>
References: <20221222144343-mutt-send-email-mst@kernel.org>
 <CAHk-=wi6Gkr7hJz20+xD=pBuTrseccVgNR9ajU7=Bqbrdk1t4g@mail.gmail.com>
 <20221223172549-mutt-send-email-mst@kernel.org>
 <CAHk-=whpdP7X+L8RtGsonthr7Ffug=FhR+TrFe3JUyb5-zaYCA@mail.gmail.com>
 <20221224003445-mutt-send-email-mst@kernel.org>
 <CAHk-=wh_cyzZgYp1pL8MDA6sioB1RndQ_fref=9V+vm9faE7fg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh_cyzZgYp1pL8MDA6sioB1RndQ_fref=9V+vm9faE7fg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Fri, Dec 23, 2022 at 10:10:30PM -0800, Linus Torvalds wrote:
> On Fri, Dec 23, 2022 at 9:35 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > They were in  next-20221220 though.
> 
> So, perfect for the *next* merge window.
> 
> Do you understand what the word "next" means? We don't call it
> "linux-this", do we?
> 
> This is not a new rule. Things are supposed to be ready *before* the
> merge window (that's what makes it "next", get it?).
> 
> I will also point you to to
> 
>   https://lore.kernel.org/lkml/CAHk-=wj_HcgFZNyZHTLJ7qC2613zphKDtLh6ndciwopZRfH0aQ@mail.gmail.com/
> 
> where I'm being pretty damn clear about things.
> 
> And before you start bleating about "I needed more heads up", never
> mind that this isn't even a new rule, and never mind what that "next"
> word means, let me just point to the 6.1-rc6 notice too:
> 
>   https://lore.kernel.org/lkml/CAHk-=wgUZwX8Sbb8Zvm7FxWVfX6CGuE7x+E16VKoqL7Ok9vv7g@mail.gmail.com/
> 
> and if the meaning of "next" has eluded you all these years, maybe it
> was high time you learnt. Hmm?
> 
>               Linus

Yea I really screwed up with this one. High time I learned that "no
fallout from testing" most likely does not mean "no bugs" but instead
"you forgot to push to next". Putting procedures in place now to
check automatically.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
