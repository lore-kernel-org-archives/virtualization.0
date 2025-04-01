Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015394D8D1
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514916; cv=none; b=edNjgJCzk0zdxGx4gHcdPmjxiyNT+AY3infJMxAS/k7TO6cqhNTEKDvA41kuTJ8GmA5+yW06y+C9XyTdLXUKl01y5YppayinWycRNC+6xGoHLvvrRhKqzduNa+9qiFwQM2UGO3jj/3BzH2C1S3hFXercx48xJqXE94aAGVzRKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514916; c=relaxed/simple;
	bh=9DmKSKgpRK/Ghoozm0xXZsix9t8rCDXOdYOtPeAD78E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bqOXapyhp2bIxswuJNlWaRkGlnSDgqp90aBfg8Ikwbe8x49H6nV0rFxuc4dOd52W/MBaIfYFaWthUPamFe2ycmPaHa6SdA9IJFR9I14DdqZHRFPJzgC6qmBFp5vzclPvVuszRWM0Z8O8Y87bzLpemA+Ha0RRa89YeSHz0dkeBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dcDarGC2; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcDarGC2"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9820140E31
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1flOsTunE51 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Apr 2025 13:41:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F243D40D8C
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F243D40D8C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dcDarGC2
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F243D40D8C
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743514913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JT/1HJ7j1dGnCuukkfDvHYvyoCmZ0J/ymsOhodchoIw=;
	b=dcDarGC2gddVDEPe4RNEH554bR1RiI+ZMECqJ7afbb1OHqgqlOefz4BLhmyGg9BAHpgAIz
	4t9Ejuau2SR01bflU0aS/Xq8+VzhA8YgOOw7Ke0muHVdNWfNLTWKcqw1qOBxExPqYeeL75
	TjiMHOzO7dyw9t+14UZeOL3mUds2hOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-cxZWe_DQN3y5lb72WZAN8A-1; Tue, 01 Apr 2025 09:41:52 -0400
X-MC-Unique: cxZWe_DQN3y5lb72WZAN8A-1
X-Mimecast-MFC-AGG-ID: cxZWe_DQN3y5lb72WZAN8A_1743514911
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so40809285e9.1
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Apr 2025 06:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514911; x=1744119711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT/1HJ7j1dGnCuukkfDvHYvyoCmZ0J/ymsOhodchoIw=;
        b=oKW3hCAdCTRTBvjhTPBH8XtLv8DhM9Tc8FGaG4k7IVCRNbapFrCxR4z2dEymMQXDrC
         UVmwNnAzndL/DQfxHaQCP/aNrUAQPJErS3u3gFhD93ENaO1XC8RZS7P6VhhBPm3qhUNr
         zaPl+lKs7T1ro5kn8g6FTpITlFrVirAm+TK9LJp/66gMEWTI7ZZFg5mlaMAVtMo/tYBj
         EY/16RfKrFw4FUMJUfvOlU5biEtYJowiG2cFPpMv7DN3owiWHVjZHOLpigTmwu60/gPh
         Y4EaGXYBoYSBhCGN95kd1EY2z2o3QbLfRFA6zcwBDKHLI2vCsEOsZghdTbUcxoELjQDQ
         S6uA==
X-Forwarded-Encrypted: i=1; AJvYcCWc6gA+jOlcGjJrI5YKMFvokfrgyaf8SurVH+1DBSdUpauS3pdnx6c7whZ9kjb5iOKEEv5LaGGlGHYDtE9CvQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx9uw57a9nh9BPpcbsF0268oxrH4S5y2Ed87xHwwHX0Z5O8ONKu
	5Qivj0X6zK5lSHUbuT6L6fyPsMTlyEVfKoTnRZW6H/OGPwyBdMAp9ZWXZBrYQJ4rVLh9sqbHtba
	BeleYmescH2B9YNkR2qYENt3KcQs0JbDUU5DFzjN+pHHU2V2Ni31VYXu9genS9eAukZjJ/E0SxF
	CEOBI=
