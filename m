Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552FE144309
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716461070; cv=none; b=k9aLYYFUtpsGduPJbJDRIFQXaY4md8DxVMYa209JCE17KJp3MB+cy+2/91L9B8RhVMYfupiU7sCQA1YQr/VM6omuwNQ+9XG+skLdnMEreYGsDrdJm2jywYknOTsg/SB3A5RTIWeeScGXnn4E7GhKpNjjc9KSuaOXLGGbHtBtzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716461070; c=relaxed/simple;
	bh=5hx2fSiT2DY4uOpmEnaz0dH8rVhtHW/XCwPNtgDvYrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=EMhN/bOGAZtU3OZwgdjecpK8V9gF5njc+tKPP/6ERiig+v0tU5NtPQ+NG7jARhTR6xGgLtjAeesQH+wCvIXwmDSun929QX4xGINt+xx8kiQUPEX/PKH9s7AgINVaZjwWR/n6b+RUR7BXDyzPPqY+QUaZqeHE9wJJx5NmO/NVfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKMVk7Rm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKMVk7Rm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716461068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+b8FaGjpy1m/+RszNBOW0Osd/3HyG6oUQQPlglChFwA=;
	b=RKMVk7RmTG1hNUhWzAfHc6aReLM3f8oR64C70RfxHI2uB23uFYMt3+isvpoz75jFgkO9ST
	H2+g4E8PKh1X8C4T33avuDQkEjxJITnMmsuMrt0rVbWgfI8RRpymhYl+3tXWWFWSa1wz4V
	zoslFU/EgNZC55+xVDir93t+//c47Y8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-zfVf1PFsNkmru0YZpsD6XQ-1; Thu, 23 May 2024 06:44:25 -0400
X-MC-Unique: zfVf1PFsNkmru0YZpsD6XQ-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-48a33435f58so110831137.3
        for <virtualization@lists.linux.dev>; Thu, 23 May 2024 03:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716461065; x=1717065865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b8FaGjpy1m/+RszNBOW0Osd/3HyG6oUQQPlglChFwA=;
        b=LxMkuJ/1YSOiCiMbyoqR9b+3JFF1E3bwSk/O/9bKyEzXbCI8srB2PfAn80EzxDEGvA
         84qOshX5mpdqU76Z4IMwqZqH+ft1s9J11L6mdUeUWK8zeK1lEbzDD8FVbOJCy7KjlVAA
         I5ASNz/bAL24RtMg6b6eYtKKgvpXKQCz0/81mH6DmFSR8afImLM1oy38Z59wabWWJjq/
         Q1tQJ/4R/Ql7Df09Nq5mFze6JJk9VFv5w6Cr7OKdZrHCF3mg4H+0s0UzYRFsb4dx7FkJ
         0+GubdLnaSn8GarEpdb7nZ3d3gVWMQA19CrdAVpMV6KdU3DgnSPF5CYzZqmjtLlMNLlj
         doAA==
X-Forwarded-Encrypted: i=1; AJvYcCVq6YJnxnDIzebuFtxeUiJpdxS3yaakgQZmUxLd58msXxMkQnkO+kIR4KIeMZl7a1UnGp56oNv84O5Aj8tM4QORM+5iqzV0gAtpHHVBgC8=
X-Gm-Message-State: AOJu0YzshQcTLJMk7bLFcOPtynWwHTBjGrCI70LRe6e9MEGNc8lnv9lc
	Q1zvJqr/6V3c+xCF/1wt5dyF+sC9E+KwyEAotFVMQfJ41zcx/1QEJR1Pv7GD95tM+SJyXoH3BHA
	Xl1HrrFo/QJWmBJLwu9XTb/CV/UP6eWtnmdEUfCZqvUAS1RVsjWJEeCXQ3U1L9ie/
X-Received: by 2002:a05:6102:6ce:b0:47e:ee4d:8431 with SMTP id ada2fe7eead31-48900956d84mr4979035137.3.1716461065128;
        Thu, 23 May 2024 03:44:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdYH7eg5e7F0lmFvh+zqemu/wAXsYnj8cJrd8nRmIqAi48RSdPDX0vAHPDdTcHVnbmyC6Ojw==
X-Received: by 2002:a05:6102:6ce:b0:47e:ee4d:8431 with SMTP id ada2fe7eead31-48900956d84mr4979019137.3.1716461064769;
        Thu, 23 May 2024 03:44:24 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-109.retail.telecomitalia.it. [79.53.30.109])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43f991bb19dsm25568231cf.63.2024.05.23.03.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:44:24 -0700 (PDT)
Date: Thu, 23 May 2024 12:44:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: stefanha@redhat.com, mst@redhat.com, davem@davemloft.net, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: Re: [RFC PATCH 3/5] vsock/virtio: can_msgzerocopy adapts to
 multi-devices
Message-ID: <dv6zyjbcl7zlkyzxc5q67zyq6sef6a5dz2nslb4ezscruhvi4d@pxjvo5t7zftk>
References: <20240517144607.2595798-1-niuxuewei.nxw@antgroup.com>
 <20240517144607.2595798-4-niuxuewei.nxw@antgroup.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240517144607.2595798-4-niuxuewei.nxw@antgroup.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, May 17, 2024 at 10:46:05PM GMT, Xuewei Niu wrote:
>Adds a new argument, named "cid", to let them know which `virtio_vsock` to
>be selected.
>
>Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>---
> include/linux/virtio_vsock.h            | 2 +-
> net/vmw_vsock/virtio_transport.c        | 5 ++---
> net/vmw_vsock/virtio_transport_common.c | 6 +++---
> 3 files changed, 6 insertions(+), 7 deletions(-)

Every commit in linux must be working to support bisection. So these 
changes should be made before adding multi-device support.

>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c82089dee0c8..21bfd5e0c2e7 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -168,7 +168,7 @@ struct virtio_transport {
> 	 * extra checks and can perform zerocopy transmission by
> 	 * default.
> 	 */
>-	bool (*can_msgzerocopy)(int bufs_num);
>+	bool (*can_msgzerocopy)(u32 cid, int bufs_num);
> };
>
> ssize_t
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 93d25aeafb83..998b22e5ce36 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -521,14 +521,13 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>-static bool virtio_transport_can_msgzerocopy(int bufs_num)
>+static bool virtio_transport_can_msgzerocopy(u32 cid, int bufs_num)
> {
> 	struct virtio_vsock *vsock;
> 	bool res = false;
>
> 	rcu_read_lock();
>-
>-	vsock = rcu_dereference(the_virtio_vsock);
>+	vsock = virtio_transport_get_virtio_vsock(cid);
> 	if (vsock) {
> 		struct virtqueue *vq = vsock->vqs[VSOCK_VQ_TX];
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index bed75a41419e..e7315d7b9af1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -39,7 +39,7 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
>
> static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> 				       struct virtio_vsock_pkt_info *info,
>-				       size_t pkt_len)
>+				       size_t pkt_len, unsigned int cid)
> {
> 	struct iov_iter *iov_iter;
>
>@@ -62,7 +62,7 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> 		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>
> 		/* +1 is for packet header. */
>-		return t_ops->can_msgzerocopy(pages_to_send + 1);
>+		return t_ops->can_msgzerocopy(cid, pages_to_send + 1);
> 	}
>
> 	return true;
>@@ -375,7 +375,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>
> 		if (info->msg->msg_flags & MSG_ZEROCOPY)
>-			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len, src_cid);
>
> 		if (can_zcopy)
> 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>-- 
>2.34.1
>

