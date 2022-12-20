Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B54C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 10:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3FB1840236;
	Tue, 20 Dec 2022 10:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3FB1840236
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZNMOnTgf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wU9aI19IMuX; Tue, 20 Dec 2022 10:31:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D726640145;
	Tue, 20 Dec 2022 10:31:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D726640145
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A03D6C0035;
	Tue, 20 Dec 2022 10:31:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41C4FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14AAB81985
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:31:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14AAB81985
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZNMOnTgf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dEWnl1yL4DDc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:31:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADC66818C2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADC66818C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671532279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ymr7dvYm0bPIMGfQN+EFR1KRA6011TA++6Gv0jSwMRI=;
 b=ZNMOnTgftsysAiTrYdiH5JR6qEJIYBpnUqyO6xKrzw/iIjpMiHDKqVOeDnvIuEo6a/K9CV
 t103u8FEFZjIww08ksHmP6kt1Ng0JQNjIYSq90BNWq7MEuF62X6IlctnW3ResRrdB/ms9l
 d2U6ievO0DIy2fViYtFcW37GwZmcOVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-8uh2UEfjMfy-GpV9rM-JZQ-1; Tue, 20 Dec 2022 05:31:18 -0500
X-MC-Unique: 8uh2UEfjMfy-GpV9rM-JZQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 i187-20020a1c3bc4000000b003d634aca337so213986wma.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 02:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ymr7dvYm0bPIMGfQN+EFR1KRA6011TA++6Gv0jSwMRI=;
 b=HQ5IW/rf8JFbY+wemXOWPSVow586TzUPBjBPXh0rsMQcR+OQjAOLW+zl33R41XKlma
 mGbVaBBNHVk+/B6+1swpM6tHK3+5gHZ1L8SvO9WZ6YpxHl8cJ/Rwsg8Z4KXrevQuXPsK
 hv3HH1d+WqN5gnpfhTlcVzsdaixbLuNNEqIIiumPORkCbKLD1OGqc4JlKqvODOGrBDBg
 HtFmAIGqci8X6EyDRHiTPy2pelK2bA/v2vnt0jrRnwTJ14OwgbyPY2/ElQu5AtCqXhVf
 tWqZ0nlIN2sqRN4EurwCmuL9gwGUV6eK6CmBub00E6R60pTvjZEcDB4rlZLyAKDI/iV3
 AtIQ==
X-Gm-Message-State: ANoB5pkTWo3r7Zh6ihvgUfy5zK1W6jsi2Y/7hlQncZtuunbHT2AoImUc
 t+yfjJjgCyd+9o5gH+otQW5s41Wjell/Xwq4lb7nHyx7PlHyhtBJpzZk+m9tc4BqxdAMrlK5w+Z
 TMLnHIBFU3BbMRDNKeQlZgxt5Gk20p+EU7Kqmx709Fg==
X-Received: by 2002:a05:600c:6549:b0:3c7:1359:783b with SMTP id
 dn9-20020a05600c654900b003c71359783bmr37201624wmb.1.1671532276955; 
 Tue, 20 Dec 2022 02:31:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5x1TeapVDCTlsoX2XzG7CqIUw11/Yk6M+YURbcyrD4F7TcwGxHCWM4JyoUR/l0n84xqNGPTg==
X-Received: by 2002:a05:600c:6549:b0:3c7:1359:783b with SMTP id
 dn9-20020a05600c654900b003c71359783bmr37201614wmb.1.1671532276748; 
 Tue, 20 Dec 2022 02:31:16 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 r8-20020a05600c35c800b003a2f2bb72d5sm30909143wmq.45.2022.12.20.02.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 02:31:16 -0800 (PST)
Date: Tue, 20 Dec 2022 11:31:05 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v5 1/4] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <20221220103105.njugghpvvjusfjrs@sgarzare-redhat>
References: <e04f749e-f1a7-9a1d-8213-c633ffcc0a69@sberdevices.ru>
 <c22a2ad3-1670-169b-7184-8f4a6d90ba06@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <c22a2ad3-1670-169b-7184-8f4a6d90ba06@sberdevices.ru>
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

On Tue, Dec 20, 2022 at 07:18:48AM +0000, Arseniy Krasnov wrote:
>This removes behaviour, where error code returned from any transport
>was always switched to ENOMEM. For example when user tries to send too
>big message via SEQPACKET socket, transport layers return EMSGSIZE, but
>this error code was always replaced with ENOMEM and returned to user.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d593d5b6d4b1..19aea7cba26e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1861,8 +1861,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
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
