Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02FD2620E9
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745233129; cv=none; b=ZTvInk34StebvLPX+RvH5770DrMexZxqBGKOG+0ZmjXsR7+PRzg94ui66UKIp2t3KdQWcXgRlhS3y/LeQXMZqiHK/sQG/YiFP0LX1L4M0WWm3Q5skL/CfwC+emoCw1dhEivI3pqkBVP5YjX4XbNuJeA6SWJojFHn9429rgQ93F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745233129; c=relaxed/simple;
	bh=+OLaudvKCaZTfYCCqJqXytXG8sGH0hFm+3/6AndZdJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sSRWLRdbkaoX08kL6a6RnTyPZCbzzIIejqqppndHHr6w/c0DWPph9WlIqb3sojqwlfTOJjLZKi0isD2OlJCmdvZYCNzg5r3CKzhzD2Tcu2wFpkVXNH0bf8grRudTwDgH6NMLOyS8IldomuRGodgntBnWYwRo6PSZthd4rn6o4Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbC8LPZs; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbC8LPZs"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4302340B5E
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 10:58:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WJyBp9YmzTf for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Apr 2025 10:58:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5E00E40B4C
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E00E40B4C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JbC8LPZs
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5E00E40B4C
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 10:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745233124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plUm0aw3iqc7OZ+CZO/kAMwVPrqauabgqNB8l2inmKM=;
	b=JbC8LPZslYAc9BDj1rOKc+Fj8tjUFApNa7o4QDMl0zaFL7Mw9WUXbgI8u3XmchaotfNewi
	QPhwOMfxqFSmLQWLDgqRpYQxWXm14C/Nzb5q/aB6I3qRvRPsJU7BowQ7WG4Tbj9F7BYZjY
	PIcEaB9kCjNDIY+kDQ5VIEvMuERZFNI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-sgX042uIObWqGxQk2jSnZA-1; Mon, 21 Apr 2025 06:58:43 -0400
X-MC-Unique: sgX042uIObWqGxQk2jSnZA-1
X-Mimecast-MFC-AGG-ID: sgX042uIObWqGxQk2jSnZA_1745233123
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-85c8a0d07f2so5156646241.0
        for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745233123; x=1745837923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plUm0aw3iqc7OZ+CZO/kAMwVPrqauabgqNB8l2inmKM=;
        b=RKrGeAZwwS5P6uetuUu4hWUnqli4XZdmKXkUlgZERiUzl9inhTsIipsLVa3Qpovbw6
         XD9YEalOseoOAdj50oQdO7CYp+4hX39kUWAi6wiC7mTwBvwh1zAu/5Yv21PyJUP72oCx
         dQ8Qlmg4FZvJfZaVEU4N5vH+1Ssv2rKPaIwZ7CSPvIbmpoEg42gHcE6GcGVqDfXVyfux
         giEDVAvwmygHax8Jko1WNdyjfW9Dyo6fBL41MzWC5reo/5UaPb38pR5DvFqcE9P8H7gD
         Ml0LLT5tM0EPQb/61CX4i6+HA0i4kv/j0rwyYEPkJ543Bpz8SjP9uuC15ZTO+prNnoQu
         Xhvg==
X-Forwarded-Encrypted: i=1; AJvYcCUYFXbwdPkvWbqqaO1GFMI5xId0Ju9CXilsjUYXkJPubMOhF21sBOKaPshidxDoTkgAEWBNh9ajg9sJg3tTRg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwgKQHK6S7KMS6ivNm072L2KxjFXjTX9lksuHewaHLpiLzli9xM
	wAMFsv1WQkHWpSgymedno9YZPy+QRaJ1cFVkm0jS0PLyml23mSwgfVKMJgt9NMCmReyA5ULUbj8
	+7NSFEJxU82qe3Easvm/CW+4+dRnrnOcW87ougevDIfVORblywfGgjLMZalklIA/hF2MA+yiHcg
	z+wrA=
X-Gm-Gg: ASbGnctKwgnQZ0YA5ked/1nk86maxS7YqQzC/2RdkBu5Iqju7BPLIj4If2GAjKe0Xcq
	Z5tjmyPY3XSFxrZroHdP/Jf2gdgN+19nG6vyBKOMHgBApxPXhIJh7ZVmwRfs+3rkTi1bJFg4PTL
	B9Oe72nDz9UE7KhtzqpC9F+sPZmgirmqdzScCCZC2h+uwyqtuXX5Tkd1gApo0AJ3R9+8EnOix8k
	J4Ww/NIr08uLBgWbmqcjBAuIRkVdImyi4OkUCove1Z8mj/Uwa6VxCbMeH8RYI0XLBBbej/fTmNw
	WQ==
X-Received: by 2002:a05:6102:36cc:b0:4bb:e1c9:80b4 with SMTP id ada2fe7eead31-4cb7fefdba9mr5862745137.0.1745233122856;
        Mon, 21 Apr 2025 03:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMDwQ7uBvdA2v84VOyUbJ1BZFidOKJ7wtP7A1u4Jk/b7ChRbwfKpOV2JN9gU+dLj2Yh9kfKg==
