Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712B9C433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 13:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 040BD40B7F;
	Wed, 11 May 2022 13:41:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n7QOxvBKhQiu; Wed, 11 May 2022 13:41:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7508740B7A;
	Wed, 11 May 2022 13:41:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44C3DC0032;
	Wed, 11 May 2022 13:41:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FCB5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 13:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21354610E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 13:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ellerman.id.au
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uIJTMLuMVeF4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 13:41:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06E29610D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 13:41:19 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KywzV4X1vz4xVP;
 Wed, 11 May 2022 23:41:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1652276471;
 bh=vEOI3XTsaBJEwMmKwOJuGXvPCXkgzyvATD8nzGoiPwk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RQdbtKH40fvudPGia+31Rz17OTRZJVD0hi6NxK819HG/TDwUTeLFxOiHPPArIIQTu
 7PAxhZhTSa3L5c55LdD9mXQyOYdnRROB2tlAymjEDPrnwVpzeIdvUNY1sqcrD1a0BF
 RyZCt321zJTGqAI3b+qWLFBv/gB8roPW72j+MJf3Z+TmMQPPYrAp/pI1+XmN9heYFq
 fvrnyB99ikQEClAW9Ued7zthbWJgvCRsuX3xp93fh5La9LdDZTylJIeUkad7VYrowN
 y6SGgNbbxOf7xvjJmmHlcJoNOmcoTCbi57fpscMYTx+TEAjNGJ1plcAMrd8fzy00SQ
 7pofjvVnsyVtw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] virtio: last minute fixup
In-Reply-To: <20220511125140.ormw47yluv4btiey@meerkat.local>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <YnrxTMVRtDnGA/EK@dev-arch.thelio-3990X>
 <CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com>
 <20220511125140.ormw47yluv4btiey@meerkat.local>
Date: Wed, 11 May 2022 23:40:59 +1000
Message-ID: <87a6bo89w4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Netdev <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, mie@igel.co.jp
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

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:
...
>
> I think we should simply disambiguate the trailer added by tooling like b4.
> Instead of using Link:, it can go back to using Message-Id, which is already
> standard with git -- it's trivial for git.kernel.org to link them to
> lore.kernel.org.

But my mailer, editor and terminal don't know what to do with a Message-Id.

Whereas they can all open an https link.

Making people paste message ids into lore to see the original submission
is not a win. People make enough fun of us already for still using email
to submit patches, let's not make their job any easier :)

> Before:
>
>     Signed-off-by: Main Tainer <main.tainer@linux.dev>
>     Link: https://lore.kernel.org/r/CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com
>
> After:
>
>     Signed-off-by: Main Tainer <main.tainer@linux.dev>
>     Message-Id: <CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com>
>
> This would allow people to still use Link: for things like linking to actual
> ML discussions. I know this pollutes commits a bit, but I would argue that
> this is a worthwhile trade-off that allows us to improve our automation and
> better scale maintainers.

I went back through the history and I'm pretty sure that the original use
for "Link:" was to link to the original submission, done by tip-bot
starting back in 2011:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f994d99cf140dbb637e49882891c89b3fd84becd

Prior to that there were no "Link:" tags, only "BugLink:".

But if people want to reclaim "Link:" for generic links then fine, but
let's still use a https link, just give it a different name.
eg. "PatchLink:", or "Submitted:" etc.

cheers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
