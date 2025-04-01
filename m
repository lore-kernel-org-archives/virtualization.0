Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF9204C39
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515304; cv=none; b=Y1dLYHp7pLvZ8wq4og+8qloldEcM3QjdEnzZv1FkjOec13uOZs5JpFzWfDyGfAKlnTTtrcnnu+3mG0C1GnzZ8eX7hmtxWb81rFJi3eqGLdtNEGCq9WDCMbn3IscTlZ7R4HNUR/9Uh1wFX8pTr62YoZZGD8LhBIpBvrPG3sj68TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515304; c=relaxed/simple;
	bh=ZXVTBdQxmjCjU3ulgpfsPSQCkooAmJuUdjJcSaB1g1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dadYYVkZB6IWpwoDFqW665RvnZQQEOJ53qYIhPx19vUiaAw+Hp5z/YDUjLui4rlS7JprSRP5kZhh3nHz7jW7dM6F5jFg7kSCxuHMoN+LBrEz9lxEJhTfolZc7Sov9y7k9qANi997XYMXB8MNfvRzanHlOLWRuuZNoQT0ryD7OsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJw7xLHD; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJw7xLHD"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33EBB83A3F
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:48:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pf5Re7VcIo9I for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Apr 2025 13:48:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 75AF3821DB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75AF3821DB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DJw7xLHD
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 75AF3821DB
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743515300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R7GU5F4nSqJyry11vrhXMIOMNpBvoJMOeaJENZ/IuO4=;
	b=DJw7xLHDbKx9hCGrp+EboLvMcraxg1N0Uh+LIQoIGeSC9m68pSRgQu3zpr8ZF6bLD9icuk
	1x5Z+c2b4MoodBgqFzdjMwiqDu4RfsgQU3bGOkAnvxehDwvBCCsDjDzuBYzGWdCEh8V2dx
	zWhOktTKBoD5bH+8ulG9iZ70e/gAYMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-0FRmW0_lNcKBTjN8U6fT4w-1; Tue, 01 Apr 2025 09:48:19 -0400
X-MC-Unique: 0FRmW0_lNcKBTjN8U6fT4w-1
X-Mimecast-MFC-AGG-ID: 0FRmW0_lNcKBTjN8U6fT4w_1743515298
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391459c0395so2277145f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Apr 2025 06:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515298; x=1744120098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7GU5F4nSqJyry11vrhXMIOMNpBvoJMOeaJENZ/IuO4=;
        b=Hc+O3BG+USgj7aytzLScIRvsIc0GXY+ZuaNHEoj4cFI7Fv8jww3eH/6xfXFQnerlRp
         TkM0tGFsfgwjnj0z+YQt6oVJiVibf+NEFb+JGWjgJlQ0n8LqwTWcwgpwrHrDvr9d11Ni
         DClVduUZPeAQ+FmDb7sNJWLRoYFtHMmGwZYfdfACwF8XNWp4EMpSr6gx9QkLhqXDIAsw
         ak8poDvuWxkmv0VRO5iYEK1a7PEDY4e6cypIC4D/cEPQeTsRA+j4Q77aYj6ZyshoLa2X
         RP5pe2STvt+fxGi9GnPab21rU9e5E6XPmt9Tvu/UaohZ7S908YPM2tuotNhlw+XhqUn6
         1HLg==
X-Forwarded-Encrypted: i=1; AJvYcCWdR0NBRlk9a6j4TEAR67D7QUUcBGkbDmF9Zs5E2ktMbFZpwmN2xVoMUoU5uySMtVh8Ql7YNoUMg6QnQoVQkA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxZJ4L7XIfIEHgcYbGiZmdkmVHxzZQ+cEsSpP53rUk7gW40v3K2
	TF6VyibH21zbxYZWLcLf1vcbhgI+xbS5r9Nznl0rcV7VYby+poM6OSsNCcKHArnlJkATlPIn4sv
	5/Fk3Sc7JnfFbqAQ9xBVS7MtfFv5oYWg6fG3CcJjlnI30Q5qjpuzk/r7JJxEv46NDJhOQjLHJ2V
	J44LM=
X-Gm-Gg: ASbGncuetdlgbfZczvrxjwvV/Os2elbKrS4dbDV90pEqNKNJUNzBkinYeWssW51UBtX
	bM60EBCdFM9napN7ZedrE4S0DeNYZCM/8qluIPJJkVJddqEw86xPy0G5hGUkeUia3UwTMcSWXtg
	3sQXeCFrUIK+qiNQzdwjfSgeJw33oXk/uZm+b1TdS3D4yghyyXVqbHZJMLZj4nrvL6CgKM/dSTH
	cQ6RZb9bgUEkLPjcXCoQPHFyc2LL9zPl+hwsKCKXhmBMMrdSz3R6sf3BknhW+qsUil8JVBlkntZ
	XtfU/AvyDIJJTJuKe+Mf2UZXGC1tEY2XyAeNBoAQOCNfwJ4V8WICkwab5oo=
X-Received: by 2002:a5d:5848:0:b0:390:fe8b:f442 with SMTP id ffacd0b85a97d-39c12119cc3mr9449913f8f.54.1743515297742;
        Tue, 01 Apr 2025 06:48:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHwq+RFHEcdC7l4xxfCK53cCh/ZW01zsvBzyQxNNavy2YTN7WUbI12TI74GK5OqAFQc28skQ==
