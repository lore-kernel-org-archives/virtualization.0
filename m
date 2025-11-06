Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47A2EAD1B
	for <virtualization@lists.linux.dev>; Thu,  6 Nov 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446022; cv=none; b=F8J6agprVAI4Rk94ykdERPfgWwz+mL1PtZvHqlioUJ6Qro9qRA8RWfc7DlSFAvcvNBLXcSp7S0xNSLwY9zlfMecKiBpi60GQcFJWz5No1Cx4KXkDKVX68jH9u0mAwKQj9S/S5kZT4PDU6BUpEs09yJBGVyMhbPkzXHeOofsDqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446022; c=relaxed/simple;
	bh=Dr6RQXlFiWy26R45Zikyl0mULmDJ2VeyCQARy5DjXeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NIvUiJiw4I5q6EqHMme6JlVBTt1eIFEG2SdAdH7WHGrSTZvGQrf4vFHNyiCVuqv09WIbe7XLtTcGLU+frq14een/Yix+zQXEt5WwtcRfQ6dEW2zAg6vceWd4yk5MnKiB/CE9s/Jk4Sy+q1mom6s5Q//rVfBcnHyTqav9nswNAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cA+8NIW+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA+8NIW+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762446019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sNWIGqIKBmCBN12LhmyrpvAkz7agvA7puiR1b4zkYGs=;
	b=cA+8NIW+hkiAK5llr0FcdWp8eM4PL3AAL7aVCItL/aAHrUiIeXhHb+8C7VA8jhjj8RUwEg
	7TLkfWEYgpEvPwo7jYbX6ViXKF0mHmoPbKoiZJMDthKwa18Y177TrwkssdWkSgKR4+jL0S
	AajrtLkzTCvvUs2LAUyX0pKqah6quDM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-qYKpuyDVORSCnI-Qj37p-A-1; Thu, 06 Nov 2025 11:20:18 -0500
X-MC-Unique: qYKpuyDVORSCnI-Qj37p-A-1
X-Mimecast-MFC-AGG-ID: qYKpuyDVORSCnI-Qj37p-A_1762446017
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so11716125e9.1
        for <virtualization@lists.linux.dev>; Thu, 06 Nov 2025 08:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446017; x=1763050817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNWIGqIKBmCBN12LhmyrpvAkz7agvA7puiR1b4zkYGs=;
        b=eFY3HU2cQDwVSRoD+YvBXUWLRQ711pGdXyMmsNIhJBE7nu6aZSEt1QV7KpVGzYdF1L
         J8gO6+OSlsUZuWkNlvqfy/vfX3UWOvU8/AHUgjhphAlgRpzadk66LzgMxrAEjW8YOvQl
         MmchkF1is3QkEuIHbU40BIbjG+gDA6tJuXdce4VDZdks72Q23wdnRftEstDhYiRcr1jQ
         VBWREfo9n8pZ41OeICc8vMBzP0C7D+XUnx8Hw4FTFehoN8225GDBxsEjWsGSY9ztKaQQ
         Ht6N8PEr1W4deuomQojqVhEomvo4Ww8BbXX0o4l93f1hRNLtIWj6VJ97FLm4JN+wPa2F
         hJSw==
X-Forwarded-Encrypted: i=1; AJvYcCVxFqr90x+7nEUOii88xWsPfLzjqUq+aQX1XGWLcizKB8y5dXXAKvjC7//pziWP/L383N3xuEMFa8aXq2w5GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhH4fJq1RsjKpwaTv4OzRp65jGXY2JxY4FEYPSlFxd1pu2WcEU
	+UgT+Rw7xEt9NU6v3NHdDguf7usNuZ5YlSoY8UuKkYWdpdpXwaoyseF7WDoeCujh2XfiggijmAW
	5v55OkC6All9QXCuWr/AwrTsbBkVb0DqAPro2mwlDgKZFGJF0G9ObbnSYVp2fc3xnz2ho
X-Gm-Gg: ASbGncvQf6TwCyIzmmU3A1QOUd35jJ/OYeMEULNAn1vt1Jl5qqM23UZvWImSCThEUMp
	LCqv2UdgeA5G5DnSvZBI9Qnmt97WKjO4N/FgoJ6LP/x0h/8Xe+gTp6rINLFp6/mLV7TdbFJikL9
	LlYTsVVHcsacK0qI/nDJwZh/YvwIhI32hnVWbBCOMk3UFN8KUINbZPxfSM8d7UXc1j59xfiw0F/
	BA58PrDcrws/A34ThNdwZaEjVQVcF4Mu5jXw9KR+zE7McsSO/xhB78i9JsJ9QlHUqezpavc27RD
	kpijg2cV9vgUp0gaD2F9TdRepBovwfXJ4wNYJNYaW91Dnxb9/phZMTNfEUcajbGOi2na8CKuQpJ
	t6g==
