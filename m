Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10171F8F17
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346930; cv=none; b=jYQvxMgg6WTBukOKBesYi6p5T2fWAHhYanpN4HqChOjwpR11k1Vo8Ks676AL+Q6gA+aDZfpeXVtuf1gZer2jC3TwdBcqJFzCu7ale66hoWzIdEkbXlKjrv66aWOkgCnhcRwP6/O0IEA7NSlrayxDv8O3vQ0hhMmSzJT/DW81Aoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346930; c=relaxed/simple;
	bh=cGZJRyPafRKNJJY5vcDxe6f14C30b1JFes5npfM4sq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YW3hRepUR9Z1Y4i8khFI1QSePosLEDdlnhVOhkYLzUor4t7PQUoQd3UDReNkK9RvWPIQiCbXk1upJC3sC9T0QT8Rr0XNm9GD7rpOykTiEZZju0sf9QtPOze+aJTUnP027Ub0JEZxkoA7N52SUgPq/nyIMLSzRtGaFWRH3mjTfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KsCWzG0o; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KsCWzG0o"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 515F6402E0
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 14:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X28FS7Csv2h3 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jan 2025 14:35:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4488940275
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4488940275
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KsCWzG0o
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4488940275
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Jan 2025 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736346925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/5ZTMHD9LRSOsMkn2E1KdU1LHI0MWopp6tiSITVH5L0=;
	b=KsCWzG0o0JAgP4JDv+xiwRAgUj6ceIrbxdIemZlDbB2tZldmIO0J4TZCpgR814xkpJpwyY
	hWL9k2h0kc7F2rlutx9pfiO1oUP3nkENpxmBGHGAFz/LTfqyGJqPe5L6ElBI243YY181IU
	mzg6/LL5dnpPKT8nnzwcIOnhRv2dQGI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-I-_PIEhhPn663y0g1GUWCg-1; Wed, 08 Jan 2025 09:35:24 -0500
X-MC-Unique: I-_PIEhhPn663y0g1GUWCg-1
X-Mimecast-MFC-AGG-ID: I-_PIEhhPn663y0g1GUWCg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e03f54d0so7604137f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 08 Jan 2025 06:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346923; x=1736951723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5ZTMHD9LRSOsMkn2E1KdU1LHI0MWopp6tiSITVH5L0=;
        b=jLzADH+MsoK81qlTxFXK2bBDsxad8hj2Zhc/GySHGaGtfP3BcYg4FfxC3otnQq7h4C
         QgTm424K81+/08aCF7jsFWnuCDCH4XeRuaHne6/BgdgDd9blcuOhqnUdHORAlC10ymse
         uI6B5Lonrt+X9snH7mU+xFQYFke4caSPQ3LPVvC8Q43oXqvGl/DYiut7+Sxl7C4CB29n
         4mvGrKvlOmzV8wQPMFZyFVOQqbg9xUaxLCPrshDHGyTXF4O6H+E0uq7dkcbGjseb8b8M
         pmSZY9szAbnSHCGBqazKjNFMK+Va/4Kdx4sJCaPVm1Hj01pZqCtTNqfGeWjmLw+Lg/t3
         cJNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpiVwRsZNSQGsBYovWotXXhP4vfD5yRvu1uJwJbm5sl7oHl4Zzzkb6qh5/MffdBNeBnZDUZ3eNhBlzfbqCqA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwVE4OZEV9mQe2xkyOI+H/lLgHqK2ilQBYDgAr997FxGqBxOgFM
	kSXvmiaTwdddSmVyYZgumzAPAsD4E+aEUUNRyM5S6oK+OupQXKtwezGPutqWPZaiZNK31QcBEuX
	OTMqpnVFrNFOVsbvFPmfbBOnG4f/bil0x7wEjnkGQZkPqa9jUmsLZuOj136xHiquAq4kvmrTlNf
	yYmd0=
X-Gm-Gg: ASbGncv+qj9T7A8EnZ8dZPA+2bNnb9GImj1sGEytRxNsVBHW0W79mlp3BuIw+9hVW+/
	evHiZRXE+YqarWdVo1rSP92qWTQqiGcvoK8BA44V68CrO3tNrx0uyddDRxUre+ywFwrZNLqXZAp
	9hTAB0hiGOXld9jKrMfIo3Wk9DkcguuU25HLOIQqtTB5EmA0nmlnEI/DI8EpCWG2sStLpxbR7cp
	z+COKGO7bLrmZuoC48m9ax/CX2FOaSt/Anyizeb0yGQGttICEk+iLM2AA==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id ffacd0b85a97d-38a873045d9mr2369577f8f.19.1736346922750;
        Wed, 08 Jan 2025 06:35:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmXEY/7tcjhjyBGapU8wmd3WjpH1fL63j8ZoTYBsDKD9dKaBd2q4JDYo9XrZZQc+PlVC9+Tg==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id ffacd0b85a97d-38a873045d9mr2369547f8f.19.1736346922181;
        Wed, 08 Jan 2025 06:35:22 -0800 (PST)
