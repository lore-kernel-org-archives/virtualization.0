Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F3FC433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 17:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C487683227;
	Thu, 12 May 2022 17:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rSQruq6h9mxV; Thu, 12 May 2022 17:19:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6529E83224;
	Thu, 12 May 2022 17:19:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43EE0C0039;
	Thu, 12 May 2022 17:19:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41DE8C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D73E4174F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hqQ094cQl2xG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:19:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E59894174C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 17:19:44 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id j6so11518160ejc.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jDHOqKOOly/u6UGesDlSvrOYIRtvk+Gi75eJQoAcvU8=;
 b=ajie93GkyM3bMzgPSyr9+zDuLO8qmNsBGOmDLDAYe2chL7Y1Dex40FgP7wpA+YsFVS
 PbCwBPFRrhD1wKMyrktSA2hu4sY+A8Snezdkh2Pl31GtbbWKUVs17izWFz1kX+D2q2GT
 3Kh1nj3RjFExJpH9SEac2MgWbeFHQCaqrxqgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jDHOqKOOly/u6UGesDlSvrOYIRtvk+Gi75eJQoAcvU8=;
 b=g1VsCMQJvKGzFMjDh3ls4E0WVAbmGSvjxbE8Pb83k+uDmnwPFLNUxuZh/Ep/3UjP0R
 1+5YyAPGvRejq8ZuPvU0cKISZWY7CdpKDSxqV7lWeUhXvvIk3WvOXff9sxSaiu01Yyy5
 XQ5HTkO2/8VyUD0U4/U+JJ86HxA5l40RN3bZgmHBVuO8BzVfjS5+2CGs5UyhnR3RB5gI
 hBtLO0Ww8q3mU9/y0dUErE8vs7B+CfuZ9vqgvKu8PHqqzRkjnI6wwJmCmcl+KMDr/zOZ
 tdMQC1lwIzIt1wP3x1J78zUuTO/kOcLwIVFhPN6EFum00y+DqBWMZk45XNB5nZQ8XxE+
 ZRQQ==
X-Gm-Message-State: AOAM530dZKueDnBlJ2X3LPhqnILp2UA3myAm19nV+glbO4cJzbkERzaP
 378MOj3Bz1xSubaL3LhrupCf0zEPvcoplqUKwPIQcg==
X-Google-Smtp-Source: ABdhPJxqzRKd51nJ+ah6CHVcGe8fMgSR6Otcs4diT9m6RYfOKYFWViCurze2/9Egry4Kg5V4aQ8AqQ==
X-Received: by 2002:a17:907:1c8f:b0:6e8:f898:63bb with SMTP id
 nb15-20020a1709071c8f00b006e8f89863bbmr810655ejc.721.1652375982609; 
 Thu, 12 May 2022 10:19:42 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com.
 [209.85.221.42]) by smtp.gmail.com with ESMTPSA id
 bg25-20020a170906a05900b006f3ef214e5asm2293831ejb.192.2022.05.12.10.19.41
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 May 2022 10:19:41 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id u3so8219411wrg.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 10:19:41 -0700 (PDT)
X-Received: by 2002:a5d:6dad:0:b0:20c:4dc1:e247 with SMTP id
 u13-20020a5d6dad000000b0020c4dc1e247mr629061wrs.274.1652375980629; Thu, 12
 May 2022 10:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <87czgk8jjo.fsf@mpe.ellerman.id.au>
 <CAHk-=wj9zKJGA_6SJOMPiQEoYke6cKX-FV3X_5zNXOcFJX1kOQ@mail.gmail.com>
 <87mtfm7uag.fsf@mpe.ellerman.id.au>
 <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
In-Reply-To: <CAHk-=wgnYGY=10sRDzXCC2bmappjBTRNNbr8owvGLEW-xuV7Vw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 May 2022 10:19:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=jfhgTkYBtY3LPPcUP=8A2bqH_iFezwOCDivuovE41w@mail.gmail.com>
Message-ID: <CAHk-=wg=jfhgTkYBtY3LPPcUP=8A2bqH_iFezwOCDivuovE41w@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: last minute fixup
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, mie@igel.co.jp,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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

On Thu, May 12, 2022 at 10:10 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And most definitely not just random data that can be trivially
> auto-generated after-the-fact.

Put another way: when people asked for change ID's and I said "we have
links", I by no means meant that "you can just add random worthless
links to commits".

For example, if you have a (public-facing) Gerrit system that tracks a
patch before it gets committed, BY ALL MEANS add a link to that as the
"change ID" that you tracked in Gerrit.

That's a Link: that actually adds *information*. It shows some real
history to the commit, and shows who approved it and when, and gives
you all the Gerrit background.

But a link to the email on lkml that just contains the patch and the
same commentary that was introduced into the commit? Useless garbage.
It adds no actual information.

THAT is my argument. Why do people think I'm arguing against the Link:
tag? No. I'm arguing against adding links with no relevant new
information behind them.

I don't argue against links to lore. Not at all. If those links are
about the background that caused the patch, they are great. Maybe they
are to a long thread about the original problem and how to solve it.
Thats WONDERFUL.

But here's the deal: when I look at a commit that I wonder "why is it
doing this, it seems wrong" (possibly after there's been a bug report
about it, but possibly just because I'm reviewing it as part of doing
the pull), and I see a "Link:" tag, and it just points back to the
SAME DAMN DATA that I already have in the commit, then that Link: tag
not only wasn't helpful, it was ACTIVELY DETRIMENTAL and made me waste
time and just get irritated.

And if you waste my time with useless links, why would you expect me
to be supportive of that behavior?

                      Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
