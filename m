Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C86EB64DD
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A5C66110A;
	Thu,  6 Jul 2023 16:54:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6A5C66110A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X36w60Rs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fyL-8CSmp57G; Thu,  6 Jul 2023 16:54:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD19160FAB;
	Thu,  6 Jul 2023 16:54:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BD19160FAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5FB5C0071;
	Thu,  6 Jul 2023 16:54:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCE7AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89CF960FFE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:54:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89CF960FFE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qqBgTwZ6TlXe
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:54:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C044D60FAB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C044D60FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glhZ+2qeJMm9MWfPWx9SoMWGjL42JiHnlLy0ooXyD8I=;
 b=X36w60RsYOFhDSr5ly5vuKgqqmY2IzWrrG8E+UxHrqhOdmk6x0u3x/goXjMfe0uwLRgS87
 Pn9gb62pZLzm5CeKiGoGNlaHLtygT48kpH1jMK/PP+bPyywAWKtGbhKPmgfbTSi7Fy1eEO
 itQBfQPw1K6dwLdItyEj+Y/mx61dse8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-G7KZxseRP_utSgiXBy8fmg-1; Thu, 06 Jul 2023 12:54:43 -0400
X-MC-Unique: G7KZxseRP_utSgiXBy8fmg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355c9028so63819966b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662482; x=1691254482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glhZ+2qeJMm9MWfPWx9SoMWGjL42JiHnlLy0ooXyD8I=;
 b=bhjXkSlMnDjMVHM1eXzyrToMcdd25cIoA3rJXoat9LJv7kYXUvWlcOIhXW1tNz5Nrz
 zSyqXkatWz4N8iFBXt4eC+frLNrTxbFJvv+MhZGpBsSXUnEXPzPCGVCITERJgHV/OSCm
 szxMPkUaGD9z7L287uO1Pa/3PE2tq2ws7tj3lNoOvGXFQTsIUPpk0ODHYD1lt7R9C7tp
 Ls8FWvq2ghvl64xOl3ZdYxXgE4KdEVsM8xtKgO7zcgZhYSgvkFst8cjnGjD21RezyT4a
 bjeHzvW7qLr/A9jt4wSpaJ3wgvAAouaFHxxFN305vOQa0Qg6RV4e0Y5rdsqhBROMNHib
 DpbQ==
X-Gm-Message-State: ABy/qLZtdLp62gyEpYwe41vIfkjAJ2JfLXKgYTJw/8c66xGZwZTr2Aus
 qIA/JQPRHP5+B9xOzbYPoulblkTC9T2cLP5LX84+Q+3CKzydDZ/ZupNohhG+Wga8CdcIN8iKC74
 5TudaNwU/9+wZb4euKh134Pnxtcog6eC+SN6c3eZESg==
X-Received: by 2002:a17:906:89a0:b0:98c:cc3c:194e with SMTP id
 gg32-20020a17090689a000b0098ccc3c194emr1668124ejc.52.1688662482342; 
 Thu, 06 Jul 2023 09:54:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF62VXDxBiD2YIMucVbmZsWHocuUY9mKHoepmGkw2mj8oHke7cYIWYsLK4/i6qDTk9eWPxoDA==
X-Received: by 2002:a17:906:89a0:b0:98c:cc3c:194e with SMTP id
 gg32-20020a17090689a000b0098ccc3c194emr1668102ejc.52.1688662482046; 
 Thu, 06 Jul 2023 09:54:42 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 k12-20020a170906970c00b0096f6a131b9fsm1034242ejx.23.2023.07.06.09.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:54:41 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:54:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 07/17] vsock: read from socket's error queue
Message-ID: <ho76zima4fe7yxm5ckj66ibgyl6kstjaexf4x5dxq7azjamoif@tny2uqb5yifn>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-8-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-8-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:37AM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag. This patch also adds 'SOL_VSOCK' define.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Update commit message by adding sentence that 'SOL_VSOCK' is also
>    added.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
> include/linux/socket.h   | 1 +
> net/vmw_vsock/af_vsock.c | 5 +++++
> 2 files changed, 6 insertions(+)
>
>diff --git a/include/linux/socket.h b/include/linux/socket.h
>index bd1cc3238851..d79efd026880 100644
>--- a/include/linux/socket.h
>+++ b/include/linux/socket.h
>@@ -382,6 +382,7 @@ struct ucred {
> #define SOL_MPTCP	284
> #define SOL_MCTP	285
> #define SOL_SMC		286
>+#define SOL_VSOCK	287
>
> /* IPX options */
> #define IPX_TYPE	1
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 45fd20c4ed50..07803d9fbf6d 100644
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
>@@ -2135,6 +2136,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	int err;
>
> 	sk = sock->sk;
>+
>+	if (unlikely(flags & MSG_ERRQUEUE))
>+		return sock_recv_errqueue(sk, msg, len, SOL_VSOCK, 0);
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
