Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A1204C0B
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515519; cv=none; b=Fr8r1QY9sl1ADHV02BwsGMeq2OdsEfLCqLNq+rgIcHrAHfowqt5yS6U/L00lCtx96GjA6dMNxNlahcAbXCTULl2WFNsBiBhqBVdY/ES71NsfvrHMBowYVE+dE7pUsKDsMP7Qzri2uGhpR3pvBKKwEoOAbbWu+Cx8Ogbo4uaxodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515519; c=relaxed/simple;
	bh=fyJnXBrOut1qI3iVOlrjftIknLYmdN5T3FQdk35b5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=P4fOEnMTk7XlSAaH+B9/pX+o+uUHYPlH0vuJmJh14cZcNu7i6JYvMyvuu2+iK4zqFNjic+qLUtzPt/yKyUJd27gxThBS3oRIrYcRVMnCItvwgDduOhal3dHFP/pQ+R82UNELjDEV2K+rczKn4jjwYdNP9c2pM0B8bUq0t/8wTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcYLPbCu; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcYLPbCu"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8DD08403F6
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:51:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVaQ7EXk7nRm for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Apr 2025 13:51:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C2AAE40319
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2AAE40319
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HcYLPbCu
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C2AAE40319
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743515514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yd713vKppQHQbjGvhffkowOQ35Ux0lbgZmPhSE6rLE4=;
	b=HcYLPbCuAI6uiaZX3nBBGkbSysPd3S5KtBWulqndSVzTbv88bg7msMyvrdk432YyD4hDQa
	77sjJP9TiZAfJ6ZLtVwaqGyUslXCzcEwkotfT3loI8f+HQ8xiJXrEdrXjjcgwbmlQVFQnz
	xe7F9OAcjiBia9aQ2HJmDWN5Jh2m8j4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-hO4ycd_POx2zBhLxFlsCew-1; Tue, 01 Apr 2025 09:51:51 -0400
X-MC-Unique: hO4ycd_POx2zBhLxFlsCew-1
X-Mimecast-MFC-AGG-ID: hO4ycd_POx2zBhLxFlsCew_1743515510
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cec217977so32373845e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Apr 2025 06:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515510; x=1744120310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd713vKppQHQbjGvhffkowOQ35Ux0lbgZmPhSE6rLE4=;
        b=dpL9IjWKpeGwiCeThoUCaWpaZQ5Uj3IPoD3CMXOYlZnI8Gx6/FLV2tYroqd0vr1kgu
         1o0O/vWaqWyBzXnFSWZ20sd81m5VhSQIAw1bhjFOZO8BbEDS+jAu/GikiK2XCOJ5rHZd
         OvwOGQUofhztJHb+KDsZmUwMUlRp1L7hr3KTYB+Y0K2Z74d1aB7WLlysrsIcfooQ85Ir
         fd6IMZx2B5g/x3vyzIQZ69s/UshcXj5A497FB9QIqSkfY0NvXhGWq7jLEsp+yZNnElry
         1FXiBo60kxzBeGXrn4Xlku1iBZy9AeDLl2d7dIRy4MdSC/SIOgm42egnhDLBUNPEKBwq
         JYRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWWkem1VycCVVd6ADMzuIQM8LZJ3pyjum2JeXlDscIdE0Z7daxa1IR8hVUjAIrT1sFRzxu9kyJ53WZjsX3Fg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwQzFw/pLRluBaDyQ9Zo6EWN8fOgZ8XFJneahh1VaNdCoRlhnt1
	+uKAqKxCiZaFy/2uNp2VKFiXczwx3C4mwnR4hAJsfylfMMChKBrf+1SwL2Q4Uq0XFHKE0SZawlM
	gm3C4AyVI2ZrMvDvBtUegSD26NIX3HiUYOu4YCo74np0ajoYri4LBQGAv/tiW18J4tEBjz+PmAn
	j+tr8=
X-Gm-Gg: ASbGnctZOK9qdlug2dwJzjSjvXvE7e6Qym42E8BuuoXZgvf5s4bhHGNazkaXjRLF1cc
	xXpfMj/2ldY6xak+OEDl1WU2IjxOP9QJEOR4UV4qCr7MdtngHMMFZg8AnadklOzb9M5fT0XlPLb
	SEpRIwwXK1ATW3J6Hlu/+YGSFwXob3EcDkEcDEAtwTrwLR7RBQ9pq3SeoFyqGxJBG8H5RYlaY/k
	e8IF40ZnnZeqUxijcS+rU0NuaA5nmF3Ujz+NR7EYz/5icNXnrAXkU/C9qvfyoIiY9TOM1cP5o+c
	qxkQyIQiYEN87MfS+oqGEuYt6LwxplZff4HwaXJgnFXFDMdZVp45e93QwhI=
