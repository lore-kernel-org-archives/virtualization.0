Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B61D88D6
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307986; cv=none; b=POzv+br+c9Xttmdr9o82UDdZlLaSrj5CmTZjmapnH5wBSydifR9buMh41TwAZs7pHJkuKv+usaqb49YbLs03CxRKgF5/EsTO4r78/0aEIBAzb7y5jB1gwkhgmH3xGlesH31bayRUO6gyy17ukYDlpRZvuvXze6m3y/DPzGDCgfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307986; c=relaxed/simple;
	bh=xFFQ1MQf5j6u4d/PzJtIt6kJj1vEBw9MYBPu8ZPD6pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rjgMvLprUM31jqiKvoEYLJ6dXZ0Au5z9I3fxbaQ72eYTL3Uf7uLIxhFJm2oUXt2POz8zm+BjqWaFab0OfK9B3YNJGdOnjrsSQQOq6zR4PVp60U6+KoGI+3i0Jx0WDw04PEu1bsWy/Am1REZjwzc4iY5MIlW1cEukq56rJm79cV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2GDcyyV; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2GDcyyV"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E4C9040299
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fvBicgyinYhc for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Oct 2024 13:32:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4544C40251
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4544C40251
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L2GDcyyV
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4544C40251
	for <virtualization@lists.linux-foundation.org>; Mon,  7 Oct 2024 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728307977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OTN4CRfzPnQ/qrZpds/jhk2KkRl2haBLO3LpgMX8X/c=;
	b=L2GDcyyV4DFNfdvWWS8UdJi3wnME/lxVAyA5JOtNAjydafXS4VwP9A1mcth6DAiLJ3pzo2
	9LxJO4I6u1yX8iFr8lA0+2AYhzWuxRmgFzD9F0wLLCk/8Wvh+hNXcbyOkTSE+Ngn1dl+67
	5D/EE+O3cFuqs1kyWl4x7bsrNnuuwpk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-B1AkXVwMPDGRoFfpERcP1A-1; Mon, 07 Oct 2024 09:32:56 -0400
X-MC-Unique: B1AkXVwMPDGRoFfpERcP1A-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a342e7e49cso66092455ab.0
        for <virtualization@lists.linux-foundation.org>; Mon, 07 Oct 2024 06:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307976; x=1728912776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTN4CRfzPnQ/qrZpds/jhk2KkRl2haBLO3LpgMX8X/c=;
        b=dT3pmSeTZvqetNhFA/Fy9wYGJh68PcHdQU9Blt3VQ6DJcjqw7nndheElxAtFn9vcKf
         lRz7Z348R5B1Q/6yd3vFvGwg22jVkuG53EoO3VNGLzUmg24vvXPazFU5pDJxZKmayTSo
         cbHaRPM1ghuS4l7pScDrrKZdSuvqXUfTPCFa2Eplu8WfKLb34lUkEY3I0+oMJ3RIhfJy
         25njbxBZYCT1VQ8e2iXvgSncnwAjbwGinhyb5GZqI64f9Rytod+CCF7Idgok1PQ45jmi
         TiIrto6i6H3/Jfy06s8LnZxBH25KRsllawEXen4ckYn/EIzWoMvJxt3TBNYte88Bf2Z7
         MvIg==
X-Forwarded-Encrypted: i=1; AJvYcCVPAgwaWB+pN+sVUGScxz/3fI2+bTiA1jq8Jzbl1ZSV7p7WWd7ZzF44f+wUBjKnTuojmQ2NTliJO2+R0uqXCw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyhBnY9N+gX11vXqPJ4hzsVrcpUrT4Ox0CAbRZW2mAxL2mgdmkf
	4WQZiHbXRS62LV9sKCEu7uXuu6pVvebNKFgbLVYPRTqmQhtSbcy/ph/jX2CVY5Ciub8zzWnXrH4
	zrRQtIuLxU9vIDa9gpZiPQPF8c680/2v/X3UChGARzcccGVNZXFENBQSfyoIlGPI+6pZ3nEWsl4
	Hz1Mk=
X-Received: by 2002:a05:6e02:13ae:b0:3a1:a57a:40a4 with SMTP id e9e14a558f8ab-3a375b9cdb6mr108023855ab.14.1728307975945;
        Mon, 07 Oct 2024 06:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/UTDImvemizxdOzxc8SgbKn3v2FDbIAI+glc8weW/S+V4tQELtKLGbB5hHuDm0/kTZK4uNw==