X-Received: by 2002:a5d:5848:0:b0:390:fe8b:f442 with SMTP id ffacd0b85a97d-39c12119cc3mr9449891f8f.54.1743515297292;
        Tue, 01 Apr 2025 06:48:17 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0dcc66a4sm13129284f8f.42.2025.04.01.06.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:48:16 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:48:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 4/8] vhost: Introduce vhost_worker_ops in vhost_worker
Message-ID: <3hsgi4a2kj5fg65zz7q463ypxbstf2x73avupayyrexjonkheo@utoyktego6as>
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
X-Mimecast-MFC-PROC-ID: slsc-mgSYUVsdQWsptzOXII_K63WraEye-EvUoXsj90_1743515298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:48PM +0800, Cindy Lu wrote:
>Abstract vhost worker operations (create/stop/wakeup) into an ops
>structure to prepare for kthread mode support.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 63 ++++++++++++++++++++++++++++++-------------
> drivers/vhost/vhost.h | 11 ++++++++
> 2 files changed, 56 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 20571bd6f7bd..c162ad772f8f 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker *worker,
> 		 * test_and_set_bit() implies a memory barrier.
> 		 */
> 		llist_add(&work->node, &worker->work_list);
>-		vhost_task_wake(worker->vtsk);
>+		worker->ops->wakeup(worker);
> 	}
> }
>
>@@ -706,7 +706,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
>
> 	WARN_ON(!llist_empty(&worker->work_list));
> 	xa_erase(&dev->worker_xa, worker->id);
>-	vhost_task_stop(worker->vtsk);
>+	worker->ops->stop(worker);
> 	kfree(worker);
> }
>
>@@ -729,42 +729,69 @@ static void vhost_workers_free(struct vhost_dev *dev)
> 	xa_destroy(&dev->worker_xa);
> }
>
>+static void vhost_task_wakeup(struct vhost_worker *worker)
>+{
>+	return vhost_task_wake(worker->vtsk);
>+}
>+
>+static void vhost_task_do_stop(struct vhost_worker *worker)
>+{
>+	return vhost_task_stop(worker->vtsk);
>+}
>+
>+static int vhost_task_worker_create(struct vhost_worker *worker,
>+				    struct vhost_dev *dev, const char *name)
>+{
>+	struct vhost_task *vtsk;
>+	u32 id;
>+	int ret;
>+
>+	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
>+				 worker, name);
>+	if (IS_ERR(vtsk))
>+		return PTR_ERR(vtsk);
>+
>+	worker->vtsk = vtsk;
>+	vhost_task_start(vtsk);
>+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
>+	if (ret < 0) {
>+		vhost_task_do_stop(worker);
>+		return ret;
>+	}

In the final code, xa_alloc() is duplicated among the functions that 
create ktrhead or task, might it make sense to leave it out and do it in 
vhost_worker_create() ?

Thanks,
Stefano

>+	worker->id = id;
>+	return 0;
>+}
>+
>+static const struct vhost_worker_ops vhost_task_ops = {
>+	.create = vhost_task_worker_create,
>+	.stop = vhost_task_do_stop,
>+	.wakeup = vhost_task_wakeup,
>+};
>+
> static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
>-	struct vhost_task *vtsk;
> 	char name[TASK_COMM_LEN];
> 	int ret;
>-	u32 id;
>+	const struct vhost_worker_ops *ops = &vhost_task_ops;
>
> 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> 	if (!worker)
> 		return NULL;
>
> 	worker->dev = dev;
>+	worker->ops = ops;
> 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>
>-	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
>-				 worker, name);
>-	if (IS_ERR(vtsk))
>-		goto free_worker;
>-
> 	mutex_init(&worker->mutex);
> 	init_llist_head(&worker->work_list);
> 	worker->kcov_handle = kcov_common_handle();
>-	worker->vtsk = vtsk;
>-
>-	vhost_task_start(vtsk);
>-
>-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
>+	ret = ops->create(worker, dev, name);
> 	if (ret < 0)
>-		goto stop_worker;
>-	worker->id = id;
>+		goto free_worker;
>
> 	return worker;
>
>-stop_worker:
>-	vhost_task_stop(vtsk);
> free_worker:
> 	kfree(worker);
> 	return NULL;
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 19bb94922a0e..98895e299efa 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -26,6 +26,16 @@ struct vhost_work {
> 	unsigned long		flags;
> };
>
>+struct vhost_worker;
>+struct vhost_dev;
>+
>+struct vhost_worker_ops {
>+	int (*create)(struct vhost_worker *worker, struct vhost_dev *dev,
>+		      const char *name);
>+	void (*stop)(struct vhost_worker *worker);
>+	void (*wakeup)(struct vhost_worker *worker);
>+};
>+
> struct vhost_worker {
> 	struct vhost_task	*vtsk;
> 	struct vhost_dev	*dev;
>@@ -36,6 +46,7 @@ struct vhost_worker {
> 	u32			id;
> 	int			attachment_cnt;
> 	bool			killed;
>+	const struct vhost_worker_ops *ops;
> };
>
> /* Poll a file (eventfd or socket) */
>-- 
>2.45.0
>

