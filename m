Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2B224222
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 09:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560722; cv=none; b=hDjJKKSAEqW49nXyfsP/Xq8thNR+gDdt8Y8jmHE63Pc9UeTOc7oXNwc4B2s7eNroPS2TgVDvvAhFUAv9j4KE8r98jdlYkV32efneTBvvbYjYOMemVqeoh0IxlZQqp/qJ6ymK4sVhCK7fMTTX1Qe3VzpbLMogqF4I5tlwvvsDU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560722; c=relaxed/simple;
	bh=70Bz6bXCIZd7CqL1a4wfBpVEIhFZTwDuQ4RJXOiwz4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eYJn/oCeEI4+cYH7CosegWBM+mW1DSEI/xnwTOS7BjSBsoFvfkBcUafFZW29ydF2GwZFQlRi8NisAMwdhKvcuP0Kkt/bR/9Ja3oYL6uR9Ru0ZlpHhOHQwvJH4P2sKDqf8G9J7Oon43BQgQeGxG9In6aEPNojhualarsFkFK5IvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXYrtyjY; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXYrtyjY"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F83560B0D
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 09:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjpquikFEobb for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Feb 2025 09:05:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8374560A8C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8374560A8C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SXYrtyjY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8374560A8C
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740560716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O3R3qxZExX3qPpR7lrGEQWDQ55EmOXnXBA4eKFTOeSc=;
	b=SXYrtyjYLDyOzq5h1OxEf+rUCZ1vgPQLa8m8SxRwjYej6ZnloWiAXavyPvC61CsD6owxh5
	rMjHigFAe8p7DpzDLLzM8aoMNJuPEytjFFzaju2+WY3k69OTG4Pk0xapzBcV/UzZy6s78L
	lpydDRtBMq9PKVy82nf9fXfKfm4RWoI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-lFah82Z7MKijlDpt8oQkfQ-1; Wed, 26 Feb 2025 04:05:14 -0500
X-MC-Unique: lFah82Z7MKijlDpt8oQkfQ-1
X-Mimecast-MFC-AGG-ID: lFah82Z7MKijlDpt8oQkfQ_1740560714
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5e0bff433cbso4350528a12.2
        for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 01:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560713; x=1741165513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3R3qxZExX3qPpR7lrGEQWDQ55EmOXnXBA4eKFTOeSc=;
        b=WcDT5YaiIEWpJSldZdNBHxSMqURL1okEXu+UMsetBazrkuxn/yo4mCKDOdZMkZy3zm
         HDDSggAUnWywABbdY2guSWhKLI2MyAj+Vixb9zUtLdGMp+49IEdU2uUbEZ1L9aLB9tF8
         6uRdwL6wCpInKCCshglGTXbsXMyg+vEsc/rc4uXK3Kncfum5qsNOVq78kerE3M+D4urv
         kfqBncVFFxTgZMIfKLohawhUubtvYduU8Zc+K5TgsOg1Oat6if0N5TW1qKFjLttaAfjB
         nPNI7LeAgRi3aSZmYsAww3lFLwYcWCNS64PgFHMcNrSXu/hDDgnzK1/KE0Yt+gqep3mA
         WqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL3ZkkIZFUGDkkhoBAEob2oKIdo3LSEMCD7Pgsl18q0eMr/0KjObKINrxpsITU6HytPfVje5zN65skBfgiJQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwoW2pVHIsv7L6OzwIqYljmtSzn+53jv54UAVMsTTPU+gjXuY97
	HujhVKaFvSjL8uN4da9mx8E2U9JL4jJLqBlPZ/Ncc3MdQlMVW6glFDwJJtXTvyl6Y/r5YI2e6A6
	m4LPFJEM6Taa/2B1AaxGJ777v/vnJr4JsFRObKDBmQ5dVOc0OqCDoYZUKgkDQE+R7wP4e2QxbyV
	gxFrc=
X-Gm-Gg: ASbGncsv+yrJX64PXvoKBIEV+5CX8uzoRmZhDA+RrdJPL+8YyDwUTfqEvrW4JSfs/ig
	i9J+4TcXrmlAL8uawWpR132V3eka1Xl0Z8sQce2vQZ3jIwjV+jTGtzZiussf9SoMxC0mQTBaDVY
	PdT7xE+mOnr3em4Aqann6vAc1DZzqJltCrI0XVwh8nw8lFpm8IcYk8RtpP2PRQ+5pjoP7vi8UHV
	pmBbMBUzyqVfx0YM2jnpB3u2FUyxmtAxVAbRQcepeQIXA+DR2hGQyPEOzNfUzS8xZmRqJq8byaH
	J8LAX6xh4kbED0jfw64=
X-Received: by 2002:a05:6402:35c9:b0:5dc:1f35:563 with SMTP id 4fb4d7f45d1cf-5e4a0d45ce0mr2974871a12.7.1740560713394;
        Wed, 26 Feb 2025 01:05:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE494TvftaZSM3XnKjm3rhP+LMRh6Vk2MpaWmBgbVXsiLnzb3YS6LBhcMLOzYGoliBdZ979FA==
X-Received: by 2002:a05:6402:35c9:b0:5dc:1f35:563 with SMTP id 4fb4d7f45d1cf-5e4a0d45ce0mr2974810a12.7.1740560712818;
        Wed, 26 Feb 2025 01:05:12 -0800 (PST)
Received: from sgarzare-redhat ([5.179.186.222])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45b80b94fsm2569435a12.42.2025.02.26.01.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 01:05:11 -0800 (PST)
Date: Wed, 26 Feb 2025 10:05:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <77uzlntuxfzcj4qxggac23g73hslbkstygunqus33hzwrmotzq@f2t22l52xqdo>
References: <20250223154042.556001-1-lulu@redhat.com>
 <20250223154042.556001-6-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250223154042.556001-6-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k5nnha_BnCpH2QdhX6J4R6sn0KHZTcmPg9MRxWjUb20_1740560714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
>Add a new UAPI to enable setting the vhost device to task mode.
>The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
>to configure the mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> 2 files changed, 40 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index d8c0ea118bb1..45d8f5c5bca9 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
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
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
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
>index b95dd84eef2d..8f558b433536 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,22 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device
>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1:
>+ *   - The VHOST worker threads inherit its values/checks from
>+ *     the thread that owns the VHOST device, The vhost threads will
>+ *     be counted in the nproc rlimits.

Should we document that this (inherit_owner = 1) is the default, so if 
the user doesn't call VHOST_FORK_FROM_OWNER, this mode will be 
automatically selected?

Thanks,
Stefano

>+ *
>+ * When inherit_owner is set to 0:
>+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
>+ *     implementation, which may be preferred by older userspace applications that
>+ *     do not utilize the newer vhost_task concept.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>

