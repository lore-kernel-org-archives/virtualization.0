Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA66BC7EE23
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 07:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 65AD240A93;
	Thu,  1 Jun 2023 07:47:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65AD240A93
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CgGko6px
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BQnOy2b8ETf8; Thu,  1 Jun 2023 07:47:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D6E16402E0;
	Thu,  1 Jun 2023 07:47:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6E16402E0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AEADEC007A;
	Thu,  1 Jun 2023 07:47:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F212C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 52FE28213A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:47:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52FE28213A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CgGko6px
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0IUe45QG1JHx
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:47:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 746E88210F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 746E88210F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685605672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LJY0ffzy9d7zjgW/HEvqIO2dS8yVBrmwr6J73PuSOuU=;
 b=CgGko6pxX5vQUtwvveXVGwMkmHEdL/1TxFwGQGOQTVaJM3XcLWQ3rr+Oa/5vLiRh9IvZTZ
 Av/mqrbLDZ5AQCXEKSgx12paf/pxL1kPDEiC3C+KwIfjJI2cpmSIQtPeQKuVErI4y/OT83
 IRBcmFWtPJs90iQU7c1h1G/rs1Lsd0g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-jAbCG4zROxOqMtMqwIxJkA-1; Thu, 01 Jun 2023 03:47:51 -0400
X-MC-Unique: jAbCG4zROxOqMtMqwIxJkA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af225e5b70so3984801fa.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jun 2023 00:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685605670; x=1688197670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJY0ffzy9d7zjgW/HEvqIO2dS8yVBrmwr6J73PuSOuU=;
 b=B3niLp9wvaoCOHDlUYULJGPGdtzaS7WaVMRK3gsPFaWw7ukTqU8GN6Q2KTp5Nn8ljp
 qjj7ejLcaZQhCwWXazhFV//+uKHQ225q3toClbJ3kJ4uiJPXW982TpVZXvAxUHOjvJ4n
 18dbaXw+aQtAtNkNkolvOJrb0A7jqQgMeTQLDlTdblZzkqKHveoGAyWfESNzr2PuwCaY
 5cjzc9itD4DRkTvm3rVaLEKjJktqowrItYxCO5Nu+GXoyqNdBCj+kEAyeBwKWHdK8qPb
 QIZyh6ejmsmSTpj5nZFzlXkzI+BjEz45z2h7TFJVcuvObmrvMREg1yUKXibhBPU3gays
 UZBw==
X-Gm-Message-State: AC+VfDxk9vcN5RFNT/O9xF7EYM7UKQ6/1vJUC+QUF4nfmCjIZU4LVOzY
 dfqNeIL+LO0A+p3gHLWlHCHAGp9KOK0z066dEwIk1Fe1PayCaJoqlKb8OJ/poENIqpkT/TxTLLx
 PYDaGZszVPXKNljS+mbt3EhBLArYJvIwDOr0D+WyDYQ==
X-Received: by 2002:a2e:8782:0:b0:2ad:8c4a:ef7e with SMTP id
 n2-20020a2e8782000000b002ad8c4aef7emr4339349lji.43.1685605670001; 
 Thu, 01 Jun 2023 00:47:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6n6txE71tIS8COu2Dmzs3VgI+CjTKwcsBTD8jJe3gHKSoIl+5OkJ1upYUs7A36ArMnP+FMZA==
X-Received: by 2002:a2e:8782:0:b0:2ad:8c4a:ef7e with SMTP id
 n2-20020a2e8782000000b002ad8c4aef7emr4339335lji.43.1685605669610; 
 Thu, 01 Jun 2023 00:47:49 -0700 (PDT)
Received: from sgarzare-redhat ([134.0.3.103])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a056402048c00b00514c4350243sm1763867edv.56.2023.06.01.00.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 00:47:48 -0700 (PDT)
Date: Thu, 1 Jun 2023 09:47:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [syzbot] [kvm?] [net?] [virt?] general protection fault in
 vhost_work_queue
Message-ID: <7vk2uizpmf4fi54tmmopnbwwb7fs2xg6vae6ynrcvs26hjmshb@hpjzu4jfj35i>
References: <0000000000001777f605fce42c5f@google.com>
 <20230530072310-mutt-send-email-mst@kernel.org>
 <CAGxU2F7O7ef3mdvNXtiC0VtWiS2DMnoiGwSR=Z6SWbzqcrBF-g@mail.gmail.com>
 <CAGxU2F7HK5KRggiY7xnKHeXFRXJmqcKbjf3JnXC3mbmn9xqRtw@mail.gmail.com>
 <e4589879-1139-22cc-854f-fed22cc18693@oracle.com>
 <6p7pi6mf3db3gp3xqarap4uzrgwlzqiz7wgg5kn2ep7hvrw5pg@wxowhbw4e7w7>
 <035e3423-c003-3de9-0805-2091b9efb45d@oracle.com>
 <CAGxU2F5oTLY_weLixRKMQVqmjpDG_09yL6tS2rF8mwJ7K+xP0Q@mail.gmail.com>
 <43f67549-fe4d-e3ca-fbb0-33bea6e2b534@oracle.com>
 <bbe697b6-dd9e-5a8d-21c5-315ab59f0456@oracle.com>
