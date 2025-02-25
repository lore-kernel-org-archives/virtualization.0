Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793B267B63
	for <virtualization@lists.linux-foundation.org>; Tue, 25 Feb 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483080; cv=none; b=c7PuxbWbIW38F8xePz6F64rTOkB4NTos3J7rrSnRlaYFvRzO9h+qxCiSauAuM2g/0eOgldJ9Vc5UmdQA23545bPG2X2r2o0xgU3qYtKQGo6A2rpO1bL+PxFgahsba/zeCSYQWjHV8n6quLD8oAcqIIQ5maI/9/l1Kn6g50JGCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483080; c=relaxed/simple;
	bh=JNsvBkbU/xeGUA2wB24yiaAwvMR0TShWcVfnwYO9psk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ju4/aO/wk46J8pAGXHVSohU5h3L6gD0JVpy/oADlxpfYwkfgYd5GCId2rp6Yvs6P/It2Z1BnVkNQzajnZhdLWDOhIRrUvo/Zb8/Ymc54m+Gz/QVJ3ZH/bjF7lDGjG1wPZvys5Pt/aYbKPvSVPZ2YxV39oaddLUBKVmhTOJqDTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAuU4mwF; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAuU4mwF"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B72384060C
	for <virtualization@lists.linux-foundation.org>; Tue, 25 Feb 2025 11:31:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lD1_PvPLCCvh for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Feb 2025 11:31:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3D1E040ACE
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D1E040ACE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BAuU4mwF
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D1E040ACE
	for <virtualization@lists.linux-foundation.org>; Tue, 25 Feb 2025 11:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740483075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amu6qNJ2XLnE1PzLc9Jh3MOyLPKxqhaqigKuNJC2nTU=;
	b=BAuU4mwFFyQQo5LANcgQnZZzzO3DGucodasAnZm846hFNCRnGZfludpvM8Nq39k0O3bA2m
	v89YOZdfNoiNcfMl8PD6QlWM/m8pdfMlIp1Q7FlB2GcRkZOsY1H3thNgKBgzkVwHwcSWUk
	RijtBHlycow7b8aPy169mAfhla2YlVs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-qxT35tQ7MeifeK32oh5tmw-1; Tue, 25 Feb 2025 06:31:14 -0500
X-MC-Unique: qxT35tQ7MeifeK32oh5tmw-1
X-Mimecast-MFC-AGG-ID: qxT35tQ7MeifeK32oh5tmw_1740483073
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394c747c72so23713655e9.1
        for <virtualization@lists.linux-foundation.org>; Tue, 25 Feb 2025 03:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483073; x=1741087873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amu6qNJ2XLnE1PzLc9Jh3MOyLPKxqhaqigKuNJC2nTU=;
        b=J7w4S5Ye378iFHxdpOdZFH6ZWuDDipwFKWwJyN/6CjnZ2jcb/GkBrNC8dDIdSgXf24
         SSyWvgVAPN1LswneR1WPnxUcOZ6bgzUQ6+oXNaGl1J7OmfsSR7ZKHu4dd0vrcJmDNTCz
         FE84LREQKX1NtqEzXpTGg38Px5Z6zaAmi5F5xgGk5gziPtZIWqOyIOY9PYzw2Rj6Vorq
         oN5GM9jaaviXurLaw10CRaVx1hVpzDCbao37jodztVEpTTHvrYyaXKDUPSt2D4QWbu1e
         g44YYHme2Gf2Jce1rnqpNGWl9XDMWGl+uOK/cEWQzpy2TnfqnPCOOGKsZrMTe6Xe1N/p
         PBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYcta+krNzpd5lNFFQFbhnFPiXK9F6Tuwuyu1YjGqUIgvENRfWaqyJbfxBWw+vGeLs5FbdRki437hUPEzpLg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyAfK9FNChNfVrqpEGpigUpDEVgDfkFz7ryK+iD9E8RP4RQ24er
	qx9C+LNGngC6AlxR/gADGQpmdyhLKeYxxgGenemSfb6xfkUhd6z4O4xccnKdBbaaN41ZnQ1kHZf
	mqSrQk2dsIgv/XToAMGpGV3vh+0oqjlviv6wZAjWWOCOhP6ygDsfNsfFCArHKAx8URa14rjogaK
	0+c+k=
X-Gm-Gg: ASbGnctjhVdfcdXTNo9m2KUbyAH0ivWRzurwtKF+sbBXAeEMAEolw5TFB+whV8EvhAx
	YlvH8LYTHaDekU+a8Ylhg8dgKFojXC1wBflqXt75yrSm8EiFobjKXmAsAj7ylf5CxC2+jrNxWAC
	3d/25lORD/FNggOl4SJCIkCH/q7ZMi6DfnkH/9XAzLXzwZP1HBhyy84WxnD7jcz3zLK51nBGAgU
	IdxsCYI2BFKuJKF6DhVc7AO9LX6yQNqyUjq0h3vs5y//OE8wKO4pBh69ydkU+BMGm7aKVsWy4My
	2gm3ZsNzzHYXXfM=
X-Received: by 2002:a5d:584f:0:b0:38f:1e87:cc6e with SMTP id ffacd0b85a97d-38f6e74f270mr14234552f8f.9.1740483073113;
        Tue, 25 Feb 2025 03:31:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtz5zkAxf+n06y+uM0vFkhN66Z0eIXxRWu45tZA+nsHTF3VLjPSb93B6lqTibRPrNYImW8BA==
X-Received: by 2002:a5d:584f:0:b0:38f:1e87:cc6e with SMTP id ffacd0b85a97d-38f6e74f270mr14234497f8f.9.1740483072522;
        Tue, 25 Feb 2025 03:31:12 -0800 (PST)
Received: from sgarzare-redhat ([5.77.102.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd883934sm1996643f8f.59.2025.02.25.03.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:31:12 -0800 (PST)
Date: Tue, 25 Feb 2025 12:31:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
Message-ID: <6vadeadshznfijaugusnwqprssqirxjtbtpprvokdk6yvvo6br@5ngvuz7peqoz>
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
X-Mimecast-MFC-PROC-ID: Vb4nMpdjttnSRsUPo6jym8iFtpf4vupgAm-ntAAhbSM_1740483073
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
>+ *
>+ * When inherit_owner is set to 0:
>+ *   - The VHOST worker threads will use the traditional kernel thread (kthread)
>+ *     implementation, which may be preferred by older userspace applications that
>+ *     do not utilize the newer vhost_task concept.
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)

I don't think we really care of the size of the parameter, so can we 
just use `bool` or `unsigned int` or `int` for this IOCTL?

As we did for other IOCTLs where we had to enable/disable something (e.g 
VHOST_VSOCK_SET_RUNNING, VHOST_VDPA_SET_VRING_ENABLE).

Thanks,
Stefano

