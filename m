Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B664BC47089
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 13:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 429B481819;
	Mon,  5 Dec 2022 13:16:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 429B481819
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tqtbi/al
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cj55lhQwG2ls; Mon,  5 Dec 2022 13:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F7FA81773;
	Mon,  5 Dec 2022 13:16:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F7FA81773
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69B4BC0033;
	Mon,  5 Dec 2022 13:16:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DAD7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 53865415FF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:16:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 53865415FF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tqtbi/al
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Frps4zMmMQLO
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:16:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 732F4415FB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 732F4415FB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670246204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DO8SJNUghVVw6i+5wKTtjH6tRTTOZjv69W3dDMY1mWw=;
 b=Tqtbi/alqwM1pDa7pNFm+p+86sN5y2dtNp117e/uestovlj+XDRWQYE9HqdDPjViqZF63y
 b9ydUaOYP3Wt3O2aGA3CUVjHl13zEjavfD6AkbbfdQU7GYPpEskEVYjpr/OsglcasFuam8
 PdMW2dPOWv03jKlTuwYK13RK4EGamR8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-480-95sVTKoKN02EQlP__cK7lw-1; Mon, 05 Dec 2022 08:16:43 -0500
X-MC-Unique: 95sVTKoKN02EQlP__cK7lw-1
Received: by mail-wr1-f72.google.com with SMTP id
 s1-20020adfa281000000b00241f7467851so2302326wra.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 05:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DO8SJNUghVVw6i+5wKTtjH6tRTTOZjv69W3dDMY1mWw=;
 b=HkHrBj0f9/Z4VKNnEttiecHc3O2BcrxMD5VkvdQOaUNyDwMmD/ABitaMVC4il5kwKu
 Np13RLvuwBFSRG1zBYBUl2m3Ehra8kaj8t5PcDeSLdu52Sm3mpPT39o3W9y3Qqvx/wWo
 QIGoWS9ckJloCKXL8XsAaxtWuuSexwfMbd0N4tEq8dDV5Pe6aSYRKHlVxpjB6yTadZ3y
 1KuFWKDeDJ4zZgV6O9yKMTj/VV9pElYn7r7Nt2qUE+Wpaw79frBL54F5gvIDri3/zCHG
 DK3uuAfCclWjXDIO6nHJL151ZIe7XME1hpQPFBUvy8jfLPv8mC7VnMvY9kHqN2Oql8aO
 Qylw==
X-Gm-Message-State: ANoB5pl7TAq+l821DoyI+b4rb3IttL1cH1YSt6b+ncNysxXFkKtn5W6X
 JMfo7bKaB5iCAIMXfaToJRUCLYI6Ju5pkhIX0uioXNLUYqZ+nhcV2idxrMnE8U5pM8hGqJLxuU7
 lHx1c+pExiliVo83zHze4tNq2tf90NlHmRkFzWsMAuA==
X-Received: by 2002:a05:600c:4f83:b0:3cf:8b32:a52 with SMTP id
 n3-20020a05600c4f8300b003cf8b320a52mr65013333wmq.72.1670246201983; 
 Mon, 05 Dec 2022 05:16:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5dHQeZqTtLmzELyCvm4sexqKq5GSBWNyWh4RYxCnvNU/SWwzywpUQAkj8otDW6yIuu0Vwtdw==
X-Received: by 2002:a05:600c:4f83:b0:3cf:8b32:a52 with SMTP id
 n3-20020a05600c4f8300b003cf8b320a52mr65013316wmq.72.1670246201772; 
 Mon, 05 Dec 2022 05:16:41 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 d10-20020adffbca000000b002366f9bd717sm17153303wrs.45.2022.12.05.05.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 05:16:41 -0800 (PST)
Date: Mon, 5 Dec 2022 14:16:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 1/4] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <20221205131638.7ymjzijkqlrimzqg@sgarzare-redhat>
References: <6bd77692-8388-8693-f15f-833df1fa6afd@sberdevices.ru>
 <b9ea0ff4-3aef-030e-0a9b-e2fcb67b305b@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <b9ea0ff4-3aef-030e-0a9b-e2fcb67b305b@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
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

On Sun, Dec 04, 2022 at 07:19:20PM +0000, Arseniy Krasnov wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This removes behaviour, where error code returned from any
>transport was always switched to ENOMEM.

I would add here the example you described in the cover letter with 
EMSGSIZE, so the problem is better explained.

>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 884eca7f6743..61ddab664c33 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1862,8 +1862,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			written = transport->stream_enqueue(vsk,
> 					msg, len - total_written);
> 		}
>+
> 		if (written < 0) {
>-			err = -ENOMEM;
>+			err = written;
> 			goto out_err;
> 		}
>
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
