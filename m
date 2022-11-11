Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D62C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 13:56:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2245981F61;
	Fri, 11 Nov 2022 13:56:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2245981F61
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fQvXFGNr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id is1vht5y6GMp; Fri, 11 Nov 2022 13:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 862BC81F70;
	Fri, 11 Nov 2022 13:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 862BC81F70
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B76FC0033;
	Fri, 11 Nov 2022 13:56:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 934CBC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 13:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 59FA081F70
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 13:56:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59FA081F70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsZouxLajXnd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 13:56:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 11CB781F61
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11CB781F61
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668174971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJKpwo9c5AlIwO79tP1KNz4b2zBwa7daS3MoX79E/OA=;
 b=fQvXFGNryX3XU/6wTZOEed0tsntCggxpM9o6ZC+CGQ2+ug9KXytVB45p5oCw+xtwuenTmZ
 vesiISmSiih5b/QB1VyZLF0qddI4RRjj9OSC3GARBsC2gYJ3h3y3xXNSILUhcJ+SEEoXvk
 41ZTrsL2fgsc5/ndvKu0DI3MGvEQ7So=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-UuwY_e1OMaOcQGnrbZbr0w-1; Fri, 11 Nov 2022 08:56:07 -0500
X-MC-Unique: UuwY_e1OMaOcQGnrbZbr0w-1
Received: by mail-qv1-f70.google.com with SMTP id
 ob9-20020a0562142f8900b004bba5363ad9so3677674qvb.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 05:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJKpwo9c5AlIwO79tP1KNz4b2zBwa7daS3MoX79E/OA=;
 b=d6ZGVvrtW07gA27XcuKjgCo/qEGCA1NM1xF9QI9kqa+cHbzQYcY0Wkd0NfbCVoFxEj
 xo1yylFocgMIy51EC6cWt4EGEt+c6ZRmYd3PP3aNxPci6fAgV3Isx9606v3EBsJA1Xf6
 YdAeI3KeDEOB7L/d+F6iaB1xNi3skCXGyJ7Dml3+ATxtZLTSfl8VK4k/7NsqM8ZL/7Tt
 QCX8i2hmzOzrpi9Gd0oHBS+H71+ybveBruEQoNf46Is/QHkHFsCaduMvN6VN3qNQ6tQn
 tqscoFTZGfj3GytxcoSD7pAS2LeAoKsy2pDpl8DkL0cZxB8KsUFYHWuO+nwmWwNKy2Zy
 mavA==
X-Gm-Message-State: ANoB5plIgnMuX4a396cQpaVFdNsuCQPmRUDx3N4YKULgLUkIx5zvLGlU
 YtS9dT/3614KVuVCpjpoG5OHmWjK5nqU+03O0U5gYaFsFzWzLxziJwglI2blMmZ9E0ZM5SB84tm
 L4YZNWICTDwqnBraxpBqJZPwExGrRHgRpLPngJGlu6Q==
X-Received: by 2002:a05:620a:31a6:b0:6fa:172:c37d with SMTP id
 bi38-20020a05620a31a600b006fa0172c37dmr1097469qkb.92.1668174967415; 
 Fri, 11 Nov 2022 05:56:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6E5N9TDha/oV3wOK0mu591qSZ1deevMEXV4lCRSdcvw2q6QTjtAAHLB3tamhyy49x6iMriNA==
X-Received: by 2002:a05:620a:31a6:b0:6fa:172:c37d with SMTP id
 bi38-20020a05620a31a600b006fa0172c37dmr1097448qkb.92.1668174967146; 
 Fri, 11 Nov 2022 05:56:07 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 ay13-20020a05620a178d00b006b929a56a2bsm1486708qkb.3.2022.11.11.05.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Nov 2022 05:56:06 -0800 (PST)
Date: Fri, 11 Nov 2022 14:55:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 03/11] af_vsock: add zerocopy receive logic
Message-ID: <20221111135549.2fqufprbc3muedmr@sgarzare-redhat>
References: <f60d7e94-795d-06fd-0321-6972533700c5@sberdevices.ru>
 <7aeba781-db09-9be1-a9a3-a4c16da38fb5@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <7aeba781-db09-9be1-a9a3-a4c16da38fb5@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, Nov 06, 2022 at 07:40:12PM +0000, Arseniy Krasnov wrote:
