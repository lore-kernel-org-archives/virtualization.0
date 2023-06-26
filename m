Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FD5EB64DA
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 16:05:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3112F612EC;
	Mon, 26 Jun 2023 16:05:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3112F612EC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJx5O3WD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SAZSr9RDa8Tp; Mon, 26 Jun 2023 16:05:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A0F4660E33;
	Mon, 26 Jun 2023 16:05:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A0F4660E33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77129C007A;
	Mon, 26 Jun 2023 16:05:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AD96C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:05:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68259401A4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:05:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 68259401A4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJx5O3WD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LdUvUn62o-lx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:05:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A16D6400EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A16D6400EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b0yQZBdpdUXl4YMdFLcFlkwsrjZb29VthZRnokOZ88k=;
 b=XJx5O3WDjN8KXTIhZCr9xvD4m770vpRPGpAdhapgg4H7nFTg2pY561SIgDTMadp+aJ1SJY
 6PBQen5CMkOpAJlGgRwRb7jEJnEl95Z2xK7gHRlZ9X4bAOXnhvOwF6CXrSvmORN/bDlTA2
 RaF80FxQN3w1wyXYGCxDCn4Wk+rZdZs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-TWYbf3aWOoygQism5Xyscg-1; Mon, 26 Jun 2023 12:05:02 -0400
X-MC-Unique: TWYbf3aWOoygQism5Xyscg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4009c8a8d74so13391171cf.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795490; x=1690387490;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0yQZBdpdUXl4YMdFLcFlkwsrjZb29VthZRnokOZ88k=;
 b=kADFz7Gpl0DY4y6dRYPgBEn4lO3BckoTCnaPCSIcNVNCJsWfJHwiLyR4sdD62bySlK
 abg6zc0UKmM7bXPU4uto6ICMzXOwA4iKUd9Qwx0W23qRdwONQcz4sBiMD6p2w2yUcmBP
 7I3/qe5MdH1x1hSAQrq4T8+LWb+Tozl/Su+VpxBc7eOpOyhwnRv8hpOS/mUpeqE/QRam
 JuzOm4DUmdRWSQ+qZY9b15wHnDIMYHG1la/2WS1cxhKAg6jlMkZoy2XhUzYhMThnbYzo
 2psaaHZtpah0N/lf45CpVNOJ7XcIOLKjeVaaCuINLhDc5/0bLL7/kE33BEWnlUnD3uMH
 Yicw==
X-Gm-Message-State: AC+VfDxjdijr0BRYKmAnfEFjLIC0eqztBXnbbwDjyVNbqtfzUobJEUlV
 qt0R4D57IY/Tp2kZPlV3GuUnUTFIgCFJdXjxuluP04mPyKUAkppFva5FA+u84mhONp1qIpfftKP
 bvftS1SvGtFyEbVHpVyncnjc7VhM01NSBLi39mP+3sg==
X-Received: by 2002:ac8:5dcc:0:b0:3ff:2fae:b4bb with SMTP id
 e12-20020ac85dcc000000b003ff2faeb4bbmr22270344qtx.37.1687795489887; 
 Mon, 26 Jun 2023 09:04:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6scFxlQwYFHNY1LJg+2KYwo5IzNCiATxO/eK3932x063Eqk2Ca+8K2qyxj23DPRz3vgCwgrw==
X-Received: by 2002:ac8:5dcc:0:b0:3ff:2fae:b4bb with SMTP id
 e12-20020ac85dcc000000b003ff2faeb4bbmr22270315qtx.37.1687795489480; 
 Mon, 26 Jun 2023 09:04:49 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 z6-20020a05622a124600b00400ab543858sm900265qtx.67.2023.06.26.09.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:04:48 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:04:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 06/17] vsock: check error queue to set EPOLLERR
Message-ID: <rg3qxgiqqi5ltt4jcf3k5tcnynh2so5ascvrte4gywcfffusv4@qjz3tkumeq7g>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-7-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-7-AVKrasnov@sberdevices.ru>
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

On Sat, Jun 03, 2023 at 11:49:28PM +0300, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>reader of error queue won't detect data in it using EPOLLERR bit.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

This patch looks like it can go even without this series.

Is it a fix? Should we add a fixes tag?

Thanks,
Stefano

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
