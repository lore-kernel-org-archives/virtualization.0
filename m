Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F825C433ED
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 15:33:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C00F610FA
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 15:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C00F610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03F9E4058A;
	Tue,  4 May 2021 15:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jimMSaeacIoR; Tue,  4 May 2021 15:33:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56C2F4010D;
	Tue,  4 May 2021 15:33:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3487AC000D;
	Tue,  4 May 2021 15:33:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D3A7C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5D7276085E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cDQg5CZhGMz7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:33:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68A3B6082D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620142419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ji5ls+56TwAjvqf4kak7tbLdpSW++VUm4c3Gl33kdU=;
 b=VFWYwf/Xp4x5OnG8FcEorjs/IupleDDvuevXxyiwPBYzvDe6Thfjue+mAIl6Z+S4zalAJo
 LxjTEVMGabdr8i2UhPLuDNCG9XIsbuFY0jqO7HNbOxcvyo0sVkPmq54yUP6vk5VtYAJvOt
 QeiRLZx7Eaah8oiYhN+zq8GYCZKzNw4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-CZkvS1tyPzS9Gu-S4s8Nog-1; Tue, 04 May 2021 11:33:35 -0400
X-MC-Unique: CZkvS1tyPzS9Gu-S4s8Nog-1
Received: by mail-ej1-f71.google.com with SMTP id
 qk30-20020a170906d9deb02903916754e1b6so3273398ejb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 May 2021 08:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+ji5ls+56TwAjvqf4kak7tbLdpSW++VUm4c3Gl33kdU=;
 b=kslbyaKXJzUrMdKUCnhry27U+rrY3w6o/TODdjvBiNbUMolsoKYTsqV8rlazZ5fsQh
 xT14kI0oFWmxmNQVJf4nEKtlzhjVr32WxxY32xbWX8QeWeijQspg/1ePD11sLb6MipP8
 LBi73T8EDo88BV3W4NlYUMvmOiSFPwJ+bnnyYH/DNrhV8boxiPUKUs4/g1C/+JQZM3g6
 DiWxUXuE64/Zf9Tie9pKSAi0zCux4Wz69Xi8C9E7zos5P/zpfz6GMtHKbb95QRiYtbXQ
 bL6GntgQEbo4MZSxmMubqYBopNeuzUhf7rh+qG5do3kndCzYYwrSr+2yoGT+mLUCwOaU
 mkSQ==
X-Gm-Message-State: AOAM532MnVd0BkPXD6dRFSGlsF7dFYVm5ehAopbQLVvl7mtVUsrNjFil
 1oaeGxJDa228MVDbhsjrMnBgI6P7A61RvvNep6y5J75qi/66bc+rKXbMdcQuuiW5+4LeALiWcmE
 LoCK59e8hFKjsM2GFghsQHOxxub0/EO3rPZCuEPF8mg==
X-Received: by 2002:a17:907:3f08:: with SMTP id
 hq8mr8233559ejc.240.1620142414170; 
 Tue, 04 May 2021 08:33:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcbH49MxbJKliy+8iG1vTnbSX7w0inpOwhS/bq8lN7JzoRETGuIGTPbbfVN6RZunAh+1NmXg==
X-Received: by 2002:a17:907:3f08:: with SMTP id
 hq8mr8233539ejc.240.1620142413948; 
 Tue, 04 May 2021 08:33:33 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id z17sm1583583ejc.69.2021.05.04.08.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 08:33:33 -0700 (PDT)
Date: Tue, 4 May 2021 17:33:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH RFC 12/14] vhost: add vhost_dev pointer to vhost_work
Message-ID: <20210504153331.e2c34qii25kvpxdf@steredhat>
References: <20210428223714.110486-1-michael.christie@oracle.com>
 <20210428223714.110486-14-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210428223714.110486-14-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, mst@redhat.com
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

