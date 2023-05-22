Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B757DC77B75
	for <virtualization@archiver.kernel.org>; Mon, 22 May 2023 19:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1970A41E34;
	Mon, 22 May 2023 19:41:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1970A41E34
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JpxLUqor
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E847xk_D-01f; Mon, 22 May 2023 19:41:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0EC7D41E2D;
	Mon, 22 May 2023 19:40:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0EC7D41E2D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8B1EC0035;
	Mon, 22 May 2023 19:40:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A52BC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 19:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 008DA614B3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 19:40:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 008DA614B3
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JpxLUqor
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BsNlAu7Yw-i0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 19:40:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1228611A9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1228611A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 19:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684784456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQTcGQmcdt/GFHUE9ukH1FXd2F7vXJA1Gm3R6PDU1zM=;
 b=JpxLUqor4ASnkn/AeQ1kB4t95AXV+v7LntCd3KVIKZZYnQNNUHm1x1GmgaCcs5S3RJVua0
 bJCtr5beHmyCI6SZvnlTSEU6C4mH7Ky7nWBdOP5ZjgCyf2flX7gnUeX8wrRVD3MEhYHTEK
 pNbKs/fD6OPzy1mVDMFXFQl71Ml/DZc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-ANiPqWUpOtihXsnKzNbJFg-1; Mon, 22 May 2023 15:40:54 -0400
X-MC-Unique: ANiPqWUpOtihXsnKzNbJFg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso2741370f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 May 2023 12:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684784453; x=1687376453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQTcGQmcdt/GFHUE9ukH1FXd2F7vXJA1Gm3R6PDU1zM=;
 b=SgpLGrj7B83/IvtSBYQLKkHHzPiS/f2i4g8izUA4G3l223Nj8A7nVZK8aO0oZS4hA/
 ZeAKXdLUbQlnZvDOagZ9LqVuqxx9QJkXSxFkRf6qiyDzypt7DkF3b2qpWlT10pjMx/xO
 4tOwRb1NZ/isjgfhBE78v/ER4W2DGqF2zYn506UG1vXwwBTPRhJPugOo38Cdz/VKRVDb
 /CTZ122jX3WGrv6Ao+DS3cYt9N6Rxer5q7yv2BAYcb0enUCunOM71jUvCrWIFrc1zPGI
 Tc1rMDa/STzGDAs16CrgJnbDlNAhMw74+HazaAg6PNxjql6U1WDhQHastU3S68MhValc
 QqoQ==
X-Gm-Message-State: AC+VfDxDcoNX/YrAdG29cdLsNgRYNf3t/pJhNx/rSRpTJi5633DP2c6X
 V+KaKJHwnpFRxNVPR6tovrFz60mjyLE3c85NGlsUjIGA4EzfHVYZedBlNe4meYL4+dAnMdlK5uF
 Ch3E/wDLVxLLQVexs7oxJI7JYHrnHbvz5iYNOZoRkFA==
X-Received: by 2002:a05:6000:1361:b0:306:2d3d:a108 with SMTP id
 q1-20020a056000136100b003062d3da108mr7896630wrz.11.1684784453736; 
 Mon, 22 May 2023 12:40:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Pr3vUykeXOoCgclaXz/IjxyFh9K2bggfSTJrWm5vv7kVYJaiW0GjtEaVvW2d4GickX43xpg==
X-Received: by 2002:a05:6000:1361:b0:306:2d3d:a108 with SMTP id
 q1-20020a056000136100b003062d3da108mr7896615wrz.11.1684784453346; 
 Mon, 22 May 2023 12:40:53 -0700 (PDT)
Received: from redhat.com ([2.52.20.68]) by smtp.gmail.com with ESMTPSA id
 c13-20020a056000104d00b0030632833e74sm8697842wrx.11.2023.05.22.12.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 12:40:52 -0700 (PDT)
Date: Mon, 22 May 2023 15:40:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Message-ID: <20230522153852-mutt-send-email-mst@kernel.org>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230522025124.5863-4-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, brauner@kernel.org, linux-kernel@vger.kernel.org,
 oleg@redhat.com, linux@leemhuis.info, ebiederm@xmission.com,
 stefanha@redhat.com, nicolas.dichtel@6wind.com,
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

On Sun, May 21, 2023 at 09:51:24PM -0500, Mike Christie wrote:
> When switching from kthreads to vhost_tasks two bugs were added:
> 1. The vhost worker tasks's now show up as processes so scripts doing ps
> or ps a would not incorrectly detect the vhost task as another process.
> 2. kthreads disabled freeze by setting PF_NOFREEZE, but vhost tasks's
> didn't disable or add support for them.
> 
> To fix both bugs, this switches the vhost task to be thread in the
> process that does the VHOST_SET_OWNER ioctl, and has vhost_worker call
> get_signal to support SIGKILL/SIGSTOP and freeze signals. Note that
> SIGKILL/STOP support is required because CLONE_THREAD requires
> CLONE_SIGHAND which requires those 2 signals to be suppported.
> 
> This a modified version of patch originally written by Linus which
> handles his review comment to himself to rename ignore_signals to
> block_signals to better represent what it now does. And it includes a
> change to vhost_worker() to support SIGSTOP/KILL and freeze, and it
> drops the wait use per Oleg's review comment that it's no longer needed
> when using CLONE_THREAD.
> 
> Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c      | 17 ++++++++++++++++-
>  include/linux/sched/task.h |  2 +-
>  kernel/fork.c              | 12 +++---------
>  kernel/signal.c            |  1 +
>  kernel/vhost_task.c        | 16 ++++------------
>  5 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a92af08e7864..bf83e9340e40 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -338,6 +338,7 @@ static int vhost_worker(void *data)
>  	struct vhost_worker *worker = data;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
> +	bool dead = false;
>  
>  	for (;;) {
>  		/* mb paired w/ kthread_stop */
> @@ -349,8 +350,22 @@ static int vhost_worker(void *data)
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
> +			 * call vhost_task_stop to tell us to return and exit.
> +			 */
> +			if (!dead && signal_pending(current)) {
> +				struct ksignal ksig;
> +
> +				dead = get_signal(&ksig);
> +				if (dead)
> +					clear_thread_flag(TIF_SIGPENDING);


Does get_signal actually return true only on SIGKILL then?

> +			}
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
> index 8050fe23c732..a0f00a078cbb 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2891,6 +2891,7 @@ bool get_signal(struct ksignal *ksig)
>  
>  	return ksig->sig > 0;
>  }
> +EXPORT_SYMBOL_GPL(get_signal);

If you are exporting this, could you add documentation please?


>  /**
>   * signal_delivered - called after signal delivery to update blocked signals
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index b7cbd66f889e..7a2d7d9fe772 100644
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
> @@ -75,13 +66,14 @@ struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg,
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
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
