Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D381E95A9A
	for <virtualization@archiver.kernel.org>; Mon,  9 Oct 2023 15:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5000612BD;
	Mon,  9 Oct 2023 15:17:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5000612BD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4KXQ0cf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYt66h4JxcWs; Mon,  9 Oct 2023 15:17:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 324D4612B0;
	Mon,  9 Oct 2023 15:17:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 324D4612B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F14BC0039;
	Mon,  9 Oct 2023 15:17:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E6F5C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 15:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2570341B70
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 15:17:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2570341B70
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4KXQ0cf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QcLoCoqJeBmq
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 15:16:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F97441B6C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Oct 2023 15:16:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F97441B6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696864617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2gmTuRm7MgRiV0DIb6UC+zzg6xOoFVegXTF+vt6GHPY=;
 b=A4KXQ0cfOGlZ190obqk2bR20z3vdQ36Mgvbbh3I/MFdUSWngikDkgpkKQ+VAGeVYvr+zG/
 c63YAWDJaBHlrfdkVq8fTNWNzm8LEum4+BIfH6b0fyuYHtUsJtyoAx686vhqD26Df3Jv4y
 HtZr6vASkJQ8KvQks4e9yo48smUwu9w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-8yyKdFVrMbCYMkcU5KsEHg-1; Mon, 09 Oct 2023 11:16:55 -0400
X-MC-Unique: 8yyKdFVrMbCYMkcU5KsEHg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-537fb536554so4048229a12.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 08:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696864614; x=1697469414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gmTuRm7MgRiV0DIb6UC+zzg6xOoFVegXTF+vt6GHPY=;
 b=sXviMlKgt0IbP6bKtQpvX0/kZnqwPnsEjRdk1LSM9comRsPaef79Q40DgHuEMLHZ0f
 PsctV8Dnm9J6EMa0TltE2b4SK6W1Fp1k547OQXpF0n5pdvW+wxoSsd4xm9XuPPOkwXiz
 mRWa5hNPiNETKLhhJ9VlGOq5K9POgNn9Q6OUsLzKmwrPia71fQ0HsRjVhM4Dxuln0VE5
 8FNkMoCd0cHxvvoHk+sSPMLlJss3cAsoahtMAJ4IuD8DBQLrIojhv0qNO65Ml1C7bYsg
 iMWlqzWUY5qxs1s8vptU+SJXgNoNoK4hPIh5G3ffuaOCwaeh4YTzrimTqW4Ka1V+EWzS
 WGJw==
X-Gm-Message-State: AOJu0YwOx9dpfK71qe2sxM/VKTG8osSZG5XQ0s2U5Uq7YTC06TWOM7ub
 Zv0opnGL+0RidHfPyj6xS0vDilUiqfiLX73fFdUAjD3kJLNbSjD7wIboIg+Fk1IDo0NKdW0j3UK
 GwEXNxeA3GELHILR7ta9Vx6RdRcxsOs1Sv0M7V4DMmQ==
X-Received: by 2002:a05:6402:1ca5:b0:53b:3225:93b2 with SMTP id
 cz5-20020a0564021ca500b0053b322593b2mr7407133edb.29.1696864614021; 
 Mon, 09 Oct 2023 08:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrMTn2vJyCRndP6TodZU0FVgeIan6pJGYPn2FrcveBY88ywUI+fm3YppJUOvDo92NN8Mz+WQ==
X-Received: by 2002:a05:6402:1ca5:b0:53b:3225:93b2 with SMTP id
 cz5-20020a0564021ca500b0053b322593b2mr7407123edb.29.1696864613643; 
 Mon, 09 Oct 2023 08:16:53 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 g18-20020a056402181200b0053782c81c69sm6187982edy.96.2023.10.09.08.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 08:16:52 -0700 (PDT)
Date: Mon, 9 Oct 2023 17:16:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v3 02/12] vsock: read from socket's error queue
Message-ID: <v3w46qfwgi66omysu64ma3lac437wy3j47a6vdbtr4umxfcrvv@4y2ypaub2k22>
References: <20231007172139.1338644-1-avkrasnov@salutedevices.com>
 <20231007172139.1338644-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20231007172139.1338644-3-avkrasnov@salutedevices.com>
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

On Sat, Oct 07, 2023 at 08:21:29PM +0300, Arseniy Krasnov wrote:
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
> v2 -> v3:
>  * Add comments to describe 'SOL_VSOCK' and 'VSOCK_RECVERR' in the file
>    'vm_sockets.h'.
>  * Reorder includes in 'af_vsock.c' in alphabetical order.
>
> include/linux/socket.h          |  1 +
> include/uapi/linux/vm_sockets.h | 12 ++++++++++++
> net/vmw_vsock/af_vsock.c        |  6 ++++++
> 3 files changed, 19 insertions(+)
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
>index c60ca33eac59..d9d703b2d45a 100644
>--- a/include/uapi/linux/vm_sockets.h
>+++ b/include/uapi/linux/vm_sockets.h
>@@ -191,4 +191,16 @@ struct sockaddr_vm {
>
> #define IOCTL_VM_SOCKETS_GET_LOCAL_CID		_IO(7, 0xb9)
>
>+/* For reading completion in case of MSG_ZEROCOPY flag transmission.
>+ * This is value of 'cmsg_level' field of the 'struct cmsghdr'.
>+ */
>+
>+#define SOL_VSOCK	287
>+
>+/* For reading completion in case of MSG_ZEROCOPY flag transmission.
>+ * This is value of 'cmsg_type' field of the 'struct cmsghdr'.
>+ */
>+
>+#define VSOCK_RECVERR	1

I would suggest a bit more context here, something like this:

diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index d9d703b2d45a..ed07181d4eff 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -191,14 +191,19 @@ struct sockaddr_vm {

  #define IOCTL_VM_SOCKETS_GET_LOCAL_CID         _IO(7, 0xb9)

-/* For reading completion in case of MSG_ZEROCOPY flag transmission.
- * This is value of 'cmsg_level' field of the 'struct cmsghdr'.
+/* MSG_ZEROCOPY notifications are encoded in the standard error format,
+ * sock_extended_err. See Documentation/networking/msg_zerocopy.rst in
+ * kernel source tree for more details.
+ */
+
+/* 'cmsg_level' field value of 'struct cmsghdr' for notification parsing
+ * when MSG_ZEROCOPY flag is used on transmissions.
   */

  #define SOL_VSOCK      287

-/* For reading completion in case of MSG_ZEROCOPY flag transmission.
- * This is value of 'cmsg_type' field of the 'struct cmsghdr'.
+/* 'cmsg_type' field value of 'struct cmsghdr' for notification parsing
+ * when MSG_ZEROCOPY flag is used on transmissions.
   */

  #define VSOCK_RECVERR  1

The rest LGTM.

Stefano

>+
> #endif /* _UAPI_VM_SOCKETS_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d841f4de33b0..38486efd3d05 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -89,6 +89,7 @@
> #include <linux/types.h>
> #include <linux/bitops.h>
> #include <linux/cred.h>
>+#include <linux/errqueue.h>
> #include <linux/init.h>
> #include <linux/io.h>
> #include <linux/kernel.h>
>@@ -110,6 +111,7 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <uapi/linux/vm_sockets.h>
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
