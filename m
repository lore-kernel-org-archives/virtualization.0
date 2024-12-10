Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32541BEF70
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853305; cv=none; b=pQJWxT0HZ9O6/k91oWWkZ7wKEnBRnhFjcd9qZG+ksWXi9P66mwlDRX+7lJ73DNiAJjXuQJrm7EPP3bIaBB8hbD/OWoNr9EANpyzs5lqC4Vn6ojK7DHgpuNExCua7DBROy10qOMAEYdJJhIb9YMaGVERgXEBtpAbsG+Rp/JKNt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853305; c=relaxed/simple;
	bh=+JHWoW0txAbFn2WTq8OWQ00Ywq+bWkSXKgMZtrj20gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o9BfkPu5g5ghSGfcmOcCucmavb6eLHl+nZbk9Xu9NoBCILLjcAAAMY/r8Gzhzp6+9axyctYb05FnKGftw6A2GEGxtpC+4sMTYxkyZhObYAF3kDXcSTFuXkVS7o5wbcp8HxTWwp4CN1BwOgW+P5xrtmIStH3PVIswpzm7H1BVPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEOyw5RI; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEOyw5RI"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 557FB409CE
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmKEOxrgOehW for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 17:55:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 48EA3409BA
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48EA3409BA
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VEOyw5RI
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 48EA3409BA
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733853301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zcHZag8gdmNWhHO5Ak8t21hEZGlUPrLrpjy85AhZ5ZQ=;
	b=VEOyw5RIoQWEAXbFcTr94fOYuf7MoXG8oGWhyn4xNIflM/aSw64kmPfAfXjonC/VQIyWtP
	QIlwxBQUbXninhfiY1iHOAP7SFtHAI9+J7gXbFmXALpYyYnT6jXDGOQxcwVH2TNrexM4n7
	9Mk3QSirxgyKvBV+CG03ux1xH5t6stk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-61u3843KPMygSOAjAZt-qw-1; Tue, 10 Dec 2024 12:55:00 -0500
X-MC-Unique: 61u3843KPMygSOAjAZt-qw-1
X-Mimecast-MFC-AGG-ID: 61u3843KPMygSOAjAZt-qw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f1af9d31so18090665e9.2
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 09:54:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853298; x=1734458098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcHZag8gdmNWhHO5Ak8t21hEZGlUPrLrpjy85AhZ5ZQ=;
        b=rxBorbmw9D9pz8jxtPU2/xH2tml4If0j3iW7E9nWPLVcU36iAyryxHFAjaUseLfM1H
         +nD8lAhBoNarBBr/Omr7XKa7dwoTPDANEClCZcVXrz8RupYlf6CrWvL8R9YsoSa+YLaQ
         ZMJTZksS2RoicY928O6BzyYhDeDYFPQ3Gaam9N0ytSel29SE4OX9kT0bo2u5RMGmbZm2
         gx5T+RhJvRkWgh2mnP+GP4EuzcraiDTr6ChPiBFKRiH9lMVVZZXMUhh/7n8/GQY6wIe8
         9SAFBLCN4PirN5Hsm/XuCmpTXv2h/MrKo6VdNHmuQQS46SOB9EfC8atehCz4YNbHTP1j
         +ykA==
X-Forwarded-Encrypted: i=1; AJvYcCWlZc9MFjjAdRHGfDjUdKpogXWJPuWjsBuj0mq/7/BqoF8g1ikXJWPcJoj3iM39kDGVA1ei0Jr0Xfdj+PZFcQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzYpMy/rAcMw2GYCCyZRq8HU0QgMRH26oq50myRbSLDyg+fnaGM
	GprIhfmxlVVOQmG8A56Zi8WlckHiS9vR6ZQgHWk8U6uNRx/NuGWrzckVS7SS9VlumEySK+adnfM
	w86TA3BSYaFLhG3oEdIgemhLC1nsWq1baEGj7oSHoGeQuFS+GP7XoOYW2Pw5X+cPCgkYg2QG1QI
	/TVjc=
