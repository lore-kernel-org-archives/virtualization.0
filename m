Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3727D780
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329569; cv=none; b=m/jTy495B9y4xNKqGbl3yUWd2tX1QgNMbC3I+k3ai896Jgb4ntSxt44D6lvt1wrBGeyDVuEoATfxzDpjmJiiCIt6C2rsZGHu+wyJdNCeV7PwhNtcM5pWqHPOiLL7fSeYp19ED4PMb+q5ovuxGXwqSaJYJMYLc5iY2NjjPRPepBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329569; c=relaxed/simple;
	bh=/28bbrd+BiKbMHtPd1h52hCg8uYfjd0/OaBPvTeuaP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qluxjKeiaFC/I6W22HXjTvHKqyy5i+9koLz/R9cPJ/vu8LIeAj6oIXt93gcbaLWjJDkKBNO7VVPYF0ppBKt8yn9Yr4vdniJ/3ywBtp1IjJ0zbWE17PENzVgyix5MccRRv9grixQvGccRo8AvIL0+uxUclKOU9OQkfSONl63hgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcGkpDav; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcGkpDav"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 876D040498
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:46:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TfvnTRTDBEpq for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Apr 2025 13:46:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B9B2E4043A
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9B2E4043A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TcGkpDav
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B9B2E4043A
	for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745329565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hr43FBt5Kf90a/anZXagBnPduPdmPMmZnfi9PtbkADQ=;
	b=TcGkpDavVxGnpgtld31nykuE7SymF5IFcSwAYMnsDjgBUFKiIn0pGkJhpFUjg/3k/+Fn+0
	i3gKBAF7tyiW6HeoDDDQa8GKz1DrxR0zr6cy6KxxHLgaMmmjMcSU8lNFbT0Bpy2tQOZGxb
	fdh68nw775Layxe2Gp5cc1ueubX0xwo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-9M-lka7SPTG5oi5rCcikxQ-1; Tue, 22 Apr 2025 09:46:03 -0400
X-MC-Unique: 9M-lka7SPTG5oi5rCcikxQ-1
X-Mimecast-MFC-AGG-ID: 9M-lka7SPTG5oi5rCcikxQ_1745329562
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acb8d1231ffso150225066b.2
        for <virtualization@lists.linux-foundation.org>; Tue, 22 Apr 2025 06:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329562; x=1745934362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hr43FBt5Kf90a/anZXagBnPduPdmPMmZnfi9PtbkADQ=;
        b=nY47U3XjTs6Rz7O2s/QLpqFCWZWAuDvvxeruisYN2Xp1gM7e8mLA68ojodHCFVQS+R
         xmay8sIF0skYjDURKy7oWTs7K/3H+PGd9pgzJfA6W58uGPkRdwdMjskT9z44J0S6MxtW
         d1VoShiqmiZ8UXov5JN8hiK49Jgf9LAt+geosOk43lORkIVhFqMvicd5LnOa5OPI3Kxq
         ZeWBoIpMlbCmaOsP0Q+CJdfmSsHgW5b6rKAI7bAuyEbuvsN48Ddh1JiLOjENU1wS9ZHy
         nPYSEy6KPcWIwm70b4AK6dZmWEzupOLFfMXDD8RxfKIZ09ZKcVHnO+hTItf9AaJ6NWEe
         +Wmg==
X-Forwarded-Encrypted: i=1; AJvYcCUI9fhOMPJ0y8uBxC6iEMcLUEIkFFnuOiJYkxNJ6erKFaFJhN/4CkQq4OhLZ8liZ36nepL/9VaGgto4Ou86tw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyqB/kyBC/XGIbt2SFd1PEw5GxUFhhKj5WRnFjwaGYuQyjZSnV6
	DG6lSSQ/u/6nbihsOMrPaVGOgCOefIDcAHdjdUWp/z/rSHiCNScqr8DjbsKuM87fI/fcIppsdeD
	yFzD2t6EOQErpQoJc3LYUk6Zl/tPSVbwYrE7gfQ0vzEXIN48rhOI7vgaeDgYDIw8fEJDxinwHep
	idG4s=
