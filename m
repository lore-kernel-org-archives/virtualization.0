Return-Path: <SRS0=QelU=OY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D6C433F5
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 13:13:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DE86321F
	for <virtualization@archiver.kernel.org>; Mon,  4 Oct 2021 13:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C3DE86321F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9178860BDD;
	Mon,  4 Oct 2021 13:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLHbdINUHUIn; Mon,  4 Oct 2021 13:13:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A9D3B60BD7;
	Mon,  4 Oct 2021 13:13:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82FCFC0011;
	Mon,  4 Oct 2021 13:13:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E73C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D6E1E40134
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:13:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75Ecyu-hnrKe
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:12:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC739400C8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Oct 2021 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633353177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKy01q7QzviKlAmThKzHSK4Bhyjv5rNTrVc1mM+/eWA=;
 b=W/06WMdChXuj3ST6mH6+TaPyMI9BqkXViAUcvmGjwTp5dfRsEgpl118pG/eDGRvj8ZIJAr
 jjikMEGgL7QB4J1W4wXHhszEydWVgJKmHSdWRRSOd5Er5liLLoGOgueY9d93zVg4V9GKy1
 MW15Mh9wTT5DBK+gOTFQ6SwUmQqAHV0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-BIyWYCtuNUegawotlbLxYA-1; Mon, 04 Oct 2021 09:12:55 -0400
X-MC-Unique: BIyWYCtuNUegawotlbLxYA-1
Received: by mail-wm1-f71.google.com with SMTP id
 200-20020a1c00d1000000b0030b3dce20e1so9971079wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Oct 2021 06:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nKy01q7QzviKlAmThKzHSK4Bhyjv5rNTrVc1mM+/eWA=;
 b=hFJ04thDzb8fcMUZIjHEEGGUohsVQy8ZnyI0/7inA5B8aNbH08p6EpUTosT5WtW+WO
 KdtQ8qmhXh8tr9JVF0tiWGBeA5ma6v+DijNz+JU+CkIBfsXlvFFf39gb56uSH5+9K1aN
 Hf0D0t6I95V01wYF2SNTC//Rvpc/8Z/q8d1GaLyu5ae13Hxm7AouRFRfzUonE2DOHD4j
 ZP5Pnixg4WpG4ZXMX402/N6MI6yXNoVAiY1Ndk2Pyi2e23T+BTRR2oBZJ063sDT1nbRw
 /3AqN2caIf85Qeb4AO1wdNOa+G8A3fpx9QJI4EIXmTQa0sFxr3EELHGBsJCFmpRtb2Om
 nOLQ==
X-Gm-Message-State: AOAM5336BfBLZvWJj3Rl02CFUGWG+YuYzgKhtBlsKRxmB6zm/w1L1HXo
 H2omm0BoaL5YxjcyX5BYTQ/SZWYeo/jkhEWtRzZ7/yampSpznFvOn/ld9kCPsCz0CyGlYhikG29
 OMkPh/4ATgjr/b82uVV5l5Y77lL37Ui04uPgs+XoOzw==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr18259713wmj.160.1633353173566; 
 Mon, 04 Oct 2021 06:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/7JuPoRusQE9dAIOzDjog1WyyGeLCBRPdpk0zlyBG1OwcmknElq3co39nZNsk8nASzG7jSQ==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr18259681wmj.160.1633353173364; 
 Mon, 04 Oct 2021 06:12:53 -0700 (PDT)
Received: from redhat.com ([2.55.134.94])
 by smtp.gmail.com with ESMTPSA id s3sm14366860wrm.40.2021.10.04.06.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Oct 2021 06:12:52 -0700 (PDT)
Date: Mon, 4 Oct 2021 09:12:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V2 9/9] vhost: use kernel_worker to check RLIMITs and
 inherit v2 cgroups
Message-ID: <20211004091216-mutt-send-email-mst@kernel.org>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-10-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210921215218.89844-10-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, hdanton@sina.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 stefanha@redhat.com, christian.brauner@ubuntu.com
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

On Tue, Sep 21, 2021 at 04:52:18PM -0500, Mike Christie wrote:
> For vhost workers we use the kthread API which inherit's its values from
> and checks against the kthreadd thread. This results in cgroups v2 not
> working and the wrong RLIMITs being checked. This patch has us use the
> kernel_copy_process function which will inherit its values/checks from the
> thread that owns the device.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge with other bits.

> ---
>  drivers/vhost/vhost.c | 68 ++++++++++++++++---------------------------
>  drivers/vhost/vhost.h |  7 ++++-
>  2 files changed, 31 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c9a1f706989c..7a5142dcde1b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,7 +22,6 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> -#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
> @@ -344,17 +343,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
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
> +		if (test_bit(VHOST_WORKER_FLAG_STOP, &worker->flags)) {
>  			__set_current_state(TASK_RUNNING);
>  			break;
>  		}
> @@ -376,8 +372,9 @@ static int vhost_worker(void *data)
>  				schedule();
>  		}
>  	}
> -	kthread_unuse_mm(dev->mm);
> -	return 0;
> +
> +	complete(worker->exit_done);
> +	do_exit(0);
>  }
>  
>  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> @@ -517,31 +514,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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
> -	vhost_work_dev_flush(dev);
> -	return attach.ret;
> -}
> -
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {
> @@ -579,6 +551,16 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>  	dev->mm = NULL;
>  }
>  
> +static void vhost_worker_stop(struct vhost_worker *worker)
> +{
> +	DECLARE_COMPLETION_ONSTACK(exit_done);
> +
> +	worker->exit_done = &exit_done;
> +	set_bit(VHOST_WORKER_FLAG_STOP, &worker->flags);
> +	wake_up_process(worker->task);
> +	wait_for_completion(worker->exit_done);
> +}
> +
>  static void vhost_worker_free(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker = dev->worker;
> @@ -588,7 +570,7 @@ static void vhost_worker_free(struct vhost_dev *dev)
>  
>  	dev->worker = NULL;
>  	WARN_ON(!llist_empty(&worker->work_list));
> -	kthread_stop(worker->task);
> +	vhost_worker_stop(worker);
>  	kfree(worker);
>  }
>  
> @@ -603,27 +585,27 @@ static int vhost_worker_create(struct vhost_dev *dev)
>  		return -ENOMEM;
>  
>  	dev->worker = worker;
> -	worker->dev = dev;
>  	worker->kcov_handle = kcov_common_handle();
>  	init_llist_head(&worker->work_list);
>  
> -	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
> +	/*
> +	 * vhost used to use the kthread API which ignores all signals by
> +	 * default and the drivers expect this behavior. So we do not want to
> +	 * ineherit the parent's signal handlers and set our worker to ignore
> +	 * everything below.
> +	 */
> +	task = kernel_worker(vhost_worker, worker, NUMA_NO_NODE,
> +			     CLONE_FS | CLONE_CLEAR_SIGHAND,
> +			     KERN_WORKER_NO_FILES | KERN_WORKER_NO_SIGS);
>  	if (IS_ERR(task)) {
>  		ret = PTR_ERR(task);
>  		goto free_worker;
>  	}
>  
>  	worker->task = task;
> -	wake_up_process(task); /* avoid contributing to loadavg */
> -
> -	ret = vhost_attach_cgroups(dev);
> -	if (ret)
> -		goto stop_worker;
> -
> +	kernel_worker_start(task, "vhost-%d", current->pid);
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
