Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F095DC433F5
	for <virtualization@archiver.kernel.org>; Fri, 17 Dec 2021 18:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78CFC41F33;
	Fri, 17 Dec 2021 18:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cJUK2Hzc-YBc; Fri, 17 Dec 2021 18:53:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 110F241F19;
	Fri, 17 Dec 2021 18:53:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C93D9C001E;
	Fri, 17 Dec 2021 18:53:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F301C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 18:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D3D660EA2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 18:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xPHGsQ7Aszb4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 18:53:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A97F60DC6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 18:53:17 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:54374)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1myILy-00FFX2-LY; Fri, 17 Dec 2021 11:53:14 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:42610
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1myILx-004GJ6-BM; Fri, 17 Dec 2021 11:53:14 -0700
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mike Christie <michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <20211129194707.5863-7-michael.christie@oracle.com>
Date: Fri, 17 Dec 2021 12:53:06 -0600
In-Reply-To: <20211129194707.5863-7-michael.christie@oracle.com> (Mike
 Christie's message of "Mon, 29 Nov 2021 13:47:03 -0600")
Message-ID: <87o85fcbcd.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1myILx-004GJ6-BM; ; ;
 mid=<87o85fcbcd.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.227.161.49; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX19BlR/EKpIwNLot1f+kMdDPwzfG2roNixE=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH V6 06/10] fork: add helpers to clone a process for kernel
 use
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Cc: axboe@kernel.dk, hdanton@sina.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, vverma@digitalocean.com, geert@linux-m68k.org,
 stefanha@redhat.com, christian.brauner@ubuntu.com,
 Christoph Hellwig <hch@lst.de>
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

> The vhost layer is creating kthreads to execute IO and management
> operations. These threads need to share a mm with a userspace thread,
> inherit cgroups, and we would like to have the thread accounted for
> under the userspace thread's rlimit nproc value so a user can't overwhelm
> the system with threads when creating VMs.
>
> We have helpers for cgroups and mm but not for the rlimit nproc and in
> the future we will probably want helpers for things like namespaces. For
> those two items and to allow future sharing/inheritance, this patch adds
> two helpers, user_worker_create and user_worker_start that allow callers
> to create threads that copy or inherit the caller's attributes like mm,
> cgroups, namespaces, etc, and are accounted for under the callers rlimits
> nproc value similar to if the caller did a clone() in userspace. However,
> instead of returning to userspace the thread is usable in the kernel for
> modules like vhost or layers like io_uring.

If you are making this a general API it would be good to wrap the called
function the way kthread_create does so that the code in the function
can just return and let the wrapper call do_exit for it, especially if
you are going to have modular users.

There is a lot of deep magic in what happens if a thread created with
kernel_thread returns.  It makes sense to expose that magic to the 1 or
2 callers that use kernel_thread directly.  It does not make sense to
expose to anything higher up and in creating a nice API you are doing
that.

Currently I have just removed all of the modular users of do_exit
and in the process of removing do_exit itself so I am a little more
sensitive to this than I would ordinarily be.  But I think my comment
stands even without my changes you conflict with.

Eric


> [added flag validation code from Christian Brauner's SIG_IGN patch]
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/sched/task.h |  5 +++
>  kernel/fork.c              | 72 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index f8a658700075..ecb21c0d95ce 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -95,6 +95,11 @@ struct mm_struct *copy_init_mm(void);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
>  extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
>  int kernel_wait(pid_t pid, int *stat);
> +struct task_struct *user_worker_create(int (*fn)(void *), void *arg, int node,
> +				       unsigned long clone_flags,
> +				       u32 worker_flags);
> +__printf(2, 3)
> +void user_worker_start(struct task_struct *tsk, const char namefmt[], ...);
>  
>  extern void free_task(struct task_struct *tsk);
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c9152596a285..e72239ae1e08 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2543,6 +2543,78 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  	return copy_process(NULL, 0, node, &args);
>  }
>  
> +static bool user_worker_flags_valid(struct kernel_clone_args *kargs)
> +{
> +	/* Verify that no unknown flags are passed along. */
> +	if (kargs->worker_flags & ~(USER_WORKER_IO | USER_WORKER |
> +				    USER_WORKER_NO_FILES | USER_WORKER_SIG_IGN))
> +		return false;
> +
> +	/*
> +	 * If we're ignoring all signals don't allow sharing struct sighand and
> +	 * don't bother clearing signal handlers.
> +	 */
> +	if ((kargs->flags & (CLONE_SIGHAND | CLONE_CLEAR_SIGHAND)) &&
> +	    (kargs->worker_flags & USER_WORKER_SIG_IGN))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * user_worker_create - create a copy of a process to be used by the kernel
> + * @fn: thread stack
> + * @arg: data to be passed to fn
> + * @node: numa node to allocate task from
> + * @clone_flags: CLONE flags
> + * @worker_flags: USER_WORKER flags
> + *
> + * This returns a created task, or an error pointer. The returned task is
> + * inactive, and the caller must fire it up through user_worker_start(). If
> + * this is an PF_IO_WORKER all singals but KILL and STOP are blocked.
> + */
> +struct task_struct *user_worker_create(int (*fn)(void *), void *arg, int node,
> +				       unsigned long clone_flags,
> +				       u32 worker_flags)
> +{
> +	struct kernel_clone_args args = {
> +		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
> +				   CLONE_UNTRACED) & ~CSIGNAL),
> +		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
> +		.stack		= (unsigned long)fn,
> +		.stack_size	= (unsigned long)arg,
> +		.worker_flags	= USER_WORKER | worker_flags,
> +	};
> +
> +	if (!user_worker_flags_valid(&args))
> +		return ERR_PTR(-EINVAL);
> +
> +	return copy_process(NULL, 0, node, &args);
> +}
> +EXPORT_SYMBOL_GPL(user_worker_create);
> +
> +/**
> + * user_worker_start - Start a task created with user_worker_create
> + * @tsk: task to wake up
> + * @namefmt: printf-style format string for the thread name
> + * @arg: arguments for @namefmt
> + */
> +void user_worker_start(struct task_struct *tsk, const char namefmt[], ...)
> +{
> +	char name[TASK_COMM_LEN];
> +	va_list args;
> +
> +	WARN_ON(!(tsk->flags & PF_USER_WORKER));
> +
> +	va_start(args, namefmt);
> +	vsnprintf(name, sizeof(name), namefmt, args);
> +	set_task_comm(tsk, name);
> +	va_end(args);
> +
> +	wake_up_new_task(tsk);
> +}
> +EXPORT_SYMBOL_GPL(user_worker_start);
> +
>  /*
>   *  Ok, this is the main fork-routine.
>   *
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
