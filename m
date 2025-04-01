Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F351EF080
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515862; cv=none; b=EDSbJyZBH22IJqx9Pok1fgX8q2nzWh5pAODDaGfKy72rkH9nmwHnpt3H01h+QAjAapRuHiV/YP1ch4SoMutObbqeAQveQNSvocWz/0m8JZEj4eT7J6bWv/RImKY850Fomw9qUUQopZs8c3Mrlmlv3sAK/CipElQr85LP7ZbNyBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515862; c=relaxed/simple;
	bh=Ei4o2YiJCXeec+uFKDsiydnj+4SkZPbIQelCXI4KKNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bFn3mmYIKygBddtHqEtZQByhJoMKjR3M92vWnzT7RGdfqXi0HTbEc5f9i+kaN7RiRf/dpThxdzfgqrSU/nAT6Pi75qvO44a7oei/ywmEHiQ5O1TkbRZG+w9S65HxNbcGjHOiS5VcB3SyfpirnIJmfE+PO1rhnOtOaL4cRX5EwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JybBy0bA; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JybBy0bA"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60BE240FE8
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QpZBOJOLiKux for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Apr 2025 13:57:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B05CE403F6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B05CE403F6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JybBy0bA
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B05CE403F6
	for <virtualization@lists.linux-foundation.org>; Tue,  1 Apr 2025 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743515858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nK9hIRueLujXj1So3EtFD3gYBWrgxP2wNV1sCqS84Xw=;
	b=JybBy0bAteRsox6MZxHFvUYPTL+JbkK0/Xyn8wtkCsQBy2oeNSQ73dokqykx5RpPsLtyI4
	qo/uiQEU4gaRyG8TnEjUXQczAoBjt0IfMqYSSLLk/qzxqKSAJ4xGDfeg3OxIN3lF0mQ2tk
	RY+Wx/o8bzxjxmhvDAxA1vMiRcYH3EI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-zpZkYAIIONeLG1xS29IpgQ-1; Tue, 01 Apr 2025 09:57:37 -0400
X-MC-Unique: zpZkYAIIONeLG1xS29IpgQ-1
X-Mimecast-MFC-AGG-ID: zpZkYAIIONeLG1xS29IpgQ_1743515856
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913f546dfdso2933469f8f.1
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Apr 2025 06:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515856; x=1744120656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK9hIRueLujXj1So3EtFD3gYBWrgxP2wNV1sCqS84Xw=;
        b=bCnKvkMT5AEEsTtdgtLif23kKpjdXkhm8E70qYmiduT5kTfi7DAEaWuUenJxDlupIe
         puV6B4LR63uTuUOk0zIMzAYATfCwRbqvHWHbjZeBrX/5PSHgbVuPVPKrf1LVnGDZo/Fb
         yJj8Mu93YovreGVXsZk7RzAFZBqn7N7EDpYZ/mbuXqIpKlCZeTRWnZPSJ/bz3YvOGuOM
         67Yy4hUkSCsUTxg4o+KAexZuiB9jjQ5Sx04KY390xjWk0veU3ugKy1LdXaf+rrLPwcPK
         dE6l6izy2cFqy4GUTD2m5MJitFtgvQ7JGCVY/sBBlN+gbJRpIL5c31ukVebYbgEx6HGT
         WUug==
X-Forwarded-Encrypted: i=1; AJvYcCVg4cVy4aieckBpBTLXs7CfjfzgASWnpv+oI1YaLVa8Gwoznem/8tx/FzT6dWIyVEmVpOyjDW199OxLDt5qhg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywj3vPen+eaeF8Klda58V3mdEYYc7FObbcckRgbAUj6rcqRMACA
	4PbqnYeWdSiW1GyL5A+yU3ObwZx2z1YyqdkG3/cJha3jBKtjm/UorHFBz4jjs4moTRqbfNcQzc4
	vLgpE+aIYm8HOyTYkdVpSXCz3gtKZM1PVUv1gprzrrQbc8gV3hOZ6HGzqEKe/lchzMCqevXHEqC
	p7cSE=
X-Gm-Gg: ASbGncuXoD5G+gFwN35mq8F6gOxBYx+iAspCA196GHPHB+kBHZBBg7pVAoxnooOO5/6
	5PE4CNvWILZp3xD1d/hE/moNDTgIMqnyejcW77PwL/Lw7UdfjgKou42IC8+pjNzT85vp9c/Gtp9
	ac8IT1KH33McNkok6MNhHrDJAMMCP4brjZXRBCjTbmvLGtDxtScsvrFSbKJd9vm9V5+TYleW5cb
	GI8jifiVIn4G5l1viPR/iKpEEtfX/qkW1TRQadXB5HaTwz5H3d6WcoXCZzQzZgfNuNBM4DY/Ui1
	2TwnDuxqULi9bPKQkcC+Jd6TfA2r9dVZvRaEVQpG6kITTaurcD3AA74FBPw=
X-Received: by 2002:a05:6000:2913:b0:39a:ca59:a626 with SMTP id ffacd0b85a97d-39c120e3e5cmr11015551f8f.28.1743515856238;
        Tue, 01 Apr 2025 06:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgTZzKaL62iArCAHG5W6zUwy/3RjZmmIeQYPk9NlRX20WPMdkLbAFtCRU8EaAYV78xSkqWEQ==
X-Received: by 2002:a05:6000:2913:b0:39a:ca59:a626 with SMTP id ffacd0b85a97d-39c120e3e5cmr11015519f8f.28.1743515855788;
        Tue, 01 Apr 2025 06:57:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8314b5e7sm201779655e9.35.2025.04.01.06.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:57:35 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:57:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 6/8] vhost: uapi to control task mode (owner vs
 kthread)
Message-ID: <pgcopzs6q6kqwlmndtbt2bdpbj3xvosjjxb7vikte3gnt643xh@5qhv5myd2cpc>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-7-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250328100359.1306072-7-lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m3l_QDRiFTcHqrWks1-RmvZvLl0Nj_wKLdRjByrpoUg_1743515856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 28, 2025 at 06:02:50PM +0800, Cindy Lu wrote:
>Add a new UAPI to configure the vhost device to use the kthread mode

nit: missing . at the end

>The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
>to choose between owner and kthread mode if necessary

Ditto

>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function

Ditto.

>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> include/uapi/linux/vhost.h | 16 ++++++++++++++++
> 2 files changed, 36 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index be97028a8baf..ff930c2e5b78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>-

As I mentioned, I'll add the Kconfig in this patch to avoid bisection 
issues.

The rest LGTM.

Thanks,
Stefano

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