X-Gm-Gg: ASbGncvToR6OpTNcU7o0ETq3t5DFjyFHmQOIB/635T/oiAd6VZEVoKSmQR+NjlT59P0
	TnV17Ht7oDSfmtJHTjbKMRlvZtnF34Eae97nZLF49fpHv0jM1I5Z3wnmPQd42B39NucslvXlg7k
	2JVThKJPSE6xtNCz4R4D2HgWQlHYBiSLgiz/Z0vtBevDbi7QV8NvTqLDqvkwaf5+XpV/uPJ9nXp
	Z6U7ed7z91aVecvE7Ej+f2aWQ+4f1xpBundo1j/HpFurYiu45/jcXDkAAYC10KM8bId1KAjncGk
	USKuvPwnOSdRcK8j
X-Received: by 2002:a17:907:3f96:b0:aca:b45a:7c86 with SMTP id a640c23a62f3a-acb74aa9323mr1458679066b.1.1745329562505;
        Tue, 22 Apr 2025 06:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr+SdKMSl5/dVJr+La2Ltp5evEokv1RwOavIWfnmNE1377Mp9Jz6N1IVAbz5B+i9vkXcgT3A==
X-Received: by 2002:a17:907:3f96:b0:aca:b45a:7c86 with SMTP id a640c23a62f3a-acb74aa9323mr1458675766b.1.1745329561899;
        Tue, 22 Apr 2025 06:46:01 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.218.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec502bcsm663384966b.66.2025.04.22.06.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:46:01 -0700 (PDT)
Date: Tue, 22 Apr 2025 15:45:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v9 3/4] vhost: add VHOST_FORK_FROM_OWNER ioctl and
 validate inherit_owner
Message-ID: <zd4njyzxo6jnmrthhsgo26t7t44tjfkkd7aghzd237s2h5pwf6@nmwhp43dvlj6>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250421024457.112163-4-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 43i-ZMvK0BCRJBl5LAMR_7FmyGCS0ypRE_KgbfUoI1Q_1745329562
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Apr 21, 2025 at 10:44:09AM +0800, Cindy Lu wrote:
>Add a new UAPI to configure the vhost device to use the kthread mode.
>The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
>to choose between owner and kthread mode if necessary.
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function.
>
>In addition, the VHOST_NEW_WORKER requires the inherit_owner
>setting to be true. So we need to add a check for this.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 29 +++++++++++++++++++++++++++--
> include/uapi/linux/vhost.h | 16 ++++++++++++++++
> 2 files changed, 43 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index be97028a8baf..fb0c7fb43f78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
> 	switch (ioctl) {
> 	/* dev worker ioctls */
> 	case VHOST_NEW_WORKER:
>+		/*
>+		 * vhost_tasks will account for worker threads under the parent's
>+		 * NPROC value but kthreads do not. To avoid userspace overflowing
>+		 * the system with worker threads inherit_owner must be true.
>+		 */
>+		if (!dev->inherit_owner)
>+			return -EFAULT;
> 		ret = vhost_new_worker(dev, &state);
> 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
> 			ret = -EFAULT;
>@@ -1134,7 +1141,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-

nit: I'd avoid removing this empty line, it helps while reading code.

>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2287,7 +2294,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>-
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
>+		u8 inherit_owner;
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+		d->inherit_owner = (bool)inherit_owner;
>+		r = 0;
>+		goto done;
>+	}

Ditto, an empty like should help to separate to the next step.

> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..1ae0917bfeca 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,20 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device,
>+ * This ioctl must called before VHOST_SET_OWNER.

Shoud we mention that this IOCTL is only supported if 
CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is y?

>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1(default value):
>+ *   - Vhost will create tasks similar to processes forked from the owner,
>+ *     inheriting all of the owner's attributes.
>+ *
>+ * When inherit_owner is set to 0:
>+ *   - Vhost will create tasks as kernel thread.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>

