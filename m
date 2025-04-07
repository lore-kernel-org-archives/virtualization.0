Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF022A1CD
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013838; cv=none; b=EnHjACazmwOmHbzWbxZ4QI8rofGpfb1M8WUsStashVpB881jERal8IYb7AsqsoMYcc9Co4oLba6k4LZZgRGNygbIBP+Vp87ITGwjis3K8Siy7ftft9rxsbMkN6W8QMLkpwPytlitIGD6c3h6drDgiYn5KQDi/xu7klmN7lgMin0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013838; c=relaxed/simple;
	bh=mSjUh8N/O5w5UJDg+QA0tXXjTVKD7/6jJkNLyw45Ceo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Fnd0LUrDlnmEClRlqG1PzLQZNrTwdcpZR8V7EQ6J+rXPG+z7fbabiUug4xST29N+PvmmHM3JuWB1lzvfBAS2u08Mw5Ek3+scOhJw67Dm/p4l8Yh4U4hIoqsZA+Um5zMiATfc9iMzZeHZ/XrF0stDHVKV/xOhNW8OcUIFKL7uTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6FOcbK6; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6FOcbK6"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A28FF81749
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VPgVXQO4bnJz for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Apr 2025 08:17:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B8283811F7
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8283811F7
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O6FOcbK6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B8283811F7
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Apr 2025 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744013834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/NXeUmz6sFdPq3LVWzGbgGpd+TscgMz224LBsRMb8cc=;
	b=O6FOcbK67sil/qVeWKNVbMKZFrGpJ5BMeCPuLGigoz6d65tp7rY+TWpgDaxfQlEvbLjFD1
	0hJbq9K/D+GnU4csxepuhOmHZ75buWrl5vCB8Yj0YU2I8nrBLDxLbiER3ejY6RYgHuuUhi
	3BTSQt8ScRYt7ZEfsyEJKZsU1lyIaB4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-k8-xQfNSNcyA7oDL4Ng8yw-1; Mon, 07 Apr 2025 04:17:11 -0400
X-MC-Unique: k8-xQfNSNcyA7oDL4Ng8yw-1
X-Mimecast-MFC-AGG-ID: k8-xQfNSNcyA7oDL4Ng8yw_1744013830
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso51346185e9.2
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Apr 2025 01:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744013830; x=1744618630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NXeUmz6sFdPq3LVWzGbgGpd+TscgMz224LBsRMb8cc=;
        b=jIBNNt4dLp0/u1D30F87+178wVh3CFjilhxqtkn1CRoIsBGAAWvvDaun+yP91YDaDp
         oxEtax2KjIkJf0P0kti8uiNTsFWuE2LM5GeT51vvsUGnL1Ylx1F7lGl2PKDXLb4Bb6QX
         iNVzW1+y+obVHs5QfeOF7mrXrJoUJEzEvtoMRqSiJGjKjDv+NXdERK0KbiLXXsCDwWVl
         +G7todAlzbi5uF+J73rc/Sqcj/4iSdUW0SW2K0xNLZIELZ211UaQv+XCPttG/dZa+dEz
         675vN3pD8Jddbd9Ev+cUokvIbYgR5/FFBwOA2Ngx7GA0/Lh/XdtZIlZT1KfRw1xQTVpH
         NP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXya4q1y1y63+jQXBi+xszCkUOx11wvwKE3Hlu2Z+17HurHwuUNLzkYyiHUdHhmynFgYCrdxaTZcjy8stw8yA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwfXzkLNBaewzm9EAzbdSmxl/IzblAsEE8/glARV8rWMdDY6VAG
	Ok/WS0dpeariC26nERHIT43Hrlx77JxmNzws0P3tNXisW43o+uqTeeGf7H7VrpXsyqf58U1HHG8
	fzRY9f+7VcQ2wpbGZcGx/LlG1qkQtlufuosf3hzPKKTbJb+8kZZqHStkDXA5pcxm0SPnPpDjf3I
	8UHEA=