Received: from sgarzare-redhat ([5.77.93.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8289a0sm54534369f8f.7.2025.01.08.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:35:21 -0800 (PST)
Date: Wed, 8 Jan 2025 15:35:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 4/6] vhost: Add worker related functions to support
 kthread
Message-ID: <foiitmbzkjjjbnz46sfy627jsfwkvya42zujxiigykzj2dluya@iumroiukvfld>
References: <20241230124445.1850997-1-lulu@redhat.com>
 <20241230124445.1850997-5-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241230124445.1850997-5-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8NMI8HFXepHvcJaS7mzMXqxT0HKxi3-YWzQKYSVZtIo_1736346923
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Dec 30, 2024 at 08:43:51PM +0800, Cindy Lu wrote:
>Restore the previously removed functions kthread_wakeup and
>kthread_stop, and add two new function pointers to wake up and stop
>the workers. The function vhost_worker_create will initialize these
>pointers based on the value of inherit_owner.
>
>The functions vhost_worker_queue() and vhost_worker_destroy() will
>use the function pointer in vhost_worker, which is initialized
>according to the inherit_owner value.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 84 ++++++++++++++++++++++++++++++++++---------
> drivers/vhost/vhost.h |  3 ++
> 2 files changed, 71 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 812dfd218bc2..ff17c42e2d1a 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c

[...]

>@@ -736,27 +758,57 @@ static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> 	worker->dev = dev;
> 	snprintf(name, sizeof(name), "vhost-%d", current->pid);
>
>-	vtsk = vhost_task_create(vhost_run_work_list, vhost_worker_killed,
>-				 worker, name);
>-	if (!vtsk)
>-		goto free_worker;
>-
> 	mutex_init(&worker->mutex);
> 	init_llist_head(&worker->work_list);
> 	worker->kcov_handle = kcov_common_handle();
>-	worker->vtsk = vtsk;
>+    /*
>+     * If inherit_owner is true we use vhost_tasks to create
>+     * the worker so all settings/limits like cgroups, NPROC,
>+     * scheduler, etc are inherited from the owner.
>+     * If false,we use kthreads and only attach to the same
>+     * cgroups as the owner for compat with older kernels.
>+     */

This comment block seems to have incorrect indentation, perhaps you need 
to replace the spaces with at least one tab.

>+	if (dev->inherit_owner) {
>+		vtsk = vhost_task_create(vhost_run_work_list,
>+					 vhost_worker_killed, worker, name);
>+		if (!vtsk)
>+			goto free_worker;
>+
>+		worker->vtsk = vtsk;
>+		worker->worker_wakeup = vhost_task_wakeup_fn;
>+		worker->worker_stop = vhost_task_stop_fn;
>+
>+		vhost_task_start(vtsk);
>+		ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b,
>+			       GFP_KERNEL);
>+		if (ret < 0)
>+			goto stop_worker;
>+	} else {
>+		task = kthread_create(vhost_run_work_kthread_list, worker,
>+				      "vhost-%d", current->pid);
>+		if (IS_ERR(task)) {
>+			ret = PTR_ERR(task);
>+			goto free_worker;
>+		}
>+		worker->kthread_task = task;
>+		worker->worker_wakeup = vhost_kthread_wakeup_fn;
>+		worker->worker_stop = vhost_kthread_stop_fn;
>
>-	vhost_task_start(vtsk);
>+		wake_up_process(task);
>+		ret = xa_alloc(&dev->worker_xa, &id, worker, 
>xa_limit_32b,
>+			       GFP_KERNEL);
>+		if (ret < 0)
>+			goto stop_worker;
>
>-	ret = xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GFP_KERNEL);
>-	if (ret < 0)
>-		goto stop_worker;
>-	worker->id = id;
>+		ret = vhost_attach_task_to_cgroups(worker);
>+		if (ret)
>+			goto stop_worker;
>+	}
>
>+	worker->id = id;
> 	return worker;
>-
> stop_worker:
>-	vhost_task_stop(vtsk);
>+	worker->worker_stop(worker);
> free_worker:
> 	kfree(worker);
> 	return NULL;
>diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
>index c650c4506c70..63b1da08a2b0 100644
>--- a/drivers/vhost/vhost.h
>+++ b/drivers/vhost/vhost.h
>@@ -27,6 +27,7 @@ struct vhost_work {
> };
>
> struct vhost_worker {
>+	struct task_struct *kthread_task;
> 	struct vhost_task	*vtsk;
> 	struct vhost_dev	*dev;
> 	/* Used to serialize device wide flushing with worker swapping. */
>@@ -36,6 +37,8 @@ struct vhost_worker {
> 	u32			id;
> 	int			attachment_cnt;
> 	bool			killed;
>+	void (*worker_wakeup)(struct vhost_worker *worker);
>+	void (*worker_stop)(struct vhost_worker *worker);
> };
>
> /* Poll a file (eventfd or socket) */
>-- 
>2.45.0
>

