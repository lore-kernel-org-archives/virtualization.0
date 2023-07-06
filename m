Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38725EB64D9
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDE46822A1;
	Thu,  6 Jul 2023 16:55:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDE46822A1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb5SVJTp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gFc3Naz47dep; Thu,  6 Jul 2023 16:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 718C18223D;
	Thu,  6 Jul 2023 16:55:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 718C18223D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AE51C0071;
	Thu,  6 Jul 2023 16:55:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B027C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13A5360FFE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13A5360FFE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jb5SVJTp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q5BqDkJJ8qmh
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3F9D560FAB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F9D560FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wsYIzXoEJlWb8NyyL4GSQKwnf6b27lly+h6hlBtZZFs=;
 b=Jb5SVJTpJgjzyHoGeQQcs39mvjVDFW8BGdq1uDT8jF/G7eR1gCG5AnU7nZf99AqnMbKCzd
 wmIcT3EDVT019mEylTS1Ldx83h1RF9U9fPTPUDMkPxsqXRF6cIVR+DRNMAw0gEPdniTk0x
 H1uD+hsdDCEq6pnqMpFT7knKBu8KpRQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-RrTkh1kkO024pA_Ysa4NBQ-1; Thu, 06 Jul 2023 12:55:17 -0400
X-MC-Unique: RrTkh1kkO024pA_Ysa4NBQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9932e8e76b9so68824166b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662516; x=1691254516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsYIzXoEJlWb8NyyL4GSQKwnf6b27lly+h6hlBtZZFs=;
 b=eGdAN2/WhJzX4MYfrK1sikUTgF30AfK97vZ9Mk1eAN5UQzCyY3nYZhhd+kxKJcEVYH
 zVyqDrcL6FV79LOL0tXYh3JE3ZflaP1s7XpZwLQ7k2nd2I9I5HbtJu/gHCq5w+1VIEaH
 pBtWILWhkTM/kf+YQLbG/CV0YV1jpzECRspQVyY3IPjcpIPWxYWwz6W46LBJWw1hmViu
 iw8dib4nz1xe4JoQhZ0+AtsnTL3MOi12s9X0PQ5Kd4Ph7DdbzUHSjk2G3CIVIsvbibVX
 SZ7KLtF4PtV7yh9Xqnzuj7dSk2KRaTRzxogebo5V8KxHvc/U+YIziws8EWlboCIkQcss
 r1kg==
X-Gm-Message-State: ABy/qLbsxYlSqO1fc9eOro0gwAW0zWKX1bdrDqwoQaOFAo+JT1Dlhit+
 xNfweRBvtwt9a8VV7vDPzV6amzZsXFXO0evJ3j8q3UHg/9st9iExQmgGWySGNsHsTbsr8pbHEda
 Ps1N28ITniBBYdnsG6Nt0IaeSOELJySe7nuWD42vU4g==
X-Received: by 2002:a17:906:2ca:b0:979:65f0:cced with SMTP id
 10-20020a17090602ca00b0097965f0ccedmr1934014ejk.17.1688662516699; 
 Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkD0rlqSdTev+Q2IqNmZT5B5F3idaEZ37dXEcrn3WdUID6ErjT2MTHmJfkU0j9eSLaJFZ9qQ==
X-Received: by 2002:a17:906:2ca:b0:979:65f0:cced with SMTP id
 10-20020a17090602ca00b0097965f0ccedmr1934002ejk.17.1688662516511; 
 Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 mb8-20020a170906eb0800b009737b8d47b6sm1023809ejb.203.2023.07.06.09.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:55:16 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:55:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 09/17] vsock: enable SOCK_SUPPORT_ZC bit
Message-ID: <vaknax5rfvbb3ymylshak4cih2ddhsfhiq5dualh5frbedczmw@zduzizg2g6pa>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-10-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-10-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:39AM +0300, Arseniy Krasnov wrote:
>This bit is used by io_uring in case of zerocopy tx mode. io_uring code
>checks, that socket has this feature. This patch sets it in two places:
>1) For socket in 'connect()' call.
>2) For new socket which is returned by 'accept()' call.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 033006e1b5ad..da22ae0ef477 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1406,6 +1406,9 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			goto out;
> 		}
>
>+		if (vsock_msgzerocopy_allow(transport))
>+			set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>+
> 		err = vsock_auto_bind(vsk);
> 		if (err)
> 			goto out;
>@@ -1560,6 +1563,9 @@ static int vsock_accept(struct socket *sock, struct socket *newsock, int flags,
> 		} else {
> 			newsock->state = SS_CONNECTED;
> 			sock_graft(connected, newsock);
>+			if (vsock_msgzerocopy_allow(vconnected->transport))
>+				set_bit(SOCK_SUPPORT_ZC,
>+					&connected->sk_socket->flags);
> 		}
>
> 		release_sock(connected);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
