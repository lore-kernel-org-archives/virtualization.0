Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE30DC7EE23
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 15:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56A9883CD6;
	Thu,  8 Jun 2023 15:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56A9883CD6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HjCWpRHd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kex8X7z2K6y; Thu,  8 Jun 2023 15:11:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF7F283CD0;
	Thu,  8 Jun 2023 15:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF7F283CD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8478C007A;
	Thu,  8 Jun 2023 15:11:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2A86C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 15:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A12760F77
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 15:11:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A12760F77
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HjCWpRHd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kH_hiOStido2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 15:11:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85F1E60F69
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85F1E60F69
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 15:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686237113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTrSch/9yx1PBuB5DEQXG/NThydZ9pr2gUk3Xm9i4JM=;
 b=HjCWpRHdM1/9XtGt/yiOoaE+oPg0wb2drux1VIeGoTIf0UmaEHKwjeq61VsHvaUNpjIg36
 mG0mK2LoyLWsH0CApp3XKLYKAQonlL9xFkHOfCq76JoNzlNmv8So6YEZpi3Ic5KUDqp0se
 G+fXfKRVBD5euxokJlS24DWskWyM+LI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-wersZ-SvONSrbWUhiKHHyw-1; Thu, 08 Jun 2023 11:11:52 -0400
X-MC-Unique: wersZ-SvONSrbWUhiKHHyw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso324692f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 08:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686237111; x=1688829111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTrSch/9yx1PBuB5DEQXG/NThydZ9pr2gUk3Xm9i4JM=;
 b=G8lQ6/AaLlz4Abmy6Zqj2X8mriukU/tnT9kqEIfoFiikedQz4V6tXcy5gqixC5F8kb
 DTK9J/3oCiIe3mmwtMD1LlxCVdw0lzAP8esrXS4NIZ4MiaXFmttIoAn1dwvfq7z8verg
 8Ze9qYTRY51/Ze8YYFvErsuIDQdfYM2vQ/pVpE0WOrXifFMzIwxF93Miw1gvEW3s6UqT
 +dPoOE9kPC/K4HXs1o8k/s5HHso7OeQ5dUaLr05UfT4cZJ7BV1uj7CdlOmtMa6K/jFz/
 LisEs57OoCPMGpNcS8dwJ4DdprMRB0ryK7HSh5FhaNdNXB2zx4m5VqxNIxDtSW1ezJWi
 e7qw==
X-Gm-Message-State: AC+VfDxdQLhoj+K/7ikL99fWiZAXKFmLfNyvatjlGMmkcKt0AUCc/2+P
 mxMak57WS3WVz2Od6PnDFZgkd8s4chjzPPAlId5MqiSIic6DYFavljka+8XX0my7uN6bcM0J8aj
 guehyW3tunPavO6rZU5BtO3Kw2uEl1NY0ucmyI5501g==
X-Received: by 2002:a05:6000:12c1:b0:30a:ea8b:4488 with SMTP id
 l1-20020a05600012c100b0030aea8b4488mr7008463wrx.16.1686237111018; 
 Thu, 08 Jun 2023 08:11:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4gZroQZYdsvnPF6/9fVkzvEj+91x+vrLggWMaAQhLfcu3F3gtzN3F4jNFPPTJGN+EHCBwx6g==
X-Received: by 2002:a05:6000:12c1:b0:30a:ea8b:4488 with SMTP id
 l1-20020a05600012c100b0030aea8b4488mr7008449wrx.16.1686237110561; 
 Thu, 08 Jun 2023 08:11:50 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 h6-20020adffd46000000b0030ae09c5efdsm1856091wrs.42.2023.06.08.08.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:11:50 -0700 (PDT)
Date: Thu, 8 Jun 2023 11:11:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 1/2] vhost: Fix crash during early
 vhost_transport_send_pkt calls
Message-ID: <20230608111138-mutt-send-email-mst@kernel.org>
References: <20230607192338.6041-1-michael.christie@oracle.com>
 <20230607192338.6041-2-michael.christie@oracle.com>
 <somiozlfylajqwmtyaaihbsilahf7nb2irq2q2sy2dahxiy4yv@xznv7bpg677x>
