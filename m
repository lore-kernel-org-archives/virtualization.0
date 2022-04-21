Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCABC433F5
	for <virtualization@archiver.kernel.org>; Thu, 21 Apr 2022 07:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E43C7400E5;
	Thu, 21 Apr 2022 07:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nvi2Yyoj3jW5; Thu, 21 Apr 2022 07:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8C8CF402B1;
	Thu, 21 Apr 2022 07:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42181C0033;
	Thu, 21 Apr 2022 07:32:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07D37C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2063416C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GttFwwlJmel6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:32:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 868D6416C7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nWKrOVONxRO0WSObJee+zFs6W4ugiC3GFnYlyVVnV4Y=; b=IMvNMRuK6bK24C75DGnVR8yDTe
 L1C3xGGpNCkk7cE9PZWy0E9MJ468LszeOST4RZIzmVQiRG3vb5N08oD1KLttCoXCIXiJmZfPd6RK0
 4eFy8+l5CZCx+LWEbzPX6IYMnVvdi7GEh49y9u+gONsNulmf+DX4g4HRo6i7edF0DgyTcYt8bssNM
 nt85+OS3Z897K8z7ZreZpPMldBppnlxsauvrSUzlrVMv6/d1xDVaoc3iFMGmOxprkPxCbRb7nOnJa
 kjZYOdLFIb2OgHx/DrNIakRIYy6je3kWwb2+nNu+WLbbr/s5r7F576CBFgh9pT4qaygybEW3yWFdv
 84UU8Jzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhRIS-004rlh-2H; Thu, 21 Apr 2022 07:32:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id 98EC59861A4; Thu, 21 Apr 2022 09:32:11 +0200 (CEST)
Date: Thu, 21 Apr 2022 09:32:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Message-ID: <20220421073211.GJ2731@worktop.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
 <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
 <20220414133050.b820fa45d42de4cfc24db82b@linux-foundation.org>
 <20220417155205.GI2731@worktop.programming.kicks-ass.net>
 <202204201117.F44DCF9@keescook>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202204201117.F44DCF9@keescook>
Cc: Juri Lelli <juri.lelli@redhat.com>, trivial@kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Apr 20, 2022 at 11:45:05AM -0700, Kees Cook wrote:

> > -Wno-array-bounds
> 
> Please no; we just spent two years fixing all the old non-flexible array
> definitions and so many other things fixed for this to be enable because
> it finds actual flaws (but we turned it off when it was introduced
> because of how much sloppy old code we had).
> 
> > Is the obvious fix-all cure. The thing is, I want to hear if this new
> > warning has any actual use or is just crack induced madness like many of
> > the warnings we turn off.
> 
> Yes, it finds real flaws. And also yes, it is rather opinionated about
> some "tricks" that have worked in C, but frankly, most of those tricks
> end up being weird/accidentally-correct and aren't great for long-term
> readability or robustness. Though I'm not speaking specifically to this
> proposed patch; I haven't looked closely at it yet.

So the whole access outside object is UB thing in C is complete rubbish
from an OS perspective. The memory is there and there are geniune uses
for it.

And so far, the patches I've seen for it make the code actively worse.
So we need a sane annotation to tell the compiler to shut up already
without making the code an unreadable mess.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
