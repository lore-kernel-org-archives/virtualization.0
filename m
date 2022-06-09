Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFD9C43334
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 08:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72C94401A2;
	Thu,  9 Jun 2022 08:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nMYDaP939KM; Thu,  9 Jun 2022 08:39:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C117940BED;
	Thu,  9 Jun 2022 08:39:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98E6EC0039;
	Thu,  9 Jun 2022 08:39:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61D06C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:39:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 420FB41C3E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YoevK7QPws_J
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:39:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EEBB2415C6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654763975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkEmK5Yjp3T2Zha/9EpqMwyl5wd2BEswY0cUWBW6j8E=;
 b=HLhWBYpxmgl5DFdeSKfyBhBXvXi1VPEORXFwvYlOzzEqZ7jR6UD92grTSaIwvqcD09uLcY
 R7s30RkWKu69AVLV6QcBO7UJi100W5C1pWYRpMUQ97aXdnlJwjSR1HoaJ1nuHBrEqm3TE7
 0Xg2X4+sk7uFgCG67UpI+u0SYWANJg0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-crlvKNvrOLa32Y-a9VoqCg-1; Thu, 09 Jun 2022 04:39:34 -0400
X-MC-Unique: crlvKNvrOLa32Y-a9VoqCg-1
Received: by mail-wr1-f70.google.com with SMTP id
 y2-20020adff142000000b0021581245fa1so4170095wro.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Jun 2022 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FkEmK5Yjp3T2Zha/9EpqMwyl5wd2BEswY0cUWBW6j8E=;
 b=Mt/m++bbkzNuqaVAJHnKh/egcxaa+eAaadt9lx+YbVW8LssTCgB0iUD2mWukI1yUf1
 uL1vARSOYOTpdxTWdN1ojgANpLo3ivyGm30+74BUu3b4oJ98Llukum69wgMQsyr1Wvsz
 eUR+VEPGcmlYM48iZYDO7n4xlYgsoKGLL06JXktdNeXnq8QWXqn+ycww/3mFnO1q1C3B
 wbXjCr+hAD+h/xPXUg7JkeQAntapwF5MFKQrlq374ov2Jht+SujMxtFdLiuaMIpAN70t
 uF2qdkimtqYNRHmflL7qku0Z5iiFSh822Zb2KDPjsG/BGA6oqog7bOpuUZwQTFIlICGH
 7fIQ==
X-Gm-Message-State: AOAM5310kBeT5Ofv2qKufNO5/45Iu7XX0c1IIm1Y7kTMZJ6QHAbMK5XF
 bqQFxPebWWsuEcIWw0YVDIUfMTu5QLqZBmTCMGYR1DSp/fngwaS0Go5sYyVO1Fbt/ypqndtndgY
 OZsp8WZxYhLt9lqO+bhfTQh99W3I0TH8HYXZUBihw7w==
X-Received: by 2002:a05:600c:d0:b0:39c:5927:3fa7 with SMTP id
 u16-20020a05600c00d000b0039c59273fa7mr2178806wmm.36.1654763973421; 
 Thu, 09 Jun 2022 01:39:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwipOC17XpHdu2HZYnw61hrXrs5XVkMTXD2WI/C7Xf1w4B5Nd4hlKO567xMpO1R9xcMkD1aqQ==
X-Received: by 2002:a05:600c:d0:b0:39c:5927:3fa7 with SMTP id
 u16-20020a05600c00d000b0039c59273fa7mr2178778wmm.36.1654763973160; 
 Thu, 09 Jun 2022 01:39:33 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 d16-20020a05600c34d000b003973d425a7fsm2047244wmq.41.2022.06.09.01.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jun 2022 01:39:32 -0700 (PDT)
Date: Thu, 9 Jun 2022 10:39:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 3/8] af_vsock: add zerocopy receive logic
Message-ID: <20220609083929.5k37tajo3qli4kr2@sgarzare-redhat>
References: <e37fdf9b-be80-35e1-ae7b-c9dfeae3e3db@sberdevices.ru>
 <129aa328-ad4d-cb2c-4a51-4a2bf9c9be37@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <129aa328-ad4d-cb2c-4a51-4a2bf9c9be37@sberdevices.ru>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
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

