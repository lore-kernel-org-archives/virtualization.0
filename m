Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CAFC433B4
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 15:30:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACA06101A
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 15:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACA06101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BAE640580;
	Tue,  4 May 2021 15:30:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pKPGVxXbWTwa; Tue,  4 May 2021 15:30:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94CC74010D;
	Tue,  4 May 2021 15:30:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 714ADC000D;
	Tue,  4 May 2021 15:30:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFB2AC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE15740570
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OTohjljfP7Lz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:30:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B2A934010D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620142227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=69aWjmh9hIjJjXeX7VIlYYr6RTfV5utMKSlIBAfHPHg=;
 b=g74rrSe9XAG7KQXsu7DZJyjhHxUHbDSeLPecoe1XyjEgD1f8CgFHqW+JczU35hynlPKxDl
 hILpjZfWQhVZiCK55yDJSH3tsmbZ/AY0+/bqRtAmGyLmOz2BzbfaiFIuEMZkjcpcXW6Vgr
 EwLbZ3Jyt8fcv60PSiwCbQZ172ieD9g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-jLNxLp1WO3ekkixNzg2Kvg-1; Tue, 04 May 2021 11:30:25 -0400
X-MC-Unique: jLNxLp1WO3ekkixNzg2Kvg-1
Received: by mail-ej1-f70.google.com with SMTP id
 yh1-20020a17090706e1b029038d0f848c7aso3288804ejb.12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 May 2021 08:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=69aWjmh9hIjJjXeX7VIlYYr6RTfV5utMKSlIBAfHPHg=;
 b=Bn2QCHtvBWRZNUHSBiOJ5EgY5ob3ApYrvtyrtmEiDSNuMN6OZwSTOqzze9LtEL6Zty
 eUoLqmjJuvEa0hpj0ocj3AFYjGxsEuzG8GyJaT72h2mdB8pGF/9mTKOScoOhuwCkNPQC
 r2gXdtTY6+yImVz0uRrUOVddwgnaP5mEsziu+2jSnqYMSyB2irwuPSb3ZT4qc9wkIe9p
 licLp7oNE1JIAM++4/RMC7LJNMAiNXcV3VLC6V4VCf9mIGZpqTFqvk+VNM6Hc2tgjFsc
 kWmhVHHJ1+33OZDKbiKeuzIgllQ0B5tWYDqs0TMXCOQ3vZZSJ1vn6G3eGgxtZx6EPN+u
 5tLg==
X-Gm-Message-State: AOAM533xSfurtAuSUnRQYKQPmNiT1F9NPtAXByn5cFZGqMTcPpxg3RE4
 0LR31Mx6teYxK4BSHHYW04gEWwSXtgQNrXJmei4xN636N3E+0dav/QH4Sp7D68XCsvtxrt4/ctn
 Y9NEcBE9ABSmex/Y+W/c05SP4JFvEj1280YY0pZGtqQ==
X-Received: by 2002:a17:906:6a41:: with SMTP id
 n1mr22938673ejs.401.1620142224625; 
 Tue, 04 May 2021 08:30:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza9DspQ2a7QGWPDPL12lfF25vAxZscxfckOPiEnR0OCq4mhi8K5+apAI8+85lop0N/xuQb8Q==
X-Received: by 2002:a17:906:6a41:: with SMTP id
 n1mr22938644ejs.401.1620142224394; 
 Tue, 04 May 2021 08:30:24 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id l11sm14125689eds.75.2021.05.04.08.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 08:30:23 -0700 (PDT)
Date: Tue, 4 May 2021 17:30:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH RFC 11/14] vhost: allow userspace to create workers
Message-ID: <20210504153021.afrnjo7l2szkvbi3@steredhat>
References: <20210428223714.110486-1-michael.christie@oracle.com>
 <20210428223714.110486-13-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20210428223714.110486-13-michael.christie@oracle.com>
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