>This:
>1) Adds callback for 'mmap()' call on socket. It checks vm area flags
>   and sets vm area ops.
>2) Adds special 'getsockopt()' case which calls transport zerocopy
>   callback. Input argument is vm area address.
>3) Adds 'getsockopt()/setsockopt()' for switching on/off rx zerocopy
>   mode.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h          |   8 ++
> include/uapi/linux/vm_sockets.h |   3 +
> net/vmw_vsock/af_vsock.c        | 187 +++++++++++++++++++++++++++++++-
> 3 files changed, 196 insertions(+), 2 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 568a87c5e0d0..e4f12ef8e623 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -73,6 +73,8 @@ struct vsock_sock {
>
> 	/* Private to transport. */
> 	void *trans;
>+
>+	bool rx_zerocopy_on;

Maybe better to leave the last fields the private ones to transports, so 
I would say put it before trans;

> };
>
> s64 vsock_stream_has_data(struct vsock_sock *vsk);
>@@ -138,6 +140,12 @@ struct vsock_transport {
> 	bool (*stream_allow)(u32 cid, u32 port);
> 	int (*set_rcvlowat)(struct vsock_sock *vsk, int val);
>
>+	int (*zerocopy_rx_mmap)(struct vsock_sock *vsk,
>+				struct vm_area_struct *vma);
>+	int (*zerocopy_dequeue)(struct vsock_sock *vsk,
>+				struct page **pages,
>+				unsigned long *pages_num);
>+
> 	/* SEQ_PACKET. */
> 	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
> 				     int flags);
>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>index c60ca33eac59..d1f792bed1a7 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -83,6 +83,9 @@
>
> #define SO_VM_SOCKETS_CONNECT_TIMEOUT_NEW 8
>
>+#define SO_VM_SOCKETS_MAP_RX 9
>+#define SO_VM_SOCKETS_ZEROCOPY 10

Before removing RFC, we should document these macros because they are 
exposed to the user.