X-Received: by 2002:a05:6e02:13ae:b0:3a1:a57a:40a4 with SMTP id e9e14a558f8ab-3a375b9cdb6mr108023175ab.14.1728307975203;
        Mon, 07 Oct 2024 06:32:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6eb868fbsm1163255173.76.2024.10.07.06.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:32:54 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:32:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 3/7] vhost: Add kthread support in function
 vhost_workers_free()
Message-ID: <4z4lgkittsui6xv26h4gwo4o4xuut4sbcih6p7jxajwignftyq@catixvwskk5m>
References: <20241004015937.2286459-1-lulu@redhat.com>
 <20241004015937.2286459-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241004015937.2286459-4-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Oct 04, 2024 at 09:58:17AM GMT, Cindy Lu wrote:
>Added back the previously removed function vhost_workers_free() and
>renamed it to vhost_workers_free_khtread(). The new vhost_workers_free()
>will select the different mode based on the value of the parameter.
>
>The old function vhost_workers_free was change to support task in
>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>also changed in
>commit a284f09effea ("vhost: Fix crash during early vhost_transport_send_pkt calls")
>change to xarray in
>commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 52 ++++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 47 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index ad359d4b725f..fed6671c1ffb 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -648,8 +648,21 @@ static void vhost_detach_mm(struct vhost_dev *dev)
> 	dev->mm = NULL;
> }
>
>-static void vhost_worker_destroy(struct vhost_dev *dev,
>-				 struct vhost_worker *worker)
>+static void vhost_worker_destroy_kthread(struct vhost_dev *dev,
>+					 struct vhost_worker *worker)
>+{
>+	if (!worker)
>+		return;
>+
>+	WARN_ON(!llist_empty(&worker->work_list));
>+
>+	xa_erase(&dev->worker_xa, worker->id);
>+	kthread_stop(worker->task);
>+	kfree(worker);
>+}
>+
>+static void vhost_worker_destroy_task(struct vhost_dev *dev,
>+				      struct vhost_worker *worker)
> {
> 	if (!worker)
> 		return;
>@@ -660,7 +673,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
> 	kfree(worker);
> }
>
>-static void vhost_workers_free(struct vhost_dev *dev)
>+static void vhost_workers_free_task(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
> 	unsigned long i;
>@@ -675,10 +688,36 @@ static void vhost_workers_free(struct vhost_dev *dev)
> 	 * created but couldn't clean up (it forgot or crashed).
> 	 */
> 	xa_for_each(&dev->worker_xa, i, worker)
>-		vhost_worker_destroy(dev, worker);
>+		vhost_worker_destroy_task(dev, worker);
> 	xa_destroy(&dev->worker_xa);
> }
>
>+static void vhost_workers_free_kthread(struct vhost_dev *dev)
>+{
>+	struct vhost_worker *worker;
>+	unsigned long i;
>+
>+	if (!dev->use_worker)
>+		return;
>+
>+	for (i = 0; i < dev->nvqs; i++)
>+		rcu_assign_pointer(dev->vqs[i]->worker, NULL);
>+	/*
>+	 * Free the default worker we created and cleanup workers userspace
>+	 * created but couldn't clean up (it forgot or crashed).
>+	 */
>+	xa_for_each(&dev->worker_xa, i, worker)
>+		vhost_worker_destroy_kthread(dev, worker);
>+	xa_destroy(&dev->worker_xa);
>+}
>+
>+static void vhost_workers_free(struct vhost_dev *dev)
>+{
>+	if (enforce_inherit_owner)
>+		vhost_workers_free_task(dev);
>+	else
>+		vhost_workers_free_kthread(dev);
>+}

nit: new line here

> static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> {
> 	struct vhost_worker *worker;
>@@ -846,7 +885,10 @@ static int vhost_free_worker(struct vhost_dev *dev,
> 	__vhost_worker_flush(worker);
> 	mutex_unlock(&worker->mutex);
>
>-	vhost_worker_destroy(dev, worker);
>+	if (enforce_inherit_owner)
>+		vhost_worker_destroy_task(dev, worker);
>+	else
>+		vhost_worker_destroy_kthread(dev, worker);
> 	return 0;
> }
>
>-- 
>2.45.0
>
>

