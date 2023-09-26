Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E924EE7E62F
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 12:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8E71841836;
	Tue, 26 Sep 2023 12:56:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E71841836
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hOnEzWn6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OMOWySQ0wZfw; Tue, 26 Sep 2023 12:56:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10ABB40912;
	Tue, 26 Sep 2023 12:56:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10ABB40912
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA402C0039;
	Tue, 26 Sep 2023 12:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 504A6C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:56:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 37EC060E7E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:56:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37EC060E7E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hOnEzWn6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XSwHjxH7XZ88
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:56:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66E3960E17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:56:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66E3960E17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695732991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CddDDC+YI+osxwaqHzSITH6Nt7h9FcyMOVgoijeQ4uU=;
 b=hOnEzWn6YW6NvavCXz0T6HzM7ADbGSc75zhWNjzr1zNEX7VBl8gTnh6VP17B8RuGugHtZ2
 nX3GfYmXSexwCTZTzCeIliCVclW0atbJ4v8slFXZlhu2NHufDv4uxq7dlyYTtMcDFYB0xV
 4Y0bBOfBJ6q4U6Q0AKwypivkHD0FGJc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-PoOAJfX8P2qq8479Zz_WIg-1; Tue, 26 Sep 2023 08:56:29 -0400
X-MC-Unique: PoOAJfX8P2qq8479Zz_WIg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a621359127so732016966b.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695732986; x=1696337786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CddDDC+YI+osxwaqHzSITH6Nt7h9FcyMOVgoijeQ4uU=;
 b=Vv/ZrhiuuebVFCb3trXbiBuIaYd6/lgqxNLPlKVanEhdjmKFh/vEqzYRV0i9C5PvtH
 DEaRfwItPbAomj0OMDJ7FcLR4J1r0JpbkbYCvRM1zB/CBb4iejkqi1PMpXGFxrj6aLbb
 IR2y7bqC+oyxjNJ4DBEdJE8vAPFUUhJE7pFln6t1m9zlDUeJyKh9zvf0qceU6jZ0z0N9
 iQHINidCHq2vddEOYMNqzfD+NoLF1NcXXaydrykIITbiAQiXUcmLOQEKL/nF6m92FkVn
 vkU9XOSR718BusePv2i5NyCCkRWiEuwEEzT+MOfDwq6rUZsyVi4mJLmaEMSQf2wZrI6z
 EiCg==
X-Gm-Message-State: AOJu0YxmC4353WNnJwN2666s6XWEskIZDFwus4A5VtC0tWwy3ZKKgb+F
 /ZzrhfyJLzinXIqHAQUkzBA6HVZXhTsJdaOwfLM3Ck3S09LpotyuaVjd6N5FIL2kHr6yrUBxPxu
 URW8cbAc2lxKMKLbTJsFwBPp87Lfm81Bri5YzS8x9eQ==
X-Received: by 2002:a17:906:1053:b0:9ae:76a2:7022 with SMTP id
 j19-20020a170906105300b009ae76a27022mr7553812ejj.38.1695732986330; 
 Tue, 26 Sep 2023 05:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYIrhN3P+JunkiZ5FgZXx3Bbhz4TDm2/Kn4vGreEaUXS+V3cU+FHm9hTpW1zj5nQMrff4I8w==
X-Received: by 2002:a17:906:1053:b0:9ae:76a2:7022 with SMTP id
 j19-20020a170906105300b009ae76a27022mr7553804ejj.38.1695732986087; 
 Tue, 26 Sep 2023 05:56:26 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a1709064acc00b009a1e73f2b4bsm7729413ejt.48.2023.09.26.05.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:56:25 -0700 (PDT)
Date: Tue, 26 Sep 2023 14:56:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v1 08/12] vsock: enable setting SO_ZEROCOPY
Message-ID: <ynuctxau4ta4pk763ut7gfdaqzcuyve7uf2a2iltyspravs5uf@xrtqtbhuuvwq>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-9-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230922052428.4005676-9-avkrasnov@salutedevices.com>
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

On Fri, Sep 22, 2023 at 08:24:24AM +0300, Arseniy Krasnov wrote:
>For AF_VSOCK, zerocopy tx mode depends on transport, so this option must
>be set in AF_VSOCK implementation where transport is accessible (if
>transport is not set during setting SO_ZEROCOPY: for example socket is
>not connected, then SO_ZEROCOPY will be enabled, but once transport will
>be assigned, support of this type of transmission will be checked).
>
>To handle SO_ZEROCOPY, AF_VSOCK implementation uses SOCK_CUSTOM_SOCKOPT
>bit, thus handling SOL_SOCKET option operations, but all of them except
>SO_ZEROCOPY will be forwarded to the generic handler by calling
>'sock_setsockopt()'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * Compact 'if' conditions.
>  * Rename 'zc_val' to 'zerocopy'.
>  * Use 'zerocopy' value directly in 'sock_valbool_flag()', without
>    ?: operator.
>  * Set 'SOCK_CUSTOM_SOCKOPT' bit for connectible sockets only, as
>    suggested by Bobby Eshleman <bobbyeshleman@gmail.com>.
>
> net/vmw_vsock/af_vsock.c | 46 ++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 44 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 482300eb88e0..c05a42e02a17 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1406,8 +1406,16 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			goto out;
> 		}
>
>-		if (vsock_msgzerocopy_allow(transport))
>+		if (vsock_msgzerocopy_allow(transport)) {
> 			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>+		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>+			/* If this option was set before 'connect()',
>+			 * when transport was unknown, check that this
>+			 * feature is supported here.
>+			 */
>+			err = -EOPNOTSUPP;
>+			goto out;
>+		}
>
> 		err = vsock_auto_bind(vsk);
> 		if (err)
>@@ -1643,7 +1651,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 	const struct vsock_transport *transport;
> 	u64 val;
>
>-	if (level != AF_VSOCK)
>+	if (level != AF_VSOCK && level != SOL_SOCKET)
> 		return -ENOPROTOOPT;
>
> #define COPY_IN(_v)                                       \
>@@ -1666,6 +1674,34 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>
> 	transport = vsk->transport;
>
>+	if (level == SOL_SOCKET) {
>+		int zerocopy;
>+
>+		if (optname != SO_ZEROCOPY) {
>+			release_sock(sk);
>+			return sock_setsockopt(sock, level, optname, optval, optlen);
>+		}
>+
>+		/* Use 'int' type here, because variable to
>+		 * set this option usually has this type.
>+		 */
>+		COPY_IN(zerocopy);
>+
>+		if (zerocopy < 0 || zerocopy > 1) {
>+			err = -EINVAL;
>+			goto exit;
>+		}
>+
>+		if (transport && !vsock_msgzerocopy_allow(transport)) {
>+			err = -EOPNOTSUPP;
>+			goto exit;
>+		}
>+
>+		sock_valbool_flag(sk, SOCK_ZEROCOPY,
>+				  zerocopy);

it's not necessary to wrap this call.

>+		goto exit;
>+	}
>+
> 	switch (optname) {
> 	case SO_VM_SOCKETS_BUFFER_SIZE:
> 		COPY_IN(val);
>@@ -2322,6 +2358,12 @@ static int vsock_create(struct net *net, struct socket *sock,
> 		}
> 	}
>
>+	/* SOCK_DGRAM doesn't have 'setsockopt' callback set in its
>+	 * proto_ops, so there is no handler for custom logic.
>+	 */
>+	if (sock_type_connectible(sock->type))
>+		set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
>+
> 	vsock_insert_unbound(vsk);
>
> 	return 0;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
