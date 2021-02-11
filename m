Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D0CC433E6
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 12:27:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8B464E23
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 12:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8B464E23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 519698740E;
	Thu, 11 Feb 2021 12:27:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aNE8gXSAjCxZ; Thu, 11 Feb 2021 12:27:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 108F687415;
	Thu, 11 Feb 2021 12:27:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E72BBC0891;
	Thu, 11 Feb 2021 12:27:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58B3CC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 12:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 451F087450
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 12:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N4Cc+a6mY5oC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 12:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 525FE8742C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 12:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613046440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMz6zYsvhAUacFy6he/Ff5pa+8L4MB4YjmA0Jw1xjYQ=;
 b=iQr6ock4ozX6Qc1vCQmUbkw4AjYbn5tMI13JXOfNFb87+Z5DYnli3FIcNY8alu1g5AcXw6
 8e+bM+zmzvnTlt5AZaJW8um81LGE3KDFAm4BROc9Z/QJbjUBjmhKVbk/DTgeISEHUH571t
 bB9OxsfjB6StnCO3ru/CxR8EQRg4jdk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-i9vgs_qhOP-OEFqr6jguKw-1; Thu, 11 Feb 2021 07:27:18 -0500
X-MC-Unique: i9vgs_qhOP-OEFqr6jguKw-1
Received: by mail-ed1-f71.google.com with SMTP id u24so4467551eds.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 04:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HMz6zYsvhAUacFy6he/Ff5pa+8L4MB4YjmA0Jw1xjYQ=;
 b=tb8fIz4fGKAgaQWvaH10gwvzvlQ6puJA8U55B961bdM32Yf7NIWX0jv4jAYXXAsoyD
 ZA9hw0lX083jx6IGCgrM2azuhDSwu9J62JCI3DxWD0mY80WAYgWYCpl7s/xTIci66ceD
 e382kwO39PQLFQ8yPvHo9slZ/BwgSOUwz7LmgCl8OfJVp9W0+ednvaFtwA/14by9Tuax
 0+S69NS82NRqXHVE8qSiJ6+InfLMa+Hk3wAsqDaSuGEGyTlyCCwotTBe0Vi+hC0gASh2
 BPG8MCt0Q3qLzzkFXspUIJ199IVSmc0ppqEorstcKx8+v+aswS7WYWMK3r+AAmraIvcd
 S9lA==
X-Gm-Message-State: AOAM533E6pYpyzPwjpng44FH/rEUhbKoHZhpRHO2zU52tQ+ePr1FaAwB
 fb0OoCBkSEGAVSi8dGkarp2V8U4PceWy04Q/F8u+fLRposB1BbQkbtmUYq0+wBBg054AQuPEadm
 6GxDvEPCwIK43QpOcnzUPBGo6M8SWDRIBz3lzL8AVGg==
X-Received: by 2002:a17:906:2747:: with SMTP id
 a7mr8529867ejd.250.1613046437398; 
 Thu, 11 Feb 2021 04:27:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyk6B6DSr3e6B0w/xlbcUeWXisr2RXOx2YRDpQHkAnrdl/RyyOhCzJ+iUDi0A/EsFUj4H9p5g==
X-Received: by 2002:a17:906:2747:: with SMTP id
 a7mr8529844ejd.250.1613046437196; 
 Thu, 11 Feb 2021 04:27:17 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id bo24sm3698134edb.51.2021.02.11.04.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 04:27:16 -0800 (PST)
Date: Thu, 11 Feb 2021 13:27:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 07/17] af_vsock: rest of SEQPACKET support
Message-ID: <20210211122714.rqiwg3qp3kuprktb@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151615.805115-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151615.805115-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Sun, Feb 07, 2021 at 06:16:12PM +0300, Arseny Krasnov wrote:
>This does rest of SOCK_SEQPACKET support:
>1) Adds socket ops for SEQPACKET type.
>2) Allows to create socket with SEQPACKET type.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
> 1 file changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index a033d3340ac4..c77998a14018 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -452,6 +452,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		new_transport = transport_dgram;
> 		break;
> 	case SOCK_STREAM:
>+	case SOCK_SEQPACKET:
> 		if (vsock_use_local_transport(remote_cid))
> 			new_transport = transport_local;
> 		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>@@ -459,6 +460,15 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 			new_transport = transport_g2h;
> 		else
> 			new_transport = transport_h2g;
>+
>+		if (sk->sk_type == SOCK_SEQPACKET) {
>+			if (!new_transport ||
>+			    !new_transport->seqpacket_seq_send_len ||
>+			    !new_transport->seqpacket_seq_send_eor ||
>+			    !new_transport->seqpacket_seq_get_len ||
>+			    !new_transport->seqpacket_dequeue)
>+				return -ESOCKTNOSUPPORT;
>+		}

Maybe we should move this check after the try_module_get() call, since 
the memory pointed by 'new_transport' pointer can be deallocated in the 
meantime.

Also, if the socket had a transport before, we should deassign it before 
returning an error.

> 		break;
> 	default:
> 		return -ESOCKTNOSUPPORT;
>@@ -684,6 +694,7 @@ static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr)
>
> 	switch (sk->sk_socket->type) {
> 	case SOCK_STREAM:
>+	case SOCK_SEQPACKET:
> 		spin_lock_bh(&vsock_table_lock);
> 		retval = __vsock_bind_connectible(vsk, addr);
> 		spin_unlock_bh(&vsock_table_lock);
>@@ -769,7 +780,7 @@ static struct sock *__vsock_create(struct net *net,
>
> static bool sock_type_connectible(u16 type)
> {
>-	return type == SOCK_STREAM;
>+	return (type == SOCK_STREAM) || (type == SOCK_SEQPACKET);
> }
>
> static void __vsock_release(struct sock *sk, int level)
>@@ -2199,6 +2210,27 @@ static const struct proto_ops vsock_stream_ops = {
> 	.sendpage = sock_no_sendpage,
> };
>
>+static const struct proto_ops vsock_seqpacket_ops = {
>+	.family = PF_VSOCK,
>+	.owner = THIS_MODULE,
>+	.release = vsock_release,
>+	.bind = vsock_bind,
>+	.connect = vsock_connect,
>+	.socketpair = sock_no_socketpair,
>+	.accept = vsock_accept,
>+	.getname = vsock_getname,
>+	.poll = vsock_poll,
>+	.ioctl = sock_no_ioctl,
>+	.listen = vsock_listen,
>+	.shutdown = vsock_shutdown,
>+	.setsockopt = vsock_connectible_setsockopt,
>+	.getsockopt = vsock_connectible_getsockopt,
>+	.sendmsg = vsock_connectible_sendmsg,
>+	.recvmsg = vsock_connectible_recvmsg,
>+	.mmap = sock_no_mmap,
>+	.sendpage = sock_no_sendpage,
>+};
>+
> static int vsock_create(struct net *net, struct socket *sock,
> 			int protocol, int kern)
> {
>@@ -2219,6 +2251,9 @@ static int vsock_create(struct net *net, struct socket *sock,
> 	case SOCK_STREAM:
> 		sock->ops = &vsock_stream_ops;
> 		break;
>+	case SOCK_SEQPACKET:
>+		sock->ops = &vsock_seqpacket_ops;
>+		break;
> 	default:
> 		return -ESOCKTNOSUPPORT;
> 	}
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
