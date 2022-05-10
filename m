Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5063C433F5
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 18:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 623754177D;
	Tue, 10 May 2022 18:23:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-XHeSNoA_lS; Tue, 10 May 2022 18:23:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 07298416C0;
	Tue, 10 May 2022 18:23:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC575C0032;
	Tue, 10 May 2022 18:23:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 484ACC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3585C401D8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JM3TwimFsyJ4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:23:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC210400A4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:23:30 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id p18so20987686edr.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I6+6daxf9DBR/wq5NboOShmKyA8J0iaTzHPVTMkgH10=;
 b=QHCsBsCmgpbSZbkfqS1Oo1MUQeuhlP1ZsLgzzMnXdAdig3V1zAvrj5IKC7nbum8dEY
 peXnK6zU/RodBxXQ4H3AQrDQdldz0aOJKB0erOEm9K95Tw69V2izzp5jd0jPewdxCHR+
 ZzsEDjnTue1e20m7A4AngmpfO54XUJd2CWRSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I6+6daxf9DBR/wq5NboOShmKyA8J0iaTzHPVTMkgH10=;
 b=dP5+sEd/DyrNmhIQfCWx7jITWrECQGAN++G8/ojp9ggmVlwQs4HtiPh+GampaszO6J
 ROK9x62N8Ic5NzTR2Wj2pkSc/6qm9xquQLOVYtX4/H5Op4uFw1/g8UyIAGm1nkzFuFfQ
 QyhVyVxTh4xt97oKEsANRgai5Z/3RKhJ4HM61UY8J5YrslHjN8vZTcjjXSQtpgMa862t
 ybKf8NLcqlvd3x9K3geexgqXRgd3d+sRkgHk6PzCy5RVlTUCZk1q6SPIerTKkzSVR7/k
 OfqtOuX4MZmcVT4P/iM4mpgS02ghSlUvDKGAAC/+aZ43bddf/GpESN7uhIaVfg/Yw+JS
 ppbQ==
X-Gm-Message-State: AOAM531MONOeSTqeEKn3SpB7boIHr6QM3TEwgoabCEQ7FiKnIJzT6UqJ
 JXMM0C5SBYba83DCCdYYycGVU1MR4QsUqe17A/yl9g==
X-Google-Smtp-Source: ABdhPJxnkEJAqQFVRhADYfynnSUZw5ek0q6H4AEMdtIQFqx6NoFGkSttC9/EzqxHWv9l3arQ9XTPlg==
X-Received: by 2002:a05:6402:1d4c:b0:427:d1f5:3a41 with SMTP id
 dz12-20020a0564021d4c00b00427d1f53a41mr24210146edb.218.1652207008512; 
 Tue, 10 May 2022 11:23:28 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 w3-20020a170906d20300b006f3ef214e2asm16114ejz.144.2022.05.10.11.23.27
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 11:23:27 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id j15so25000546wrb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 11:23:27 -0700 (PDT)
X-Received: by 2002:adf:dfc8:0:b0:20a:d256:5b5c with SMTP id
 q8-20020adfdfc8000000b0020ad2565b5cmr19494972wrn.97.1652207007228; Tue, 10
 May 2022 11:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220510082351-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220510082351-mutt-send-email-mst@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 May 2022 11:23:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
Message-ID: <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: last minute fixup
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Netdev <netdev@vger.kernel.org>, mie@igel.co.jp,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>, virtualization@lists.linux-foundation.org
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

On Tue, May 10, 2022 at 5:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A last minute fixup of the transitional ID numbers.
> Important to get these right - if users start to depend on the
> wrong ones they are very hard to fix.

Hmm. I've pulled this, but those numbers aren't exactly "new".

They've been that way since 5.14, so what makes you think people
haven't already started depending on them?

And - once again - I want to complain about the "Link:" in that commit.

It points to a completely useless patch submission. It doesn't point
to anything useful at all.

I think it's a disease that likely comes from "b4", and people decided
that "hey, I can use the -l parameter to add that Link: field", and it
looks better that way.

And then they add it all the time, whether it makes any sense or not.

I've mainly noticed it with the -tip tree, but maybe that's just
because I've happened to look at it.

I really hate those worthless links that basically add zero actual
information to the commit.

The "Link" field is for _useful_ links. Not "let's add a link just
because we can".

                           Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