X-Gm-Gg: ASbGnctM3hRnWqnLaYaAgh2L43vEzPAYlZs3veBofaBMBuRQ9tg0WxIY6AzibRGEbMS
	VezYEBxINs8WzB0d+9wYkT/mO+7JiMtyJMNZAyJ8C2UCxQ+nYyYfB68omlcz2RH8oeE2IT6I1UJ
	hcJTO+1sfUOFAx3gR1J/mq64V4bXzsyNmQhCYgGMqkUQ4CNaN3qqwe1IOu+qDp2CVPELLEZQg+W
	Dp5NOlxq7SvgaRSKjulRCY3OtRksz6myhqRYcoycv7T7+UvDWVQIgvt2RqGdi226iFNwAX2KYPf
	BHqV2xKO1g==
X-Received: by 2002:a05:6000:2505:b0:39a:c8a8:4fdc with SMTP id ffacd0b85a97d-39d0de12ccdmr8771254f8f.16.1744013830503;
        Mon, 07 Apr 2025 01:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwOTqjbMc9o3iiqXoVsN5aZIAS84q095cDwnrD0zTHjtFAU1Yzf7ek1qUTjNU8khKKwtAHAA==
X-Received: by 2002:a05:6000:2505:b0:39a:c8a8:4fdc with SMTP id ffacd0b85a97d-39d0de12ccdmr8771226f8f.16.1744013830045;
        Mon, 07 Apr 2025 01:17:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c300968cfsm11484116f8f.16.2025.04.07.01.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:17:09 -0700 (PDT)
Date: Mon, 7 Apr 2025 04:17:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
Message-ID: <20250407041540-mutt-send-email-mst@kernel.org>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-5-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-5-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4ag47i7AK__1hrWyBRU_YsE9pEtDmXbZMB4U0qFGisc_1744013830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
> Abstract vhost worker operations (create/stop/wakeup) into an ops
> structure to prepare for kthread mode support.
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>

I worry about the overhead of indirect calls here.

We have the wrappers, and only two options,
why did you decide to add it like this,
with ops?



> ---
>  drivers/vhost/vhost.c | 63 ++++++++++++++++++++++++++++++-------------
>  drivers/vhost/vhost.h | 11 ++++++++
>  2 files changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 20571bd6f7bd..c162ad772f8f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
>  		llist_add(&work->node, &worker->work_list);
> -		vhost_task_wake(worker->vtsk);
> +		worker->ops->wakeup(worker);
>  	}
>  }
>  
> @@ -706,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
>  
>  	WARN_ON(!llist_empty(&worker->work_list));
>  	xa_erase(&dev->worker_xa, worker->id);
> -	vhost_task_stop(worker->vtsk);
> +	worker->ops->stop(worker);
>  	kfree(worker);
>  }
>  
> @@ -729,42 +729,69 @@ static void vhost_workers_free(struct vhost_dev *dev)
>  	xa_destroy(&dev->worker_xa);
>  }
>  
> +static void vhost_task_wakeup(struct vhost_worker *worker)
> +{
> +	return vhost_task_wake(worker->vtsk);
> +}
> +
> +static void vhost_task_do_stop(struct vhost_worker *worker)
> +{
> +	return vhost_task_stop(worker->vtsk);
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
> +	const struct vhost_worker_ops *ops = &vhost_task_ops;
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
> index 19bb94922a0e..98895e299efa 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -26,6 +26,16 @@ struct vhost_work {
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
>  	struct vhost_task	*vtsk;
>  	struct vhost_dev	*dev;
> @@ -36,6 +46,7 @@ struct vhost_worker {
>  	u32			id;
>  	int			attachment_cnt;
>  	bool			killed;
> +	const struct vhost_worker_ops *ops;
>  };
>  
>  /* Poll a file (eventfd or socket) */
> -- 
> 2.45.0

