Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BB4C7EE23
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 00:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0750400EF;
	Fri,  2 Jun 2023 00:43:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0750400EF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MOcLyQgI6fHT; Fri,  2 Jun 2023 00:43:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4F65C40280;
	Fri,  2 Jun 2023 00:43:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F65C40280
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F478C0037;
	Fri,  2 Jun 2023 00:43:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68029C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 00:43:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 46259409B4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 00:43:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46259409B4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G9XCbgDU38MJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 00:43:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3ECA1409A5
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3ECA1409A5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 00:43:30 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:46364)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q4st6-005nTy-E7; Thu, 01 Jun 2023 18:43:28 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:42496
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q4st5-002xjg-0I; Thu, 01 Jun 2023 18:43:28 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mike Christie <michael.christie@oracle.com>
References: <20230601183232.8384-1-michael.christie@oracle.com>
Date: Thu, 01 Jun 2023 19:43:20 -0500
In-Reply-To: <20230601183232.8384-1-michael.christie@oracle.com> (Mike
 Christie's message of "Thu, 1 Jun 2023 13:32:32 -0500")
Message-ID: <87fs7a8ziv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1q4st5-002xjg-0I; ; ;
 mid=<87fs7a8ziv.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX19gjFlb69o32ctZ8A+BQrp1h5U1revTqvs=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
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

> When switching from kthreads to vhost_tasks two bugs were added:
> 1. The vhost worker tasks's now show up as processes so scripts doing
> ps or ps a would not incorrectly detect the vhost task as another
> process.  2. kthreads disabled freeze by setting PF_NOFREEZE, but
> vhost tasks's didn't disable or add support for them.
>
> To fix both bugs, this switches the vhost task to be thread in the
> process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
> get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
> SIGKILL/STOP support is required because CLONE_THREAD requires
> CLONE_SIGHAND which requires those 2 signals to be supported.
>
> This is a modified version of the patch written by Mike Christie
> <michael.christie@oracle.com> which was a modified version of patch
> originally written by Linus.
>
> Much of what depended upon PF_IO_WORKER now depends on PF_USER_WORKER.
> Including ignoring signals, setting up the register state, and having
> get_signal return instead of calling do_group_exit.
>
> Tidied up the vhost_task abstraction so that the definition of
> vhost_task only needs to be visible inside of vhost_task.c.  Making
> it easier to review the code and tell what needs to be done where.
> As part of this the main loop has been moved from vhost_worker into
> vhost_task_fn.  vhost_worker now returns true if work was done.

Please see below for a race in that tidying up.

> The main loop has been updated to call get_signal which handles
> SIGSTOP, freezing, and collects the message that tells the thread to
> exit as part of process exit.  This collection clears
> __fatal_signal_pending.  This collection is not guaranteed to
> clear signal_pending() so clear that explicitly so the schedule()
> sleeps.
>
> For now the vhost thread continues to exist and run work until the
> last file descriptor is closed and the release function is called as
> part of freeing struct file.  To avoid hangs in the coredump
> rendezvous and when killing threads in a multi-threaded exec.  The
> coredump code and de_thread have been modified to ignore vhost threads.
>
> Remvoing the special case for exec appears to require teaching
> vhost_dev_flush how to directly complete transactions in case
> the vhost thread is no longer running.
>
> Removing the special case for coredump rendezvous requires either the
> above fix needed for exec or moving the coredump rendezvous into
> get_signal.



In just fixing the hang after exec I am afraid I may have introduced
something worse.

Two different sighand_struct's (and their associated locks) pointing
at the same signal_struct.  (Should be fixable?)

I am worried about what happens with that vhost task after an exec.
It retains it's existing cred (and technically the old mm) but shares
signal_struct so it might be possible to use permission checks against
the old vhost task cred to bypass permission checks on the new tasks
cred.  In particular for exec's that gain privilege.

It doesn't look like that is an issue for signals and suid exec as
kill_ok_by_cred seems to deliberately allow the same thing.


We may be ok but the way that vhost task remains after exec it smells
like the setup for a local privilege escalation.


Oleg do you have any insights?

Does anyone see why using the vhost task to modify the process should
not result in privilege escalation?


> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a92af08e7864..074273020849 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -256,7 +256,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
>  		llist_add(&work->node, &dev->worker->work_list);
> -		wake_up_process(dev->worker->vtsk->task);
> +		vhost_task_wake(dev->worker->vtsk);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vhost_work_queue);
> @@ -333,31 +333,19 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  	__vhost_vq_meta_reset(vq);
>  }
>  
> -static int vhost_worker(void *data)
> +static bool vhost_worker(void *data)
>  {
>  	struct vhost_worker *worker = data;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
>  
> -	for (;;) {
> -		/* mb paired w/ kthread_stop */
> -		set_current_state(TASK_INTERRUPTIBLE);
> -
> -		if (vhost_task_should_stop(worker->vtsk)) {
> -			__set_current_state(TASK_RUNNING);
> -			break;
> -		}
> -
> -		node = llist_del_all(&worker->work_list);
> -		if (!node)
> -			schedule();
> -
> +	node = llist_del_all(&worker->work_list);
> +	if (node) {
>  		node = llist_reverse_order(node);
>  		/* make sure flag is seen after deletion */
>  		smp_wmb();
>  		llist_for_each_entry_safe(work, work_next, node, node) {
>  			clear_bit(VHOST_WORK_QUEUED, &work->flags);
> -			__set_current_state(TASK_RUNNING);
>  			kcov_remote_start_common(worker->kcov_handle);
>  			work->fn(work);
>  			kcov_remote_stop();
> @@ -365,7 +353,7 @@ static int vhost_worker(void *data)
>  		}
>  	}
>  
> -	return 0;
> +	return !!node;
>  }
>  
>  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index b7cbd66f889e..f80d5c51ae67 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -12,58 +12,88 @@ enum vhost_task_flags {
>  	VHOST_TASK_FLAGS_STOP,
>  };
>  
> +struct vhost_task {
> +	bool (*fn)(void *data);
> +	void *data;
> +	struct completion exited;
> +	unsigned long flags;
> +	struct task_struct *task;
> +};
> +
>  static int vhost_task_fn(void *data)
>  {
>  	struct vhost_task *vtsk = data;
> -	int ret;
> +	bool dead = false;
> +
> +	for (;;) {
> +		bool did_work;
> +
> +		/* mb paired w/ vhost_task_stop */
> +		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
> +			break;
> +
> +		if (!dead && signal_pending(current)) {
> +			struct ksignal ksig;
> +			/*
> +			 * Calling get_signal will block in SIGSTOP,
> +			 * or clear fatal_signal_pending, but remember
> +			 * what was set.
> +			 *
> +			 * This thread won't actually exit until all
> +			 * of the file descriptors are closed, and
> +			 * the release function is called.
> +			 */
> +			dead = get_signal(&ksig);
> +			if (dead)
> +				clear_thread_flag(TIF_SIGPENDING);
> +		}
> +
> +		did_work = vtsk->fn(vtsk->data);
> +		if (!did_work) {
> +			set_current_state(TASK_INTERRUPTIBLE);

I am about to head off on vacation for a week or so, but I want to
add some comments before I go.


First moving set_current_state(TASK_INTERRUPTIBLE) here in the loop
won't work.  It introduces a race between vhost_work_queue and this wake
up.

Better would be to move the "if (!dead && signal_pending(current)) ..."
check up above "test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)"

Eric
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
