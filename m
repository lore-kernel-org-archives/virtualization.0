Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC12A1DC98C
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853172; cv=none; b=oWra5OXzz37jiECXYpsgKQOh52TQUqeUMtEYKeduQu8G/9kGW8EyopZgJv9pkFYZpaF2q+YVbRO1YC8nnMfAXzeP17oTUOzeQWDAuymTMD4F4Ugc4Ttzd6uLGCUVlH8Lzql6EnMANoihBFZmPYnSP5zp0TueqzDg94SukkgjWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853172; c=relaxed/simple;
	bh=DGmY49ZIKqA4CUxyhD2kOLWmzd1vsVv0boF4mbcySXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qBJP2rrSLt4lrXLh9Ajj7et4Vu7FS/Me6Q+HGcIKU7Mo5nq8RiKN/bJLxns8VKqfibIopABIh+OnG5k9YkjdXseXrUaCQNF+aaX1a6+fjAzbXfnFU0bGfiy3kp9gN+piC1fgWZGd0fEQrVIDvyVQgSPovaPDsS2Ja681TCz8xpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZVYiOmM; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZVYiOmM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A3AD40ECA
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1oW_p1hlg6Bd for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 17:52:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7202140EC7
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7202140EC7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gZVYiOmM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7202140EC7
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YqU+wCdvIl3266U71Sl65AIwUMu71vG8+SSC8yh1g38=;
	b=gZVYiOmMONxr014Y5ku6c4F6YcMu/B1cisS14Z8mYsUGroGL9o/1jHbpzU+8KqzP8V+XTB
	XDVqrOfyDoVeTEsXRhfK0BmObwOdPjfLBntWUjN7ji/vPq6iQpA89efTuctiK6UJEOBqk1
	4WQlyJLj3M8LdKQb+W+KKowDVj88Ysw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-T8qrJBW7ODSo-dR-yGLpug-1; Tue, 10 Dec 2024 12:52:46 -0500
X-MC-Unique: T8qrJBW7ODSo-dR-yGLpug-1
X-Mimecast-MFC-AGG-ID: T8qrJBW7ODSo-dR-yGLpug
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385fdff9db5so2583011f8f.0
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 09:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853165; x=1734457965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqU+wCdvIl3266U71Sl65AIwUMu71vG8+SSC8yh1g38=;
        b=w/k50AjEFPbptT2H6J3GyzcMDEPa7WZ6bvKJHNmBtOpT/SX0dZPkkv/Rtjn10qxJd3
         Enem7HMYpxxB71cqdgYISVkKcb/67UBkBnKz8rrE8GzRiK6fMyf5q8GgOj1cTPXl0Jwo
         PhAgf8rAHifUjc7EBS+EgbgfvKyJjxfWBi0d9dwakHtpK1cU6NlFz+EvCkHfnd923bE+
         oW65aUziyreZZoVIEC3Rr1vUtq50ruf6LGWDNXEqWuBckNTu1gtj89A0eHR/SlQIpZjr
         EPkvLuaIGrr36s2lze67rb30W/4HiNJ1jok/YPaLowtCpIelHVBrlV8xlolNvyfYrHnH
         e3QA==
X-Forwarded-Encrypted: i=1; AJvYcCX0JBj+d6cjD+oo7AdD6isR5U8wj7gcTh9t1jy4qyjczTpXsM6B/yd53uo+HjwxqJOwY562zEr47Sovh0RQVA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzfft6U0BI6khbdEY74MLKL6Vs7ApFqvL4qxgG60WA9HgrAp72w
	9iEVRCwOEldyQV0fwon6E0ysZH00v++tXhBqBHtCsKo4lg2cDD4LbY4l5jGAfO1JMHA3dwwTn9r
	m06VZ2dRg6l39XHCjMlTO9UE+TJtx2ESrrraAHBkSejpEFBC8IQoXYDaQmYSYPaT8ZzLY4kcsyC
	MNnPk=
X-Gm-Gg: ASbGncu9bYbfg80Hjw973iSTqr0/c9j8SYWfhrof7/iuZuUpvUGVNd47pkgWv4Mnty4
	EZdZ8gYAsBLYWHWeyGJM10Z1Lst7sw2FE2qadx+0hyTRDnMf6P3GBWJJdVOj2FXAHOZ+5baq4aL
	4HqHbDyfOz7I5DY+kNKIxOnokeH7Mq5Ij2gDLGRkfqx0decJesyszxFwczGfwWfebGFTxiLZ/6s
	Rt1kXSYRa3vqFQTAJZhkSBbsazMpmuVQMX79hOb+eCNVFMVZQlGv90LCuAVXwEH48xNf0gWbDAL
	u8wVdao/8xqor0CFKe0bpKaOXSiE7g==
X-Received: by 2002:a05:6000:481e:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-3864ce54f0amr29302f8f.15.1733853165540;
        Tue, 10 Dec 2024 09:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlIRanMyPY49k8LLWBeegAF0qzuzxLDFrLJbgvoiFUR/M2x7SIW77Vh90AfjtffquLWIfLFA==
X-Received: by 2002:a05:6000:481e:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-3864ce54f0amr29278f8f.15.1733853164983;
        Tue, 10 Dec 2024 09:52:44 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f387d112sm100286945e9.30.2024.12.10.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:52:44 -0800 (PST)
Date: Tue, 10 Dec 2024 18:52:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 2/8] vhost: Add the vhost_worker to support kthread
Message-ID: <tah7oyn43szvjmuzdatcaysonqlzel5zok2ancuupk5eir2hh3@xfq7uacjn7rn>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241210164456.925060-3-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i--s087II3i_BlZIy2McupWLNsM-qPJf_-q8_CUQyO8_1733853166
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 11, 2024 at 12:41:41AM +0800, Cindy Lu wrote:
>Add the previously removed function vhost_worker() back
>to support the kthread and rename it to vhost_run_work_kthread_list.
>
>The old function vhost_worker was change to support task in

s/change/changed

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>change to xarray in

"and to support multiple workers per device using xarray in"

>commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 38 insertions(+)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index eaddbd39c29b..1feba29abf95 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> 	__vhost_vq_meta_reset(vq);
> }
>
>+static int vhost_run_work_kthread_list(void *data)
>+{
>+	struct vhost_worker *worker = data;
>+	struct vhost_work *work, *work_next;
>+	struct vhost_dev *dev = worker->dev;
>+	struct llist_node *node;
>+
>+	kthread_use_mm(dev->mm);
>+
>+	for (;;) {
>+		/* mb paired w/ kthread_stop */
>+		set_current_state(TASK_INTERRUPTIBLE);
>+
>+		if (kthread_should_stop()) {
>+			__set_current_state(TASK_RUNNING);
>+			break;
>+		}
>+		node = llist_del_all(&worker->work_list);
>+		if (!node)
>+			schedule();
>+
>+		node = llist_reverse_order(node);
>+		/* make sure flag is seen after deletion */
>+		smp_wmb();
>+		llist_for_each_entry_safe(work, work_next, node, node) {
>+			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>+			__set_current_state(TASK_RUNNING);
>+			kcov_remote_start_common(worker->kcov_handle);
>+			work->fn(work);
>+			kcov_remote_stop();
>+			cond_resched();
>+		}
>+	}
>+	kthread_unuse_mm(dev->mm);
>+
>+	return 0;
>+}
>+
> static bool vhost_run_work_list(void *data)
> {
> 	struct vhost_worker *worker = data;
>-- 
>2.45.0
>