>+
> #if !defined(__KERNEL__)
> #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && 
> defined(__ILP32__))
> #define SO_VM_SOCKETS_CONNECT_TIMEOUT SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ee418701cdee..21a915eb0820 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1663,6 +1663,16 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 		}
> 		break;
> 	}
>+	case SO_VM_SOCKETS_ZEROCOPY: {
>+		if (sock->state != SS_UNCONNECTED) {
>+			err = -EOPNOTSUPP;
>+			break;
>+		}
>+
>+		COPY_IN(val);
>+		vsk->rx_zerocopy_on = val;
>+		break;
>+	}
>
> 	default:
> 		err = -ENOPROTOOPT;
>@@ -1676,6 +1686,124 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 	return err;
> }
>
>+static const struct vm_operations_struct afvsock_vm_ops = {
>+};
>+
>+static int vsock_recv_zerocopy(struct socket *sock,
>+			       unsigned long address)
>+{
>+	const struct vsock_transport *transport;
>+	struct vm_area_struct *vma;
>+	unsigned long vma_pages;
>+	struct vsock_sock *vsk;
>+	struct page **pages;
>+	struct sock *sk;
>+	int err;
>+	int i;
>+
>+	sk = sock->sk;
>+	vsk = vsock_sk(sk);
>+	err = 0;
>+
>+	lock_sock(sk);
>+
>+	if (!vsk->rx_zerocopy_on) {
>+		err = -EOPNOTSUPP;
>+		goto out_unlock_sock;
>+	}
>+
>+	transport = vsk->transport;
>+
>+	if (!transport->zerocopy_dequeue) {
>+		err = -EOPNOTSUPP;
>+		goto out_unlock_sock;
>+	}
>+
>+	mmap_write_lock(current->mm);
>+
>+	vma = vma_lookup(current->mm, address);
>+
>+	if (!vma || vma->vm_ops != &afvsock_vm_ops) {
>+		err = -EINVAL;
>+		goto out_unlock_vma;
>+	}
>+
>+	/* Allow to use vm area only from the first page. */
>+	if (vma->vm_start != address) {
>+		err = -EINVAL;
>+		goto out_unlock_vma;
>+	}
>+
>+	vma_pages = (vma->vm_end - vma->vm_start) / PAGE_SIZE;
>+	pages = kmalloc_array(vma_pages, sizeof(pages[0]),
>+			      GFP_KERNEL | __GFP_ZERO);
>+
>+	if (!pages) {
>+		err = -EINVAL;
>+		goto out_unlock_vma;
>+	}
>+
>+	err = transport->zerocopy_dequeue(vsk, pages, &vma_pages);
>+
>+	if (err)
>+		goto out_unlock_vma;
>+
>+	/* Now 'vma_pages' contains number of pages in array.
>+	 * If array element is NULL, skip it, go to next page.
>+	 */
>+	for (i = 0; i < vma_pages; i++) {
>+		if (pages[i]) {
>+			unsigned long pages_inserted;
>+
>+			pages_inserted = 1;
>+			err = vm_insert_pages(vma, address, &pages[i], &pages_inserted);
>+
>+			if (err || pages_inserted) {
>+				/* Failed to insert some pages, we have "partially"
>+				 * mapped vma. Do not return, set error code. This
>+				 * code will be returned to user. User needs to call
>+				 * 'madvise()/mmap()' to clear this vma. Anyway,
>+				 * references to all pages will to be dropped below.
>+				 */
>+				if (!err) {
>+					err = -EFAULT;
>+					break;
>+				}
>+			}
>+		}
>+
>+		address += PAGE_SIZE;
>+	}
>+
>+	i = 0;
>+
>+	while (i < vma_pages) {
>+		/* Drop ref count for all pages, returned by transport.
>+		 * We call 'put_page()' only once, as transport needed
>+		 * to 'get_page()' at least only once also, to prevent
>+		 * pages being freed. If transport calls 'get_page()'
>+		 * more twice or more for every page - we don't care,
>+		 * if transport calls 'get_page()' only one time, this
>+		 * meanse that every page had ref count equal to 1,then
>+		 * 'vm_insert_pages()' increments it to 2. After this
>+		 * loop, ref count will be 1 again, and page will be
>+		 * returned to allocator by user.
>+		 */
>+		if (pages[i])
>+			put_page(pages[i]);
>+		i++;
>+	}
>+
>+	kfree(pages);
>+
>+out_unlock_vma:
>+	mmap_write_unlock(current->mm);
>+out_unlock_sock:
>+	release_sock(sk);
>+
>+	return err;
>+}
>+
> static int vsock_connectible_getsockopt(struct socket *sock,
> 					int level, int optname,
> 					char __user *optval,
>@@ -1720,6 +1848,26 @@ static int vsock_connectible_getsockopt(struct socket *sock,
> 		lv = sock_get_timeout(vsk->connect_timeout, &v,
> 				      optname == SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD);
> 		break;
>+	case SO_VM_SOCKETS_ZEROCOPY: {
>+		lock_sock(sk);
>+
>+		v.val64 = vsk->rx_zerocopy_on;
>+
>+		release_sock(sk);
>+
>+		break;
>+	}
>+	case SO_VM_SOCKETS_MAP_RX: {
>+		unsigned long vma_addr;
>+
>+		if (len < sizeof(vma_addr))
>+			return -EINVAL;
>+
>+		if (copy_from_user(&vma_addr, optval, sizeof(vma_addr)))
>+			return -EFAULT;
>+
>+		return vsock_recv_zerocopy(sock, vma_addr);
>+	}
>
> 	default:
> 		return -ENOPROTOOPT;
>@@ -2167,6 +2315,41 @@ static int vsock_set_rcvlowat(struct sock *sk, int val)
> 	return 0;
> }
>
>+static int afvsock_mmap(struct file *file, struct socket *sock,
>+			struct vm_area_struct *vma)
>+{
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	struct sock *sk;
>+	int err;
>+
>+	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
>+		return -EPERM;
>+
>+	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
>+	vma->vm_flags |= (VM_MIXEDMAP);
>+	vma->vm_ops = &afvsock_vm_ops;
>+
>+	sk = sock->sk;
>+	vsk = vsock_sk(sk);
>+
>+	lock_sock(sk);
>+
>+	transport = vsk->transport;
>+
>+	if (!transport || !transport->zerocopy_rx_mmap) {
>+		err = -EOPNOTSUPP;
>+		goto out_unlock;
>+	}
>+
>+	err = transport->zerocopy_rx_mmap(vsk, vma);
>+
>+out_unlock:
>+	release_sock(sk);
>+
>+	return err;
>+}
>+
> static const struct proto_ops vsock_stream_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>@@ -2184,7 +2367,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.getsockopt = vsock_connectible_getsockopt,
> 	.sendmsg = vsock_connectible_sendmsg,
> 	.recvmsg = vsock_connectible_recvmsg,
>-	.mmap = sock_no_mmap,
>+	.mmap = afvsock_mmap,
> 	.sendpage = sock_no_sendpage,
> 	.set_rcvlowat = vsock_set_rcvlowat,
> };
>@@ -2206,7 +2389,7 @@ static const struct proto_ops vsock_seqpacket_ops = {
> 	.getsockopt = vsock_connectible_getsockopt,
> 	.sendmsg = vsock_connectible_sendmsg,
> 	.recvmsg = vsock_connectible_recvmsg,
>-	.mmap = sock_no_mmap,
>+	.mmap = afvsock_mmap,
> 	.sendpage = sock_no_sendpage,
> };
>
>-- 
>2.35.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
