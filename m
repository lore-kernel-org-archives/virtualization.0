Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CB0C54EED
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 12:40:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2FE4819BE;
	Mon, 30 Jan 2023 12:40:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A2FE4819BE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=QkGJFOeW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8N78FTVLfFwe; Mon, 30 Jan 2023 12:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 61F19819ED;
	Mon, 30 Jan 2023 12:40:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61F19819ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3132BC0071;
	Mon, 30 Jan 2023 12:40:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF629C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 12:40:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD33D408EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 12:40:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AD33D408EC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=QkGJFOeW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P08w6B2AyFKT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 12:40:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF58A408D4
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF58A408D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=BFYWJkXqjJPJpFT0wydjtQXbF5F3b4P+HfuG4t2+TMg=; b=QkGJFOeWp2gXOe6u+zph8KHMLb
 rUEhBDEFyUZk4EcT9oGZLIdZxF7YjnkwkWHpvbnke74J8GVbpFHFJjoXO18NdGalTTBsN5MwjjPHG
 6pwDXBQRsqUEigvaGYU5Pc8I8ani9xlvbugcErUyu3yFyqEyHyl5dz9ncjiGtwbPXt0XBnENbIJcM
 xCRGDvY9VuB6p7D0/ba+Hpqmr3kuHr1mhDq2zGrleo7GL131HPSQKgb+XbBVz7ExZoiK4/jvtUNOU
 Df9wYUkjvVDPD9R2FvDO0TxmLUOeyUj/kE01k4wpD9KW7AKsJrLidNicO8w2NYvQaCQALeDwuuyN+
 JeYAGvpQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pMTRr-003wMy-2V; Mon, 30 Jan 2023 12:39:48 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39B2A3002BF;
 Mon, 30 Jan 2023 13:40:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 14FA920BD2C90; Mon, 30 Jan 2023 13:40:19 +0100 (CET)
Date: Mon, 30 Jan 2023 13:40:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 0/2] vhost: improve livepatch switching for heavily
 loaded vhost worker kthreads
Message-ID: <Y9e6ssSHUt+MUvum@hirez.programming.kicks-ass.net>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <Y9KyVKQk3eH+RRse@alley> <Y9LswwnPAf+nOVFG@do-x1extreme>
 <20230127044355.frggdswx424kd5dq@treble>
 <Y9OpTtqWjAkC2pal@hirez.programming.kicks-ass.net>
 <20230127165236.rjcp6jm6csdta6z3@treble>
 <20230127170946.zey6xbr4sm4kvh3x@treble>
 <20230127221131.sdneyrlxxhc4h3fa@treble>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230127221131.sdneyrlxxhc4h3fa@treble>
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "Seth Forshee \(DigitalOcean\)" <sforshee@digitalocean.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
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

On Fri, Jan 27, 2023 at 02:11:31PM -0800, Josh Poimboeuf wrote:


> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 4df2b3e76b30..fbcd3acca25c 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -36,6 +36,7 @@
>  #include <linux/seqlock.h>
>  #include <linux/kcsan.h>
>  #include <linux/rv.h>
> +#include <linux/livepatch_sched.h>
>  #include <asm/kmap_size.h>
>  
>  /* task_struct member predeclarations (sorted alphabetically): */
> @@ -2074,6 +2075,9 @@ DECLARE_STATIC_CALL(cond_resched, __cond_resched);
>  
>  static __always_inline int _cond_resched(void)
>  {
> +	//FIXME this is a bit redundant with preemption disabled
> +	klp_sched_try_switch();
> +
>  	return static_call_mod(cond_resched)();
>  }

Right, I was thinking you'd do something like:

	static_call_update(cond_resched, klp_cond_resched);

With:

static int klp_cond_resched(void)
{
	klp_try_switch_task(current);
	return __cond_resched();
}

That would force cond_resched() into doing the transition thing,
irrespective of the preemption mode at hand. And then, when KLP be done,
re-run sched_dynamic_update() to reset it to whatever it ought to be.

> @@ -401,8 +421,10 @@ void klp_try_complete_transition(void)
>  	 */
>  	read_lock(&tasklist_lock);
>  	for_each_process_thread(g, task)
> -		if (!klp_try_switch_task(task))
> +		if (!klp_try_switch_task(task)) {
> +			set_tsk_need_resched(task);
>  			complete = false;
> +		}

Yeah, no, that's broken -- preemption state live in more than just the
TIF bit.

>  	read_unlock(&tasklist_lock);
>  
>  	/*
> @@ -413,6 +435,7 @@ void klp_try_complete_transition(void)
>  		task = idle_task(cpu);
>  		if (cpu_online(cpu)) {
>  			if (!klp_try_switch_task(task)) {
> +				set_tsk_need_resched(task);
>  				complete = false;
>  				/* Make idle task go through the main loop. */
>  				wake_up_if_idle(cpu);

Idem.

Also, I don't see the point of this and the __schedule() hook here:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a0ef2fefbd5..01e32d242ef6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6506,6 +6506,8 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  	struct rq *rq;
>  	int cpu;
>  
> +	klp_sched_try_switch();
> +
>  	cpu = smp_processor_id();
>  	rq = cpu_rq(cpu);
>  	prev = rq->curr;

If it schedules, you'll get it with the normal switcheroo, because it'll
be inactive some of the time. If it doesn't schedule, it'll run into
cond_resched().

> @@ -8500,8 +8502,10 @@ EXPORT_STATIC_CALL_TRAMP(might_resched);
>  static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
>  int __sched dynamic_cond_resched(void)
>  {
> -	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
> +	if (!static_branch_unlikely(&sk_dynamic_cond_resched)) {
> +		klp_sched_try_switch();
>  		return 0;
> +	}
>  	return __cond_resched();
>  }
>  EXPORT_SYMBOL(dynamic_cond_resched);

I would make the klp_sched_try_switch() not depend on
sk_dynamic_cond_resched, because __cond_resched() is not a guaranteed
pass through __schedule().

But you'll probably want to check with Mark here, this all might
generate crap code on arm64.

Both ways this seems to make KLP 'depend' (or at least work lots better)
when PREEMPT_DYNAMIC=y. Do we want a PREEMPT_DYNAMIC=n fallback for
_cond_resched() too?


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
