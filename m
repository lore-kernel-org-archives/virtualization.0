Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3B3EB64DA
	for <virtualization@archiver.kernel.org>; Thu, 20 Jul 2023 13:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89B9240126;
	Thu, 20 Jul 2023 13:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89B9240126
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SPY3aXcB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EtdcWUCvy2b0; Thu, 20 Jul 2023 13:06:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C57C1400D9;
	Thu, 20 Jul 2023 13:06:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C57C1400D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57E59C0071;
	Thu, 20 Jul 2023 13:06:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05236C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 13:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFEB961162
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 13:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFEB961162
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SPY3aXcB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPoypgGS0s5d
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 13:06:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 943A860B0F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 13:06:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 943A860B0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689858380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v6rTOLJG5GaCR/Syt3QSVmsmEmhVSwYUTFKI/e0y0Dg=;
 b=SPY3aXcBp/oYLosVSMAjOl/lbamctzn6UqGdfc5iEs+tljh17PC30//5UxUJfx7Ltq7yCE
 7my0lnMYG6Xw4ahB/59ZLjQAuq18iAwVhAYveZec3/H65wYUX7YZVd7dyCbnmC4Tb5+ZCJ
 6HQpU3AxhrlJikIrOC8MENupQsRmWfE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-6JU__6ceM5SwJcLKbMIDag-1; Thu, 20 Jul 2023 09:06:19 -0400
X-MC-Unique: 6JU__6ceM5SwJcLKbMIDag-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so475143f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jul 2023 06:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689858373; x=1690463173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6rTOLJG5GaCR/Syt3QSVmsmEmhVSwYUTFKI/e0y0Dg=;
 b=McK8TmWqSllw91T7qK5Notedxa/r8YCxFzjmREka/tic1IkLumGjVIjPtGNgGdGyVm
 6cglUgWBpFAJp+DPTsXx44POf8/sVwNbDSnYuBsazBvbZr34Ku3rm3hig0TptfodlVH9
 HUVu8oYE0+rpRz1N0/oWcIza6ZsEM3v8RpoojeeOAcHHuigrtJ5unWsaDrtoZfmO85LM
 QEjXMTm84g0MkSZSzGmllDOWv2vxGXNKB6dTPqq7TYcFYb3huogp3AuoArmUkj5U/wSr
 b1kjD3bJr//ATp88sW2V4BUpKYDNRdmDRFA4RG25QQ559tbuj3ZKkwQyGyoddQza23KY
 60Nw==
X-Gm-Message-State: ABy/qLZ+d9iG4sBanjGV/XEtnmRBBRXp+VRLxutrg2E4G1HfdGcdK1XZ
 imOUIQPuof+x/1wxFL6rMttpg3BmlW3sqKkjez7wYIKQL4TcbdTEt3sfjtwl5rwYQSRhBAD+VQa
 EKcF4v1zWSn2ooEtwiK197T0xN8GTWKVykccsjPvD8w==
X-Received: by 2002:a5d:58ca:0:b0:315:9fb7:bd9 with SMTP id
 o10-20020a5d58ca000000b003159fb70bd9mr2202718wrf.69.1689858372896; 
 Thu, 20 Jul 2023 06:06:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHTgv95ZuZpJ+dS1+P8teYo17qW+QbhpAI5TLWY/ih9MRHnsEEtjG3hxKcAUvUNkKjRmXY92A==
X-Received: by 2002:a5d:58ca:0:b0:315:9fb7:bd9 with SMTP id
 o10-20020a5d58ca000000b003159fb70bd9mr2202694wrf.69.1689858372498; 
 Thu, 20 Jul 2023 06:06:12 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 o5-20020a5d6845000000b0031435731dfasm1311009wrw.35.2023.07.20.06.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 06:06:11 -0700 (PDT)
Date: Thu, 20 Jul 2023 09:06:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230720090415-mutt-send-email-mst@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230202232517.8695-9-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brauner@kernel.org, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com, torvalds@linux-foundation.org
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

On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
> For vhost workers we use the kthread API which inherit's its values from
> and checks against the kthreadd thread. This results in the wrong RLIMITs
> being checked, so while tools like libvirt try to control the number of
> threads based on the nproc rlimit setting we can end up creating more
> threads than the user wanted.
> 
> This patch has us use the vhost_task helpers which will inherit its
> values/checks from the thread that owns the device similar to if we did
> a clone in userspace. The vhost threads will now be counted in the nproc
> rlimits. And we get features like cgroups and mm sharing automatically,
> so we can remove those calls.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>



