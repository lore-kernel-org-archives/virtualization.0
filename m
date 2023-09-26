Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403F5E7E62F
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 12:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 599428231B;
	Tue, 26 Sep 2023 12:56:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 599428231B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FnlNiesB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pjnJGLjEw9OL; Tue, 26 Sep 2023 12:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C5ECA82319;
	Tue, 26 Sep 2023 12:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5ECA82319
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DB7FC0039;
	Tue, 26 Sep 2023 12:56:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A12B5C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:56:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BF14614A2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:56:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BF14614A2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FnlNiesB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P5fPwbjRx-pL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:56:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B404160E7B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:56:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B404160E7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695732959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t4iH3vwVxFoPswV3u1qhZq4zjltOD47zGEuJH78n1q8=;
 b=FnlNiesB9vjKk+/YKtXzmHXlQKP0UzQrz/Hv65hPzBzDjBPgdMW4/OgNerHoLd6KAuFsyh
 Xw6t3IZuW0kmzs/pLcvLaCKI/88bA+S/px66u4YfNgJW/2pIyU9QLCY6sbx3I7cMkdej+y
 Qe5G0AMIm91md4cUyYWCt41+KaKhe3A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-kmUTTlloMDy_Mg7OKDnrNg-1; Tue, 26 Sep 2023 08:55:56 -0400
X-MC-Unique: kmUTTlloMDy_Mg7OKDnrNg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso727278766b.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695732955; x=1696337755;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t4iH3vwVxFoPswV3u1qhZq4zjltOD47zGEuJH78n1q8=;
 b=kzgM673VpTL6gKYMrO+8HLNfZA4tJ3apuRUCR0eaFQl1XlXpfzPt8LHlimKwY4r/Ci
 aqvu9GC3ex8qwTXU536KTrq2OXMgbKgU5Zliv/AA9+EmYYdoQAXuXx8Yv74OvhZ1nC3N
 /7UwyM60kKBED1KmSgamsrKpSNFco6R70gTDhimmMzz6puK0lW1ZNqdc/VpxrF74HTs/
 0FkYoIF3AyjXQQyj880isp+wYbX2D08+HLiSURrGAMotLHPERP49cUbdHeSnB//woeZn
 Zmls5wuQUddauh2gn+siZlA+eyZCqZJ9wpn7kkn9/749zm2e+e11I9EjnSIWrelcWCaQ
 gSdA==
X-Gm-Message-State: AOJu0YwqHz3VhmFsrB/HtUKor5ueMI08c7Beb02+MHIsURVf7uj2UPaS
 u/Ib+cgSooQYYJox3NhasO13d7+QOdqTEa6g2gYM12d3d4Xz77cRj3H661C1BS2UgaxIxCZv8oA
 LVifUTzSRV0gYiA2yY6gGbgYgfimUK2Y2T71OMIlveQ==
X-Received: by 2002:a17:906:30d5:b0:9ad:c763:c3fd with SMTP id
 b21-20020a17090630d500b009adc763c3fdmr9300571ejb.28.1695732955240; 
 Tue, 26 Sep 2023 05:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBoqKi4bGW4XT84p8pcKtRJrDw9HwrTduGHjeF7FIg3KEpK5irhsbqg/b4oWx2SfDz4/fEpA==
X-Received: by 2002:a17:906:30d5:b0:9ad:c763:c3fd with SMTP id
 b21-20020a17090630d500b009adc763c3fdmr9300558ejb.28.1695732954899; 
 Tue, 26 Sep 2023 05:55:54 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a170906374800b0099cf840527csm7748029ejc.153.2023.09.26.05.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:55:54 -0700 (PDT)
Date: Tue, 26 Sep 2023 14:55:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v1 02/12] vsock: read from socket's error queue
Message-ID: <3oys2ouhlkitsjx7q7utp7wkitnnl4kisl2r54wwa2addd644p@jzyu7ubfrcog>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-3-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230922052428.4005676-3-avkrasnov@salutedevices.com>
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

On Fri, Sep 22, 2023 at 08:24:18AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds new defines: 'SOL_VSOCK'
>and 'VSOCK_RECVERR'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * R-b tag removed, due to added defines to 'include/uapi/linux/vsock.h'.
>    Both 'SOL_VSOCK' and 'VSOCK_RECVERR' are needed by userspace, so
>    they were placed to 'include/uapi/linux/vsock.h'. At the same time,
>    the same define for 'SOL_VSOCK' was placed to 'include/linux/socket.h'.
>    This is needed because this file contains SOL_XXX defines for different
>    types of socket, so it prevents situation when another new SOL_XXX
>    will use constant 287.
>
> include/linux/socket.h     | 1 +
> include/uapi/linux/vsock.h | 9 +++++++++
> net/vmw_vsock/af_vsock.c   | 6 ++++++
> 3 files changed, 16 insertions(+)
> create mode 100644 include/uapi/linux/vsock.h
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
>diff --git a/include/uapi/linux/vsock.h b/include/uapi/linux/vsock.h
>new file mode 100644
>index 000000000000..b25c1347a3b8
>--- /dev/null
>+++ b/include/uapi/linux/vsock.h

We already have include/uapi/linux/vm_sockets.h

Should we include these changes there instead of creating a new header?

>@@ -0,0 +1,9 @@
>+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>+#ifndef _UAPI_LINUX_VSOCK_H
>+#define _UAPI_LINUX_VSOCK_H
>+
>+#define SOL_VSOCK	287

Why we need to re-define this also here?

In that case, should we protect with some guards to avoid double
defines?

>+
>+#define VSOCK_RECVERR	1
>+
>+#endif /* _UAPI_LINUX_VSOCK_H */
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d841f4de33b0..4fd11bf34bc7 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -110,6 +110,8 @@
> #include <linux/workqueue.h>
> #include <net/sock.h>
> #include <net/af_vsock.h>
>+#include <linux/errqueue.h>
>+#include <uapi/linux/vsock.h>
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
