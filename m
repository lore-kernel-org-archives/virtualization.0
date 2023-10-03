Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53F5E7AD76
	for <virtualization@archiver.kernel.org>; Tue,  3 Oct 2023 16:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2289B6124E;
	Tue,  3 Oct 2023 16:23:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2289B6124E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ey/sGDDo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jd5V3rfLas3F; Tue,  3 Oct 2023 16:23:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5CE4A60F3E;
	Tue,  3 Oct 2023 16:23:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CE4A60F3E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25236C0071;
	Tue,  3 Oct 2023 16:23:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B93C8C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8763D60F7F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8763D60F7F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9R2trjpZh9np
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74E9C60F3E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74E9C60F3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696350200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K8nJSyCd6Mj6/uVIoeX6vSBcbL415T2j/UKJhN/9HxQ=;
 b=ey/sGDDoSMh/Jnq134elEYvVGlNJ8rd82E2OTPDd9t092CFk/+cym9Y3tpMdIptUZBcYIR
 9nzHSDx8ijoSxSl1rEuMPV8kV4W2CmGyuZeXiMFi5u4ygXZKGZe4rR2zKH7y2AzV4YhgYm
 bH9eq7iYJSLT5Jq8R0qAbITwcXBJ7aY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-MMowvGa0MyildJt45K8HrA-1; Tue, 03 Oct 2023 12:23:19 -0400
X-MC-Unique: MMowvGa0MyildJt45K8HrA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65b23c40cefso11266626d6.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Oct 2023 09:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696350199; x=1696954999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8nJSyCd6Mj6/uVIoeX6vSBcbL415T2j/UKJhN/9HxQ=;
 b=UF+GCoJoOv7v4RLPtHKvvlH5zF8cgonNegfaTjyjIxMQYwJ2yF4c4CH/90lD+7o7BN
 Kr2D85I/Pixn2RUgL5TRM4BeoAfI7562bjMY89DMxfiVjeRQTJIWCeGwAgLETwbJrjJ7
 mnsLeYJ42fS9UlRCn6jLz4DjzAOVexLCB7ZcNMAzJLU2CZiZC4ZICbSIAA2CMRgHNCLA
 TQZyAYA1IeVfQKjaNs4Ct7VRH0YkVtZYoSsUdHisCiB+zGD3NGBxeejjKAsoU8MOSgCA
 uEFNnGGqM3VH3JZeEgXF8YWwvqSxUFX2DiClYxydcBjYYFuhyzBOMT8ownnYPncIbfO0
 Oj5g==
X-Gm-Message-State: AOJu0Yy/kGtMaBmyhNKtGnCc6lEA5l7nnCxjGDuRsAhMlRXnZrMrjOUr
 i/4pT2N37Txyrc0CRnqKvQIFPbXvPuSBmW0D/gGgEGBe2VyRjf4ktHEM8siAjWX/jWLy7aRg6V2
 glJk/lmUxEClbGuC9T/rth8BS25NZ+8l4aWuZoGQe5g==
X-Received: by 2002:a0c:f04c:0:b0:658:a29a:e297 with SMTP id
 b12-20020a0cf04c000000b00658a29ae297mr12037767qvl.49.1696350198913; 
 Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8uQkWWDZB3h/ubLuDg4GpK42nrIzlPUoFwtgf5CmfllU3UftYG/UPLqG6M4Qulj6QX9ZOAw==
X-Received: by 2002:a0c:f04c:0:b0:658:a29a:e297 with SMTP id
 b12-20020a0cf04c000000b00658a29ae297mr12037737qvl.49.1696350198592; 
 Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 vv22-20020a05620a563600b0076ca9f79e1fsm580607qkn.46.2023.10.03.09.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 09:23:18 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:23:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v2 02/12] vsock: read from socket's error queue
Message-ID: <2o6wtfwxa3xeurri2tomed3zkdginsgu7gty7bvf5solgyheck@45pkpcol2xb3>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230930210308.2394919-3-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
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

On Sun, Oct 01, 2023 at 12:02:58AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>and 'VSOCK_RECVERR'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v1 -> v2:
>  * Place new defines for userspace to the existing file 'vm_sockets.h'
>    instead of creating new one.
>
> include/linux/socket.h          | 1 +
> include/uapi/linux/vm_sockets.h | 4 ++++
> net/vmw_vsock/af_vsock.c        | 6 ++++++
> 3 files changed, 11 insertions(+)
>
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index 39b74d83c7c4..cfcb7e2c3813 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -383,6 +383,7 @@ struct ucred {
> #define SOL_MPTCP	284
> #define SOL_MCTP	285
> #define SOL_SMC		286
>+#define SOL_VSOCK	287
>
> /* IPX options */
> #define IPX_TYPE	1
>diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
>index c60ca33eac59..b1a66c1a7054 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -191,4 +191,8 @@ struct sockaddr_vm {
>
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>
>+#define SOL_VSOCK	287
>+
>+#define VSOCK_RECVERR	1

Please add good documentation for both of them. This is an header
exposed to the user space.

>+
> #endif /* _UAPI_VM_SOCKETS_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d841f4de33b0..0365382beab6 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -110,6 +110,8 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <linux/errqueue.h>
>+#include <uapi/linux/vm_sockets.h>

Let's keep the alphabetic order as it was before this change.

`net/af_vsock.h` already includes the `uapi/linux/vm_sockets.h`,
and we also use several defines from it in this file, so you can also
skip it.

On the other end it would be better to directly include the headers that
we use, so it's also okay to keep it. As you prefer.

>
> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> static void vsock_sk_destruct(struct sock *sk);
>@@ -2137,6 +2139,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	int err;
>
> 	sk = sock->sk;
>+
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, VSOCK_RECVERR);
>+
> 	vsk = vsock_sk(sk);
> 	err = 0;
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