Hi Mike,
So this seems to have caused a measureable regression in networking
performance (about 30%). Take a look here, and there's a zip file
with detailed measuraments attached:

https://bugzilla.redhat.com/show_bug.cgi?id=2222603


Could you take a look please?
You can also ask reporter questions there assuming you
have or can create a (free) account.



> ---
>  drivers/vhost/vhost.c | 58 ++++++++-----------------------------------
>  drivers/vhost/vhost.h |  4 +--
>  2 files changed, 13 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 74378d241f8d..d3c7c37b69a7 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,11 +22,11 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> -#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/signal.h>
> +#include <linux/sched/vhost_task.h>
>  #include <linux/interval_tree_generic.h>
>  #include <linux/nospec.h>
>  #include <linux/kcov.h>
> @@ -256,7 +256,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
>  		llist_add(&work->node, &dev->worker->work_list);
> -		wake_up_process(dev->worker->task);
> +		wake_up_process(dev->worker->vtsk->task);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vhost_work_queue);
> @@ -336,17 +336,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  static int vhost_worker(void *data)
>  {
>  	struct vhost_worker *worker = data;
> -	struct vhost_dev *dev = worker->dev;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
>  
> -	kthread_use_mm(dev->mm);
> -
>  	for (;;) {
>  		/* mb paired w/ kthread_stop */
>  		set_current_state(TASK_INTERRUPTIBLE);
>  
> -		if (kthread_should_stop()) {
> +		if (vhost_task_should_stop(worker->vtsk)) {
>  			__set_current_state(TASK_RUNNING);
>  			break;
>  		}
> @@ -368,7 +365,7 @@ static int vhost_worker(void *data)
>  				schedule();
>  		}
>  	}
> -	kthread_unuse_mm(dev->mm);
> +
>  	return 0;
>  }
>  
> @@ -509,31 +506,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>  
> -struct vhost_attach_cgroups_struct {
> -	struct vhost_work work;
> -	struct task_struct *owner;
> -	int ret;
> -};
> -
> -static void vhost_attach_cgroups_work(struct vhost_work *work)
> -{
> -	struct vhost_attach_cgroups_struct *s;
> -
> -	s = container_of(work, struct vhost_attach_cgroups_struct, work);
> -	s->ret = cgroup_attach_task_all(s->owner, current);
> -}
> -
> -static int vhost_attach_cgroups(struct vhost_dev *dev)
> -{
> -	struct vhost_attach_cgroups_struct attach;
> -
> -	attach.owner = current;
> -	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> -	vhost_work_queue(dev, &attach.work);
> -	vhost_dev_flush(dev);
> -	return attach.ret;
> -}
> -
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {
> @@ -580,14 +552,14 @@ static void vhost_worker_free(struct vhost_dev *dev)
>  
>  	dev->worker = NULL;
>  	WARN_ON(!llist_empty(&worker->work_list));
> -	kthread_stop(worker->task);
> +	vhost_task_stop(worker->vtsk);
>  	kfree(worker);
>  }
>  
>  static int vhost_worker_create(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
> -	struct task_struct *task;
> +	struct vhost_task *vtsk;
>  	int ret;
>  
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> @@ -595,27 +567,19 @@ static int vhost_worker_create(struct vhost_dev *dev)
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
> +	vtsk = vhost_task_create(vhost_worker, worker, NUMA_NO_NODE);
> +	if (!vtsk) {
> +		ret = -ENOMEM;
>  		goto free_worker;
>  	}
>  
> -	worker->task = task;
> -	wake_up_process(task); /* avoid contributing to loadavg */
> -
> -	ret = vhost_attach_cgroups(dev);
> -	if (ret)
> -		goto stop_worker;
> -
> +	worker->vtsk = vtsk;
> +	vhost_task_start(vtsk, "vhost-%d", current->pid);
>  	return 0;
>  
> -stop_worker:
> -	kthread_stop(worker->task);
>  free_worker:
>  	kfree(worker);
>  	dev->worker = NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 2f6beab93784..3af59c65025e 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -16,6 +16,7 @@
>  #include <linux/irqbypass.h>
>  
>  struct vhost_work;
> +struct vhost_task;
>  typedef void (*vhost_work_fn_t)(struct vhost_work *work);
>  
>  #define VHOST_WORK_QUEUED 1
> @@ -26,9 +27,8 @@ struct vhost_work {
>  };
>  
>  struct vhost_worker {
> -	struct task_struct	*task;
> +	struct vhost_task	*vtsk;
>  	struct llist_head	work_list;
> -	struct vhost_dev	*dev;
>  	u64			kcov_handle;
>  };
>  
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
