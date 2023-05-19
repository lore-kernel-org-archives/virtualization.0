Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B2FC77B7F
	for <virtualization@archiver.kernel.org>; Fri, 19 May 2023 04:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DDA9E42BF1;
	Fri, 19 May 2023 04:16:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDA9E42BF1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IfwpvpXH50KS; Fri, 19 May 2023 04:16:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEEF34031E;
	Fri, 19 May 2023 04:16:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEEF34031E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A61C5C0036;
	Fri, 19 May 2023 04:16:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B78F7C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 04:16:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7E3464032C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 04:16:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7E3464032C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xs6GJ1Cwah9n
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 04:16:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C8584031E
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C8584031E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 04:16:41 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:59472)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pzrXj-00FxBE-N6; Thu, 18 May 2023 22:16:39 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:37718
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pzrXi-00EQER-3G; Thu, 18 May 2023 22:16:39 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mike Christie <michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
 <20230518000920.191583-2-michael.christie@oracle.com>
 <87ednei9is.fsf@email.froward.int.ebiederm.org>
 <ab7d07ba-5dc3-95c0-aa7c-c2575d03f429@oracle.com>
 <20230518162508.GB20779@redhat.com>
 <05236dee-59b7-f394-db3d-cbb4d4163ce8@oracle.com>
 <20230518170359.GC20779@redhat.com>
 <875y8ph4tj.fsf@email.froward.int.ebiederm.org>
 <677200bd-4cd7-e0a5-eab0-46ee29128281@oracle.com>
Date: Thu, 18 May 2023 23:16:08 -0500
In-Reply-To: <677200bd-4cd7-e0a5-eab0-46ee29128281@oracle.com> (Mike
 Christie's message of "Thu, 18 May 2023 17:57:55 -0500")
Message-ID: <874jo9c5x3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1pzrXi-00EQER-3G; ; ;
 mid=<874jo9c5x3.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX1/x0CI0UrqN2n4txao5LhERKR6d4vbOTlQ=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH 1/8] signal: Dequeue SIGKILL even if
 SIGNAL_GROUP_EXIT/group_exec_task is set
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 stefanha@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
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