X-Received: by 2002:a5d:5984:0:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-39c120e079amr10530780f8f.25.1743515509943;
        Tue, 01 Apr 2025 06:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsBMqSUaVpvZcub9DerZUyAcDAdWPbokGx4MrEDvZ1V89a1sJp60yqYaFeSZ3uq31KHnaDGQ==
X-Received: by 2002:a5d:5984:0:b0:391:4095:49b7 with SMTP id ffacd0b85a97d-39c120e079amr10530760f8f.25.1743515509455;
        Tue, 01 Apr 2025 06:51:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4318sm13937042f8f.87.2025.04.01.06.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:51:48 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:51:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 5/8] vhost: Reintroduce kthread mode support in vhost
Message-ID: <qtii7gazb52fuvkeiymllkapnd3l3ji6ht7y7cfegybreavmit@h6bvfhwpghg6>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-6-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PZYEYV717ARbpWqUgIQUnOvHVNWly7bDL7p881k4eWE_1743515510
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:49PM +0800, Cindy Lu wrote:
>This commit restores the previously removed functions kthread
>wake/stop/create, and use ops structure vhost_worker_ops to
>manage worker wakeup, stop and creation. The function
>vhost_worker_create initializes these ops pointers based on
>the value of inherit_owner
>
>The old function was remove in

nit: s/remove/removed

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 48 ++++++++++++++++++++++++++++++++++++++++++-
> drivers/vhost/vhost.h |  1 +
> 2 files changed, 48 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index c162ad772f8f..be97028a8baf 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -734,11 +734,21 @@ static void vhost_task_wakeup(struct vhost_worker *worker)
> 	return vhost_task_wake(worker->vtsk);
> }
>
>+static void vhost_kthread_wakeup(struct vhost_worker *worker)
>+{
>+	wake_up_process(worker->kthread_task);
>+}
>+
> static void vhost_task_do_stop(struct vhost_worker *worker)
> {
> 	return vhost_task_stop(worker->vtsk);
> }
>
>+static void vhost_kthread_do_stop(struct vhost_worker *worker)
>+{
>+	kthread_stop(worker->kthread_task);
>+}
>+
> static int vhost_task_worker_create(struct vhost_worker *worker,
> 				    struct vhost_dev *dev, const char *name)
> {
>@@ -762,6 +772,41 @@ static int vhost_task_worker_create(struct vhost_worker *worker,
> 	return 0;
> }
>
>+static int vhost_kthread_worker_create(struct vhost_worker *worker,
>+				       struct vhost_dev *dev, const char *name)
>+{
>+	struct task_struct *task;
>+	u32 id;
>+	int ret;
>+
>+	task = kthread_create(vhost_run_work_kthread_list, worker, "%s", name);
>+	if (IS_ERR(task))
>+		return PTR_ERR(task);
>+
>+	worker->kthread_task = task;
>+	wake_up_process(task);
>+	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
>+	if (ret < 0)
>+		goto stop_worker;
>+
>+	ret = vhost_attach_task_to_cgroups(worker);
>+	if (ret)
>+		goto stop_worker;
>+
>+	worker->id = id;
>+	return 0;
>+
>+stop_worker:
>+	vhost_kthread_do_stop(worker);
>+	return ret;
>+}
>+
>+static const struct vhost_worker_ops kthread_ops = {
>+	.create = vhost_kthread_worker_create,
>+	.stop = vhost_kthread_do_stop,
>+	.wakeup = vhost_kthread_wakeup,
>+};
>+
> static const struct vhost_worker_ops vhost_task_ops = {
> 	.create = vhost_task_worker_create,
> 	.stop = vhost_task_do_stop,
>@@ -773,7 +818,8 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> 	struct vhost_worker *worker;
> 	char name[TASK_COMM_LEN];
> 	int ret;
>-	const struct vhost_worker_ops *ops = &vhost_task_ops;
>+	const struct vhost_worker_ops *ops =
>+		dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
>
> 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> 	if (!worker)
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index 98895e299efa..af4b2f7d3b91 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -37,6 +37,7 @@ struct vhost_worker_ops {
> };
>
> struct vhost_worker {
>+	struct task_struct *kthread_task;
                           ^
nit: I'm not a fan of tabs, but here all the other fields have it, so I 
would put it in.

> 	struct vhost_task	*vtsk;
> 	struct vhost_dev	*dev;
> 	/* Used to serialize device wide flushing with worker swapping. */
>-- 
>2.45.0
>

The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

