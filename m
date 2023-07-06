Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAEDEB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B23241597;
	Thu,  6 Jul 2023 16:56:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B23241597
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SzlrjJF0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id njeolobdegVG; Thu,  6 Jul 2023 16:56:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 866424158C;
	Thu,  6 Jul 2023 16:56:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 866424158C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FD8CC0071;
	Thu,  6 Jul 2023 16:56:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92A93C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B7AA41896
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:56:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B7AA41896
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SzlrjJF0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BpXrzarEOeey
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:56:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED6B340246
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED6B340246
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AOn2FSR/F+AepHAW4tuhLZ6J2d0DqA3sGZENm8WNhBk=;
 b=SzlrjJF0BEuKHUTTN3Royo6X/REtOYhlXhfPDSB3bJNPfGAq5vQXvvR1aLIrBJJPPNjvXJ
 Qi4KjkIsRxc16UfUdzn8nvd7EliVBn9uZle3s/U82d3Nz0i04WIz3YhJSf3mimdq+U7tea
 S/Qa0hFkivYe3/dGZvIyBwnNkn2yDbw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-OH5k1wSnMLycx8mpXOPa6w-1; Thu, 06 Jul 2023 12:56:28 -0400
X-MC-Unique: OH5k1wSnMLycx8mpXOPa6w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6fdbd0caeso10668251fa.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662587; x=1691254587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOn2FSR/F+AepHAW4tuhLZ6J2d0DqA3sGZENm8WNhBk=;
 b=i7uwdfFWVQ/NZ9L+2epHSW7QciK/eNkF7ep/soMXi5ugq0mQf4JAS5mpCd9OZ8emsS
 e9qgskFGG61ZDZPo28staC4YV/VrysPMNcLhs+aS7/eS/JQhkL0lb17pGzx0NvXTPllR
 E8rFzz5NZJp+rZeD3GFHh9D+JXzYSFiONiBOy70cbdBCuEtdJeOLHVmh+3t4sntPZFDi
 o1Q7maUeEwTI8OXENrYNZdZ0m4XNrEcObH9NwbcWu0gLdsxrsxaM7devuWSDSmOIEw8p
 y+M+23pmFHZPmkWrTB8d4+FBGmPnt3UaEnykRAf9Ina/csPQVGNSg3GsLwDAGNSpMzN8
 pZFQ==
X-Gm-Message-State: ABy/qLZJNnT94XaXl+Qg9WWTA4tFpK3CsnyTUjcUdXTNvpOGefJubKPw
 sx0v4IZ6G01Jr1krr4WkBSssJjvG0VJYJ1XYBsAp+feyNydZrH+oQhaI3b8mnUIr96HH+q0fg+9
 35Eh1jlx/4ds74ylqn02C0bWuHSL8FOwJG1xzUUQCKA==
X-Received: by 2002:a2e:99d3:0:b0:2b6:e3e2:5045 with SMTP id
 l19-20020a2e99d3000000b002b6e3e25045mr1907502ljj.18.1688662587339; 
 Thu, 06 Jul 2023 09:56:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+MGDRqQfF9kapT4zmm8lQzVMW6DfZBqPPwvO/e9jD6LvFab7VnpcM4MmvpSS7cFxJwa1qgw==
X-Received: by 2002:a2e:99d3:0:b0:2b6:e3e2:5045 with SMTP id
 l19-20020a2e99d3000000b002b6e3e25045mr1907472ljj.18.1688662586938; 
 Thu, 06 Jul 2023 09:56:26 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 a6-20020aa7cf06000000b0051de20c59d7sm975495edy.15.2023.07.06.09.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:56:26 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:56:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 13/17] vsock: enable setting SO_ZEROCOPY
Message-ID: <di3hhsulz5smngtyfwyvnvanlju22xuii46szrn5fmu3woj2ro@3toj6n4kbks3>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-14-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-14-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:43AM +0300, Arseniy Krasnov wrote:
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
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * This patch is totally reworked. Previous version added check for
>    PF_VSOCK directly to 'net/core/sock.c', thus allowing to set
>    SO_ZEROCOPY for AF_VSOCK type of socket. This new version catches
>    attempt to set SO_ZEROCOPY in 'af_vsock.c'. All other options
>    except SO_ZEROCOPY are forwarded to generic handler. Only this
>    option is processed in 'af_vsock.c'. Handling this option includes
>    access to transport to check that MSG_ZEROCOPY transmission is
>    supported by the current transport (if it is set, if not - transport
>    will be checked during 'connect()').

Yeah, great, this is much better!

>
> net/vmw_vsock/af_vsock.c | 44 ++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 42 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index da22ae0ef477..8acc77981d01 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1406,8 +1406,18 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			goto out;
> 		}
>
>-		if (vsock_msgzerocopy_allow(transport))
>+		if (!vsock_msgzerocopy_allow(transport)) {

Can you leave `if (vsock_msgzerocopy_allow(transport))` and just add
the else branch with this new check?

		if (vsock_msgzerocopy_allow(transport)) {
			...
		} else if (sock_flag(sk, SOCK_ZEROCOPY)) {
			...
		}

>+			/* If this option was set before 'connect()',
>+			 * when transport was unknown, check that this
>+			 * feature is supported here.
>+			 */
>+			if (sock_flag(sk, SOCK_ZEROCOPY)) {
>+				err = -EOPNOTSUPP;
>+				goto out;
>+			}
>+		} else {
> 			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>+		}
>
> 		err = vsock_auto_bind(vsk);
> 		if (err)
>@@ -1643,7 +1653,7 @@ static int vsock_connectible_setsockopt(struct socket *sock,
> 	const struct vsock_transport *transport;
> 	u64 val;
>
>-	if (level != AF_VSOCK)
>+	if (level != AF_VSOCK && level != SOL_SOCKET)
> 		return -ENOPROTOOPT;
>
> #define COPY_IN(_v)                                       \
>@@ -1666,6 +1676,34 @@ static int vsock_connectible_setsockopt(struct socket *sock,
>
> 	transport = vsk->transport;
>
>+	if (level == SOL_SOCKET) {

We could reduce the indentation here:
		if (optname != SO_ZEROCOPY) {
			release_sock(sk);
			return sock_setsockopt(sock, level, optname, optval, optlen);
		}

Then remove the next indentation.

>+		if (optname == SO_ZEROCOPY) {
>+			int zc_val;

`zerocopy` is more readable.
>+
>+			/* Use 'int' type here, because variable to
>+			 * set this option usually has this type.
>+			 */
>+			COPY_IN(zc_val);
>+
>+			if (zc_val < 0 || zc_val > 1) {
>+				err = -EINVAL;
>+				goto exit;
>+			}
>+
>+			if (transport && !vsock_msgzerocopy_allow(transport)) {
>+				err = -EOPNOTSUPP;
>+				goto exit;
>+			}
>+
>+			sock_valbool_flag(sk, SOCK_ZEROCOPY,
>+					  zc_val ? true : false);

Why not using directly `zc_val`?
The 3rd param of sock_valbool_flag() is an int.

>+			goto exit;
>+		}
>+
>+		release_sock(sk);
>+		return sock_setsockopt(sock, level, optname, optval, optlen);
>+	}
>+
> 	switch (optname) {
> 	case SO_VM_SOCKETS_BUFFER_SIZE:
> 		COPY_IN(val);
>@@ -2321,6 +2359,8 @@ static int vsock_create(struct net *net, struct socket *sock,
> 		}
> 	}
>
>+	set_bit(SOCK_CUSTOM_SOCKOPT, &sk->sk_socket->flags);
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