X-Received: by 2002:a05:600c:529b:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-4775ce14abbmr69830535e9.27.1762446017222;
        Thu, 06 Nov 2025 08:20:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIFV9md/ByynJvSGxwacmD4oCYIAwnoN0WSvyfjQAEzU671xAjd2ScfVMCadxZZDB6bIgYAw==
X-Received: by 2002:a05:600c:529b:b0:46e:1abc:1811 with SMTP id 5b1f17b1804b1-4775ce14abbmr69830185e9.27.1762446016799;
        Thu, 06 Nov 2025 08:20:16 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce210a7sm118787675e9.12.2025.11.06.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:20:14 -0800 (PST)
Date: Thu, 6 Nov 2025 17:20:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 06/14] vsock/virtio: add netns to virtio
 transport common
Message-ID: <hkwlp6wpiik35zesxqfe6uw7m6uayd4tcbvrg55qhhej3ox33q@lah2dwed477g>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251023-vsock-vmtest-v8-6-dea984d02bb0@meta.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tGbcAuSqS83pgDrPNL_t5wjp8onWFUNnGIxCY4_-LpY_1762446017
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Oct 23, 2025 at 11:27:45AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Enable network namespace support in the virtio-vsock common transport
>layer by declaring namespace pointers in the transmit and receive
>paths.
>
>The changes include:
>1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
>   pointer for outgoing packets.
>2. Store the namespace and namespace mode in the skb control buffer when
>   allocating packets (except for VIRTIO_VSOCK_OP_RST packets which do
>   not have an associated socket).
>3. Retrieve namespace information from skbs on the receive path for
>   lookups using vsock_find_connected_socket_net() and
>   vsock_find_bound_socket_net().
>
>This allows users of virtio transport common code
>(vhost-vsock/virtio-vsock) to later enable namespace support.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v7:
>- add comment explaining the !vsk case in virtio_transport_alloc_skb()
>---
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 21 +++++++++++++++++++--
> 2 files changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 29290395054c..f90646f82993 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -217,6 +217,7 @@ struct virtio_vsock_pkt_info {
> 	u32 remote_cid, remote_port;
> 	struct vsock_sock *vsk;
> 	struct msghdr *msg;
>+	struct net *net;
> 	u32 pkt_len;
> 	u16 type;
> 	u16 op;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..b8e52c71920a 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -316,6 +316,15 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 					 info->flags,
> 					 zcopy);
>
>+	/*
>+	 * If there is no corresponding socket, then we don't have a
>+	 * corresponding namespace. This only happens For VIRTIO_VSOCK_OP_RST.
>+	 */

So, in virtio_transport_recv_pkt() should we check that `net` is not 
set?

Should we set it to NULL here?

>+	if (vsk) {
>+		virtio_vsock_skb_set_net(skb, info->net);

Ditto here about the net refcnt, can the net disappear?
Should we use get_net() in some way, or the socket will prevent that?

>+		virtio_vsock_skb_set_net_mode(skb, vsk->net_mode);
>+	}
>+
> 	return skb;
> out:
> 	kfree_skb(skb);
>@@ -527,6 +536,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1067,6 +1077,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1082,6 +1093,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 			 (mode & SEND_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1108,6 +1120,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1145,6 +1158,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.reply = !!skb,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	/* Send RST only if the original pkt is not a RST pkt */
>@@ -1465,6 +1479,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> 		.remote_port = le32_to_cpu(hdr->src_port),
> 		.reply = true,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1578,7 +1593,9 @@ static bool virtio_transport_valid_type(u16 type)
> void virtio_transport_recv_pkt(struct virtio_transport *t,
> 			       struct sk_buff *skb)
> {
>+	enum vsock_net_mode net_mode = virtio_vsock_skb_net_mode(skb);
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct net *net = virtio_vsock_skb_net(skb);

Okay, so this is where the skb net is read, so why we touch the 
virtio-vsock driver (virtio_transport.c) in the other patch where we 
changed just af_vsock.c?

IMO we should move that change here, or in a separate commit.
Or maybe I missed some dependency :-)

Thanks,
Stefano

> 	struct sockaddr_vm src, dst;
> 	struct vsock_sock *vsk;
> 	struct sock *sk;
>@@ -1606,9 +1623,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	/* The socket must be in connected or bound table
> 	 * otherwise send reset back
> 	 */
>-	sk = vsock_find_connected_socket(&src, &dst);
>+	sk = vsock_find_connected_socket_net(&src, &dst, net, net_mode);
> 	if (!sk) {
>-		sk = vsock_find_bound_socket(&dst);
>+		sk = vsock_find_bound_socket_net(&dst, net, net_mode);
> 		if (!sk) {
> 			(void)virtio_transport_reset_no_sock(t, skb);
> 			goto free_pkt;
>
>-- 
>2.47.3
>

