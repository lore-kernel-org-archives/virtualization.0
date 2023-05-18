Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D59C77B7F
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 02:34:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B18C083D13;
	Thu, 18 May 2023 02:34:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B18C083D13
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1jQ4rmr21t5z; Thu, 18 May 2023 02:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D927F83B40;
	Thu, 18 May 2023 02:34:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D927F83B40
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE4C0C0037;
	Thu, 18 May 2023 02:34:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C041AC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 02:34:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93C8060F60
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 02:34:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93C8060F60
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 71J17kSbdgsw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 02:34:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDF3C60E9D
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDF3C60E9D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 02:34:36 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:48126)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pzTTO-00E22Y-OV; Wed, 17 May 2023 20:34:34 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:42960
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pzTTN-00BSST-AS; Wed, 17 May 2023 20:34:34 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mike Christie <michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
Date: Wed, 17 May 2023 21:34:01 -0500
In-Reply-To: <20230518000920.191583-2-michael.christie@oracle.com> (Mike
 Christie's message of "Wed, 17 May 2023 19:09:13 -0500")
Message-ID: <87mt22l65i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1pzTTN-00BSST-AS; ; ;
 mid=<87mt22l65i.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX18mx5PgcJMNNWl7RPzJ+HESs6gEuy+ye7o=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, stefanha@redhat.com,
 linux@leemhuis.info, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
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

Mike Christie <michael.christie@oracle.com> writes:

> This has us deqeue SIGKILL even if SIGNAL_GROUP_EXIT/group_exec_task is
> set when we are dealing with PF_USER_WORKER tasks.

> When a vhost_task gets a SIGKILL, we could have outstanding IO in flight.
> We can easily stop new work/IO from being queued to the vhost_task, but
> for IO that's already been sent to something like the block layer we
> need to wait for the response then process it. These type of IO
> completions use the vhost_task to process the completion so we can't
> exit immediately.


I understand the concern.

> We need to handle wait for then handle those completions from the
> vhost_task, but when we have a SIGKLL pending, functions like
> schedule() return immediately so we can't wait like normal. Functions
> like vhost_worker() degrade to just a while(1); loop.
>
> This patch has get_signal drop down to the normal code path when
> SIGNAL_GROUP_EXIT/group_exec_task is set so the caller can still detect
> there is a SIGKILL but still perform some blocking cleanup.
>
> Note that in that chunk I'm now bypassing that does:
>
> sigdelset(&current->pending.signal, SIGKILL);
>
> we look to be ok, because in the places we set SIGNAL_GROUP_EXIT/
> group_exec_task we are already doing that on the threads in the
> group.

What you are doing does not make any sense to me.

First there is the semantic non-sense, of queuing something that
is not a signal.   The per task SIGKILL bit is used as a flag with
essentially the same meaning as SIGNAL_GROUP_EXIT, reporting that
the task has been scheduled for exit.

More so is what happens afterwards.

As I read your patch it is roughly equivalent to doing:

	if ((current->flags & PF_USER_WORKER) &&
       	    fatal_signal_pending(current)) {
		sigdelset(&current->pending.signal, SIGKILL);
	        clear_siginfo(&ksig->info);
                ksig->info.si_signo = SIGKILL;
                ksig->info.si_code = SI_USER;
                recalc_sigpending();
		trace_signal_deliver(SIGKILL, &ksig->info,
			&sighand->action[SIGKILL - 1]);
                goto fatal;
	}

Before the "(SIGNAL_GROUP_EXIT || signal->group_exec_task)" test.

To get that code I stripped the active statements out of the
dequeue_signal path the code executes after your change below.

I don't get why you are making it though because the code you
are opting out of does:

		/* Has this task already been marked for death? */
		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
		     signal->group_exec_task) {
			clear_siginfo(&ksig->info);
			ksig->info.si_signo = signr = SIGKILL;
			sigdelset(&current->pending.signal, SIGKILL);
			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
				&sighand->action[SIGKILL - 1]);
			recalc_sigpending();
			goto fatal;
		}

I don't see what in practice changes, other than the fact that by going
through the ordinary dequeue_signal path that other signals can be
processed after a SIGKILL has arrived.  Of course those signal all
should be blocked.




The trailing bit that expands the PF_IO_WORKER test to be PF_USER_WORKER
appears reasonable, and possibly needed.

Eric


> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  kernel/signal.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..ae4972eea5db 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2705,9 +2705,18 @@ bool get_signal(struct ksignal *ksig)
>  		struct k_sigaction *ka;
>  		enum pid_type type;
>  
> -		/* Has this task already been marked for death? */
> -		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
> -		     signal->group_exec_task) {
> +		/*
> +		 * Has this task already been marked for death?
> +		 *
> +		 * If this is a PF_USER_WORKER then the task may need to do
> +		 * extra work that requires waiting on running work, so we want
> +		 * to dequeue the signal below and tell the caller its time to
> +		 * start its exit procedure. When the work has completed then
> +		 * the task will exit.
> +		 */
> +		if (!(current->flags & PF_USER_WORKER) &&
> +		    ((signal->flags & SIGNAL_GROUP_EXIT) ||
> +		     signal->group_exec_task)) {
>  			clear_siginfo(&ksig->info);
>  			ksig->info.si_signo = signr = SIGKILL;
>  			sigdelset(&current->pending.signal, SIGKILL);
> @@ -2861,11 +2870,11 @@ bool get_signal(struct ksignal *ksig)
>  		}
>  
>  		/*
> -		 * PF_IO_WORKER threads will catch and exit on fatal signals
> +		 * PF_USER_WORKER threads will catch and exit on fatal signals
>  		 * themselves. They have cleanup that must be performed, so
>  		 * we cannot call do_exit() on their behalf.
>  		 */
> -		if (current->flags & PF_IO_WORKER)
> +		if (current->flags & PF_USER_WORKER)
>  			goto out;
>  
>  		/*
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
