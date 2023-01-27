Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABD5C38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 12:09:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E03382B3E;
	Fri, 27 Jan 2023 12:09:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E03382B3E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=sMvrKAeF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aNWXj_wS-1cT; Fri, 27 Jan 2023 12:09:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E27482AC8;
	Fri, 27 Jan 2023 12:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E27482AC8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C462C0033;
	Fri, 27 Jan 2023 12:09:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CA48C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E886160EB8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:09:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E886160EB8
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=sMvrKAeF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEL6gEc4dFWW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:09:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3E5060B36
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3E5060B36
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 12:09:05 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 621CF218BB;
 Fri, 27 Jan 2023 12:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674821343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a9faRZ/SxtgILFonZsHOQNT86YKAAhJwA/HSfiWSP6Y=;
 b=sMvrKAeF1FXre3nEN+/+ZQQUn2ojiJ+7aDv42b1jHg+dbyaQVeZI/KWwHjy4mn/l0JBxj1
 TWkdJ4D44Wv8rj+4VbfdLqDSTf/FSTUUZo0J01gqgOs5vQM+tfDOOpi5dgSjp/SsqZc754
 mjK6oH+DAvMdmUOUe3KdLkt0Rzik/wc=
Received: from suse.cz (unknown [10.100.201.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3C7932C141;
 Fri, 27 Jan 2023 12:09:03 +0000 (UTC)
Date: Fri, 27 Jan 2023 13:09:02 +0100
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] vhost: improve livepatch switching for heavily
 loaded vhost worker kthreads
Message-ID: <Y9O+3jzH0PiG1qlJ@alley>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <Y9KyVKQk3eH+RRse@alley> <Y9LswwnPAf+nOVFG@do-x1extreme>
 <20230127044355.frggdswx424kd5dq@treble>
 <Y9OpTtqWjAkC2pal@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9OpTtqWjAkC2pal@hirez.programming.kicks-ass.net>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "Seth Forshee \(DigitalOcean\)" <sforshee@digitalocean.com>,
 live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
 Josh Poimboeuf <jpoimboe@kernel.org>
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
From: Petr Mladek via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri 2023-01-27 11:37:02, Peter Zijlstra wrote:
> On Thu, Jan 26, 2023 at 08:43:55PM -0800, Josh Poimboeuf wrote:
> > On Thu, Jan 26, 2023 at 03:12:35PM -0600, Seth Forshee (DigitalOcean) wrote:
> > > On Thu, Jan 26, 2023 at 06:03:16PM +0100, Petr Mladek wrote:
> > > > On Fri 2023-01-20 16:12:20, Seth Forshee (DigitalOcean) wrote:
> > > > > We've fairly regularaly seen liveptches which cannot transition within kpatch's
> > > > > timeout period due to busy vhost worker kthreads.
> > > > 
> > > > I have missed this detail. Miroslav told me that we have solved
> > > > something similar some time ago, see
> > > > https://lore.kernel.org/all/20220507174628.2086373-1-song@kernel.org/
> > > 
> > > Interesting thread. I had thought about something along the lines of the
> > > original patch, but there are some ideas in there that I hadn't
> > > considered.
> > 
> > Here's another idea, have we considered this?  Have livepatch set
> > TIF_NEED_RESCHED on all kthreads to force them into schedule(), and then
> > have the scheduler call klp_try_switch_task() if TIF_PATCH_PENDING is
> > set.
> > 
> > Not sure how scheduler folks would feel about that ;-)
> 
> So, let me try and page all that back in.... :-)
> 
> KLP needs to unwind the stack to see if any of the patched functions are
> active, if not, flip task to new set.
> 
> Unwinding the stack of a task can be done when:
> 
>  - task is inactive (stable reg and stack) -- provided it stays inactive
>    while unwinding etc..
> 
>  - task is current (guarantees stack doesn't dip below where we started
>    due to being busy on top etc..)
> 
> Can NOT be done from interrupt context, because can hit in the middle of
> setting up stack frames etc..

All the above seems correct.

> The issue at hand is that some tasks run for a long time without passing
> through an explicit check.

There might actually be two possibilities why the transition fails
too often:

1. The task might be in the running state most of the time. Therefore
   the backtrace is not reliable most of the time.

   In this case, some cooperation with the scheduler would really
   help. We would need to stop the task and check the stack
   when it is stopped. Something like the patch you proposed.


2. The task might be sleeping but almost always in a livepatched
   function. Therefore it could not be transitioned.

   It might be the case with vhost_worker(). The main loop is "tiny".
   The kthread probaly spends most of the time with processing
   a vhost_work. And if the "works" are livepatched...

   In this case, it would help to call klp_try_switch_task(current)
   in the main loop in vhost_worker(). It would always succeed
   when vhost_worker() is not livepatched on its own.

   Note that even this would not help with kPatch when a single
   vhost_work might need more than the 1 minute timout to get proceed.

> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> index f1b25ec581e0..06746095a724 100644
> --- a/kernel/livepatch/transition.c
> +++ b/kernel/livepatch/transition.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/stacktrace.h>
> +#include <linux/stop_machine.h>
>  #include "core.h"
>  #include "patch.h"
>  #include "transition.h"
> @@ -334,6 +335,16 @@ static bool klp_try_switch_task(struct task_struct *task)
>  	return !ret;
>  }
>  
> +static int __stop_try_switch(void *arg)
> +{
> +	return klp_try_switch_task(arg) ? 0 : -EBUSY;
> +}
> +
> +static bool klp_try_switch_task_harder(struct task_struct *task)
> +{
> +	return !stop_one_cpu(task_cpu(task), __stop_try_switch, task);
> +}
> +
>  /*
>   * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
>   * Kthreads with TIF_PATCH_PENDING set are woken up.

Nice. I am surprised that it can be implemented so easily.

Best Regards,
Petr
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