> On 5/18/23 1:28 PM, Eric W. Biederman wrote:
>> Still the big issue seems to be the way get_signal is connected into
>> these threads so that it keeps getting called.  Calling get_signal after
>> a fatal signal has been returned happens nowhere else and even if we fix
>> it today it is likely to lead to bugs in the future because whoever is
>> testing and updating the code is unlikely they have a vhost test case
>> the care about.
>> 
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 8f6330f0e9ca..4d54718cad36 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -181,7 +181,9 @@ void recalc_sigpending_and_wake(struct task_struct *t)
>>  
>>  void recalc_sigpending(void)
>>  {
>> -       if (!recalc_sigpending_tsk(current) && !freezing(current))
>> +       if ((!recalc_sigpending_tsk(current) && !freezing(current)) ||
>> +           ((current->signal->flags & SIGNAL_GROUP_EXIT) &&
>> +                   !__fatal_signal_pending(current)))
>>                 clear_thread_flag(TIF_SIGPENDING);
>>  
>>  }
>> @@ -1043,6 +1045,13 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>>                  * This signal will be fatal to the whole group.
>>                  */
>>                 if (!sig_kernel_coredump(sig)) {
>> +                       /*
>> +                        * The signal is being short circuit delivered
>> +                        * don't it pending.
>> +                        */
>> +                       if (type != PIDTYPE_PID) {
>> +                               sigdelset(&t->signal->shared_pending,  sig);
>> +
>>                         /*
>>                          * Start a group exit and wake everybody up.
>>                          * This way we don't have other threads
>> 
>
> If I change up your patch so the last part is moved down a bit to when we set t
> like this:
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 0ac48c96ab04..c976a80650db 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -181,9 +181,10 @@ void recalc_sigpending_and_wake(struct task_struct *t)
>  
>  void recalc_sigpending(void)
>  {
> -	if (!recalc_sigpending_tsk(current) && !freezing(current))
> +	if ((!recalc_sigpending_tsk(current) && !freezing(current)) ||
> +	    ((current->signal->flags & SIGNAL_GROUP_EXIT) &&
> +	     !__fatal_signal_pending(current)))
>  		clear_thread_flag(TIF_SIGPENDING);
> -
Can we get rid of this suggestion to recalc_sigpending.  The more I look
at it the more I am convinced it is not safe.  In particular I believe
it is incompatible with dump_interrupted() in fs/coredump.c

The code in fs/coredump.c is the closest code we have to what you are
trying to do with vhost_worker after the session is killed.  It also
struggles with TIF_SIGPENDING getting set. 
>  }
>  EXPORT_SYMBOL(recalc_sigpending);
>  
> @@ -1053,6 +1054,17 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>  			signal->group_exit_code = sig;
>  			signal->group_stop_count = 0;
>  			t = p;
> +			/*
> +			 * The signal is being short circuit delivered
> +			 * don't it pending.
> +			 */
> +			if (type != PIDTYPE_PID) {
> +				struct sigpending *pending;
> +
> +				pending = &t->signal->shared_pending;
> +				sigdelset(&pending->signal, sig);
> +			}
> +
>  			do {
>  				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
>  				sigaddset(&t->pending.signal, SIGKILL);
>
>
> Then get_signal() works like how Oleg mentioned it should earlier.

I am puzzled it makes a difference as t->signal and p->signal should
point to the same thing, and in fact the code would more clearly read
sigdelset(&signal->shared_pending, sig);

But all of that seems minor.

> For vhost I just need the code below which is just Linus's patch plus a call
> to get_signal() in vhost_worker() and the PF_IO_WORKER->PF_USER_WORKER change.
>
> Note that when we get SIGKILL, the vhost file_operations->release function is called via
>
>             do_exit -> exit_files -> put_files_struct -> close_files
>
> and so the vhost release function starts to flush IO and stop the worker/vhost
> task. In vhost_worker() then we just handle those last completions for already
> running IO. When  the vhost release function detects they are done it does
> vhost_task_stop() and vhost_worker() returns and then vhost_task_fn() does do_exit().
> So we don't return immediately when get_signal() returns non-zero.
>
> So it works, but it sounds like you don't like vhost relying on the behavior,
> and it's non standard to use get_signal() like we are. So I'm not sure how we
> want to proceed.

Let me clarify my concern.

Your code modifies get_signal as:
 		/*
-		 * PF_IO_WORKER threads will catch and exit on fatal signals
+		 * PF_USER_WORKER threads will catch and exit on fatal signals
 		 * themselves. They have cleanup that must be performed, so
 		 * we cannot call do_exit() on their behalf.
 		 */
-		if (current->flags & PF_IO_WORKER)
+		if (current->flags & PF_USER_WORKER)
 			goto out;
 		/*
 		 * Death signals, no core dump.
 		 */
 		do_group_exit(ksig->info.si_signo);
 		/* NOTREACHED */

Which means by modifying get_signal you are logically deleting the
do_group_exit from get_signal.  As far as that goes that is a perfectly
reasonable change.  The problem is you wind up calling get_signal again
after that.  That does not make sense.

I would suggest doing something like:

 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
        bool dead = false;
 
 	for (;;) {
 		/* mb paired w/ kthread_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
 
 		if (vhost_task_should_stop(worker->vtsk)) {
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
 
+		if (!dead && signal_pending()) {
+			dead = get_signal();
+                       if (dead) {
+				/*
+			 	* When the process exits we kick off a work to
+			 	* run the driver's helper to stop new work and
+			 	* handle completions. When they are done they will
+			 	* call vhost_task_stop to tell us to exit.
+			 	*/
+				schedule_work(&dev->destroy_worker);
+				clear_thread_flag(TIF_SIGPENDING);
+			}
+		}
+
 		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();

 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
 		smp_wmb();
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
 			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			cond_resched();
 		}
 	}
 
 	return 0;
 }


The idea is two fold.
1) Call get_signal every time through the loop to handle SIGSTOP (to the
   process).
2) Don't call get_signal after you know the process is exiting.

With a single call to get_signal (once the process is dead) I don't
see any fundamental problems with your approach.  It is doing pretty
much what fs/coredump.c is trying to do.

*Grumble*  fs/coredump.c also struggles with TIF_SIGPENDING.  But at
least you won't be alone.


> Maybe the safest is to revert:
>
> commit 6e890c5d5021ca7e69bbe203fde42447874d9a82
> Author: Mike Christie <michael.christie@oracle.com>
> Date:   Fri Mar 10 16:03:32 2023 -0600
>
>     vhost: use vhost_tasks for worker threads
>
> and retry this for the next kernel when we can do proper testing and more
> code review?

I can see wisdom in that.  It is always nice when you don't have
to scramble to get the code to do what you want.