On Fri, Jun 03, 2022 at 05:35:48AM +0000, Arseniy Krasnov wrote:
>This:
>1) Adds callback for 'mmap()' call on socket. It checks vm
>   area flags and sets vm area ops.
>2) Adds special 'getsockopt()' case which calls transport
>   zerocopy callback. Input argument is vm area address.
>3) Adds 'getsockopt()/setsockopt()' for switching on/off rx
>   zerocopy mode.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/net/af_vsock.h          |   7 +++
> include/uapi/linux/vm_sockets.h |   3 +
> net/vmw_vsock/af_vsock.c        | 100 ++++++++++++++++++++++++++++++++
> 3 files changed, 110 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index f742e50207fb..f15f84c648ff 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -135,6 +135,13 @@ struct vsock_transport {
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>
>+	int (*rx_zerocopy_set)(struct vsock_sock *vsk,
>+			       bool enable);
>+	int (*rx_zerocopy_get)(struct vsock_sock *vsk);
>+	int (*zerocopy_dequeue)(struct vsock_sock *vsk,
>+				struct vm_area_struct *vma,
>+				unsigned long addr);
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
>+
> #if !defined(__KERNEL__)
> #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> #define SO_VM_SOCKETS_CONNECT_TIMEOUT SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index f04abf662ec6..10061ef21730 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1644,6 +1644,17 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 		}
> 		break;
> 	}
>+	case SO_VM_SOCKETS_ZEROCOPY: {
>+		if (!transport || !transport->rx_zerocopy_set) {
>+			err = -EOPNOTSUPP;
>+		} else {
>+			COPY_IN(val);
>+
>+			if (transport->rx_zerocopy_set(vsk, val))
>+				err = -EINVAL;
>+		}
>+		break;
>+	}
>
> 	default:
> 		err = -ENOPROTOOPT;
>@@ -1657,6 +1668,48 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 	return err;
> }
>
>+static const struct vm_operations_struct afvsock_vm_ops = {
>+};
>+
>+static int vsock_recv_zerocopy(struct socket *sock,
>+			       unsigned long address)
>+{
>+	struct sock *sk = sock->sk;
>+	struct vsock_sock *vsk = vsock_sk(sk);
>+	struct vm_area_struct *vma;
>+	const struct vsock_transport *transport;
>+	int res;
>+
>+	transport = vsk->transport;
>+
>+	if (!transport->rx_zerocopy_get)
>+		return -EOPNOTSUPP;
>+
>+	if (!transport->rx_zerocopy_get(vsk))
>+		return -EOPNOTSUPP;

Maybe we can merge in
         if (!transport->rx_zerocopy_get ||
             !transport->rx_zerocopy_get(vsk)}
                 return -EOPNOTSUPP;

>+
>+	if (!transport->zerocopy_dequeue)
>+		return -EOPNOTSUPP;
>+
>+	lock_sock(sk);
>+	mmap_write_lock(current->mm);

So, multiple threads using different sockets are serialized if they use 
zero-copy?

IIUC this is necessary because the callback calls vm_insert_page().

At this point I think it's better not to do this in every transport, but 
have the callback return an array of pages to map and we map them here 
trying to limit as much as possible the critical section to protect with 
mmap_write_lock().

>+
>+	vma = vma_lookup(current->mm, address);
>+
>+	if (!vma || vma->vm_ops != &afvsock_vm_ops) {
>+		mmap_write_unlock(current->mm);
>+		release_sock(sk);
>+		return -EINVAL;
>+	}
>+
>+	res = transport->zerocopy_dequeue(vsk, vma, address);
>+
>+	mmap_write_unlock(current->mm);
>+	release_sock(sk);
>+
>+	return res;
>+}
>+
> static int vsock_connectible_getsockopt(struct socket *sock,
> 					int level, int optname,
> 					char __user *optval,
>@@ -1701,6 +1754,39 @@ static int vsock_connectible_getsockopt(struct socket *sock,
> 		lv = sock_get_timeout(vsk->connect_timeout, &v,
> 				      optname == SO_VM_SOCKETS_CONNECT_TIMEOUT_OLD);
> 		break;
>+	case SO_VM_SOCKETS_ZEROCOPY: {
>+		const struct vsock_transport *transport;
>+		int res;
>+
>+		transport = vsk->transport;
>+
>+		if (!transport->rx_zerocopy_get)
>+			return -EOPNOTSUPP;
>+
>+		lock_sock(sk);

I think we should call lock_sock() before reading the transport to avoid 
races and we should check if it is assigned.

At that point I think is better to store this info in vsock_sock and not 
in the transport.

And maybe we should allow to change it only if the socket state is 
SS_UNCONNECTED, inheriting from the parent the setting for sockets that 
have it.

>+
>+		res = transport->rx_zerocopy_get(vsk);
>+
>+		release_sock(sk);
>+
>+		if (res < 0)
>+			return -EINVAL;
>+
>+		v.val64 = res;
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
>@@ -2129,6 +2215,19 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	return err;
> }
>
>+static int afvsock_mmap(struct file *file, struct socket *sock,
>+			struct vm_area_struct *vma)
>+{
>+	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
>+		return -EPERM;
>+
>+	vma->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
>+	vma->vm_flags |= (VM_MIXEDMAP);
>+	vma->vm_ops = &afvsock_vm_ops;
>+
>+	return 0;
>+}
>+
> static const struct proto_ops vsock_stream_ops = {
> 	.family = PF_VSOCK,
> 	.owner = THIS_MODULE,
>@@ -2148,6 +2247,7 @@ static const struct proto_ops vsock_stream_ops = {
> 	.recvmsg = vsock_connectible_recvmsg,
> 	.mmap = sock_no_mmap,
> 	.sendpage = sock_no_sendpage,
>+	.mmap = afvsock_mmap,
> };
>
> static const struct proto_ops vsock_seqpacket_ops = {
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