MIME-Version: 1.0
In-Reply-To: <bbe697b6-dd9e-5a8d-21c5-315ab59f0456@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org,
 syzbot <syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Wed, May 31, 2023 at 11:27:12AM -0500, Mike Christie wrote:
>On 5/31/23 10:15 AM, Mike Christie wrote:
>>>> rcu would work for your case and for what Jason had requested.
>>> Yeah, so you already have some patches?
>>>
>>> Do you want to send it to solve this problem?
>>>
>> Yeah, I'll break them out and send them later today when I can retest
>> rebased patches.
>>
>
>Just one question. Do you core vhost developers consider RCU more complex
>or switching to READ_ONCE/WRITE_ONCE? I am asking because for this immediate
>regression fix we could just switch to the latter like below to just fix
>the crash if we think that is more simple.
>
>I think RCU is just a little more complex/invasive because it will have the
>extra synchronize_rcu calls.

Yes, you may be right, in this case we should just need
READ_ONCE/WRITE_ONCE if dev->worker is no longer a pointer.

>
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index a92af08e7864..03fd47a22a73 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -235,7 +235,7 @@ void vhost_dev_flush(struct vhost_dev *dev)
> {
> 	struct vhost_flush_struct flush;
>
>-	if (dev->worker) {
>+	if (READ_ONCE(dev->worker.vtsk)) {
> 		init_completion(&flush.wait_event);
> 		vhost_work_init(&flush.work, vhost_flush_work);
>
>@@ -247,7 +247,9 @@ EXPORT_SYMBOL_GPL(vhost_dev_flush);
>
> void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> {
>-	if (!dev->worker)
>+	struct vhost_task *vtsk = READ_ONCE(dev->worker.vtsk);
>+
>+	if (!vtsk)
> 		return;
>
> 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
>@@ -255,8 +257,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> 		 * sure it was not in the list.
> 		 * test_and_set_bit() implies a memory barrier.
> 		 */
>-		llist_add(&work->node, &dev->worker->work_list);
>-		wake_up_process(dev->worker->vtsk->task);
>+		llist_add(&work->node, &dev->worker.work_list);
>+		wake_up_process(vtsk->task);
> 	}
> }
> EXPORT_SYMBOL_GPL(vhost_work_queue);
>@@ -264,7 +266,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
> /* A lockless hint for busy polling code to exit the loop */
> bool vhost_has_work(struct vhost_dev *dev)
> {
>-	return dev->worker && !llist_empty(&dev->worker->work_list);
>+	return !llist_empty(&dev->worker.work_list);
> }
> EXPORT_SYMBOL_GPL(vhost_has_work);
>
>@@ -468,7 +470,7 @@ void vhost_dev_init(struct vhost_dev *dev,
> 	dev->umem = NULL;
> 	dev->iotlb = NULL;
> 	dev->mm = NULL;
>-	dev->worker = NULL;
>+	memset(&dev->worker, 0, sizeof(dev->worker));
> 	dev->iov_limit = iov_limit;
> 	dev->weight = weight;
> 	dev->byte_weight = byte_weight;
>@@ -542,46 +544,38 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>
> static void vhost_worker_free(struct vhost_dev *dev)
> {
>-	struct vhost_worker *worker = dev->worker;
>+	struct vhost_task *vtsk = READ_ONCE(dev->worker.vtsk);
>
>-	if (!worker)
>+	if (!vtsk)
> 		return;
>
>-	dev->worker = NULL;
>-	WARN_ON(!llist_empty(&worker->work_list));
>-	vhost_task_stop(worker->vtsk);
>-	kfree(worker);
>+	vhost_task_stop(vtsk);
>+	WARN_ON(!llist_empty(&dev->worker.work_list));
>+	WRITE_ONCE(dev->worker.vtsk, NULL);

The patch LGTM, I just wonder if we should set dev->worker to zero here,
but maybe we don't need to.

Thanks,
Stefano

> }
>
> static int vhost_worker_create(struct vhost_dev *dev)
> {
>-	struct vhost_worker *worker;
> 	struct vhost_task *vtsk;
> 	char name[TASK_COMM_LEN];
> 	int ret;
>
>-	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
>-	if (!worker)
>-		return -ENOMEM;
>-
>-	dev->worker = worker;
>-	worker->kcov_handle = kcov_common_handle();
>-	init_llist_head(&worker->work_list);
>+	dev->worker.kcov_handle = kcov_common_handle();
>+	init_llist_head(&dev->worker.work_list);
> 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>
>-	vtsk = vhost_task_create(vhost_worker, worker, name);
>+	vtsk = vhost_task_create(vhost_worker, &dev->worker, name);
> 	if (!vtsk) {
> 		ret = -ENOMEM;
> 		goto free_worker;
> 	}
>
>-	worker->vtsk = vtsk;
>+	WRITE_ONCE(dev->worker.vtsk, vtsk);
> 	vhost_task_start(vtsk);
> 	return 0;
>
> free_worker:
>-	kfree(worker);
>-	dev->worker = NULL;
>+	WRITE_ONCE(dev->worker.vtsk, NULL);
> 	return ret;
> }
>
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
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
