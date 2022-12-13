Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43FFC04FDE
	for <virtualization@archiver.kernel.org>; Tue, 13 Dec 2022 10:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D5D540993;
	Tue, 13 Dec 2022 10:44:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D5D540993
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bd5Yv1V7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eKYBuCEne4Jg; Tue, 13 Dec 2022 10:44:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BFB68405D4;
	Tue, 13 Dec 2022 10:44:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFB68405D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B07AC0033;
	Tue, 13 Dec 2022 10:44:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34419C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 10:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EF72E40983
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 10:44:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF72E40983
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v7-3n399DmXy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 10:44:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FFF6405D4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FFF6405D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670928285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pMYwjIC6UHS7AUmMk2EC3pw2uQe+h6oRlfhlealRKwM=;
 b=Bd5Yv1V7MQ/yroSEfHX6Do2salJvpzv1HtZALSc6tyrZwtx7GvcabInIIV7f/tOqjX3asG
 l/eKRQbUwhtU4rrF7M8kEOxBGHDjTfsAUFiqdlPXmOCq27YwJTgKbO6WNJ7a0B9jyEY360
 MIco/XEJ5oWAFg7PVrkg9o8OhWoeUCA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-hgGLlOi6Msax3JPQOoFo8A-1; Tue, 13 Dec 2022 05:44:44 -0500
X-MC-Unique: hgGLlOi6Msax3JPQOoFo8A-1
Received: by mail-wm1-f69.google.com with SMTP id
 a6-20020a05600c224600b003d1f3ed49adso2853660wmm.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Dec 2022 02:44:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMYwjIC6UHS7AUmMk2EC3pw2uQe+h6oRlfhlealRKwM=;
 b=0TRyDB1pUKeg3hJnsnndUzKZ9wv3qScVwUEc4W4xsxr7bRwhADtoIbQe5L0fDyTgtZ
 EEYH0VBC52eqFwQLJIHT4c3gPyj6dKhSdiem+UNSj51Ya1FPKbwcHpJ+IDgsW5QNZBw3
 vXbLGse7oYhW5LZpdY8SnUbDJPkAha0OMESmj9HlZpJWIamYgBoykFdKOL4KnX3wQdXd
 4WH/tVbWOtgSFW2MvDY/w1tbsfh7YI1qauXX2H6pF0gA//oOODXHU43bWHlejSqcsGUA
 xmejlYxkwDBvNiuFcGNiBL8nb2Sbmq9F7D79dtu2Zy6RPu20qASJM9RWW8qD/Rasnfh+
 GykA==
X-Gm-Message-State: ANoB5pn5FyWEngE9RlWR7e7S5z/krzZZ1toRpHo/QkBAXdzhyrY/Zw3U
 qobzZrnm1Y1jwTlayFPj6M1I8w7kW2FrdvGg+KzFFelSPX+5a5l3P8EDJwlCXC3+KgQx7LqiaRy
 bDSS2OKEflcRjPbugESi6w2R1jcIjHzqNsbLuZy9Hvw==
X-Received: by 2002:a05:600c:1da2:b0:3cf:5fd2:87a0 with SMTP id
 p34-20020a05600c1da200b003cf5fd287a0mr14395238wms.40.1670928283202; 
 Tue, 13 Dec 2022 02:44:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6fNK5scCDlhlIETzu6ffXOPOCbtR/s/QsA8Tjaa1BqGfXMLIjfHxR3Ilv8TxdOGnEeUVk8cA==
X-Received: by 2002:a05:600c:1da2:b0:3cf:5fd2:87a0 with SMTP id
 p34-20020a05600c1da200b003cf5fd287a0mr14395218wms.40.1670928282971; 
 Tue, 13 Dec 2022 02:44:42 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c444a00b003cff309807esm13399985wmn.23.2022.12.13.02.44.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Dec 2022 02:44:42 -0800 (PST)
Date: Tue, 13 Dec 2022 11:44:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 1/4] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <20221213104437.llci2g7zbbffjfjo@sgarzare-redhat>
References: <6be11122-7cf2-641f-abd8-6e379ee1b88f@sberdevices.ru>
 <727f2c9e-a909-a3d3-c04f-a16529df7bb2@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <727f2c9e-a909-a3d3-c04f-a16529df7bb2@sberdevices.ru>
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

On Tue, Dec 06, 2022 at 08:49:19PM +0000, Arseniy Krasnov wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This removes behaviour, where error code returned from any transport
>was always switched to ENOMEM. For example when user tries to send too
>big message via SEQPACKET socket, transport layers return EMSGSIZE, but
>this error code will be replaced to ENOMEM and returned to user.

Just a minor thing here, I would write
"this error code was always replaced with ENOMEM and returned to user"

To make it clearer that it was the previous behavior.

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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
