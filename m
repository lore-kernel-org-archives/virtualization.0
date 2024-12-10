Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3A86336
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853270; cv=none; b=s+VDv+DCHDWEM+l1gQtHlnas1tIqYQk9WAUsCzjlqtia+zdEpj5BOhY1BrYIwnltF+fMuN8eX38H3ATJxWhXHHxjiefadpg+wQLIxD5V4H9l1lROr9d8yCw0gxM8rsRX7ZyjlOpqr6ytGfD/thxcnNBGHOLD04pnItWAUwuUwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853270; c=relaxed/simple;
	bh=K9ByPjXthNnzk4FPK877f5xtZOPcLGkA29sc86con5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=e9qlqyhDdgjdwOpGYJvFDecSDo8QqSQ5XVFoLgLFntc83iSmIOA7AGenqnRxglAuhhp+zVF4sC+SOV15IzjY3ZzSM7WNLRwdSHJTmwEDiQ1yzVRFLd/225mRhNiTlJT4lv+qEczCk+gmKL2/uOg7z4vqj9GKieeoOBeO4wRcMeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWqit7l3; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWqit7l3"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E63EC60B5D
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V21jOwilo6BE for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 17:54:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 35AE660B5C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35AE660B5C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HWqit7l3
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 35AE660B5C
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rRzY7/WWXd0NQuWwIWH9kGuyMdF7tM8qRG1Uei+GbU=;
	b=HWqit7l3UP4KcTJ+YdHQB+HvIaFD+QhTXd56KNJIY5xIuHKhWYfRaKeq1kJrhNOsKo703k
	K1NbWqU1B1RBhouEs0C7ZPkvuRPENYyl7o+fmi5waIH3TqON/CjhJSOD6WOdOEgKOnccPS
	C3Vh8Dxbbi/PZSbog6OhTc/XfwCyCMY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-Mi0kjKuiPsuQ-5rTutq29A-1; Tue, 10 Dec 2024 12:54:25 -0500
X-MC-Unique: Mi0kjKuiPsuQ-5rTutq29A-1
X-Mimecast-MFC-AGG-ID: Mi0kjKuiPsuQ-5rTutq29A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-434f40667e5so17670725e9.1
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 09:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853265; x=1734458065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rRzY7/WWXd0NQuWwIWH9kGuyMdF7tM8qRG1Uei+GbU=;
        b=Ty8CazDqmny6niuvabCEgZHtH5Koe9OcDMrWtyVnUV0340kDq2ZLY4Vn1vvNEnCoLs
         NFnb1OydyRD3Cyd5nwt4F0VAJlKdt0D8ZCf3mBtE1gdlldBrORRBEJOowu7oA4OC50Hi
         hHTXbsXRmjgw6ZnhgblqlpsSZhyzPkw/OIMVn2zd078lsoTpaCF2+B1TPGT2HGI9Gevq
         JRbu/qETaPAYHRovxjPKnelR1OVNJ7GGk08aVJOue0vYTv4cZn3L9Cb/c/bV7sOOu+93
         ITF/fsSoRoBZbqS/Qc8liuDS6jgwiuOTD4bLx8kiiClXS7V3umIhh6tPlxvqYZ8fP/1x
         U6qg==
X-Forwarded-Encrypted: i=1; AJvYcCXHwo12noajvy6XkcLcPQmQeIML0Fp63Milc4HrIR4qGaq8NDFhafhQO/wP6S8z6ptk/ip4kzFqhkoDpHNgrw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwdvGqWKYN6+GjL1A+A3TgZI/2kQ1WOsTixNMzh/n7Sv5pH8jAS
	p4UIl8dnwiD+fboRBQRuO1GVQpxjz4gxAaUgnVPAaZRyASYt187G521atKgVmYgH/ZeypTtaz4q
	jKMgeXAXnyEuGWD/eTF22WoqjiY8Cg/O/izwEsyNIWk6Y3CZNzp9GbAbzBI6sZJhuFya+64R/Yv
	TNKj4=
X-Gm-Gg: ASbGncu7XGDgWTUrRu4H5w8fCZeinheDqEP6jB2Ib0+nRHU3UeOB0EbabXKil2YLbui
	8TgacWXdgsTnKHi2Jx7hyZxZwOtr4e5ZyjHYSiQfddPS952I76kIs0A+z5+nFAX8kQ2+0hHA8Hm
	bpwo9DDTmS2BvEfG2NzD/40vvB2XS1APYmHWWWpB7xDPG7AAfkdlews58OEe5MjKmO9aH9+qINn
	PGXnuVX9xyH2WZMF9kGpcSOByBFRk9UhqwjizbTr8giG20OWJfWAk+42Vo/UV5JIHz3Tn/qDqDq
	nxHpBAFr9VH1UGkWLfLsvY0BJv9KjA==
X-Received: by 2002:a05:600c:3d8f:b0:434:f131:1e6d with SMTP id 5b1f17b1804b1-434fff41b82mr59305265e9.10.1733853264785;
        Tue, 10 Dec 2024 09:54:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPWoOUzyZKPwP8dqnFSdgd5moePBZMHqB64BaKkDl1ZXBJyZATfPmpsXV2IUepOobQ2Kj0XA==
X-Received: by 2002:a05:600c:3d8f:b0:434:f131:1e6d with SMTP id 5b1f17b1804b1-434fff41b82mr59304895e9.10.1733853264190;
        Tue, 10 Dec 2024 09:54:24 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf42b2sm16120454f8f.12.2024.12.10.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:54:23 -0800 (PST)
Date: Tue, 10 Dec 2024 18:54:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 5/8] vhost: Add kthread support in function
 vhost_worker_queue()
Message-ID: <e2wooukn372tdfx374ffs54cotb3y3cy3jn7gn34u4ztnnrxw5@eio7rllodou2>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241210164456.925060-6-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VYJ9MojtjwtazAeMQmiqg1EPdkRsUZypUtBQFNPUuzE_1733853265
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 11, 2024 at 12:41:44AM +0800, Cindy Lu wrote:
>The function vhost_worker_queue() uses a function pointer in
>vhost_worker, which is initialized based on the inherit_owner
>value.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 0175bbf4d8b3..d1aec41bcd56 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -237,13 +237,16 @@ EXPORT_SYMBOL_GPL(vhost_poll_stop);
> static void vhost_worker_queue(struct vhost_worker *worker,
> 			       struct vhost_work *work)
> {
>+	if (!worker)
>+		return;
>+

In which scenario can `worker` be NULL?

I would like to better understand why it couldn't happen before and now 
it can.

Thanks,
Stefano

> 	if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
> 		/* We can only add the work to the list after we're
> 		 * sure it was not in the list.
> 		 * test_and_set_bit() implies a memory barrier.
> 		 */
> 		llist_add(&work->node, &worker->work_list);
>-		vhost_task_wake(worker->vtsk);
>+		worker->task_wakeup(worker);
> 	}
> }
>
>-- 
>2.45.0
>

