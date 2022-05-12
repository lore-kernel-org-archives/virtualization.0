Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE5ABC433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 02:07:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A5E582FF9;
	Thu, 12 May 2022 02:07:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gINZ5egtdOax; Thu, 12 May 2022 02:07:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC4438301F;
	Thu, 12 May 2022 02:07:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE74EC0039;
	Thu, 12 May 2022 02:07:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CC40C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 02:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74D2B402EF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 02:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=fail (2048-bit key) reason="fail (message has been altered)"
 header.d=mit.edu
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3QwF3Ik2Wwrm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 02:07:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 54EF6402BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 02:07:54 +0000 (UTC)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net
 [108.7.220.252]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24C27abX015835
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 May 2022 22:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1652321259; bh=N0RrHZICQeD+jMKffmiVOPCX1VOHVXkmF2unBxL2MJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ICSnAYgUceKKXsBKoRVPVEIQKsCW0KTrDhONUN31qeHKplZYIzPxqs8r+P+6YnX6x
 abGDraN6I6t1+6cpTxV+pX/G3fEwMzr4yTmbUKBr0T0taRo1DJimXKf5Gg79Ohpl3X
 JpMubQ0WlA6eF0LKDzQNgnOqe3puzHfHVqCXvtBW3+YG7uyHfHolbIovUtrn+rdOwy
 JRr9Qa2HfVEUQ+aQ+EAp9AyaK7SPZhtHVsCbScLn15PNFhEYvE1xXltNl0sfjvJCFF
 uoPI6+2MP/NnYrl1D9pLkyRIkK7Nn5W9/l5pldeyIP7y4GsgumtbbEERrnA1b/cRhh
 9OGVUNr2s3ldg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id 0BBB915C3F2A; Wed, 11 May 2022 22:07:36 -0400 (EDT)
Date: Wed, 11 May 2022 22:07:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] virtio: last minute fixup
Message-ID: <Ynxr6JNczWFTwxVw@mit.edu>
References: <20220510082351-mutt-send-email-mst@kernel.org>
 <CAHk-=wjPR+bj7P1O=MAQWXp0Mx2hHuNQ1acn6gS+mRo_kbo5Lg@mail.gmail.com>
 <YnrxTMVRtDnGA/EK@dev-arch.thelio-3990X>
 <CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com>
 <20220511125140.ormw47yluv4btiey@meerkat.local>
 <87a6bo89w4.fsf@mpe.ellerman.id.au>
 <20220511163116.fpw2lvrkjbxmiesz@meerkat.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220511163116.fpw2lvrkjbxmiesz@meerkat.local>
Cc: KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, mie@igel.co.jp,
 Netdev <netdev@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
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

On Wed, May 11, 2022 at 12:31:16PM -0400, Konstantin Ryabitsev wrote:
> > But my mailer, editor and terminal don't know what to do with a Message-Id.
> > 
> > Whereas they can all open an https link.
> > 
> > Making people paste message ids into lore to see the original submission
> > is not a win. People make enough fun of us already for still using email
> > to submit patches, let's not make their job any easier :)
> 
> Okay, I'm fine with using a dedicated trailer for this purpose, perhaps an
> "Archived-At"? That's a real header that was proposed by IETF for similar
> purposes. E.g.:
> 
>     Archived-at: https://lore.kernel.org/r/CAHk-=wgAk3NEJ2PHtb0jXzCUOGytiHLq=rzjkFKfpiuH-SROgA@mail.gmail.com
>

I'd suggest is "Patch-Link".  Then we can also have "Bug-Link:",
"Test-Link:", etc.

"Patch-Link" is a tad bit shorter "Archived-at", and ultimately, it's
not actually not the patch which is being archived.  It's the fact
that it's a pointer to the patch review which is of most interest.

					- Ted
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