What is the diff below?  It does not appear to a revert diff.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a92af08e7864..1ba9e068b2ab 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -349,8 +349,16 @@ static int vhost_worker(void *data)
>  		}
>  
>  		node = llist_del_all(&worker->work_list);
> -		if (!node)
> +		if (!node) {
>  			schedule();
> +			/*
> +			 * When we get a SIGKILL our release function will
> +			 * be called. That will stop new IOs from being queued
> +			 * and check for outstanding cmd responses. It will then
> +			 * call vhost_task_stop to exit us.
> +			 */
> +			vhost_task_get_signal();
> +		}
>  
>  		node = llist_reverse_order(node);
>  		/* make sure flag is seen after deletion */
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 537cbf9a2ade..249a5ece9def 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -29,7 +29,7 @@ struct kernel_clone_args {
>  	u32 io_thread:1;
>  	u32 user_worker:1;
>  	u32 no_files:1;
> -	u32 ignore_signals:1;
> +	u32 block_signals:1;
>  	unsigned long stack;
>  	unsigned long stack_size;
>  	unsigned long tls;
> diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
> index 6123c10b99cf..79bf0ed4ded0 100644
> --- a/include/linux/sched/vhost_task.h
> +++ b/include/linux/sched/vhost_task.h
> @@ -19,5 +19,6 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
>  void vhost_task_start(struct vhost_task *vtsk);
>  void vhost_task_stop(struct vhost_task *vtsk);
>  bool vhost_task_should_stop(struct vhost_task *vtsk);
> +void vhost_task_get_signal(void);
>  
>  #endif
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ed4e01daccaa..9e04ab5c3946 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2338,14 +2338,10 @@ __latent_entropy struct task_struct *copy_process(
>  		p->flags |= PF_KTHREAD;
>  	if (args->user_worker)
>  		p->flags |= PF_USER_WORKER;
> -	if (args->io_thread) {
> -		/*
> -		 * Mark us an IO worker, and block any signal that isn't
> -		 * fatal or STOP
> -		 */
> +	if (args->io_thread)
>  		p->flags |= PF_IO_WORKER;
> +	if (args->block_signals)
>  		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
> -	}
>  
>  	if (args->name)
>  		strscpy_pad(p->comm, args->name, sizeof(p->comm));
> @@ -2517,9 +2513,6 @@ __latent_entropy struct task_struct *copy_process(
>  	if (retval)
>  		goto bad_fork_cleanup_io;
>  
> -	if (args->ignore_signals)
> -		ignore_signals(p);
> -
>  	stackleak_task_init(p);
>  
>  	if (pid != &init_struct_pid) {
> @@ -2861,6 +2854,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  		.fn_arg		= arg,
>  		.io_thread	= 1,
>  		.user_worker	= 1,
> +		.block_signals	= 1,
>  	};
>  
>  	return copy_process(NULL, 0, node, &args);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..0ac48c96ab04 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2861,11 +2861,11 @@ bool get_signal(struct ksignal *ksig)
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
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index b7cbd66f889e..82467f450f0d 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -31,22 +31,13 @@ static int vhost_task_fn(void *data)
>   */
>  void vhost_task_stop(struct vhost_task *vtsk)
>  {
> -	pid_t pid = vtsk->task->pid;
> -
>  	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
>  	wake_up_process(vtsk->task);
>  	/*
>  	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
> -	 * freeing it below. If userspace crashed or exited without closing,
> -	 * then the vhost_task->task could already be marked dead so
> -	 * kernel_wait will return early.
> +	 * freeing it below.
>  	 */
>  	wait_for_completion(&vtsk->exited);
> -	/*
> -	 * If we are just closing/removing a device and the parent process is
> -	 * not exiting then reap the task.
> -	 */
> -	kernel_wait4(pid, NULL, __WCLONE, NULL);
>  	kfree(vtsk);
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_stop);
> @@ -61,6 +52,25 @@ bool vhost_task_should_stop(struct vhost_task *vtsk)
>  }
>  EXPORT_SYMBOL_GPL(vhost_task_should_stop);
>  
> +/**
> + * vhost_task_get_signal - Check if there are pending signals
> + *
> + * This checks if there are signals and will handle freezes requests. For
> + * SIGKILL, out file_operations->release is already being called when we
> + * see the signal, so we let release call vhost_task_stop to tell the
> + * vhost_task to exit when it's done using the task.
> + */
> +void vhost_task_get_signal(void)
> +{
> +	struct ksignal ksig;
> +
> +	if (!signal_pending(current))
> +		return;
> +
> +	get_signal(&ksig);
> +}
> +EXPORT_SYMBOL_GPL(vhost_task_get_signal);
> +
>  /**
>   * vhost_task_create - create a copy of a process to be used by the kernel
>   * @fn: thread stack
> @@ -75,13 +85,14 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
>  				     const char *name)
>  {
>  	struct kernel_clone_args args = {
> -		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
> +		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM |
> +				  CLONE_THREAD | CLONE_SIGHAND,
>  		.exit_signal	= 0,
>  		.fn		= vhost_task_fn,
>  		.name		= name,
>  		.user_worker	= 1,
>  		.no_files	= 1,
> -		.ignore_signals	= 1,
> +		.block_signals	= 1,
>  	};
>  	struct vhost_task *vtsk;
>  	struct task_struct *tsk;

Eric
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
