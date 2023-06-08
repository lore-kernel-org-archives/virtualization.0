Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55579C7EE25
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 08:39:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C62AF83A45;
	Thu,  8 Jun 2023 08:39:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C62AF83A45
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HC+c/oFs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xtmVkqlzM82z; Thu,  8 Jun 2023 08:39:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E9FB383A42;
	Thu,  8 Jun 2023 08:39:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9FB383A42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF045C0037;
	Thu,  8 Jun 2023 08:39:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A106FC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 08:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73ED961095
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 08:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73ED961095
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HC+c/oFs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WYEjLdiMmKFw
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 08:39:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B16E60B57
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B16E60B57
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686213590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swwCKTRn6c8GkV2wh6jw5Zsdy55spmnNctiOyPdbsG0=;
 b=HC+c/oFso9fIjY8SMwh6rwdEU1IMUEhyQErZuT7QFdZ+E+UTg/0UiqyF+L7zn2aj33LFJV
 bEUBGKY6KyamZDxFyYn8uHXsxzoqhLE5sqD4bOuo2s3MKjwTJJByboIQ9fhxp3F7L5TCo2
 qVQ/dpmtqbPMTkDc+7OlPOFVUzDp4qw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-LC9PQ2ljOMuXuVXx47EUGQ-1; Thu, 08 Jun 2023 04:39:48 -0400
X-MC-Unique: LC9PQ2ljOMuXuVXx47EUGQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e8c24a92so1209625e9.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 01:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686213587; x=1688805587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swwCKTRn6c8GkV2wh6jw5Zsdy55spmnNctiOyPdbsG0=;
 b=Jc5TVNopWP9A8vJr0BX3N4ZJF+fwS1inXWn2e8D/XKOUTer4BmnA2HdSEiBOhCDAFI
 mcaW+DAZIaqw+p7ycUKKru7e02XaljdC+QD2gcG/t1DZY1y8a9/lKjl7fNHsvGW1Ipem
 Y5tovO5tXiFwwfYe8ANS2rXPS+PVsqkV1roVtB+Stc95c0iBvPGwP4nGDblhvoxgyZR4
 V2nypkJ4UvaGtZYXV2GXoZZfe5vohNMIbMk3gU/78xCMV7sOS/UymCzVlwOmlRhD85a8
 lW2/lWvqxoSPm2yhRNLVAu29NFk/Bqo83K0lEhFEMAgsN4AuzHstzfohB0ockKLdA95h
 aG9A==
X-Gm-Message-State: AC+VfDwUc+a6F1LDLzefFqXQlvFGmojUDP43X4EgXcjODm0rhoCDJp7J
 C/t1x6zbPqyBfbB/L3h1AFtdrJ1R55KKe76hCanQN19e47gvWFuv5OPa71rwhIIFJZIYmsjkpoY
 4EpYXXIyQiNpxDd7cEAT3t9XNucCHS+C78B2RwQeBbQ==
X-Received: by 2002:a05:600c:251:b0:3f4:f4d1:5c28 with SMTP id
 17-20020a05600c025100b003f4f4d15c28mr803447wmj.24.1686213587731; 
 Thu, 08 Jun 2023 01:39:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wMvl9fjnCw3EL/CXx+7u90XGnlgYAomwinkA4VMkOvLEa7kN17vZ1VjexM+Un510s0mabnQ==
X-Received: by 2002:a05:600c:251:b0:3f4:f4d1:5c28 with SMTP id
 17-20020a05600c025100b003f4f4d15c28mr803438wmj.24.1686213587437; 
 Thu, 08 Jun 2023 01:39:47 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-111.business.telecomitalia.it.
 [87.12.25.111]) by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003f195d540d9sm4519246wmj.14.2023.06.08.01.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 01:39:46 -0700 (PDT)
Date: Thu, 8 Jun 2023 10:39:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/2] vhost: Fix crash during early
 vhost_transport_send_pkt calls
Message-ID: <somiozlfylajqwmtyaaihbsilahf7nb2irq2q2sy2dahxiy4yv@xznv7bpg677x>
References: <20230607192338.6041-1-michael.christie@oracle.com>
 <20230607192338.6041-2-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230607192338.6041-2-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 mst@redhat.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jun 07, 2023 at 02:23:37PM -0500, Mike Christie wrote:
