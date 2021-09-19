Return-Path: <SRS0=H5WS=OJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8BCC433F5
	for <virtualization@archiver.kernel.org>; Sun, 19 Sep 2021 08:24:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FB0610A8
	for <virtualization@archiver.kernel.org>; Sun, 19 Sep 2021 08:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5FB0610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62DDE403A6;
	Sun, 19 Sep 2021 08:24:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wg7ebXM8cW0O; Sun, 19 Sep 2021 08:24:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4994400BB;
	Sun, 19 Sep 2021 08:24:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B54F9C0011;
	Sun, 19 Sep 2021 08:24:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D36EEC000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 08:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3D8780F13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 08:24:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4B34vBWLKSIu
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 08:24:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn
 [202.108.3.166])
 by smtp1.osuosl.org (Postfix) with SMTP id EE2CF80E80
 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 08:24:26 +0000 (UTC)
Received: from unknown (HELO localhost.localdomain)([123.115.166.15])
 by sina.com (172.16.97.23) with ESMTP
 id 6146F3B400007789; Sun, 19 Sep 2021 16:24:24 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
X-SMAIL-MID: 10962154919508
From: Hillf Danton <hdanton@sina.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 7/8] vhost: use kernel_copy_process to check RLIMITs and
 inherit cgroups
Date: Sun, 19 Sep 2021 16:24:12 +0800
Message-Id: <20210919082412.4483-1-hdanton@sina.com>
In-Reply-To: <20210916212051.6918-8-michael.christie@oracle.com>
References: <20210916212051.6918-1-michael.christie@oracle.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, 16 Sep 2021 16:20:50 -0500 Mike Christie wrote:
>  
>  static int vhost_worker_create(struct vhost_dev *dev)
>  {
> +	DECLARE_COMPLETION_ONSTACK(start_done);

Nit, cut it.

>  	struct vhost_worker *worker;
>  	struct task_struct *task;
> +	char buf[TASK_COMM_LEN];
>  	int ret;
>  
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> @@ -603,27 +613,30 @@ static int vhost_worker_create(struct vhost_dev *dev)
>  		return -ENOMEM;
>  
>  	dev->worker = worker;
> -	worker->dev = dev;
>  	worker->kcov_handle = kcov_common_handle();
>  	init_llist_head(&worker->work_list);
>  
> -	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
> -	if (IS_ERR(task)) {
> -		ret = PTR_ERR(task);
> +	/*
> +	 * vhost used to use the kthread API which ignores all signals by
> +	 * default and the drivers expect this behavior. So we do not want to
> +	 * ineherit the parent's signal handlers and set our worker to ignore
> +	 * everything below.
> +	 */
> +	task = kernel_copy_process(vhost_worker, worker, NUMA_NO_NODE,
> +				   CLONE_FS|CLONE_CLEAR_SIGHAND, 0, 1);
> +	if (IS_ERR(task))
>  		goto free_worker;
> -	}
>  
>  	worker->task = task;
> -	wake_up_process(task); /* avoid contributing to loadavg */
>  
> -	ret = vhost_attach_cgroups(dev);
> -	if (ret)
> -		goto stop_worker;
> +	snprintf(buf, sizeof(buf), "vhost-%d", current->pid);
> +	set_task_comm(task, buf);
> +
> +	ignore_signals(task);
>  
> +	wake_up_new_task(task);
>  	return 0;
>  
> -stop_worker:
> -	kthread_stop(worker->task);
>  free_worker:
>  	kfree(worker);
>  	dev->worker = NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 102ce25e4e13..09748694cb66 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -25,11 +25,16 @@ struct vhost_work {
>  	unsigned long		flags;
>  };
>  
> +enum {
> +	VHOST_WORKER_FLAG_STOP,
> +};
> +
>  struct vhost_worker {
>  	struct task_struct	*task;
> +	struct completion	*exit_done;
>  	struct llist_head	work_list;
> -	struct vhost_dev	*dev;
>  	u64			kcov_handle;
> +	unsigned long		flags;
>  };
>  
>  /* Poll a file (eventfd or socket) */
> -- 
> 2.25.1
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