MIME-Version: 1.0
In-Reply-To: <somiozlfylajqwmtyaaihbsilahf7nb2irq2q2sy2dahxiy4yv@xznv7bpg677x>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Thu, Jun 08, 2023 at 10:39:41AM +0200, Stefano Garzarella wrote:
> On Wed, Jun 07, 2023 at 02:23:37PM -0500, Mike Christie wrote:
> > If userspace does VHOST_VSOCK_SET_GUEST_CID before VHOST_SET_OWNER we
> > can race where:
> > 1. thread0 calls vhost_transport_send_pkt -> vhost_work_queue
> > 2. thread1 does VHOST_SET_OWNER which calls vhost_worker_create.
> > 3. vhost_worker_create will set the dev->worker pointer before setting
> > the worker->vtsk pointer.
> > 4. thread0's vhost_work_queue will see the dev->worker pointer is
> > set and try to call vhost_task_wake using not yet set worker->vtsk
> > pointer.
> > 5. We then crash since vtsk is NULL.
> > 
> > Before commit 6e890c5d5021 ("vhost: use vhost_tasks for worker
> > threads"), we only had the worker pointer so we could just check it to
> > see if VHOST_SET_OWNER has been done. After that commit we have the
> > vhost_worker and vhost_task pointer, so we can now hit the bug above.
> > 
> > This patch embeds the vhost_worker in the vhost_dev and moves the work
> > list initialization back to vhost_dev_init, so we can just check the
> > worker.vtsk pointer to check if VHOST_SET_OWNER has been done like
> > before.
> > 
> 
> We should add:
> 
> Reported-by: syzbot+d0d442c22fa8db45ff0e@syzkaller.appspotmail.com
> 
> Michael, can it be added when apply?

will do, thanks!

> > Fixes: 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > Signed-off-by: Mike Christie <michael.christie@oracle.com>
> > ---
> > drivers/vhost/vhost.c | 50 +++++++++++++++----------------------------
> > drivers/vhost/vhost.h |  2 +-
> > 2 files changed, 18 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 074273020849..7a9f93eae225 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -235,7 +235,7 @@ void vhost_dev_flush(struct vhost_dev *dev)
> > {
> > 	struct vhost_flush_struct flush;
> > 
> > -	if (dev->worker) {
> > +	if (dev->worker.vtsk) {
> > 		init_completion(&flush.wait_event);
> > 		vhost_work_init(&flush.work, vhost_flush_work);
> > 
> > @@ -247,7 +247,7 @@ EXPORT_SYMBOL_GPL(vhost_dev_flush);
> > 
> > void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> > {
> > -	if (!dev->worker)
> > +	if (!dev->worker.vtsk)
> > 		return;
> > 
> > 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> > @@ -255,8 +255,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
> > 		 * sure it was not in the list.
> > 		 * test_and_set_bit() implies a memory barrier.
> > 		 */
> > -		llist_add(&work->node, &dev->worker->work_list);
> > -		vhost_task_wake(dev->worker->vtsk);
> > +		llist_add(&work->node, &dev->worker.work_list);
> > +		vhost_task_wake(dev->worker.vtsk);
> > 	}
> > }
> > EXPORT_SYMBOL_GPL(vhost_work_queue);
> > @@ -264,7 +264,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
> > /* A lockless hint for busy polling code to exit the loop */
> > bool vhost_has_work(struct vhost_dev *dev)
> > {
> > -	return dev->worker && !llist_empty(&dev->worker->work_list);
> > +	return !llist_empty(&dev->worker.work_list);
> > }
> > EXPORT_SYMBOL_GPL(vhost_has_work);
> > 
> > @@ -456,7 +456,8 @@ void vhost_dev_init(struct vhost_dev *dev,
> > 	dev->umem = NULL;
> > 	dev->iotlb = NULL;
> > 	dev->mm = NULL;
> > -	dev->worker = NULL;
> > +	memset(&dev->worker, 0, sizeof(dev->worker));
> > +	init_llist_head(&dev->worker.work_list);
> > 	dev->iov_limit = iov_limit;
> > 	dev->weight = weight;
> > 	dev->byte_weight = byte_weight;
> > @@ -530,47 +531,30 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> > 
> > static void vhost_worker_free(struct vhost_dev *dev)
> > {
> > -	struct vhost_worker *worker = dev->worker;
> > -
> > -	if (!worker)
> > +	if (!dev->worker.vtsk)
> > 		return;
> > 
> > -	dev->worker = NULL;
> > -	WARN_ON(!llist_empty(&worker->work_list));
> > -	vhost_task_stop(worker->vtsk);
> > -	kfree(worker);
> > +	WARN_ON(!llist_empty(&dev->worker.work_list));
> > +	vhost_task_stop(dev->worker.vtsk);
> > +	dev->worker.kcov_handle = 0;
> > +	dev->worker.vtsk = NULL;
> > }
> > 
> > static int vhost_worker_create(struct vhost_dev *dev)
> > {
> > -	struct vhost_worker *worker;
> > 	struct vhost_task *vtsk;
> > 	char name[TASK_COMM_LEN];
> > -	int ret;
> > -
> > -	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> > -	if (!worker)
> > -		return -ENOMEM;
> > 
> > -	dev->worker = worker;
> > -	worker->kcov_handle = kcov_common_handle();
> > -	init_llist_head(&worker->work_list);
> > 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
> > 
> > -	vtsk = vhost_task_create(vhost_worker, worker, name);
> > -	if (!vtsk) {
> > -		ret = -ENOMEM;
> > -		goto free_worker;
> > -	}
> > +	vtsk = vhost_task_create(vhost_worker, &dev->worker, name);
> > +	if (!vtsk)
> > +		return -ENOMEM;
> > 
> > -	worker->vtsk = vtsk;
> > +	dev->worker.kcov_handle = kcov_common_handle();
> > +	dev->worker.vtsk = vtsk;
> 
> Okay, I think we are safe for now for the problem I highlighted in v1:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> Thanks,
> Stefano
> 
> > 	vhost_task_start(vtsk);
> > 	return 0;
> > -
> > -free_worker:
> > -	kfree(worker);
> > -	dev->worker = NULL;
> > -	return ret;
> > }
> > 
> > /* Caller should have device mutex */
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index 0308638cdeee..305ec8593d46 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -154,7 +154,7 @@ struct vhost_dev {
> > 	struct vhost_virtqueue **vqs;
> > 	int nvqs;
> > 	struct eventfd_ctx *log_ctx;
> > -	struct vhost_worker *worker;
> > +	struct vhost_worker worker;
> > 	struct vhost_iotlb *umem;
> > 	struct vhost_iotlb *iotlb;
> > 	spinlock_t iotlb_lock;
> > -- 
> > 2.25.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