>If userspace does VHOST_VSOCK_SET_GUEST_CID before VHOST_SET_OWNER we
>can race where:
>1. thread0 calls vhost_transport_send_pkt -> vhost_work_queue
>2. thread1 does VHOST_SET_OWNER which calls vhost_worker_create.
>3. vhost_worker_create will set the dev->worker pointer before setting
>the worker->vtsk pointer.
>4. thread0's vhost_work_queue will see the dev->worker pointer is
>set and try to call vhost_task_wake using not yet set worker->vtsk
>pointer.
>5. We then crash since vtsk is NULL.
>
>Before commit 6e890c5d5021 ("vhost: use vhost_tasks for worker
>threads"), we only had the worker pointer so we could just check it to
>see if VHOST_SET_OWNER has been done. After that commit we have the
>vhost_worker and vhost_task pointer, so we can now hit the bug above.
>
>This patch embeds the vhost_worker in the vhost_dev and moves the work
>list initialization back to vhost_dev_init, so we can just check the
>worker.vtsk pointer to check if VHOST_SET_OWNER has been done like
>before.
>

We should add:

Reported-by: syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com

Michael, can it be added when apply?

>Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/vhost.c | 50 +++++++++++++++----------------------------
> drivers/vhost/vhost.h |  2 +-
> 2 files changed, 18 insertions(+), 34 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 074273020849..7a9f93eae225 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -235,7 +235,7 @@ void vhost_dev_flush(struct vhost_dev *dev)
> {
> 	struct vhost_flush_struct flush;
>
>-	if (dev->worker) {
>+	if (dev->worker.vtsk) {
> 		init_completion(&flush.wait_event);
> 		vhost_work_init(&flush.work, vhost_flush_work);
>
>@@ -247,7 +247,7 @@ EXPORT_SYMBOL_GPL(vhost_dev_flush);
>
> void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> {
>-	if (!dev->worker)
>+	if (!dev->worker.vtsk)
> 		return;
>
> 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>@@ -255,8 +255,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> 		 * sure it was not in the list.
> 		 * test_and_set_bit() implies a memory barrier.
> 		 */
>-		llist_add(&work->node, &dev->worker->work_list);
>-		vhost_task_wake(dev->worker->vtsk);
>+		llist_add(&work->node, &dev->worker.work_list);
>+		vhost_task_wake(dev->worker.vtsk);
> 	}
> }
> EXPORT_SYMBOL_GPL(vhost_work_queue);
>@@ -264,7 +264,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
> /* A lockless hint for busy polling code to exit the loop */
> bool vhost_has_work(struct vhost_dev *dev)
> {
>-	return dev->worker && !llist_empty(&dev->worker->work_list);
>+	return !llist_empty(&dev->worker.work_list);
> }
> EXPORT_SYMBOL_GPL(vhost_has_work);
>
>@@ -456,7 +456,8 @@ void vhost_dev_init(struct vhost_dev *dev,
> 	dev->umem = NULL;
> 	dev->iotlb = NULL;
> 	dev->mm = NULL;
>-	dev->worker = NULL;
>+	memset(&dev->worker, 0, sizeof(dev->worker));
>+	init_llist_head(&dev->worker.work_list);
> 	dev->iov_limit = iov_limit;
> 	dev->weight = weight;
> 	dev->byte_weight = byte_weight;
>@@ -530,47 +531,30 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>
> static void vhost_worker_free(struct vhost_dev *dev)
> {
>-	struct vhost_worker *worker = dev->worker;
>-
>-	if (!worker)
>+	if (!dev->worker.vtsk)
> 		return;
>
>-	dev->worker = NULL;
>-	WARN_ON(!llist_empty(&worker->work_list));
>-	vhost_task_stop(worker->vtsk);
>-	kfree(worker);
>+	WARN_ON(!llist_empty(&dev->worker.work_list));
>+	vhost_task_stop(dev->worker.vtsk);
>+	dev->worker.kcov_handle = 0;
>+	dev->worker.vtsk = NULL;
> }
>
> static int vhost_worker_create(struct vhost_dev *dev)
> {
>-	struct vhost_worker *worker;
> 	struct vhost_task *vtsk;
> 	char name[TASK_COMM_LEN];
>-	int ret;
>-
>-	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>-	if (!worker)
>-		return -ENOMEM;
>
>-	dev->worker = worker;
>-	worker->kcov_handle = kcov_common_handle();
>-	init_llist_head(&worker->work_list);
> 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>
>-	vtsk = vhost_task_create(vhost_worker, worker, name);
>-	if (!vtsk) {
>-		ret = -ENOMEM;
>-		goto free_worker;
>-	}
>+	vtsk = vhost_task_create(vhost_worker, &dev->worker, name);
>+	if (!vtsk)
>+		return -ENOMEM;
>
>-	worker->vtsk = vtsk;
>+	dev->worker.kcov_handle = kcov_common_handle();
>+	dev->worker.vtsk = vtsk;

Okay, I think we are safe for now for the problem I highlighted in v1:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 	vhost_task_start(vtsk);
> 	return 0;
>-
>-free_worker:
>-	kfree(worker);
>-	dev->worker = NULL;
>-	return ret;
> }
>
> /* Caller should have device mutex */
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 0308638cdeee..305ec8593d46 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -154,7 +154,7 @@ struct vhost_dev {
> 	struct vhost_virtqueue **vqs;
> 	int nvqs;
> 	struct eventfd_ctx *log_ctx;
>-	struct vhost_worker *worker;
>+	struct vhost_worker worker;
> 	struct vhost_iotlb *umem;
> 	struct vhost_iotlb *iotlb;
> 	spinlock_t iotlb_lock;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
