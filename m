Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D187CC7EE24
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 09:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 493394012D;
	Tue,  6 Jun 2023 09:50:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 493394012D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LbEcXzlN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R8_7ayR1DLfi; Tue,  6 Jun 2023 09:50:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B813F4011B;
	Tue,  6 Jun 2023 09:50:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B813F4011B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 867EFC0037;
	Tue,  6 Jun 2023 09:50:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF91EC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 09:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7EA5607A4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 09:50:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7EA5607A4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LbEcXzlN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDfhxilsSG7r
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 09:50:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 53A2C60BAF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 53A2C60BAF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686045028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HGEl4I8xBRdHB7nfeakkIzfvYFxcSfyHN+bo47NsPdQ=;
 b=LbEcXzlN6QPa3UgBqdOn12L8xJx0JWkIgpwGiE1n1sfU4u9yJfDl2P94eHkgp0uCdPdhw3
 dggshAuTdgrtMe9SeKMPNqZJFgfHc2Id3EA9KRKIiouq204FF4jslksFiELcIv/fP7uE3E
 0F/RCeQh++hNbZorUAMNB71XXeroz24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-7sWaVRo9PKqjUOAP4htYsw-1; Tue, 06 Jun 2023 05:50:26 -0400
X-MC-Unique: 7sWaVRo9PKqjUOAP4htYsw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso35067985e9.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Jun 2023 02:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686045018; x=1688637018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HGEl4I8xBRdHB7nfeakkIzfvYFxcSfyHN+bo47NsPdQ=;
 b=IJNflc0ghPMt3hhd58K/hDN2OW3l5/5WYjpZpu7RWHgmoo2EeApYONAvNiU6xggr3P
 6sLhirfxwLLHM4KVK8vYJnNehxC3NTLdqWQf5B81ykAKqi1bjXOI1aVm6X4J3bW+Em/h
 pM3FefOlUXDEA8BTWL3Um2jiFWWV0ImhrKxIWA5P9Je+V1hSUM+CTj+S3SL5Q65qBH1x
 d1ZndloMKqfNzW2zvn8lbr3MUBDo+yRJunEymHZ0xemH3ic68V6lXZJ1vURTkKkSdnYG
 bSVHcnutdFOyKM+ty90E/CV1I9DM9Ed8gjLuyJi6ut2RT4KX+2I16T5NOWMA2K6O4SJ1
 nYRg==
X-Gm-Message-State: AC+VfDzdTeYNEEQFxz26OKv7EHwl0jev/Az78vr7xtwL4vlgTsym9FVK
 k5slW7us9EoNvchmbQUvR7shiV+s2zX4Ej7XOVWVhQjYeWXAUTCHNYpVnMtkhozT9R+MENK4zcq
 QJNnV3tNyvDFw5RJI58WAFGyWq9VHDaKtNGdAo3Kkqw==
X-Received: by 2002:a7b:cb92:0:b0:3f7:29c4:8fbd with SMTP id
 m18-20020a7bcb92000000b003f729c48fbdmr1624279wmi.27.1686045018624; 
 Tue, 06 Jun 2023 02:50:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4rryWeAKMeuFy2CkxHtn0mSO7jLLR++ZlpgWP26fv8VfufF/ZSQF4DqK9fEpCk+7wX0yPUDg==
X-Received: by 2002:a7b:cb92:0:b0:3f7:29c4:8fbd with SMTP id
 m18-20020a7bcb92000000b003f729c48fbdmr1624264wmi.27.1686045018352; 
 Tue, 06 Jun 2023 02:50:18 -0700 (PDT)
Received: from sgarzare-redhat (93-44-29-47.ip95.fastwebnet.it. [93.44.29.47])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003f60482024fsm13536569wmc.30.2023.06.06.02.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:50:17 -0700 (PDT)
Date: Tue, 6 Jun 2023 11:49:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] vhost: Fix crash during early
 vhost_transport_send_pkt calls
Message-ID: <yocmdeykp2no67yaopvc3on6hqmwt2gavuhchxfl3appfsapg2@qhcor7x5e7mi>
References: <20230605185730.6560-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20230605185730.6560-1-michael.christie@oracle.com>
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

On Mon, Jun 05, 2023 at 01:57:30PM -0500, Mike Christie wrote:
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
>vhost_worker and vhost_task pointers, so we can now hit the bug above.
>
>This patch embeds the vhost_worker in the vhost_dev, so we can just
>check the worker.vtsk pointer to check if VHOST_SET_OWNER has been done
>like before.
>
>Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")

We should add:

Reported-by: syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com

>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/vhost.c | 50 +++++++++++++++----------------------------
> drivers/vhost/vhost.h |  2 +-
> 2 files changed, 18 insertions(+), 34 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 074273020849..0ad9fea7c170 100644
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
>@@ -456,7 +456,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 	dev->umem = NULL;
> 	dev->iotlb = NULL;
> 	dev->mm = NULL;
>-	dev->worker = NULL;
>+	memset(&dev->worker, 0, sizeof(dev->worker));
> 	dev->iov_limit = iov_limit;
> 	dev->weight = weight;
> 	dev->byte_weight = byte_weight;
>@@ -530,47 +530,31 @@ static void vhost_detach_mm(struct vhost_dev *dev)
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
>+	init_llist_head(&dev->worker.work_list);
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

vhost_work_queue() is called by vhost_transport_send_pkt() without
holding vhost_dev.mutex (like vhost_poll_queue() in several places).

If vhost_work_queue() finds dev->worker.vtsk not NULL, how can we
be sure that for example `work_list` has been initialized?

Maybe I'm overthinking since we didn't have this problem before or the
race is really short that it never happened.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
