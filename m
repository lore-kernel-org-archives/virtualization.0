Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A1AEB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 16:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DB4D60ECA;
	Mon, 26 Jun 2023 16:09:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DB4D60ECA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RnWpXYeD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0VSBoI0pgzZ; Mon, 26 Jun 2023 16:09:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3923460B26;
	Mon, 26 Jun 2023 16:09:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3923460B26
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AF4FC007A;
	Mon, 26 Jun 2023 16:09:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE0A6C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:09:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8984D60ECA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:09:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8984D60ECA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUmRpAfPUxmp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:09:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 704E460B26
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 704E460B26
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVw/Wv9H1+jgHlFyXB8K46FNsZdoHq7Qo4C7jHkkuH8=;
 b=RnWpXYeDG2gW4Xl8Bp+nM9yDtES+t2YELOXgYkzOIxBheTx71qPO5jXek7T0QzP43UJWKN
 87ejDolL9FMSXLqzAhTpC5VOniflvKruXy5b7HgsLTECzTRkyXvyBDqn5wDoZe/VnVWWZs
 HwlWH96htlJ3gU5OOrN8jYePpbtN74M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-yIs4ft4aMTyRY4SSPKuYXQ-1; Mon, 26 Jun 2023 12:08:56 -0400
X-MC-Unique: yIs4ft4aMTyRY4SSPKuYXQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-635984f84a9so20694206d6.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795722; x=1690387722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVw/Wv9H1+jgHlFyXB8K46FNsZdoHq7Qo4C7jHkkuH8=;
 b=KFThcNHTJDn7zXC/BZv4VHNvsRxKlyh1OY92txBR/IG7jVDOQTyFVmJADBsBEbKE6V
 ZDr0YDUFw7lpINZHXXKN6BL2PQGVDVcYIBZgKAUGci4Fm9cvvn2eVAc9HjVejxjsiq97
 gRum7AM1mY1IdyC42rGvQE1Cjs1cn4VwgXYnfsTYob/1I5OZJeSv+LuEdrciZMDLXnxy
 LORCjZjcCapkcTxmtONAMjhvhAW9AursBCithfY7CqhXXaHZeBNIQDoInJ1P8TVBVLJf
 E+fAPKWOVig/aNIVtmapGSa7ijdpRqY/dIyDPeM7bcmki9dT2Z+ochFaBRQLI9z1Ck6R
 sidA==
X-Gm-Message-State: AC+VfDybL0aYP+vNry1V5GYBLh4NBEdO8mfwHz0AfjVn6xgujF6G447T
 99OjiRJUBbrl0nFO1jw/fJdsAVSIDYaw5tIoJpf3Bq/UHQ3IDc0hJ7hZv3+w36GlYL3O1V6CaaU
 UpBci3yzpAuJynHJ+jvUbChUy9alv9eAkV9W0ap88iA==
X-Received: by 2002:a05:6214:27c9:b0:62d:f515:9320 with SMTP id
 ge9-20020a05621427c900b0062df5159320mr36074270qvb.28.1687795722199; 
 Mon, 26 Jun 2023 09:08:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5raYOLH44gjALQWDUf6IbJggeYwYWXvVHtOWcRvbl3wuo2Ee6zIMMrWONEOeu5ohWrGHlbZg==
X-Received: by 2002:a05:6214:27c9:b0:62d:f515:9320 with SMTP id
 ge9-20020a05621427c900b0062df5159320mr36074244qvb.28.1687795721957; 
 Mon, 26 Jun 2023 09:08:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 l13-20020ad44d0d000000b0063227969cf7sm3308298qvl.96.2023.06.26.09.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:08:41 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:08:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 07/17] vsock: read from socket's error queue
Message-ID: <sq5jlfhhlj347uapazqnotc5rakzdvj33ruzqwxdjsfx275m5r@dxujwphcffkl>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-8-AVKrasnov@sberdevices.ru>
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

On Sat, Jun 03, 2023 at 11:49:29PM +0300, Arseniy Krasnov wrote:
>This adds handling of MSG_ERRQUEUE input flag in receive call. This flag
>is used to read socket's error queue instead of data queue. Possible
>scenario of error queue usage is receiving completions for transmission
>with MSG_ZEROCOPY flag.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
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

Maybe this change should go in another patch where we describe that
we need to support setsockopt()

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