X-Gm-Gg: ASbGncsWBJGUCJaSwgp2uVJj5Dl5K7OoojIjzr6kpIpipZ+UfgR0gILQHGjPayr6MVv
	fu3h5q5ms3XxhdqdOcJLPfCUG4QARWdSqROqhk3qCzOyzieziQS9yL6dxb3pL2tcvxhlWIS/f07
	TrM40CwUlFaxQqOhOcpPjQOy+0ZtBlvqwyobzzJsevp6t6xYIbWbCPbZtIf6+zwWr72i35zT2sm
	UszIhS4/UdfzfdQe7Aa4pAppX8rvqoFnyR0dbPU30P14XzhnkCz1OXnPMH/L/IuabogYjg/2qur
	xN/V7gr0m03eK91VGXtxdeHhIZKFW7U6C/rryhRYGF2FQBjiXEbx0AYRka8=
X-Received: by 2002:a05:600c:4705:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43db6247e03mr130604245e9.14.1743514910753;
        Tue, 01 Apr 2025 06:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOonQsa/shEuP0wDgfiH+HuLEzgbTbno+i+to8l7EiHyrr/1tPYY8WHBx9YFeKuuzvpEHoDA==
X-Received: by 2002:a05:600c:4705:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43db6247e03mr130603935e9.14.1743514910230;
        Tue, 01 Apr 2025 06:41:50 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e33asm14333177f8f.66.2025.04.01.06.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:41:49 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:41:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 3/8] vhost: Add the cgroup related function
Message-ID: <qucbuuwmqlrjhm7t7onoedzldrb2cvixjbjezmcovpo24ttzdx@sde275drep5u>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-4-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wGt3dCOErIJ1ZfujsLBttqJ8BsOZ7drHQDpThYwbqJ0_1743514911
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:47PM +0800, Cindy Lu wrote:
>Add back the previously removed cgroup function to support the kthread

nit: Missing . at the end

>The biggest change for this part is in vhost_attach_cgroups() and
>vhost_attach_task_to_cgroups().
>
>The old function was remove in

nit: s/remove/removed

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 41 +++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

As I mentioned, this patch also has unused functions, but LGTM.

Thanks,
Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 9500e85b42ce..20571bd6f7bd 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -22,6 +22,7 @@
> #include <linux/slab.h>
> #include <linux/vmalloc.h>
> #include <linux/kthread.h>
>+#include <linux/cgroup.h>
> #include <linux/module.h>
> #include <linux/sort.h>
> #include <linux/sched/mm.h>
>@@ -620,6 +621,46 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
> }
> EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>
>+struct vhost_attach_cgroups_struct {
>+	struct vhost_work work;
>+	struct task_struct *owner;
>+	int ret;
>+};
>+
>+static void vhost_attach_cgroups_work(struct vhost_work *work)
>+{
>+	struct vhost_attach_cgroups_struct *s;
>+
>+	s = container_of(work, struct vhost_attach_cgroups_struct, work);
>+	s->ret = cgroup_attach_task_all(s->owner, current);
>+}
>+
>+static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
>+{
>+	struct vhost_attach_cgroups_struct attach;
>+	int saved_cnt;
>+
>+	attach.owner = current;
>+
>+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
>+	vhost_worker_queue(worker, &attach.work);
>+
>+	mutex_lock(&worker->mutex);
>+
>+	/*
>+	 * Bypass attachment_cnt check in __vhost_worker_flush:
>+	 * Temporarily change it to INT_MAX to bypass the check
>+	 */
>+	saved_cnt = worker->attachment_cnt;
>+	worker->attachment_cnt = INT_MAX;
>+	__vhost_worker_flush(worker);
>+	worker->attachment_cnt = saved_cnt;
>+
>+	mutex_unlock(&worker->mutex);
>+
>+	return attach.ret;
>+}
>+
> /* Caller should have device mutex */
> bool vhost_dev_has_owner(struct vhost_dev *dev)
> {
>-- 
>2.45.0
>

