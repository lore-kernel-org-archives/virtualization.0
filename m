Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DBFC636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 13:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDE5C611F6;
	Thu, 16 Feb 2023 13:55:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDE5C611F6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hqHZ2K7N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2sFPJGC4dCGW; Thu, 16 Feb 2023 13:55:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7799960AC9;
	Thu, 16 Feb 2023 13:55:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7799960AC9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51CF5C0033;
	Thu, 16 Feb 2023 13:55:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0DB5C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0DD3582072
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DD3582072
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hqHZ2K7N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id THuTYjoDiVrn
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 323D28203D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 323D28203D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 13:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676555736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hii/hEJ9PZyd5sM9pg8DiE74V3lS3n6PlgGZ2jOvQQA=;
 b=hqHZ2K7N1FEyU91dO0tSTZrKz+YpIas6Zmlfz7ppDkaHrDrygBo6UDLy87TDkuCFYSrVzu
 YBeihVyE622TS1K1w70j8le1hS/hai53YeLlacQnbIJpqq2ZD6PMe/J1AB8aNzb3fUbwQf
 zZxDi7bYAD2jH6wvgn97u9tzi1+L1Qg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-m12to5lHNaiK8jizlRUBWw-1; Thu, 16 Feb 2023 08:55:35 -0500
X-MC-Unique: m12to5lHNaiK8jizlRUBWw-1
Received: by mail-qv1-f70.google.com with SMTP id
 k15-20020a0cd68f000000b00535261af1b1so1108550qvi.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hii/hEJ9PZyd5sM9pg8DiE74V3lS3n6PlgGZ2jOvQQA=;
 b=EbJEcRFMygj7Wf6lA7E5zry58STYlqT8lQIIlYGVpQLsSoELx0HfhK5NEy5F1Yh/B4
 Jblwv8egICoY3BO87kzAM/p2qS2IQxX47YOV1bbWcR2q2kr69Z2tljjYcrWNQYE+ts08
 WDqADP4BnzUvquVcncM1Ciefe5Q7n6+si9wBTGkRDy5ZXg6n9M1IWYVZbYny8y0Zyxs3
 ROApYA8wQxdOoCpoHHYeOOf2els+WvVhfYVeJXnwMa1S58EyK6EiMJVxMjEaprbvoMKQ
 7yYNJk7BQv4mTZMtKRXcgqO6i0C2bJw8i+eYVy6RvPrNpeqonnhsd33HuzGZDswo25tI
 mAWw==
X-Gm-Message-State: AO0yUKVSFTZoZOkXfW1USyU5LxhvF2UFehmklJOV3S7/jLqjH2E+Lz+w
 NeM4AciC5SmQhf0rJmV3c81PbiR5m+4LGBkMdaSU5+r0zB7FV0n0h5ciCI9SpqsusLWNE8xvNnX
 zYkkeWXF5cZ+fNTXDQQWlfGOkBo3ub8MqIb6uMwsVYw==
X-Received: by 2002:ac8:5bd5:0:b0:3bb:8f10:6029 with SMTP id
 b21-20020ac85bd5000000b003bb8f106029mr10792540qtb.50.1676555734665; 
 Thu, 16 Feb 2023 05:55:34 -0800 (PST)
X-Google-Smtp-Source: AK7set+JnPrAuwzQGhfHNhTBc/+z66FBbT4aDZCX6sfMD4/mj4mAXZ+i5dm9S21S3kppDEVaj0vlBQ==
X-Received: by 2002:ac8:5bd5:0:b0:3bb:8f10:6029 with SMTP id
 b21-20020ac85bd5000000b003bb8f106029mr10792507qtb.50.1676555734312; 
 Thu, 16 Feb 2023 05:55:34 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-167.retail.telecomitalia.it.
 [82.57.51.167]) by smtp.gmail.com with ESMTPSA id
 r188-20020a37a8c5000000b00729a26e836esm1206352qke.84.2023.02.16.05.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Feb 2023 05:55:33 -0800 (PST)
Date: Thu, 16 Feb 2023 14:55:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 02/12] vsock: read from socket's error queue
Message-ID: <20230216135528.ge4otfhfv22p3htc@sgarzare-redhat>
References: <0e7c6fc4-b4a6-a27b-36e9-359597bba2b5@sberdevices.ru>
 <7b2f00ce-296c-3f59-9861-468c6340300e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <7b2f00ce-296c-3f59-9861-468c6340300e@sberdevices.ru>
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
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel <kernel@sberdevices.ru>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 06, 2023 at 06:54:51AM +0000, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag for receive call, thus
>skb from socket's error queue is read.

A general tip, add a little more description in the commit messages,
especially to explain why these changes are necessary.
Otherwise, even review becomes difficult because one has to look at all
the patches to understand what the previous ones are for.
I know it's boring, but it's very useful for those who review and even
then if we have to bisect ;-)

Thanks,
Stefano

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> include/linux/socket.h   |  1 +
> net/vmw_vsock/af_vsock.c | 26 ++++++++++++++++++++++++++
> 2 files changed, 27 insertions(+)
>
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index 13c3a237b9c9..19a6f39fa014 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -379,6 +379,7 @@ struct ucred {
> #define SOL_MPTCP	284
> #define SOL_MCTP	285
> #define SOL_SMC		286
>+#define SOL_VSOCK	287
>
> /* IPX options */
> #define IPX_TYPE	1
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index b5e51ef4a74c..f752b30b71d6 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -110,6 +110,7 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <linux/errqueue.h>
>
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
>@@ -2086,6 +2087,27 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 	return err;
> }
>
>+static int vsock_err_recvmsg(struct sock *sk, struct msghdr *msg)
>+{
>+	struct sock_extended_err *ee;
>+	struct sk_buff *skb;
>+	int err;
>+
>+	lock_sock(sk);
>+	skb = sock_dequeue_err_skb(sk);
>+	release_sock(sk);
>+
>+	if (!skb)
>+		return -EAGAIN;
>+
>+	ee = &SKB_EXT_ERR(skb)->ee;
>+	err = put_cmsg(msg, SOL_VSOCK, 0, sizeof(*ee), ee);
>+	msg->msg_flags |= MSG_ERRQUEUE;
>+	consume_skb(skb);
>+
>+	return err;
>+}
>+
> static int
> vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 			  int flags)
>@@ -2096,6 +2118,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	int err;
>
> 	sk = sock->sk;
>+
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return vsock_err_recvmsg(sk, msg);
>+
> 	vsk = vsock_sk(sk);
> 	err = 0;
>
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
