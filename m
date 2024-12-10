Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5A1C5CAE
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853197; cv=none; b=AnoxFEJOVdI2VeITO9LOtOiR+IlKSw8PPw3sB/U/tF/fDgVS+5SqE19GFpMB04gCcJUIjmI/RfyDXJBor5gYu+pjv1h9wYYZKqyFauJq+qUUC368o7S9VAQUn69es2unKbGzWz1q/4sq7+8YcCOqX4QYVLIAhj9M67XU3bD9CVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853197; c=relaxed/simple;
	bh=GiA6E6YUT24hkxZZfyf2XJKY4+22S6/8ZvzlZG2X5rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZX9hoMVfk22TEJ+Dygms4edm0/iqZS4olv+Rn63eOdIQDssywfMgv7prIISrxNlriR+fmZxLJqNPJbn8Pw0li9EMDOvANMYybdVI0hmA+4WfCrEeyMXht+IyxYjTxEzdP6g7vPj7cgZaGxkSrerauKsURqai2MvGP3vLmbP7WT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce+uwv24; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce+uwv24"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBD8B80ED8
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:53:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8zdmrhtxHEUI for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 17:53:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 25E9581B35
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 25E9581B35
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ce+uwv24
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 25E9581B35
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V7+hheXjFxQWX/A6CbQM2y9lEoN18zy57mFtnrvRGzE=;
	b=ce+uwv24yLYlw9zcFAkiENQ5Rr1T6vBhSwhrACQrghbyL+erUbjslDxWlFxb2deyPMXnxd
	UjNaPvJOOXphM1C1YnM63mK77aQwooDUEnWiOvG6fQLqOAFGxapzNk2nadFATZHAksbEXq
	jk1MSwlbwZnThq+scXZkSW/QEHoNEZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-H2I-CTreMdmj0hJqTjb5iQ-1; Tue, 10 Dec 2024 12:53:12 -0500
X-MC-Unique: H2I-CTreMdmj0hJqTjb5iQ-1
X-Mimecast-MFC-AGG-ID: H2I-CTreMdmj0hJqTjb5iQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e3cbf308so1436302f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 09:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853191; x=1734457991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7+hheXjFxQWX/A6CbQM2y9lEoN18zy57mFtnrvRGzE=;
        b=dvrwESZxs62ccToF2dlDi7LLYq7gsqID+Jmk7S1Egcw75A/6K3FMV90VEqI3t4k3Ag
         b50SuZKl53ZJU5kQizjzbtDcOqL8tDrlBGTLemEkEvHWJQcXtnb65695jxfJv93UTIM3
         etR3lUknaIFGKnfh24KdIekl5nDTk7APZDBcxPoMYl7H1b1nndIVbRTWtvosmRTRlRCk
         8/SyoFpYxYvDgV4UTBxzBpiA/a4wD//dDBTz7qGH6q1Yoh3ZUinT8PfryFbv9aAs2uAi
         T0gnMYPrEkO+zWxe739XgKVfSJg+rjwKpahx3CeXuSp529Do9aQ2ib11RyCfa2E1nZyF
         U0kg==
X-Forwarded-Encrypted: i=1; AJvYcCUn/cQPSs/gMOmOykckuF7cqwOQaGSBvRd7K8Ze5QCB/om8YkB2bqkTGnxH6IkqNv4xecyXDj/Je2Afta7IRA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwcYcq/s6lz2tz8f7NNUivPp8LbxBo0IL8Pj5b8odutNhU2sRxE
	VpjgNyZ/S12FMSsxqaaHmIggUpDcjiAjkCuN2L/UpfIx7VyXwC3L0lTkoSeRj8yp1OeI/3vUEG5
	m5EAMyXWIKoYyMqBlB0FzeTfhI+8mKGoJ1u15CBd1fdDn0EjbRIleaPwR8ieUi0FpKtmIjsOSnh
	n3hLs=
X-Gm-Gg: ASbGncviQK3OvybGxCL9pNikvxd7J+NwL8CjP75Kmpsc5/4BSsszM9yCT5Fd9P+bD4h
	3cuMZCMUtvV7LXN07vX7bRI4QM4LT4/anEKekVRCHavUvIT+hmpzCueiJvFjD0uyBpj9VZ8HadF
	Kee9IAu9AvOqD9uypsA74Wc7lIBSIZpy/FSGXgXD1wr9yTZEQkUoFU+hxN5OavOGP08Ggaw2ARY
	WyI5dIi/40axbeMzLDRPlROA0KaaXyfhB5zVNi3+ML5TlgCG7Ra/RxN1yxlfYOET7fqXQOCviPQ
	DImA0qC6MZJL6kRScsmX60ElLyKEvw==
X-Received: by 2002:a5d:5f91:0:b0:385:e43a:4dd8 with SMTP id ffacd0b85a97d-3864ce86740mr20240f8f.4.1733853191429;
        Tue, 10 Dec 2024 09:53:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyNGcJtqIvdODAbGKru3zIfA/gLNJtt/5XcSx5m5F9FIgAvZT/2YjpbC5CxbPoDO18XR8O7g==
X-Received: by 2002:a5d:5f91:0:b0:385:e43a:4dd8 with SMTP id ffacd0b85a97d-3864ce86740mr20218f8f.4.1733853190735;
        Tue, 10 Dec 2024 09:53:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d3f57a0sm13157753f8f.108.2024.12.10.09.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:53:10 -0800 (PST)
Date: Tue, 10 Dec 2024 18:53:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 3/8] vhost: Add the cgroup related function
Message-ID: <yo2wq3brumnud4e7a4f4ni5s37olicv3ksvztcetgj2urmccks@qvrutryfahmf>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241210164456.925060-4-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cfFw6nmMTn4qDzZi2QRRhmFshfQjxvxMWfdyTnUrnM4_1733853191
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 11, 2024 at 12:41:42AM +0800, Cindy Lu wrote:
>Add back the previously removed cgroup function to support the kthread

nit: missing . at the end

>The biggest change for this part is in vhost_attach_cgroups() and
>vhost_attach_task_to_cgroups().

It's not clear what the big change is, is there a piece missing?

>
>The old function was remove in

s/remove/removed

BTW which is the old function?

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 1feba29abf95..812dfd218bc2 100644
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
>@@ -620,6 +621,38 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
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

This function looks renamed, should we mention in the commit 
description?

>+{
>+	struct vhost_flush_struct flush;
>+	struct vhost_attach_cgroups_struct attach;
>+
>+	attach.owner = current;
>+
>+	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
>+	vhost_worker_queue(worker, &attach.work);
>+
>+	init_completion(&flush.wait_event);
>+	vhost_work_init(&flush.work, vhost_flush_work);
>+	vhost_worker_queue(worker, &flush.work);
>+	wait_for_completion(&flush.wait_event);

IIUC this block is the old "vhost_dev_flush", right?

Maybe we should mention also that in the commit description.

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

