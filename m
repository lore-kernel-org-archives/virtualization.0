Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73611C433F5
	for <virtualization@archiver.kernel.org>; Thu, 14 Apr 2022 15:48:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 075B160BCC;
	Thu, 14 Apr 2022 15:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emxpfGGQxC6J; Thu, 14 Apr 2022 15:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 900D060AAB;
	Thu, 14 Apr 2022 15:48:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53D80C002F;
	Thu, 14 Apr 2022 15:48:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79195C002C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 15:48:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6669B403A5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 15:48:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 458k5OVMHTsn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 15:48:45 +0000 (UTC)
X-Greylist: delayed 00:27:05 by SQLgrey-1.8.0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2156D400A8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+iRSXHQlt9lmhOSBYrvMuVQHw2ElrWncN2mrge5/yQ4=; b=D4UH8lPRYK29ybcCYqOCJLNd3u
 Q4+bXU/1kTRxIE7w0/mHcMkrSCPJLapr2iCBsE80oGx3aeLmDbXhfKP6Fkzs31vlY0FP+8YSnLnGA
 psKONhCK8ST+iduJ2Cti5dc3/6xuzu4tUyrIHXDJUf3AQJwRNtqCqg/sZFQdBxJcqgIJGbD60Bxdi
 oaS0jyseexJ2bmKgeTcR1u426IWL9UnLdxAAKWVNxQBpyvSlDMHvhbL3rxBlCURpBfsccZHjsU40U
 p/tYya+kBtsh2ywbDnxGs9FU+WwVs7jWaPh4lOoJ1W1BUap47SGA8TWNcD30kSVuVAPp+UnWSnl0A
 I59pSpRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nf1HL-0052yG-BV; Thu, 14 Apr 2022 15:21:03 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 578083002DE;
 Thu, 14 Apr 2022 17:21:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 3B94F2057AAE7; Thu, 14 Apr 2022 17:21:01 +0200 (CEST)
Date: Thu, 14 Apr 2022 17:21:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 1/3] sched/headers: Fix compilation error with GCC 12
Message-ID: <Ylg73c83AJGwz9UN@hirez.programming.kicks-ass.net>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-2-dinechin@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220414150855.2407137-2-dinechin@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, trivial@kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
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

On Thu, Apr 14, 2022 at 05:08:53PM +0200, Christophe de Dinechin wrote:
> With gcc version 12.0.1 20220401 (Red Hat 12.0.1-0) (GCC), the following
> errors are reported in sched.h when building after `make defconfig`:

<snip tons of noise>

> Rewrite the definitions of sched_class_highest and for_class_range to
> avoid this error as follows:
> 
> 1/ The sched_class_highest is rewritten to be relative to
>   __begin_sched_classes, so that GCC sees it as being part of the
>   __begin_sched_classes array and not a distinct __end_sched_classes
>   array.
> 
> 2/ The for_class_range macro is modified to replace the comparison with
>   an out-of-bound pointer __begin_sched_classes - 1 with an equivalent,
>   but in-bounds comparison.
> 
> In that specific case, I believe that the GCC analysis is correct and
> potentially valuable for other arrays, so it makes sense to keep it
> enabled.
> 
> Signed-off-by: Christophe de Dinechin <christophe@dinechin.org>
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  kernel/sched/sched.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8dccb34eb190..6350fbc7418d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2193,11 +2193,18 @@ const struct sched_class name##_sched_class \
>  extern struct sched_class __begin_sched_classes[];
>  extern struct sched_class __end_sched_classes[];
>  
> -#define sched_class_highest (__end_sched_classes - 1)
> +/*
> + * sched_class_highests is really __end_sched_classes - 1, but written in a way
> + * that makes it clear that it is within __begin_sched_classes[] and not outside
> + * of __end_sched_classes[].
> + */
> +#define sched_class_highest (__begin_sched_classes + \
> +			     (__end_sched_classes - __begin_sched_classes - 1))
>  #define sched_class_lowest  (__begin_sched_classes - 1)
>  
> +/* The + 1 below places the pointers within the range of their array */
>  #define for_class_range(class, _from, _to) \
> -	for (class = (_from); class != (_to); class--)
> +	for (class = (_from); class + 1 != (_to) + 1; class--)

Urgh, so now we get less readable code, just because GCC is being
stupid?

What's wrong with negative array indexes? memory is memory, stuff works.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