On Wed, Apr 28, 2021 at 05:37:12PM -0500, Mike Christie wrote:
>The next patch allows a vhost_worker to handle different devices. To
>prepare for that, this patch adds a pointer to the device on the work so
>we can get to the different mms in the vhost_worker thread.
>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/scsi.c  |  7 ++++---
> drivers/vhost/vhost.c | 24 ++++++++++++++----------
> drivers/vhost/vhost.h | 10 ++++++----
> drivers/vhost/vsock.c |  3 ++-
> 4 files changed, 26 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>index 2f84cf602ab3..0e862503b6a8 100644
>--- a/drivers/vhost/scsi.c
>+++ b/drivers/vhost/scsi.c
>@@ -1808,7 +1808,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
> 	if (!vqs)
> 		goto err_vqs;
>
>-	vhost_work_init(&vs->vs_event_work, vhost_scsi_evt_work);
>+	vhost_work_init(&vs->dev, &vs->vs_event_work, vhost_scsi_evt_work);
>
> 	vs->vs_events_nr = 0;
> 	vs->vs_events_missed = false;
>@@ -1823,7 +1823,7 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
> 		vqs[i] = &svq->vq;
> 		svq->vs = vs;
> 		init_llist_head(&svq->completion_list);
>-		vhost_work_init(&svq->completion_work,
>+		vhost_work_init(&vs->dev, &svq->completion_work,
> 				vhost_scsi_complete_cmd_work);
> 		svq->vq.handle_kick = vhost_scsi_handle_kick;
> 	}
>@@ -2017,7 +2017,8 @@ static int vhost_scsi_port_link(struct se_portal_group *se_tpg,
> 	if (!tmf)
> 		return -ENOMEM;
> 	INIT_LIST_HEAD(&tmf->queue_entry);
>-	vhost_work_init(&tmf->vwork, vhost_scsi_tmf_resp_work);
>+	vhost_work_init(&tpg->vhost_scsi->dev, &tmf->vwork,
>+			 vhost_scsi_tmf_resp_work);
>

`checkpatch.pl --strict` complains here:

CHECK: Alignment should match open parenthesis
#74: FILE: drivers/vhost/scsi.c:2036:
+	vhost_work_init(&tpg->vhost_scsi->dev, &tmf->vwork,
+			 vhost_scsi_tmf_resp_work);

> 	mutex_lock(&vhost_scsi_mutex);
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index fecdae0d18c7..7ba0c303bb98 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -181,10 +181,12 @@ static int vhost_poll_wakeup(wait_queue_entry_t *wait, unsigned mode, int sync,
> 	return 0;
> }
>
>-void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn)
>+void vhost_work_init(struct vhost_dev *dev, struct vhost_work *work,
>+		     vhost_work_fn_t fn)
> {
> 	clear_bit(VHOST_WORK_QUEUED, &work->flags);
> 	work->fn = fn;
>+	work->dev = dev;
> }
> EXPORT_SYMBOL_GPL(vhost_work_init);
>
>@@ -200,7 +202,7 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
> 	poll->wqh = NULL;
> 	poll->vq = vq;
>
>-	vhost_work_init(&poll->work, fn);
>+	vhost_work_init(dev, &poll->work, fn);
> }
> EXPORT_SYMBOL_GPL(vhost_poll_init);
>
>@@ -269,12 +271,13 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> }
> EXPORT_SYMBOL_GPL(vhost_work_queue);
>
>-static void vhost_work_dev_flush_on(struct vhost_worker *worker)
>+static void vhost_work_dev_flush_on(struct vhost_dev *dev,
>+				    struct vhost_worker *worker)
> {
> 	struct vhost_flush_struct flush;
>
> 	init_completion(&flush.wait_event);
>-	vhost_work_init(&flush.work, vhost_flush_work);
>+	vhost_work_init(dev, &flush.work, vhost_flush_work);
>
> 	vhost_work_queue_on(&flush.work, worker);
> 	wait_for_completion(&flush.wait_event);
>@@ -285,7 +288,7 @@ void vhost_work_dev_flush(struct vhost_dev *dev)
> 	int i;
>
> 	for (i = 0; i < dev->num_workers; i++)
>-		vhost_work_dev_flush_on(dev->workers[i]);
>+		vhost_work_dev_flush_on(dev, dev->workers[i]);
> }
> EXPORT_SYMBOL_GPL(vhost_work_dev_flush);
>
>@@ -305,7 +308,7 @@ EXPORT_SYMBOL_GPL(vhost_has_work);
>
> void vhost_vq_work_flush(struct vhost_virtqueue *vq)
> {
>-	vhost_work_dev_flush_on(vq->worker);
>+	vhost_work_dev_flush_on(vq->dev, vq->worker);
> }
> EXPORT_SYMBOL_GPL(vhost_vq_work_flush);
>
>@@ -572,14 +575,15 @@ static void vhost_attach_cgroups_work(struct vhost_work *work)
> 	s->ret = cgroup_attach_task_all(s->owner, current);
> }
>
>-static int vhost_attach_cgroups_on(struct vhost_worker *worker)
>+static int vhost_attach_cgroups_on(struct vhost_dev *dev,
>+				   struct vhost_worker *worker)
> {
> 	struct vhost_attach_cgroups_struct attach;
>
> 	attach.owner = current;
>-	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
>+	vhost_work_init(dev, &attach.work, vhost_attach_cgroups_work);
> 	vhost_work_queue_on(&attach.work, worker);
>-	vhost_work_dev_flush_on(worker);
>+	vhost_work_dev_flush_on(dev, worker);
> 	return attach.ret;
> }
>
>@@ -673,7 +677,7 @@ static struct vhost_worker 
>*vhost_worker_create(struct vhost_dev *dev)
> 	worker->task = task;
> 	wake_up_process(task); /* avoid contributing to loadavg */
>
>-	ret = vhost_attach_cgroups_on(worker);
>+	ret = vhost_attach_cgroups_on(dev, worker);
> 	if (ret)
> 		goto stop_worker;
>
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 64dc00337389..051dea4e3ab6 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -21,9 +21,10 @@ typedef void (*vhost_work_fn_t)(struct vhost_work *work);
>
> #define VHOST_WORK_QUEUED 1
> struct vhost_work {
>-	struct llist_node	  node;
>-	vhost_work_fn_t		  fn;
>-	unsigned long		  flags;
>+	struct llist_node	node;
>+	vhost_work_fn_t		fn;
>+	unsigned long		flags;

Maybe we should move these changes in another patch since they are not 
related.

Thanks,
Stefano

>+	struct vhost_dev	*dev;
> };
>
> struct vhost_worker {
>@@ -47,7 +48,8 @@ struct vhost_poll {
> 	struct vhost_virtqueue	*vq;
> };
>
>-void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
>+void vhost_work_init(struct vhost_dev *dev, struct vhost_work *work,
>+		     vhost_work_fn_t fn);
> void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
> bool vhost_has_work(struct vhost_dev *dev);
> void vhost_vq_work_flush(struct vhost_virtqueue *vq);
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index f954f4d29c95..302415b6460b 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -648,7 +648,8 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> 	file->private_data = vsock;
> 	spin_lock_init(&vsock->send_pkt_list_lock);
> 	INIT_LIST_HEAD(&vsock->send_pkt_list);
>-	vhost_work_init(&vsock->send_pkt_work, vhost_transport_send_pkt_work);
>+	vhost_work_init(&vsock->dev, &vsock->send_pkt_work,
>+			vhost_transport_send_pkt_work);
> 	return 0;
>
> out:
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