On Wed, Apr 28, 2021 at 05:37:11PM -0500, Mike Christie wrote:
>This patch allows userspace to create workers and bind them to vqs, so you
>can have N workers per dev and also share N workers with M vqs. The next
>patch will allow sharing across devices.
>
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/vhost.c            | 95 +++++++++++++++++++++++++++++++-
> drivers/vhost/vhost.h            |  3 +
> include/uapi/linux/vhost.h       |  6 ++
> include/uapi/linux/vhost_types.h |  9 +++
> 4 files changed, 111 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 345ade0af133..fecdae0d18c7 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -42,6 +42,9 @@ module_param(max_iotlb_entries, int, 0444);
> MODULE_PARM_DESC(max_iotlb_entries,
> 	"Maximum number of iotlb entries. (default: 2048)");
>
>+static LIST_HEAD(vhost_workers_list);
>+static DEFINE_SPINLOCK(vhost_workers_lock);
>+
> enum {
> 	VHOST_MEMORY_F_LOG = 0x1,
> };
>@@ -617,8 +620,16 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> 	dev->mm = NULL;
> }
>
>-static void vhost_worker_free(struct vhost_worker *worker)
>+static void vhost_worker_put(struct vhost_worker *worker)
> {
>+	spin_lock(&vhost_workers_lock);
>+	if (!refcount_dec_and_test(&worker->refcount)) {
>+		spin_unlock(&vhost_workers_lock);
>+		return;
>+	}
>+	list_del(&worker->list);
>+	spin_unlock(&vhost_workers_lock);
>+
> 	WARN_ON(!llist_empty(&worker->work_list));
> 	kthread_stop(worker->task);
> 	kfree(worker);
>@@ -632,7 +643,7 @@ static void vhost_workers_free(struct vhost_dev *dev)
> 		return;
>
> 	for (i = 0; i < dev->num_workers; i++)
>-		vhost_worker_free(dev->workers[i]);
>+		vhost_worker_put(dev->workers[i]);
>
> 	kfree(dev->workers);
> 	dev->num_workers = 0;
>@@ -652,6 +663,8 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> 	worker->id = dev->num_workers;
> 	worker->dev = dev;
> 	init_llist_head(&worker->work_list);
>+	INIT_LIST_HEAD(&worker->list);
>+	refcount_set(&worker->refcount, 1);
>
> 	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
> 	if (IS_ERR(task))
>@@ -664,6 +677,9 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> 	if (ret)
> 		goto stop_worker;
>
>+	spin_lock(&vhost_workers_lock);
>+	list_add_tail(&worker->list, &vhost_workers_list);
>+	spin_unlock(&vhost_workers_lock);
> 	return worker;
>
> stop_worker:
>@@ -673,6 +689,71 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> 	return NULL;
> }
>
>+static struct vhost_worker *vhost_worker_find(struct vhost_dev *dev, pid_t pid)
>+{
>+	struct vhost_worker *worker;
>+
>+	/* TODO hash on pid? */
>+	spin_lock(&vhost_workers_lock);
>+	list_for_each_entry(worker, &vhost_workers_list, list) {
>+		if (worker->task->pid != pid)
>+			continue;
>+
>+		/* tmp - next patch allows sharing across devs */
>+		if (worker->dev != dev) {
>+			spin_unlock(&vhost_workers_lock);
>+			return NULL;
>+		}
>+
>+		refcount_inc(&worker->refcount);
>+		spin_unlock(&vhost_workers_lock);
>+		return worker;
>+	}
>+	spin_unlock(&vhost_workers_lock);
>+	return NULL;

I would like to have a single point where we release the lock to avoid
future issues, how about changing vhost_worker_find() to:

static struct vhost_worker *vhost_worker_find(struct vhost_dev *dev, pid_t pid)
{
	struct vhost_worker *worker, *found_worker = NULL;

	spin_lock(&vhost_workers_lock);
	list_for_each_entry(worker, &vhost_workers_list, list) {
		if (worker->task->pid == pid) {
			/* tmp - next patch allows sharing across devs */
			if (worker->dev != dev)
				break;

			found_worker = worker;
			refcount_inc(&found_worker->refcount);
			break;
		}
	}
	spin_unlock(&vhost_workers_lock);
	return found_worker;
}

>+}
>+
>+/* Caller must have device mutex */
>+static int vhost_vq_set_worker(struct vhost_virtqueue *vq,
>+			       struct vhost_vring_worker *info)
>+{
>+	struct vhost_dev *dev = vq->dev;
>+	struct vhost_worker *worker;
>+
>+	if (vq->worker) {
>+		/* TODO - support changing while works are running */
>+		return -EBUSY;
>+	}
>+
>+	if (info->pid == -1) {
>+		worker = vhost_worker_create(dev);
>+		if (!worker)
>+			return -ENOMEM;
>+
>+		info->pid = worker->task->pid;
>+	} else {
>+		worker = vhost_worker_find(dev, info->pid);
>+		if (!worker)
>+			return -ENODEV;
>+	}
>+
>+	if (!dev->workers) {
>+		dev->workers = kcalloc(vq->dev->nvqs,
>+				       sizeof(struct vhost_worker *),
>+				       GFP_KERNEL);
>+		if (!dev->workers) {
>+			vhost_worker_put(worker);
>+			return -ENOMEM;
>+		}
>+	}
>+
>+	vq->worker = worker;
>+
>+	dev->workers[dev->num_workers] = worker;
>+	dev->num_workers++;
>+	return 0;
>+}
>+
> /* Caller must have device mutex */
> static int vhost_worker_try_create_def(struct vhost_dev *dev)
> {
>@@ -1680,6 +1761,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> 	struct eventfd_ctx *ctx = NULL;
> 	u32 __user *idxp = argp;
> 	struct vhost_virtqueue *vq;
>+	struct vhost_vring_worker w;
> 	struct vhost_vring_state s;
> 	struct vhost_vring_file f;
> 	u32 idx;
>@@ -1794,6 +1876,15 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
> 		if (copy_to_user(argp, &s, sizeof(s)))
> 			r = -EFAULT;
> 		break;
>+	case VHOST_SET_VRING_WORKER:
>+		if (copy_from_user(&w, argp, sizeof(w))) {
>+			r = -EFAULT;
>+			break;
>+		}
>+		r = vhost_vq_set_worker(vq, &w);
>+		if (!r && copy_to_user(argp, &w, sizeof(w)))
>+			r = -EFAULT;
>+		break;
> 	default:
> 		r = -ENOIOCTLCMD;
> 	}
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 973889ec7d62..64dc00337389 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -14,6 +14,7 @@
> #include <linux/atomic.h>
> #include <linux/vhost_iotlb.h>
> #include <linux/irqbypass.h>
>+#include <linux/refcount.h>
>
> struct vhost_work;
> typedef void (*vhost_work_fn_t)(struct vhost_work *work);
>@@ -28,6 +29,8 @@ struct vhost_work {
> struct vhost_worker {
> 	struct task_struct	*task;
> 	struct llist_head	work_list;
>+	struct list_head	list;
>+	refcount_t		refcount;
> 	struct vhost_dev	*dev;
> 	int			id;
> };
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index c998860d7bbc..61a57f5366ee 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -70,6 +70,12 @@
> #define VHOST_VRING_BIG_ENDIAN 1
> #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
> #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
>+/* Create/bind a vhost worker to a virtqueue. If pid > 0 and matches an existing
>+ * vhost_worker thread it will be bound to the vq. If pid is -1, then a new

What about adding a macro for -1? (e.g. VHOST_VRING_NEW_WORKER)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
