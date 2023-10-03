Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E956CE7AD77
	for <virtualization@archiver.kernel.org>; Tue,  3 Oct 2023 16:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D4BA418A3;
	Tue,  3 Oct 2023 16:23:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D4BA418A3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E/EqjKmG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BFgMMSXrjOMS; Tue,  3 Oct 2023 16:23:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 82863417DC;
	Tue,  3 Oct 2023 16:23:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82863417DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6976CC0071;
	Tue,  3 Oct 2023 16:23:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5055C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83BEF4052A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83BEF4052A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=E/EqjKmG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4I_4a3IIltBH
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4318740182
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Oct 2023 16:23:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4318740182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696350220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sfMS7si10Em3Ih0ewdIsQWk4sOjmW1agVLON4O4ZHFs=;
 b=E/EqjKmGORySBA8LC8FLGDNw6gfrvIK1p3+oi4pdVBimFqvU68feQ8NdPANTCtyr3gIRJ7
 0u2amggl2ubpmKxQOGegiNfK5NXOl9ek0EF21wn5D7tXZE76zaExDBk6c0E7YfcNDBXRZA
 ugXIRSE8SrMAO7F1TyMxkqdcmBbS2SQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-JfTPC-uqPQKRni9alCb-0Q-1; Tue, 03 Oct 2023 12:23:38 -0400
X-MC-Unique: JfTPC-uqPQKRni9alCb-0Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4196a386347so12608691cf.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 03 Oct 2023 09:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696350218; x=1696955018;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfMS7si10Em3Ih0ewdIsQWk4sOjmW1agVLON4O4ZHFs=;
 b=uhPeodY6HI2tBX2rcnKyDmBQWDdLRro/ndR5ypoAKw4WSynUW9WZ9EdbSFFPJzeR2W
 YNGl8IFGLyprUg0Wt1GidT7VCtWt8ZGm1H2KRaa8V7qtMl3HbyKZtw+bpt3WMcJ3agoC
 wnh87riBYcoDVdIzUhL5DCAeQFFETE9nFNLzDd2oYvMFAsjZ11xWpL6osx/sG30NQ5wG
 lcE/NYj/C+nOkPpC/bVKoq1bDZ4AFnM4wXIuxusJO2RrB2mNoOkB+TAK7LpZFyfdAyCd
 q4+7lToixd6iy7C7ywnYMhgPYBEqLFP9sqsMVHax4afq2C+kfrVDY/wWh10m45aTCM6U
 9wcg==
X-Gm-Message-State: AOJu0Yw+PzeR5fCAeX/xYrI6AvoovsveBH3JeTXOQnB2PlKciCMnt73R
 JQqzOSSR7icl3K+L6g0SB4Mwa3lRHKzrvrjbDENLTw2yXqSbNXvqiClaO3p1RYFpWYFJFy8eFgW
 B3XtUfkO+vO1kA152hwHUVN3oiEH89Q158+i+59+nXw==
X-Received: by 2002:ac8:149a:0:b0:419:af26:fc72 with SMTP id
 l26-20020ac8149a000000b00419af26fc72mr1872215qtj.27.1696350218265; 
 Tue, 03 Oct 2023 09:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQy1JM0pldsNEW5rolW8PRXJCWF1GlYH0HqlcRRXiBOMMPAuTdsJD5SqR4LDPBV8ljq34JbQ==
X-Received: by 2002:ac8:149a:0:b0:419:af26:fc72 with SMTP id
 l26-20020ac8149a000000b00419af26fc72mr1872186qtj.27.1696350217966; 
 Tue, 03 Oct 2023 09:23:37 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 d14-20020ac8118e000000b004198d026be6sm552077qtj.35.2023.10.03.09.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 09:23:37 -0700 (PDT)
Date: Tue, 3 Oct 2023 18:23:33 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v2 08/12] vsock: enable setting SO_ZEROCOPY
Message-ID: <rtc5f42epcmjksoyrvkbjmomucdg2xg6a6e7d3dm2ewuoaqok3@x37szdvwflm6>
References: <20230930210308.2394919-1-avkrasnov@salutedevices.com>
 <20230930210308.2394919-9-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230930210308.2394919-9-avkrasnov@salutedevices.com>
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

On Sun, Oct 01, 2023 at 12:03:04AM +0300, Arseniy Krasnov wrote:
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
> v1 -> v2:
>  * Place 'sock_valbool_flag()' in a single line.
>
> net/vmw_vsock/af_vsock.c | 45 ++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 43 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ff44bab05191..a84f242466cf 100644
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
>@@ -1666,6 +1674,33 @@ static int vsock_connectible_setsockopt(struct socket *sock,
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
>+		sock_valbool_flag(sk, SOCK_ZEROCOPY, zerocopy);
>+		goto exit;
>+	}
>+
> 	switch (optname) {
> 	case SO_VM_SOCKETS_BUFFER_SIZE:
> 		COPY_IN(val);
>@@ -2322,6 +2357,12 @@ static int vsock_create(struct net *net, struct socket *sock,
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
