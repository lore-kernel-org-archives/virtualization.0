Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6218AEB64DD
	for <virtualization@archiver.kernel.org>; Thu,  6 Jul 2023 16:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE72982268;
	Thu,  6 Jul 2023 16:54:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE72982268
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GpY01BcJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nBSh4H4bw-ka; Thu,  6 Jul 2023 16:54:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7FFD382219;
	Thu,  6 Jul 2023 16:54:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FFD382219
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 580F5C0071;
	Thu,  6 Jul 2023 16:54:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7302BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DA7160FFE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:54:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4DA7160FFE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GpY01BcJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xxWTA0--4kcq
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:54:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84A4D60FAB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84A4D60FAB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jul 2023 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688662461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JAiHhriZpvTS63ort7r8zwvuONWQrrwpaGdn7CXb3ds=;
 b=GpY01BcJaWxqkhsqUYIQUlR+gpG9nOcGkzZK3VPh9KWQ/TUDaO3oXdyv8unRRkdmwbDM2x
 6LEinDOOdn6CCAfCkdoPXopPbCLX9zOIHKxNYjyyGypleFH62Ul9duD0VT4aXjTRxL7cxS
 6V9fUIzVq7FG+72bXI75SyE3PYOQI8s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-xqXVtX99PI23zT7En0kO4g-1; Thu, 06 Jul 2023 12:54:20 -0400
X-MC-Unique: xqXVtX99PI23zT7En0kO4g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98df34aa83aso242917166b.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jul 2023 09:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688662459; x=1691254459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAiHhriZpvTS63ort7r8zwvuONWQrrwpaGdn7CXb3ds=;
 b=NmRab9BfdWnkBU0oFzL9EBlZ4d7gphJKjykBjm/ONnfZgjOqH9o0/L6DCPTCxBQA4u
 rnPwv25rju2PmLJMebF/QiSGAYX/IxNMSvK7d+YO5zX+AG1/XY+aH2Nfgx4KeUv1JJ/7
 /CRgltvSWs0/u6X6lvjtYmX/Os4zErdVa9LSxBjqZh/I5Ed2ExotbOJomHp7N2KEYRsE
 H+gG92GYyPuSNfWA6uwfmthx3yDQkUVFBJBvw/iIYWhCSg3Jgz9gagXtbJE9WAXAhDgh
 BYoLwNUEA6QpZhcUKBcrUUKDrWY3f48I5HhVFG3bDveS0dv50cXmd8oVussGYaEhV7y0
 an8Q==
X-Gm-Message-State: ABy/qLaqi5oJNkhUMqGVb/zaqoo7YZjvhEbj/eqkBiAGcm4aJXpvu78u
 vKmB76sVYQ05aVLHPw84+rx6NMBElXvdcvqQM6Y2Ik9DQRbiiXXF+aCEtAKmlpyono7HnsDrEXK
 3hjtahI09H0nuG/CLEpnB6TbaPEdVF5Fizkyw6Fp68g==
X-Received: by 2002:a17:906:189:b0:978:8685:71d5 with SMTP id
 9-20020a170906018900b00978868571d5mr2589629ejb.30.1688662459239; 
 Thu, 06 Jul 2023 09:54:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFnhk3IpvpZs4YO7xxAyJb/wtXZUKN6ADWvXy9B2WEMXrs6pu4JTD3zmKxYP2iPxRlve8MOrw==
X-Received: by 2002:a17:906:189:b0:978:8685:71d5 with SMTP id
 9-20020a170906018900b00978868571d5mr2589600ejb.30.1688662458935; 
 Thu, 06 Jul 2023 09:54:18 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 l10-20020a1709066b8a00b00992f2befcbcsm1023534ejr.180.2023.07.06.09.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 09:54:18 -0700 (PDT)
Date: Thu, 6 Jul 2023 18:54:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 06/17] vsock: fix EPOLLERR set on non-empty error
 queue
Message-ID: <bwcgwfiwf5siky3nqvcedenvooszd4vk2gfi6tkvge2ayfyim6@wihfy74lqoct>
References: <20230701063947.3422088-1-AVKrasnov@sberdevices.ru>
 <20230701063947.3422088-7-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230701063947.3422088-7-AVKrasnov@sberdevices.ru>
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

On Sat, Jul 01, 2023 at 09:39:36AM +0300, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>reader of error queue won't detect data in it using EPOLLERR bit.
>Currently for AF_VSOCK this is reproducible only with MSG_ZEROCOPY, as
>this feature is the only user of an error queue of the socket.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

Sorry if I confused you, but if without MSG_ZEROCOPY this is not an
issue, then we can remove the Fixes tag.

>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> Changelog:
> v4 -> v5:
>  * Change commit message as Fix patch. Also add details that this
>    problem could be reproduced only with MSG_ZEROCOPY transmission
>    mode.
>
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index efb8a0937a13..45fd20c4ed50 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1030,7 +1030,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 	poll_wait(file, sk_sleep(sk), wait);
> 	mask = 0;
>
>-	if (sk->sk_err)
>+	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
> 		/* Signify that there has been an error on this socket. */
> 		mask |= EPOLLERR;
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
