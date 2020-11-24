Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D26C56201
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 23:46:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB3720BED
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 23:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGjC6KnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB3720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1187D232FA;
	Tue, 24 Nov 2020 23:46:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n6qz5nNjbnDE; Tue, 24 Nov 2020 23:46:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F3FBE22844;
	Tue, 24 Nov 2020 23:46:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE246C1833;
	Tue, 24 Nov 2020 23:46:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56D98C0052;
 Tue, 24 Nov 2020 23:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 434A3872EC;
 Tue, 24 Nov 2020 23:46:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VNHhlEV8wVD7; Tue, 24 Nov 2020 23:46:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 590F486F7C;
 Tue, 24 Nov 2020 23:46:35 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id d9so1167106qke.8;
 Tue, 24 Nov 2020 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H+rGPaoJ9R3rr7zK4cuxMwlBlLpdlGUAwlQnvIZjZd8=;
 b=rGjC6KnGzC9NIfLo6IfoTM7C5TiZmv4q08vYNRt8cewMWpFhbX886WW47/gIiopas/
 e2jKhT73QJs/dRAIbILcJdQSFnVW9dal1rOBoIKd0ECBe+nqcukIgJrBRfX2wbZlPbrR
 27L+0GE9CXpbAta7TZEIdoDweQHp+sEvmypYMH9hyutdrnRkkklGbspFfFiZY+HYfDHj
 jsH/8tjPy+0JiTdJWitSDoQxXZntWXoEWL0cWLR+fmdpM332GBoSCjfuWUHY88IWDiPh
 04ztpEPYlCjpB7IXy1yQhW/otwe7DgKcwtOpyIrk5XdAw3ZKiOAkll08YWpT8S+NhzMx
 e/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H+rGPaoJ9R3rr7zK4cuxMwlBlLpdlGUAwlQnvIZjZd8=;
 b=oH+LmnHGsJhXPuCVyy+Ctxx9OF8FoMlJ9IdOM/NK2fU8eSHrXBF/q62xfrZ+W9c3DR
 Gb6qg20YPDnvSo9b59Q3zDlsy+J2+Lm31i4LptzngTQjrM9rlFrbrUPAzv1UQELm+I7+
 sQQ3oFmj1n8QrAoP4YAMfDVJWFac5IjaH0e9aWfd1zAMiDst3lYRB5B0yJqcKU1124VE
 WHK3c8taXVoSc4OQgZ+B+FxsWP30ozpHUtYIXQgja2c9rq+BDUEWpSxRqP0XelhUCA93
 9LRL4z784b8viJCD04kLX6tYnVSvwRDPJauHGLcuBGF2ZeRqFCNGW7cytKsiDvYrkt/S
 97BA==
X-Gm-Message-State: AOAM5316Ib6tLe6c5E0WLZeEK82kjvIhN6EGxSVT0opxpGAgE+jFTJu0
 9fj52fisY3DxOrc94TGJQzPivBZn6vPsust0Tzw=
X-Google-Smtp-Source: ABdhPJzOwu2wFsHHn8A1YNPfZeoFLdmnMgNDFogUYxSXdSyfkKR4RJ+IXZpEdbdh4p7RHhstmUROclNZOq0Hltp8jFg=
X-Received: by 2002:a5b:40e:: with SMTP id m14mr627984ybp.33.1606261594309;
 Tue, 24 Nov 2020 15:46:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
 <alpine.LNX.2.23.453.2011230938390.7@nippy.intranet>
 <CANiq72=z+tmuey9wj3Kk7wX5s0hTHpsQdLhAqcOVNrHon6xn5Q@mail.gmail.com>
 <alpine.LNX.2.23.453.2011241036520.7@nippy.intranet>
In-Reply-To: <alpine.LNX.2.23.453.2011241036520.7@nippy.intranet>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Nov 2020 00:46:23 +0100
Message-ID: <CANiq72=Ybm2MHmOizo1xQ_QYGuvbthtnLbwCkr8AFb8PcfmuQw@mail.gmail.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
To: Finn Thain <fthain@telegraphics.com.au>
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net,
 reiserfs-devel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless <linux-wireless@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org,
 linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com,
 wcn36xx@lists.infradead.org, samba-technical@lists.samba.org,
 linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net,
 linux-afs@lists.infradead.org, usb-storage@lists.one-eyed-alien.net,
 drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 Nick Desaulniers <ndesaulniers@google.com>, linux-scsi@vger.kernel.org,
 Nathan Chancellor <natechancellor@gmail.com>, linux-rdma@vger.kernel.org,
 oss-drivers@netronome.com, bridge@lists.linux-foundation.org,
 linux-security-module@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com,
 linux-acpi@vger.kernel.org, coreteam@netfilter.org,
 intel-wired-lan@lists.osuosl.org, linux-input <linux-input@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-geode@lists.infradead.org, linux-can@vger.kernel.org,
 linux-block@vger.kernel.org, linux-gpio@vger.kernel.org,
 op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org,
 xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org,
 linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-nfs@vger.kernel.org,
 GR-Linux-NIC-Dev@marvell.com, tipc-discussion@lists.sourceforge.net,
 Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>,
 linux-decnet-user@lists.sourceforge.net, linux-mmc@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 linux-renesas-soc@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-usb@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 patches@opensource.cirrus.com, Joe Perches <joe@perches.com>,
 linux-integrity@vger.kernel.org, target-devel@vger.kernel.org,
 linux-hardening@vger.kernel.org
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

On Tue, Nov 24, 2020 at 1:58 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> What I meant was that you've used pessimism as if it was fact.

"future mistakes that it might prevent" is neither pessimism nor states a fact.

> For example, "There is no way to guess what the effect would be if the
> compiler trained programmers to add a knee-jerk 'break' statement to avoid
> a warning".

It is only knee-jerk if you think you are infallible.

> Moreover, what I meant was that preventing programmer mistakes is a
> problem to be solved by development tools

This warning comes from a development tool -- the compiler.

> The idea that retro-fitting new
> language constructs onto mature code is somehow necessary to "prevent
> future mistakes" is entirely questionable.

The kernel is not a frozen codebase.

Further, "mature code vs. risk of change" arguments don't apply here
because the semantics of the program and binary output isn't changing.

> Sure. And if you put -Wimplicit-fallthrough into the Makefile and if that
> leads to well-intentioned patches that cause regressions, it is partly on
> you.

Again: adding a `fallthrough` does not change the program semantics.
If you are a maintainer and want to cross-check, compare the codegen.

> Have you ever considered the overall cost of the countless
> -Wpresume-incompetence flags?

Yeah: negative. On the other hand, the overall cost of the countless
-fI-am-infallible flags is very noticeable.

> Perhaps you pay the power bill for a build farm that produces logs that
> no-one reads? Perhaps you've run git bisect, knowing that the compiler
> messages are not interesting? Or compiled software in using a language
> that generates impenetrable messages? If so, here's a tip:
>
> # grep CFLAGS /etc/portage/make.conf
> CFLAGS="... -Wno-all -Wno-extra ..."
> CXXFLAGS="${CFLAGS}"
>
> Now allow me some pessimism: the hardware upgrades, gigawatt hours and
> wait time attributable to obligatory static analyses are a net loss.

If you really believe compiler warnings and static analysis are
useless and costly, I think there is not much point in continuing the
discussion.

> No, it's not for me to prove that such patches don't affect code
> generation. That's for the patch author and (unfortunately) for reviewers.

I was not asking you to prove it. I am stating that proving it is very easy.

Cheers,
Miguel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
