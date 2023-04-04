Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0751BC761A6
	for <virtualization@archiver.kernel.org>; Tue,  4 Apr 2023 18:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8628F40AC9;
	Tue,  4 Apr 2023 18:38:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8628F40AC9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A8Hu3mvd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RKSXYpmhh8aA; Tue,  4 Apr 2023 18:38:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 26513401DF;
	Tue,  4 Apr 2023 18:38:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26513401DF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B373FC0037;
	Tue,  4 Apr 2023 18:38:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDD12C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:38:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9888E81775
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:38:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9888E81775
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A8Hu3mvd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N2PBtaCZj0i5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:38:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F26F5815CC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F26F5815CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Apr 2023 18:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680633489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to; bh=KQWuuHIZan4soZR/xsCmpCUigz5BcNeFZpsjnbdDYOw=;
 b=A8Hu3mvd7prxLD+//f+Wy9qZwiyufUkOO3gVjLH9Rq9I5GiuI4pxVqkC+7Pdi7BjcGriC1
 e504oISYeuoyUNTKOtzO8FWlSn3hl1gLpJbkfC2unBsQ7tBmAjIYCA7ZHDACeNlaidK5Fu
 oQgQc7FH+TzxwOwjNiYDh3kZ+ooupMk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-qSRrp48CP2uY70x6IGHnYw-1; Tue, 04 Apr 2023 14:38:08 -0400
X-MC-Unique: qSRrp48CP2uY70x6IGHnYw-1
Received: by mail-ed1-f69.google.com with SMTP id
 f15-20020a50a6cf000000b0050050d2326aso46881444edc.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 Apr 2023 11:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680633487;
 h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KQWuuHIZan4soZR/xsCmpCUigz5BcNeFZpsjnbdDYOw=;
 b=NCkfXi3XMhPefBIzxq2PRD/8n2rqyEMUXh4Y/Nm6dvUmHhVqOwzeV6cn+3x8H5v+9X
 Amz1ec4ybiyhOQjh3x5kw2gbq1ijOphvUbk1gWmunE8QBNGMOcbvMePe3EpBomAPR9d4
 4nwOjZpuiSEsKnd+l78sTGgBEPT2c/EsEAycPvI///7sn1ofoiRcrCgucneM5zN4m/ha
 urrqiA6nM9r5XA5FwfLSATjDiRCLMOK8oOQ5WFF50GCBPgRnuicfIOlpIBdLpDRipXPv
 1dNTS9tFkQV6H/FYpBPF3bam5duXMVWMAWHyGLHcIlfRp0g/H1XV1SHmEH5MsIhuLTxY
 J40w==
X-Gm-Message-State: AAQBX9fOwPIUMJeLhs4Gge93tndjX5wI6MVkQVTqdxdWlfxleSjqPBux
 Euxp/KhhhrUDPqQPI5cD9z91M/bSsy4PHug4m2cH9ut/4aOTzZMIsrCNwsXWlZgv3m1sn19z8qw
 7Gld4/XcsU0SAB6tanntajJRzOlGn5EL0jYtXi5YsQw==
X-Received: by 2002:a17:906:5298:b0:8e6:266c:d195 with SMTP id
 c24-20020a170906529800b008e6266cd195mr483833ejm.38.1680633486342; 
 Tue, 04 Apr 2023 11:38:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350YQ+c8Yc8XyleqZgnIiCMDEdK343JXl8tjx5d5Rhyx00FUBIArIFKBWnSsVuM5mEUAU/MnSTw==
X-Received: by 2002:a17:906:5298:b0:8e6:266c:d195 with SMTP id
 c24-20020a170906529800b008e6266cd195mr483785ejm.38.1680633485494; 
 Tue, 04 Apr 2023 11:38:05 -0700 (PDT)
Received: from redhat.com ([2.52.139.22]) by smtp.gmail.com with ESMTPSA id
 g19-20020a170906c19300b0093313f4fc3csm6315881ejz.70.2023.04.04.11.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 11:38:04 -0700 (PDT)
Date: Tue, 4 Apr 2023 14:38:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH v6 01/11] vhost: add vhost_worker pointer to
 vhost_virtqueue
Message-ID: <20230404143713-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230328021717.42268-12-michael.christie@oracle.com>
 <20230328021717.42268-11-michael.christie@oracle.com>
 <20230328021717.42268-10-michael.christie@oracle.com>
 <20230328021717.42268-9-michael.christie@oracle.com>
 <20230328021717.42268-8-michael.christie@oracle.com>
 <20230328021717.42268-7-michael.christie@oracle.com>
 <20230328021717.42268-6-michael.christie@oracle.com>
 <20230328021717.42268-5-michael.christie@oracle.com>
 <20230328021717.42268-4-michael.christie@oracle.com>
 <20230328021717.42268-3-michael.christie@oracle.com>
 <20230328021717.42268-2-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Mon, Mar 27, 2023 at 09:17:07PM -0500, Mike Christie wrote:
> This patchset allows userspace to map vqs to different workers. This
> patch adds a worker pointer to the vq so we can store that info.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Thanks! Conflicts with a bunch of refactorings upstream:
could you rebase this on my tree and repost?
I need to queue this soon so it gets time in -next.

