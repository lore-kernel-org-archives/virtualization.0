Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AACC433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Apr 2022 20:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49B35415F5;
	Thu, 14 Apr 2022 20:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AtLzNc0l1YNa; Thu, 14 Apr 2022 20:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9FA2F41545;
	Thu, 14 Apr 2022 20:30:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F1DFC0033;
	Thu, 14 Apr 2022 20:30:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0D35C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 20:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AEA5283EB6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 20:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wyChPVrM8yWl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 20:30:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F00A83EB5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 20:30:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B0F2661B98;
 Thu, 14 Apr 2022 20:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741C7C385A1;
 Thu, 14 Apr 2022 20:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1649968252;
 bh=F2sUCe9gi4kdAwiM+xd38Vkiw3sg5LfikwjEod6T5no=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=q5F4ba7EW90B8hMcPBLkQdGZLNF5JCeKwv0NHSuDHMXFMJEnW8CWNaqRStzcHyJUn
 3kpUYKCn7E/ZRHyMF675pgeheJvViUCQvqn6mGJ5CxSqXwAQKgK7rRXqVFkfIkzA/q
 6x3lGssjUCKjaeI0vsKoavc0sJLRCPyYhNZs+lHg=
Date: Thu, 14 Apr 2022 13:30:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Message-Id: <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
In-Reply-To: <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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

On Thu, 14 Apr 2022 17:21:01 +0200 Peter Zijlstra <peterz@infradead.org> wrote:

> > +/* The + 1 below places the pointers within the range of their array */
> >  #define for_class_range(class, _from, _to) \
> > -	for (class = (_from); class != (_to); class--)
> > +	for (class = (_from); class + 1 != (_to) + 1; class--)
> 
> Urgh, so now we get less readable code, just because GCC is being
> stupid?
> 
> What's wrong with negative array indexes? memory is memory, stuff works.

What's more, C is C.  Glorified assembly language in which people do odd
stuff.

But this is presumably a released gcc version and we need to do
something.  And presumably, we need to do a backportable something, so
people can compile older kernels with gcc-12.

Is it possible to suppress just this warning with a gcc option?  And if
so, are we confident that this warning will never be useful in other
places in the kernel?

If no||no then we'll need to add workarounds such as these?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