X-Received: by 2002:a05:6102:36cc:b0:4bb:e1c9:80b4 with SMTP id ada2fe7eead31-4cb7fefdba9mr5862735137.0.1745233122382;
        Mon, 21 Apr 2025 03:58:42 -0700 (PDT)
Received: from redhat.com ([45.140.184.92])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7dd84911sm1602196137.4.2025.04.21.03.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 03:58:41 -0700 (PDT)
Date: Mon, 21 Apr 2025 06:58:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 2/4] vhost: Reintroduce kthread mode support in vhost
Message-ID: <20250421065549-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250421024457.112163-3-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c1DZ0bar9pRe-RLemBGPJV3Mj9Jyjds_i6vE9n6TWUc_1745233123
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Apr 21, 2025 at 10:44:08AM +0800, Cindy Lu wrote:
> This patch reintroduces kthread mode support in vhost,
> It also introduces struct vhost_worker_ops to abstract
> worker create/stop/wakeup operations.
> 
> * Bring back the original vhost_worker() implementation,
>   and renamed to vhost_run_work_kthread_list().
> 
> * Add cgroup support for the kthread
> 
> * Introduce struct vhost_worker_ops:
>   - Encapsulates create / stop / wake‑up callbacks.
>   - vhost_worker_create() selects the proper ops according to
>     inherit_owner.
> 
> This partially reverts or improves upon:
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vhost/vhost.c | 188 ++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |  12 +++
>  2 files changed, 182 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 250dc43f1786..be97028a8baf 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> +#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
> @@ -242,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
>  		llist_add(&work->node, &worker->work_list);
> -		vhost_task_wake(worker->vtsk);
> +		worker->ops->wakeup(worker);
>  	}
>  }
>  
> @@ -388,6 +389,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  	__vhost_vq_meta_reset(vq);
>  }
>  
> +static int vhost_run_work_kthread_list(void *data)
> +{
> +	struct vhost_worker *worker = data;
> +	struct vhost_work *work, *work_next;
> +	struct vhost_dev *dev = worker->dev;
> +	struct llist_node *node;
> +
> +	kthread_use_mm(dev->mm);
> +
> +	for (;;) {
> +		/* mb paired w/ kthread_stop */
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		if (kthread_should_stop()) {
> +			__set_current_state(TASK_RUNNING);
> +			break;
> +		}
> +		node = llist_del_all(&worker->work_list);
> +		if (!node)
> +			schedule();
> +
> +		node = llist_reverse_order(node);
> +		/* make sure flag is seen after deletion */
> +		smp_wmb();
> +		llist_for_each_entry_safe(work, work_next, node, node) {
> +			clear_bit(VHOST_WORK_QUEUED, &work->flags);
> +			__set_current_state(TASK_RUNNING);
> +			kcov_remote_start_common(worker->kcov_handle);
> +			work->fn(work);
> +			kcov_remote_stop();
> +			cond_resched();
> +		}
> +	}
> +	kthread_unuse_mm(dev->mm);
> +
> +	return 0;
> +}
> +
>  static bool vhost_run_work_list(void *data)
>  {
>  	struct vhost_worker *worker = data;
> @@ -582,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>  
> +struct vhost_attach_cgroups_struct {
> +	struct vhost_work work;
> +	struct task_struct *owner;
> +	int ret;
> +};
> +
> +static void vhost_attach_cgroups_work(struct vhost_work *work)
> +{
> +	struct vhost_attach_cgroups_struct *s;
> +
> +	s = container_of(work, struct vhost_attach_cgroups_struct, work);
> +	s->ret = cgroup_attach_task_all(s->owner, current);
> +}
> +
> +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> +{
> +	struct vhost_attach_cgroups_struct attach;
> +	int saved_cnt;
> +
> +	attach.owner = current;
> +
> +	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> +	vhost_worker_queue(worker, &attach.work);
> +
> +	mutex_lock(&worker->mutex);
> +
> +	/*
> +	 * Bypass attachment_cnt check in __vhost_worker_flush:
> +	 * Temporarily change it to INT_MAX to bypass the check
> +	 */
> +	saved_cnt = worker->attachment_cnt;
> +	worker->attachment_cnt = INT_MAX;
> +	__vhost_worker_flush(worker);
> +	worker->attachment_cnt = saved_cnt;


You mean this one?
        if (!worker->attachment_cnt || worker->killed)
                return;


Just introduce a variant of __vhost_worker_flush that
skips this check.

E.g.

Rename __vhost_worker_flush -> _vhost_worker_flush.

then rework:

static void _vhost_worker_flush(struct vhost_worker *worker)
{
        struct vhost_flush_struct flush; 
                                  
        if (!worker->attachment_cnt || worker->killed)
                return;

	__vhost_worker_flush(worker);
}





> +
> +	mutex_unlock(&worker->mutex);
> +
> +	return attach.ret;
> +}
> +
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {
> @@ -627,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
>  
>  	WARN_ON(!llist_empty(&worker->work_list));
>  	xa_erase(&dev->worker_xa, worker->id);
> -	vhost_task_stop(worker->vtsk);
> +	worker->ops->stop(worker);
>  	kfree(worker);
>  }
>  
> @@ -650,42 +729,115 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  	xa_destroy(&dev->worker_xa);
>  }
>  
> +static void vhost_task_wakeup(struct vhost_worker *worker)
> +{
> +	return vhost_task_wake(worker->vtsk);
> +}
> +
> +static void vhost_kthread_wakeup(struct vhost_worker *worker)
> +{
> +	wake_up_process(worker->kthread_task);
> +}
> +
> +static void vhost_task_do_stop(struct vhost_worker *worker)
> +{
> +	return vhost_task_stop(worker->vtsk);
> +}
> +
> +static void vhost_kthread_do_stop(struct vhost_worker *worker)
> +{
> +	kthread_stop(worker->kthread_task);
> +}
> +
> +static int vhost_task_worker_create(struct vhost_worker *worker,
> +				    struct vhost_dev *dev, const char *name)
> +{
> +	struct vhost_task *vtsk;
> +	u32 id;
> +	int ret;
> +
> +	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
> +				 worker, name);
> +	if (IS_ERR(vtsk))
> +		return PTR_ERR(vtsk);
> +
> +	worker->vtsk = vtsk;
> +	vhost_task_start(vtsk);
> +	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	if (ret < 0) {
> +		vhost_task_do_stop(worker);
> +		return ret;
> +	}
> +	worker->id = id;
> +	return 0;
> +}
> +
> +static int vhost_kthread_worker_create(struct vhost_worker *worker,
> +				       struct vhost_dev *dev, const char *name)
> +{
> +	struct task_struct *task;
> +	u32 id;
> +	int ret;
> +
> +	task = kthread_create(vhost_run_work_kthread_list, worker, "%s", name);
> +	if (IS_ERR(task))
> +		return PTR_ERR(task);
> +
> +	worker->kthread_task = task;
> +	wake_up_process(task);
> +	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	if (ret < 0)
> +		goto stop_worker;
> +
> +	ret = vhost_attach_task_to_cgroups(worker);
> +	if (ret)
> +		goto stop_worker;
> +
> +	worker->id = id;
> +	return 0;
> +
> +stop_worker:
> +	vhost_kthread_do_stop(worker);
> +	return ret;
> +}
> +
> +static const struct vhost_worker_ops kthread_ops = {
> +	.create = vhost_kthread_worker_create,
> +	.stop = vhost_kthread_do_stop,
> +	.wakeup = vhost_kthread_wakeup,
> +};
> +
> +static const struct vhost_worker_ops vhost_task_ops = {
> +	.create = vhost_task_worker_create,
> +	.stop = vhost_task_do_stop,
> +	.wakeup = vhost_task_wakeup,
> +};
> +
>  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
> -	struct vhost_task *vtsk;
>  	char name[TASK_COMM_LEN];
>  	int ret;
> -	u32 id;
> +	const struct vhost_worker_ops *ops =
> +		dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
>  
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>  	if (!worker)
>  		return NULL;
>  
>  	worker->dev = dev;
> +	worker->ops = ops;
>  	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>  
> -	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
> -				 worker, name);
> -	if (IS_ERR(vtsk))
> -		goto free_worker;
> -
>  	mutex_init(&worker->mutex);
>  	init_llist_head(&worker->work_list);
>  	worker->kcov_handle = kcov_common_handle();
> -	worker->vtsk = vtsk;
> -
> -	vhost_task_start(vtsk);
> -
> -	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	ret = ops->create(worker, dev, name);
>  	if (ret < 0)
> -		goto stop_worker;
> -	worker->id = id;
> +		goto free_worker;
>  
>  	return worker;
>  
> -stop_worker:
> -	vhost_task_stop(vtsk);
>  free_worker:
>  	kfree(worker);
>  	return NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 19bb94922a0e..af4b2f7d3b91 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -26,7 +26,18 @@ struct vhost_work {
>  	unsigned long		flags;
>  };
>  
> +struct vhost_worker;
> +struct vhost_dev;
> +
> +struct vhost_worker_ops {
> +	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
> +		      const char *name);
> +	void (*stop)(struct vhost_worker *worker);
> +	void (*wakeup)(struct vhost_worker *worker);
> +};
> +
>  struct vhost_worker {
> +	struct task_struct *kthread_task;
>  	struct vhost_task	*vtsk;
>  	struct vhost_dev	*dev;
>  	/* Used to serialize device wide flushing with worker swapping. */
> @@ -36,6 +47,7 @@ struct vhost_worker {
>  	u32			id;
>  	int			attachment_cnt;
>  	bool			killed;
> +	const struct vhost_worker_ops *ops;
>  };
>  
>  /* Poll a file (eventfd or socket) */
> -- 
> 2.45.0