> ---
>  drivers/vhost/vhost.c | 24 +++++++++++++-----------
>  drivers/vhost/vhost.h |  1 +
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4368ee9b999c..e041e116afee 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -486,6 +486,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>  		vq->log = NULL;
>  		vq->indirect = NULL;
>  		vq->heads = NULL;
> +		vq->worker = NULL;
>  		vq->dev = dev;
>  		mutex_init(&vq->mutex);
>  		vhost_vq_reset(dev, vq);
> @@ -554,16 +555,15 @@ static void vhost_worker_free(struct vhost_dev *dev)
>  	kfree(worker);
>  }
>  
> -static int vhost_worker_create(struct vhost_dev *dev)
> +static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
>  	struct vhost_task *vtsk;
>  	char name[TASK_COMM_LEN];
> -	int ret;
>  
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>  	if (!worker)
> -		return -ENOMEM;
> +		return NULL;
>  
>  	dev->worker = worker;
>  	worker->kcov_handle = kcov_common_handle();
> @@ -571,25 +571,24 @@ static int vhost_worker_create(struct vhost_dev *dev)
>  	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>  
>  	vtsk = vhost_task_create(vhost_worker, worker, name);
> -	if (!vtsk) {
> -		ret = -ENOMEM;
> +	if (!vtsk)
>  		goto free_worker;
> -	}
>  
>  	worker->vtsk = vtsk;
>  	vhost_task_start(vtsk);
> -	return 0;
> +	return worker;
>  
>  free_worker:
>  	kfree(worker);
>  	dev->worker = NULL;
> -	return ret;
> +	return NULL;
>  }
>  
>  /* Caller should have device mutex */
>  long vhost_dev_set_owner(struct vhost_dev *dev)
>  {
> -	int err;
> +	struct vhost_worker *worker;
> +	int err, i;
>  
>  	/* Is there an owner already? */
>  	if (vhost_dev_has_owner(dev)) {
> @@ -600,9 +599,12 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  	vhost_attach_mm(dev);
>  
>  	if (dev->use_worker) {
> -		err = vhost_worker_create(dev);
> -		if (err)
> +		worker = vhost_worker_create(dev);
> +		if (!worker)
>  			goto err_worker;
> +
> +		for (i = 0; i < dev->nvqs; i++)
> +			dev->vqs[i]->worker = worker;
>  	}
>  
>  	err = vhost_dev_alloc_iovecs(dev);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 0308638cdeee..e72b665ba3a5 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -74,6 +74,7 @@ struct vhost_vring_call {
>  /* The virtqueue structure describes a queue attached to a device. */
>  struct vhost_virtqueue {
>  	struct vhost_dev *dev;
> +	struct vhost_worker *worker;
>  
>  	/* The actual ring of buffers. */
>  	struct mutex mutex;
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:08PM -0500, Mike Christie wrote:
> In the next patches each vq might have different workers so one could
> have work but others do not. For net, we only want to check specific vqs,
> so this adds a helper to check if a vq has work pending and converts
> vhost-net to use it.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/net.c   | 2 +-
>  drivers/vhost/vhost.c | 6 +++---
>  drivers/vhost/vhost.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 07181cd8d52e..8ed63651b9eb 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -546,7 +546,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  	endtime = busy_clock() + busyloop_timeout;
>  
>  	while (vhost_can_busy_poll(endtime)) {
> -		if (vhost_has_work(&net->dev)) {
> +		if (vhost_vq_has_work(vq)) {
>  			*busyloop_intr = true;
>  			break;
>  		}
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index e041e116afee..6567aed69ebb 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -262,11 +262,11 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  EXPORT_SYMBOL_GPL(vhost_work_queue);
>  
>  /* A lockless hint for busy polling code to exit the loop */
> -bool vhost_has_work(struct vhost_dev *dev)
> +bool vhost_vq_has_work(struct vhost_virtqueue *vq)
>  {
> -	return dev->worker && !llist_empty(&dev->worker->work_list);
> +	return vq->worker && !llist_empty(&vq->worker->work_list);
>  }
> -EXPORT_SYMBOL_GPL(vhost_has_work);
> +EXPORT_SYMBOL_GPL(vhost_vq_has_work);
>  
>  void vhost_poll_queue(struct vhost_poll *poll)
>  {
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index e72b665ba3a5..0dde119fb0ee 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -45,7 +45,6 @@ struct vhost_poll {
>  
>  void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
>  void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
> -bool vhost_has_work(struct vhost_dev *dev);
>  
>  void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
>  		     __poll_t mask, struct vhost_dev *dev);
> @@ -195,6 +194,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
>  		      struct vhost_log *log, unsigned int *log_num);
>  void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
>  
> +bool vhost_vq_has_work(struct vhost_virtqueue *vq);
>  bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
>  int vhost_vq_init_access(struct vhost_virtqueue *);
>  int vhost_add_used(struct vhost_virtqueue *, unsigned int head, int len);
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:09PM -0500, Mike Christie wrote:
> This patch has the core work queueing function take a worker for when we
> support multiple workers. It also adds a helper that takes a vq during
> queueing so modules can control which vq/worker to queue work on.
> 
> This temp leaves vhost_work_queue. It will be removed when the drivers
> are converted in the next patches.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c | 44 +++++++++++++++++++++++++++----------------
>  drivers/vhost/vhost.h |  1 +
>  2 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 6567aed69ebb..cc2628ba9a77 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -231,6 +231,34 @@ void vhost_poll_stop(struct vhost_poll *poll)
>  }
>  EXPORT_SYMBOL_GPL(vhost_poll_stop);
>  
> +static void vhost_work_queue_on(struct vhost_worker *worker,
> +				struct vhost_work *work)
> +{
> +	if (!worker)
> +		return;
> +
> +	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> +		/* We can only add the work to the list after we're
> +		 * sure it was not in the list.
> +		 * test_and_set_bit() implies a memory barrier.
> +		 */
> +		llist_add(&work->node, &worker->work_list);
> +		wake_up_process(worker->vtsk->task);
> +	}
> +}
> +
> +void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> +{
> +	vhost_work_queue_on(dev->worker, work);
> +}
> +EXPORT_SYMBOL_GPL(vhost_work_queue);
> +
> +void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
> +{
> +	vhost_work_queue_on(vq->worker, work);
> +}
> +EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
> +
>  void vhost_dev_flush(struct vhost_dev *dev)
>  {
>  	struct vhost_flush_struct flush;
> @@ -245,22 +273,6 @@ void vhost_dev_flush(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_flush);
>  
> -void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> -{
> -	if (!dev->worker)
> -		return;
> -
> -	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> -		/* We can only add the work to the list after we're
> -		 * sure it was not in the list.
> -		 * test_and_set_bit() implies a memory barrier.
> -		 */
> -		llist_add(&work->node, &dev->worker->work_list);
> -		wake_up_process(dev->worker->vtsk->task);
> -	}
> -}
> -EXPORT_SYMBOL_GPL(vhost_work_queue);
> -
>  /* A lockless hint for busy polling code to exit the loop */
>  bool vhost_vq_has_work(struct vhost_virtqueue *vq)
>  {
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 0dde119fb0ee..b64ee4ef387d 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -194,6 +194,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *,
>  		      struct vhost_log *log, unsigned int *log_num);
>  void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
>  
> +void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work);
>  bool vhost_vq_has_work(struct vhost_virtqueue *vq);
>  bool vhost_vq_is_setup(struct vhost_virtqueue *vq);
>  int vhost_vq_init_access(struct vhost_virtqueue *);
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:10PM -0500, Mike Christie wrote:
> This patch has the core work flush function take a worker. When we
> support multiple workers we can then flush each worker during device
> removal, stoppage, etc.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index cc2628ba9a77..6160aa1cc922 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -247,6 +247,20 @@ static void vhost_work_queue_on(struct vhost_worker *worker,
>  	}
>  }
>  
> +static void vhost_work_flush_on(struct vhost_worker *worker)
> +{
> +	struct vhost_flush_struct flush;
> +
> +	if (!worker)
> +		return;
> +
> +	init_completion(&flush.wait_event);
> +	vhost_work_init(&flush.work, vhost_flush_work);
> +
> +	vhost_work_queue_on(worker, &flush.work);
> +	wait_for_completion(&flush.wait_event);
> +}
> +
>  void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  {
>  	vhost_work_queue_on(dev->worker, work);
> @@ -261,15 +275,7 @@ EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
>  
>  void vhost_dev_flush(struct vhost_dev *dev)
>  {
> -	struct vhost_flush_struct flush;
> -
> -	if (dev->worker) {
> -		init_completion(&flush.wait_event);
> -		vhost_work_init(&flush.work, vhost_flush_work);
> -
> -		vhost_work_queue(dev, &flush.work);
> -		wait_for_completion(&flush.wait_event);
> -	}
> +	vhost_work_flush_on(dev->worker);
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_flush);
>  
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:11PM -0500, Mike Christie wrote:
> This has the drivers pass in their poll to vq mapping and then converts
> the core poll code to use the vq based helpers. In the next patches we
> will allow vqs to be handled by different workers, so to allow drivers
> to execute operations like queue, stop, flush, etc on specific polls/vqs
> we need to know the mappings.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/net.c   | 6 ++++--
>  drivers/vhost/vhost.c | 8 +++++---
>  drivers/vhost/vhost.h | 4 +++-
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 8ed63651b9eb..4a9b757071a2 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1342,8 +1342,10 @@ static int vhost_net_open(struct inode *inode, struct file *f)
>  		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
>  		       NULL);
>  
> -	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
> -	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
> +	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev,
> +			vqs[VHOST_NET_VQ_TX]);
> +	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev,
> +			vqs[VHOST_NET_VQ_RX]);
>  
>  	f->private_data = n;
>  	n->page_frag.page = NULL;
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 6160aa1cc922..6968f8fc17e8 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -187,13 +187,15 @@ EXPORT_SYMBOL_GPL(vhost_work_init);
>  
>  /* Init poll structure */
>  void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
> -		     __poll_t mask, struct vhost_dev *dev)
> +		     __poll_t mask, struct vhost_dev *dev,
> +		     struct vhost_virtqueue *vq)
>  {
>  	init_waitqueue_func_entry(&poll->wait, vhost_poll_wakeup);
>  	init_poll_funcptr(&poll->table, vhost_poll_func);
>  	poll->mask = mask;
>  	poll->dev = dev;
>  	poll->wqh = NULL;
> +	poll->vq = vq;
>  
>  	vhost_work_init(&poll->work, fn);
>  }
> @@ -288,7 +290,7 @@ EXPORT_SYMBOL_GPL(vhost_vq_has_work);
>  
>  void vhost_poll_queue(struct vhost_poll *poll)
>  {
> -	vhost_work_queue(poll->dev, &poll->work);
> +	vhost_vq_work_queue(poll->vq, &poll->work);
>  }
>  EXPORT_SYMBOL_GPL(vhost_poll_queue);
>  
> @@ -510,7 +512,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>  		vhost_vq_reset(dev, vq);
>  		if (vq->handle_kick)
>  			vhost_poll_init(&vq->poll, vq->handle_kick,
> -					EPOLLIN, dev);
> +					EPOLLIN, dev, vq);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_init);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index b64ee4ef387d..d9b8abbe3a26 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -41,13 +41,15 @@ struct vhost_poll {
>  	struct vhost_work	work;
>  	__poll_t		mask;
>  	struct vhost_dev	*dev;
> +	struct vhost_virtqueue	*vq;
>  };
>  
>  void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
>  void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
>  
>  void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
> -		     __poll_t mask, struct vhost_dev *dev);
> +		     __poll_t mask, struct vhost_dev *dev,
> +		     struct vhost_virtqueue *vq);
>  int vhost_poll_start(struct vhost_poll *poll, struct file *file);
>  void vhost_poll_stop(struct vhost_poll *poll);
>  void vhost_poll_queue(struct vhost_poll *poll);
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:12PM -0500, Mike Christie wrote:
> Convert from vhost_work_queue to vhost_vq_work_queue.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vsock.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index c8e6087769a1..1dcbc8669f95 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -285,7 +285,7 @@ vhost_transport_send_pkt(struct sk_buff *skb)
>  		atomic_inc(&vsock->queued_replies);
>  
>  	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
> -	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
> +	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>  
>  	rcu_read_unlock();
>  	return len;
> @@ -582,7 +582,7 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>  	/* Some packets may have been queued before the device was started,
>  	 * let's kick the send worker to send them.
>  	 */
> -	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
> +	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
>  
>  	mutex_unlock(&vsock->dev.mutex);
>  	return 0;
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:13PM -0500, Mike Christie wrote:
> This patch separates the scsi cmd completion code paths so we can complete
> cmds based on their vq instead of having all cmds complete on the same
> worker/CPU. This will be useful with the next patches that allow us to
> create mulitple worker threads and bind them to different vqs, so we can
> have completions running on different threads/CPUs.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/vhost/scsi.c | 56 ++++++++++++++++++++------------------------
>  1 file changed, 26 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 3b0b556c57ef..ecb5cd7450b8 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -167,6 +167,7 @@ MODULE_PARM_DESC(max_io_vqs, "Set the max number of IO virtqueues a vhost scsi d
>  
>  struct vhost_scsi_virtqueue {
>  	struct vhost_virtqueue vq;
> +	struct vhost_scsi *vs;
>  	/*
>  	 * Reference counting for inflight reqs, used for flush operation. At
>  	 * each time, one reference tracks new commands submitted, while we
> @@ -181,6 +182,9 @@ struct vhost_scsi_virtqueue {
>  	struct vhost_scsi_cmd *scsi_cmds;
>  	struct sbitmap scsi_tags;
>  	int max_cmds;
> +
> +	struct vhost_work completion_work;
> +	struct llist_head completion_list;
>  };
>  
>  struct vhost_scsi {
> @@ -190,12 +194,8 @@ struct vhost_scsi {
>  
>  	struct vhost_dev dev;
>  	struct vhost_scsi_virtqueue *vqs;
> -	unsigned long *compl_bitmap;
>  	struct vhost_scsi_inflight **old_inflight;
>  
> -	struct vhost_work vs_completion_work; /* cmd completion work item */
> -	struct llist_head vs_completion_list; /* cmd completion queue */
> -
>  	struct vhost_work vs_event_work; /* evt injection work item */
>  	struct llist_head vs_event_list; /* evt injection queue */
>  
> @@ -368,10 +368,11 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
>  	} else {
>  		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
>  					struct vhost_scsi_cmd, tvc_se_cmd);
> -		struct vhost_scsi *vs = cmd->tvc_vhost;
> +		struct vhost_scsi_virtqueue *svq =  container_of(cmd->tvc_vq,
> +					struct vhost_scsi_virtqueue, vq);
>  
> -		llist_add(&cmd->tvc_completion_list, &vs->vs_completion_list);
> -		vhost_work_queue(&vs->dev, &vs->vs_completion_work);
> +		llist_add(&cmd->tvc_completion_list, &svq->completion_list);
> +		vhost_vq_work_queue(&svq->vq, &svq->completion_work);
>  	}
>  }
>  
> @@ -534,17 +535,17 @@ static void vhost_scsi_evt_work(struct vhost_work *work)
>   */
>  static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  {
> -	struct vhost_scsi *vs = container_of(work, struct vhost_scsi,
> -					vs_completion_work);
> +	struct vhost_scsi_virtqueue *svq = container_of(work,
> +				struct vhost_scsi_virtqueue, completion_work);
>  	struct virtio_scsi_cmd_resp v_rsp;
>  	struct vhost_scsi_cmd *cmd, *t;
>  	struct llist_node *llnode;
>  	struct se_cmd *se_cmd;
>  	struct iov_iter iov_iter;
> -	int ret, vq;
> +	bool signal = false;
> +	int ret;
>  
> -	bitmap_zero(vs->compl_bitmap, vs->dev.nvqs);
> -	llnode = llist_del_all(&vs->vs_completion_list);
> +	llnode = llist_del_all(&svq->completion_list);
>  	llist_for_each_entry_safe(cmd, t, llnode, tvc_completion_list) {
>  		se_cmd = &cmd->tvc_se_cmd;
>  
> @@ -564,21 +565,17 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
>  			      cmd->tvc_in_iovs, sizeof(v_rsp));
>  		ret = copy_to_iter(&v_rsp, sizeof(v_rsp), &iov_iter);
>  		if (likely(ret == sizeof(v_rsp))) {
> -			struct vhost_scsi_virtqueue *q;
> +			signal = true;
> +
>  			vhost_add_used(cmd->tvc_vq, cmd->tvc_vq_desc, 0);
> -			q = container_of(cmd->tvc_vq, struct vhost_scsi_virtqueue, vq);
> -			vq = q - vs->vqs;
> -			__set_bit(vq, vs->compl_bitmap);
>  		} else
>  			pr_err("Faulted on virtio_scsi_cmd_resp\n");
>  
>  		vhost_scsi_release_cmd_res(se_cmd);
>  	}
>  
> -	vq = -1;
> -	while ((vq = find_next_bit(vs->compl_bitmap, vs->dev.nvqs, vq + 1))
> -		< vs->dev.nvqs)
> -		vhost_signal(&vs->dev, &vs->vqs[vq].vq);
> +	if (signal)
> +		vhost_signal(&svq->vs->dev, &svq->vq);
>  }
>  
>  static struct vhost_scsi_cmd *
> @@ -1795,6 +1792,7 @@ static int vhost_scsi_set_features(struct vhost_scsi *vs, u64 features)
>  
>  static int vhost_scsi_open(struct inode *inode, struct file *f)
>  {
> +	struct vhost_scsi_virtqueue *svq;
>  	struct vhost_scsi *vs;
>  	struct vhost_virtqueue **vqs;
>  	int r = -ENOMEM, i, nvqs = vhost_scsi_max_io_vqs;
> @@ -1813,10 +1811,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  	}
>  	nvqs += VHOST_SCSI_VQ_IO;
>  
> -	vs->compl_bitmap = bitmap_alloc(nvqs, GFP_KERNEL);
> -	if (!vs->compl_bitmap)
> -		goto err_compl_bitmap;
> -
>  	vs->old_inflight = kmalloc_array(nvqs, sizeof(*vs->old_inflight),
>  					 GFP_KERNEL | __GFP_ZERO);
>  	if (!vs->old_inflight)
> @@ -1831,7 +1825,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  	if (!vqs)
>  		goto err_local_vqs;
>  
> -	vhost_work_init(&vs->vs_completion_work, vhost_scsi_complete_cmd_work);
>  	vhost_work_init(&vs->vs_event_work, vhost_scsi_evt_work);
>  
>  	vs->vs_events_nr = 0;
> @@ -1842,8 +1835,14 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  	vs->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
>  	vs->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
>  	for (i = VHOST_SCSI_VQ_IO; i < nvqs; i++) {
> -		vqs[i] = &vs->vqs[i].vq;
> -		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
> +		svq = &vs->vqs[i];
> +
> +		vqs[i] = &svq->vq;
> +		svq->vs = vs;
> +		init_llist_head(&svq->completion_list);
> +		vhost_work_init(&svq->completion_work,
> +				vhost_scsi_complete_cmd_work);
> +		svq->vq.handle_kick = vhost_scsi_handle_kick;
>  	}
>  	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV,
>  		       VHOST_SCSI_WEIGHT, 0, true, NULL);
> @@ -1858,8 +1857,6 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
>  err_vqs:
>  	kfree(vs->old_inflight);
>  err_inflight:
> -	bitmap_free(vs->compl_bitmap);
> -err_compl_bitmap:
>  	kvfree(vs);
>  err_vs:
>  	return r;
> @@ -1879,7 +1876,6 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
>  	kfree(vs->dev.vqs);
>  	kfree(vs->vqs);
>  	kfree(vs->old_inflight);
> -	bitmap_free(vs->compl_bitmap);
>  	kvfree(vs);
>  	return 0;
>  }
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:14PM -0500, Mike Christie wrote:
> Convert from vhost_work_queue to vhost_vq_work_queue.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index ecb5cd7450b8..3e86b5fbeca6 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -363,8 +363,9 @@ static void vhost_scsi_release_cmd(struct se_cmd *se_cmd)
>  	if (se_cmd->se_cmd_flags & SCF_SCSI_TMR_CDB) {
>  		struct vhost_scsi_tmf *tmf = container_of(se_cmd,
>  					struct vhost_scsi_tmf, se_cmd);
> +		struct vhost_virtqueue *vq = &tmf->svq->vq;
>  
> -		vhost_work_queue(&tmf->vhost->dev, &tmf->vwork);
> +		vhost_vq_work_queue(vq, &tmf->vwork);
>  	} else {
>  		struct vhost_scsi_cmd *cmd = container_of(se_cmd,
>  					struct vhost_scsi_cmd, tvc_se_cmd);
> @@ -1357,11 +1358,9 @@ static void vhost_scsi_ctl_handle_kick(struct vhost_work *work)
>  }
>  
>  static void
> -vhost_scsi_send_evt(struct vhost_scsi *vs,
> -		   struct vhost_scsi_tpg *tpg,
> -		   struct se_lun *lun,
> -		   u32 event,
> -		   u32 reason)
> +vhost_scsi_send_evt(struct vhost_scsi *vs, struct vhost_virtqueue *vq,
> +		    struct vhost_scsi_tpg *tpg, struct se_lun *lun,
> +		    u32 event, u32 reason)
>  {
>  	struct vhost_scsi_evt *evt;
>  
> @@ -1383,7 +1382,7 @@ vhost_scsi_send_evt(struct vhost_scsi *vs,
>  	}
>  
>  	llist_add(&evt->list, &vs->vs_event_list);
> -	vhost_work_queue(&vs->dev, &vs->vs_event_work);
> +	vhost_vq_work_queue(vq, &vs->vs_event_work);
>  }
>  
>  static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
> @@ -1397,7 +1396,8 @@ static void vhost_scsi_evt_handle_kick(struct vhost_work *work)
>  		goto out;
>  
>  	if (vs->vs_events_missed)
> -		vhost_scsi_send_evt(vs, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
> +		vhost_scsi_send_evt(vs, vq, NULL, NULL, VIRTIO_SCSI_T_NO_EVENT,
> +				    0);
>  out:
>  	mutex_unlock(&vq->mutex);
>  }
> @@ -2016,7 +2016,7 @@ vhost_scsi_do_plug(struct vhost_scsi_tpg *tpg,
>  		goto unlock;
>  
>  	if (vhost_has_feature(vq, VIRTIO_SCSI_F_HOTPLUG))
> -		vhost_scsi_send_evt(vs, tpg, lun,
> +		vhost_scsi_send_evt(vs, vq, tpg, lun,
>  				   VIRTIO_SCSI_T_TRANSPORT_RESET, reason);
>  unlock:
>  	mutex_unlock(&vq->mutex);
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:15PM -0500, Mike Christie wrote:
> vhost_work_queue is no longer used. Each driver is using the poll or vq
> based queueing, so remove vhost_work_queue.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c | 6 ------
>  drivers/vhost/vhost.h | 1 -
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 6968f8fc17e8..f812daf25648 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -263,12 +263,6 @@ static void vhost_work_flush_on(struct vhost_worker *worker)
>  	wait_for_completion(&flush.wait_event);
>  }
>  
> -void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> -{
> -	vhost_work_queue_on(dev->worker, work);
> -}
> -EXPORT_SYMBOL_GPL(vhost_work_queue);
> -
>  void vhost_vq_work_queue(struct vhost_virtqueue *vq, struct vhost_work *work)
>  {
>  	vhost_work_queue_on(vq->worker, work);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index d9b8abbe3a26..ef55fae2517c 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -45,7 +45,6 @@ struct vhost_poll {
>  };
>  
>  void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
> -void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
>  
>  void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
>  		     __poll_t mask, struct vhost_dev *dev,
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:16PM -0500, Mike Christie wrote:
> With one worker we will always send the scsi cmd responses then send the
> TMF rsp, because LIO will always complete the scsi cmds first then call
> into us to send the TMF response.
> 
> With multiple workers, the IO vq workers could be running while the
> TMF/ctl vq worker is so this has us do a flush before completing the TMF
> to make sure cmds are completed when it's work is later queued and run.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/scsi.c  | 22 +++++++++++++++++++---
>  drivers/vhost/vhost.c |  6 ++++++
>  drivers/vhost/vhost.h |  1 +
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 3e86b5fbeca6..48dba4fe2dac 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -1158,12 +1158,28 @@ static void vhost_scsi_tmf_resp_work(struct vhost_work *work)
>  {
>  	struct vhost_scsi_tmf *tmf = container_of(work, struct vhost_scsi_tmf,
>  						  vwork);
> -	int resp_code;
> +	struct vhost_virtqueue *ctl_vq, *vq;
> +	int resp_code, i;
> +
> +	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE) {
> +		/*
> +		 * Flush IO vqs that don't share a worker with the ctl to make
> +		 * sure they have sent their responses before us.
> +		 */
> +		ctl_vq = &tmf->vhost->vqs[VHOST_SCSI_VQ_CTL].vq;
> +		for (i = VHOST_SCSI_VQ_IO; i < tmf->vhost->dev.nvqs; i++) {
> +			vq = &tmf->vhost->vqs[i].vq;
> +
> +			if (vhost_vq_is_setup(vq) &&
> +			    vq->worker != ctl_vq->worker) {
> +				vhost_vq_flush(vq);
> +			}
> +		}
>  
> -	if (tmf->scsi_resp == TMR_FUNCTION_COMPLETE)
>  		resp_code = VIRTIO_SCSI_S_FUNCTION_SUCCEEDED;
> -	else
> +	} else {
>  		resp_code = VIRTIO_SCSI_S_FUNCTION_REJECTED;
> +	}
>  
>  	vhost_scsi_send_tmf_resp(tmf->vhost, &tmf->svq->vq, tmf->in_iovs,
>  				 tmf->vq_desc, &tmf->resp_iov, resp_code);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f812daf25648..1fa5e9a49092 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -275,6 +275,12 @@ void vhost_dev_flush(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_flush);
>  
> +void vhost_vq_flush(struct vhost_virtqueue *vq)
> +{
> +	vhost_work_flush_on(vq->worker);
> +}
> +EXPORT_SYMBOL_GPL(vhost_vq_flush);
> +
>  /* A lockless hint for busy polling code to exit the loop */
>  bool vhost_vq_has_work(struct vhost_virtqueue *vq)
>  {
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index ef55fae2517c..395707c680e5 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -53,6 +53,7 @@ int vhost_poll_start(struct vhost_poll *poll, struct file *file);
>  void vhost_poll_stop(struct vhost_poll *poll);
>  void vhost_poll_queue(struct vhost_poll *poll);
>  void vhost_dev_flush(struct vhost_dev *dev);
> +void vhost_vq_flush(struct vhost_virtqueue *vq);
>  
>  struct vhost_log {
>  	u64 addr;
> -- 
> 2.25.1

On Mon, Mar 27, 2023 at 09:17:17PM -0500, Mike Christie wrote:
> For vhost-scsi with 3 vqs and a workload like that tries to use those vqs
> like:
> 
> fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
> --ioengine=libaio --iodepth=128  --numjobs=3
> 
> the single vhost worker thread will become a bottlneck and we are stuck
> at around 500K IOPs no matter how many jobs, virtqueues, and CPUs are
> used.
> 
> To better utilize virtqueues and available CPUs, this patch allows
> userspace to create workers and bind them to vqs. You can have N workers
> per dev and also share N workers with M vqs.
> 
> With the patches and doing a worker per vq, we can scale to at least
> 16 vCPUs/vqs (that's my system limit) with the same command fio command
> above with numjobs=16:
> 
> fio --filename=/dev/sdb  --direct=1 --rw=randrw --bs=4k \
> --ioengine=libaio --iodepth=64  --numjobs=16
> 
> which gives around 2326K IOPs.
> 
> Note that for testing I dropped depth to 64 above because the vhost/virt
> layer supports only 1024 total commands per device. And the only tuning I
> did was set LIO's emulate_pr to 0 to avoid LIO's PR lock in the main IO
> path which becomes an issue at around 12 jobs/virtqueues.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/vhost/vhost.c            | 177 ++++++++++++++++++++++++++++---
>  drivers/vhost/vhost.h            |   4 +-
>  include/uapi/linux/vhost.h       |  22 ++++
>  include/uapi/linux/vhost_types.h |  15 +++
>  4 files changed, 204 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 1fa5e9a49092..e40699e83c6d 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -271,7 +271,11 @@ EXPORT_SYMBOL_GPL(vhost_vq_work_queue);
>  
>  void vhost_dev_flush(struct vhost_dev *dev)
>  {
> -	vhost_work_flush_on(dev->worker);
> +	struct vhost_worker *worker;
> +	unsigned long i;
> +
> +	xa_for_each(&dev->worker_xa, i, worker)
> +		vhost_work_flush_on(worker);
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_flush);
>  
> @@ -489,7 +493,6 @@ void vhost_dev_init(struct vhost_dev *dev,
>  	dev->umem = NULL;
>  	dev->iotlb = NULL;
>  	dev->mm = NULL;
> -	dev->worker = NULL;
>  	dev->iov_limit = iov_limit;
>  	dev->weight = weight;
>  	dev->byte_weight = byte_weight;
> @@ -499,7 +502,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>  	INIT_LIST_HEAD(&dev->read_list);
>  	INIT_LIST_HEAD(&dev->pending_list);
>  	spin_lock_init(&dev->iotlb_lock);
> -
> +	xa_init_flags(&dev->worker_xa, XA_FLAGS_ALLOC);
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
>  		vq = dev->vqs[i];
> @@ -562,32 +565,67 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>  	dev->mm = NULL;
>  }
>  
> -static void vhost_worker_free(struct vhost_dev *dev)
> +static void vhost_worker_put(struct vhost_dev *dev, struct vhost_worker *worker)
>  {
> -	struct vhost_worker *worker = dev->worker;
> -
>  	if (!worker)
>  		return;
>  
> -	dev->worker = NULL;
> +	if (!refcount_dec_and_test(&worker->refcount))
> +		return;
> +
>  	WARN_ON(!llist_empty(&worker->work_list));
>  	vhost_task_stop(worker->vtsk);
>  	kfree(worker);
>  }
>  
> +static void vhost_vq_detach_worker(struct vhost_virtqueue *vq)
> +{
> +	if (vq->worker)
> +		vhost_worker_put(vq->dev, vq->worker);
> +	vq->worker = NULL;
> +}
> +
> +static void vhost_workers_free(struct vhost_dev *dev)
> +{
> +	struct vhost_worker *worker;
> +	unsigned long i;
> +
> +	if (!dev->use_worker)
> +		return;
> +
> +	for (i = 0; i < dev->nvqs; i++)
> +		vhost_vq_detach_worker(dev->vqs[i]);
> +	/*
> +	 * Drop the refcount taken during allocation, and handle the default
> +	 * worker and the cases where userspace might have crashed or was lazy
> +	 * and did a VHOST_NEW_WORKER but not a VHOST_FREE_WORKER.
> +	 */
> +	xa_for_each(&dev->worker_xa, i, worker) {
> +		xa_erase(&dev->worker_xa, worker->id);
> +		vhost_worker_put(dev, worker);
> +	}
> +	xa_destroy(&dev->worker_xa);
> +}
> +
>  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker;
>  	struct vhost_task *vtsk;
>  	char name[TASK_COMM_LEN];
> +	int ret;
> +	u32 id;
>  
>  	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>  	if (!worker)
>  		return NULL;
>  
> -	dev->worker = worker;
>  	worker->kcov_handle = kcov_common_handle();
>  	init_llist_head(&worker->work_list);
> +	/*
> +	 * We increase the refcount for the initial creation and then
> +	 * later each time it's attached to a virtqueue.
> +	 */
> +	refcount_set(&worker->refcount, 1);
>  	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>  
>  	vtsk = vhost_task_create(vhost_worker, worker, name);
> @@ -596,14 +634,104 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
>  
>  	worker->vtsk = vtsk;
>  	vhost_task_start(vtsk);
> +
> +	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
> +	if (ret < 0)
> +		goto stop_worker;
> +	worker->id = id;
> +
>  	return worker;
>  
> +stop_worker:
> +	vhost_task_stop(vtsk);
>  free_worker:
>  	kfree(worker);
> -	dev->worker = NULL;
>  	return NULL;
>  }
>  
> +/* Caller must have device and virtqueue mutex */
> +static void __vhost_vq_attach_worker(struct vhost_virtqueue *vq,
> +				     struct vhost_worker *worker)
> +{
> +	refcount_inc(&worker->refcount);
> +	vhost_vq_detach_worker(vq);
> +	vq->worker = worker;
> +}
> +
> +/* Caller must have device and virtqueue mutex */
> +static int vhost_vq_attach_worker(struct vhost_virtqueue *vq,
> +				  struct vhost_vring_worker *info)
> +{
> +	unsigned long index = info->worker_id;
> +	struct vhost_dev *dev = vq->dev;
> +	struct vhost_worker *worker;
> +
> +	if (!dev->use_worker)
> +		return -EINVAL;
> +
> +	/*
> +	 * We don't support setting a worker on an active vq to make flushing
> +	 * and removal simple.
> +	 */
> +	if (vhost_vq_get_backend(vq))
> +		return -EBUSY;
> +
> +	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
> +	if (!worker || worker->id != info->worker_id)
> +		return -ENODEV;
> +
> +	__vhost_vq_attach_worker(vq, worker);
> +	return 0;
> +}
> +
> +/* Caller must have device mutex */
> +static int vhost_new_worker(struct vhost_dev *dev,
> +			    struct vhost_worker_state *info)
> +{
> +	struct vhost_worker *worker;
> +
> +	if (!dev->use_worker)
> +		return -EINVAL;
> +
> +	worker = vhost_worker_create(dev);
> +	if (!worker)
> +		return -ENOMEM;
> +
> +	info->worker_id = worker->id;
> +	return 0;
> +}
> +
> +/* Caller must have device mutex */
> +static int vhost_free_worker(struct vhost_dev *dev,
> +			     struct vhost_worker_state *info)
> +{
> +	unsigned long index = info->worker_id;
> +	struct vhost_worker *worker;
> +
> +	if (!dev->use_worker)
> +		return -EINVAL;
> +
> +	worker = xa_find(&dev->worker_xa, &index, UINT_MAX, XA_PRESENT);
> +	if (!worker || worker->id != info->worker_id)
> +		return -ENODEV;
> +
> +	/*
> +	 * We can free the worker if it's not attached to any virtqueues.
> +	 */
> +	if (refcount_read(&worker->refcount) != 1)
> +		return -EBUSY;
> +
> +	xa_erase(&dev->worker_xa, worker->id);
> +	/*
> +	 * Make sure if there was a flush that saw the worker in the XA that
> +	 * it has completed.
> +	 */
> +	vhost_work_flush_on(worker);
> +
> +	vhost_worker_put(dev, worker);
> +	return 0;
> +}
> +
>  /* Caller should have device mutex */
>  long vhost_dev_set_owner(struct vhost_dev *dev)
>  {
> @@ -624,7 +752,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  			goto err_worker;
>  
>  		for (i = 0; i < dev->nvqs; i++)
> -			dev->vqs[i]->worker = worker;
> +			__vhost_vq_attach_worker(dev->vqs[i], worker);
>  	}
>  
>  	err = vhost_dev_alloc_iovecs(dev);
> @@ -633,7 +761,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  
>  	return 0;
>  err_iovecs:
> -	vhost_worker_free(dev);
> +	vhost_workers_free(dev);
>  err_worker:
>  	vhost_detach_mm(dev);
>  err_mm:
> @@ -726,7 +854,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	dev->iotlb = NULL;
>  	vhost_clear_msg(dev);
>  	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
> -	vhost_worker_free(dev);
> +	vhost_workers_free(dev);
>  	vhost_detach_mm(dev);
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> @@ -1616,6 +1744,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  	struct eventfd_ctx *ctx = NULL;
>  	u32 __user *idxp = argp;
>  	struct vhost_virtqueue *vq;
> +	struct vhost_vring_worker w;
>  	struct vhost_vring_state s;
>  	struct vhost_vring_file f;
>  	u32 idx;
> @@ -1723,7 +1852,16 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
>  		if (copy_to_user(argp, &s, sizeof(s)))
>  			r = -EFAULT;
>  		break;
> -	default:
> +	case VHOST_ATTACH_VRING_WORKER:
> +		if (copy_from_user(&w, argp, sizeof(w))) {
> +			r = -EFAULT;
> +			break;
> +		}
> +		r = vhost_vq_attach_worker(vq, &w);
> +		if (!r && copy_to_user(argp, &w, sizeof(w)))
> +			r = -EFAULT;
> +		break;
> +default:
>  		r = -ENOIOCTLCMD;
>  	}
>  
> @@ -1776,6 +1914,7 @@ EXPORT_SYMBOL_GPL(vhost_init_device_iotlb);
>  /* Caller must have device mutex */
>  long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  {
> +	struct vhost_worker_state w;
>  	struct eventfd_ctx *ctx;
>  	u64 p;
>  	long r;
> @@ -1836,6 +1975,18 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
>  		if (ctx)
>  			eventfd_ctx_put(ctx);
>  		break;
> +	case VHOST_NEW_WORKER:
> +		r = vhost_new_worker(d, &w);
> +		if (!r && copy_to_user(argp, &w, sizeof(w)))
> +			r = -EFAULT;
> +		break;
> +	case VHOST_FREE_WORKER:
> +		if (copy_from_user(&w, argp, sizeof(w))) {
> +			r = -EFAULT;
> +			break;
> +		}
> +		r = vhost_free_worker(d, &w);
> +		break;
>  	default:
>  		r = -ENOIOCTLCMD;
>  		break;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 395707c680e5..a67ae8293c38 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -30,6 +30,8 @@ struct vhost_worker {
>  	struct vhost_task	*vtsk;
>  	struct llist_head	work_list;
>  	u64			kcov_handle;
> +	refcount_t		refcount;
> +	u32			id;
>  };
>  
>  /* Poll a file (eventfd or socket) */
> @@ -156,7 +158,6 @@ struct vhost_dev {
>  	struct vhost_virtqueue **vqs;
>  	int nvqs;
>  	struct eventfd_ctx *log_ctx;
> -	struct vhost_worker *worker;
>  	struct vhost_iotlb *umem;
>  	struct vhost_iotlb *iotlb;
>  	spinlock_t iotlb_lock;
> @@ -166,6 +167,7 @@ struct vhost_dev {
>  	int iov_limit;
>  	int weight;
>  	int byte_weight;
> +	struct xarray worker_xa;
>  	bool use_worker;
>  	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
>  			   struct vhost_iotlb_msg *msg);
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index 92e1b700b51c..7329e7f349dd 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -45,6 +45,23 @@
>  #define VHOST_SET_LOG_BASE _IOW(VHOST_VIRTIO, 0x04, __u64)
>  /* Specify an eventfd file descriptor to signal on log write. */
>  #define VHOST_SET_LOG_FD _IOW(VHOST_VIRTIO, 0x07, int)
> +/* By default, a device gets one vhost_worker that its virtqueues share. This
> + * command allows the owner of the device to create an additional vhost_worker
> + * for the device. It can later be bound to 1 or more of its virtqueues using
> + * the VHOST_ATTACH_VRING_WORKER command.
> + *
> + * This must be called after VHOST_SET_OWNER and the caller must be the owner
> + * of the device. The new thread will inherit caller's cgroups and namespaces,
> + * and will share the caller's memory space. The new thread will also be
> + * counted against the caller's RLIMIT_NPROC value.
> + */
> +#define VHOST_NEW_WORKER _IOW(VHOST_VIRTIO, 0x8, struct vhost_worker_state)
> +/* Free a worker created with VHOST_NEW_WORKER if it's not attached to any
> + * virtqueue. If userspace is not able to call this for workers its created,
> + * the kernel will free all the device's workers when the device is closed and
> + * the last reference to the device has been released.
> + */
> +#define VHOST_FREE_WORKER _IOR(VHOST_VIRTIO, 0x9, struct vhost_worker_state)
>  
>  /* Ring setup. */
>  /* Set number of descriptors in ring. This parameter can not
> @@ -70,6 +87,11 @@
>  #define VHOST_VRING_BIG_ENDIAN 1
>  #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
>  #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> +/* Attach a vhost_worker created with VHOST_NEW_WORKER to one of the device's
> + * virtqueues. This must be done before the virtqueue is active.
> + */
> +#define VHOST_ATTACH_VRING_WORKER _IOR(VHOST_VIRTIO, 0x15,		\
> +				       struct vhost_vring_worker)
>  
>  /* The following ioctls use eventfd file descriptors to signal and poll
>   * for events. */
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
> index c5690a8992d8..ad0fe2e721be 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -47,6 +47,21 @@ struct vhost_vring_addr {
>  	__u64 log_guest_addr;
>  };
>  
> +struct vhost_worker_state {
> +	/*
> +	 * For VHOST_NEW_WORKER the kernel will return the new vhost_worker id.
> +	 * For VHOST_FREE_WORKER this must be set to the id of the vhost_worker
> +	 * to free.
> +	 */
> +	int worker_id;
> +};
> +
> +struct vhost_vring_worker {
> +	unsigned int index;
> +	/* The id of the vhost_worker returned from VHOST_NEW_WORKER */
> +	int worker_id;
> +};
> +
>  /* no alignment requirement */
>  struct vhost_iotlb_msg {
>  	__u64 iova;
> -- 
> 2.25.1


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