X-Gm-Gg: ASbGncu/6ox2ZgbLePpfuF2eY7WzCLB/jwvg39NR+Z5qdt47yjj6r9cAKfAh5kJHScG
	b64hyMOfSSpL3cwt2YqDmOqejUKPv3jYFeu+bzzg0f8FaktXzFkw2kq/SBphiboUPjtKP9HJuuU
	nax5mvAmdTT9qB9FQbG+L2pbRQULAKFl7ZkBkVyh0V54JbfD6hit+iFAbs+ml6AOh0OrQecFVJ1
	f7ZWvD3kRpGyN11u9+ZMTQc+GkjuZyd68vMG2F0mC7atuUYReclVj0zIdI1kn2frkXMPJ/mNig3
	dclm6cdtQt/XyoB0RbyYX7xBOqQfNg==
X-Received: by 2002:a05:600c:548d:b0:434:f8a0:9df0 with SMTP id 5b1f17b1804b1-434fff69f6bmr47410915e9.8.1733853298525;
        Tue, 10 Dec 2024 09:54:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5h5cFZjv86y3Dziyg3MBclOHJHLgdGo4xsXmVuUJMXKQPSyKhOGL2jS9vx881qRPPMi/Jfw==
X-Received: by 2002:a05:600c:548d:b0:434:f8a0:9df0 with SMTP id 5b1f17b1804b1-434fff69f6bmr47410635e9.8.1733853297872;
        Tue, 10 Dec 2024 09:54:57 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-435c1833d67sm24102865e9.5.2024.12.10.09.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 09:54:57 -0800 (PST)
Date: Tue, 10 Dec 2024 18:54:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
Message-ID: <2on4eblmkzkhecpyiwtauel6hxw6upnlh6wunfxgxvfp45cej3@6z5lzdermzeg>
References: <20241210164456.925060-1-lulu@redhat.com>
 <20241210164456.925060-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241210164456.925060-8-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9oRHyTOkgedzkS0vGgeE8yBR4seG1mMFAsCApN9okhw_1733853299
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
>Add a new UAPI to enable setting the vhost device to task mode.
>The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>to configure the mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> 2 files changed, 39 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 3e9cb99da1b5..12c3bf3d1ed4 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> {
> 	struct eventfd_ctx *ctx;
> 	u64 p;
>-	long r;
>+	long r = 0;
> 	int i, fd;
>+	u8 inherit_owner;
>
> 	/* If you are not the owner, you can become one */
> 	if (ioctl == VHOST_SET_OWNER) {
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>+	if (ioctl == VHOST_SET_INHERIT_FROM_OWNER) {
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		/* Validate the inherit_owner value, ensuring it is either 0 or 1 */
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+
>+		d->inherit_owner = (bool)inherit_owner;
>
>+		goto done;
>+	}
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..d7564d62b76d 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,22 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	
> \
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the vhost device
>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1:
>+ *   - The VHOST worker threads inherit its values/checks from
>+ *     the thread that owns the VHOST device, The vhost threads will
>+ *     be counted in the nproc rlimits.

We should mention that this is the default behaviour, so the user does 
not need to call VHOST_SET_INHERIT_FROM_OWNER if the default is okay.

>+ *
>+ * When inherit_owner is set to 0:
>+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
>+ *     implementation, which may be preferred by older userspace applications that
>+ *     do not utilize the newer vhost_task concept.
>+ */
>+#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)

Do we really need a parameter? I mean could we just have an IOCTL to set 
the old behavior, since the new one is enabled by default?

Not a strong opinion on that, but just an idea to reduce confusion in 
the user. Anyway, if we want the parameter, maybe we can use int instead 
of u8, since we don't particularly care about the length.

Thanks,
Stefano

>+
> #endif
>-- 
>2.45.0
>

