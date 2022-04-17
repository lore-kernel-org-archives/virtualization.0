Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61182C433EF
	for <virtualization@archiver.kernel.org>; Sun, 17 Apr 2022 15:52:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D833B415FD;
	Sun, 17 Apr 2022 15:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TUBc6Rxs5q4E; Sun, 17 Apr 2022 15:52:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0046C415F5;
	Sun, 17 Apr 2022 15:52:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3DC0C0033;
	Sun, 17 Apr 2022 15:52:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C3E2C002C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 15:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 165ED83E2C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 15:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zo48a97d-v5A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 15:52:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CC6E83E21
 for <virtualization@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=R2Xc6IsXJOaCLPhfJTDhaB1kmhsuBGq5W8QH4gGbQhQ=; b=OXRIEoC7ocBq6Cjdn/TbQPxDcf
 KcXOZy3URWB6FLiCrSAyVbbjJq8K4m52yp8qWBdZYMK9LKjhnMmRcC4DpkFJT5jSmPIxSAuo1eAN6
 tL9Nd6ch5N7bLOYcEX4vKnKA34g4gfCZwoFID9nEuoQNM6pDoR4nmrepVAd+RD+CrvzkBRnZK0vhV
 B0o6Amp5RNoftyko0KZ6lRj4ljNlUNB0qG15DdIHNZEIue3WT+oJHCbBE+p7Wzz6ELiFeNMN2Oydt
 zKAWR194H6pzIsMrSz7b3Hfw2PhEpE18gEtwFLLAODZVcgZehKYKzUVvrr/25/86OdX5x+lkHluEr
 cxTEKvKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ng7C4-006C0j-Ow; Sun, 17 Apr 2022 15:52:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 070B09861C1; Sun, 17 Apr 2022 17:52:06 +0200 (CEST)
Date: Sun, 17 Apr 2022 17:52:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Message-ID: <20220417155205.GI2731@worktop.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
 <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, trivial@kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
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

On Thu, Apr 14, 2022 at 01:30:50PM -0700, Andrew Morton wrote:
> On Thu, 14 Apr 2022 17:21:01 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > +/* The + 1 below places the pointers within the range of their array */
> > >  #define for_class_range(class, _from, _to) \
> > > -	for (class = (_from); class != (_to); class--)
> > > +	for (class = (_from); class + 1 != (_to) + 1; class--)
> > 
> > Urgh, so now we get less readable code, just because GCC is being
> > stupid?
> > 
> > What's wrong with negative array indexes? memory is memory, stuff works.
> 
> What's more, C is C.  Glorified assembly language in which people do odd
> stuff.
> 
> But this is presumably a released gcc version and we need to do
> something.  And presumably, we need to do a backportable something, so
> people can compile older kernels with gcc-12.
> 
> Is it possible to suppress just this warning with a gcc option?  And if
> so, are we confident that this warning will never be useful in other
> places in the kernel?
> 
> If no||no then we'll need to add workarounds such as these?

-Wno-array-bounds

Is the obvious fix-all cure. The thing is, I want to hear if this new
warning has any actual use or is just crack induced madness like many of
the warnings we turn off.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
