Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10898C761A6
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 11:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84F0D60F69;
	Mon,  3 Apr 2023 11:15:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 84F0D60F69
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jJtoOU/7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UFvRtX1OOUz0; Mon,  3 Apr 2023 11:15:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2824760D94;
	Mon,  3 Apr 2023 11:15:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2824760D94
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04AC7C0037;
	Mon,  3 Apr 2023 11:15:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A3C1C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 11:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 246E581E40
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 11:15:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 246E581E40
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jJtoOU/7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDedOWb9KZh3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 11:15:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5934E81B52
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5934E81B52
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 11:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680520543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ur1wtGFej11roMtg3KU2Y0Q1CPjhKzuCIJeUQ2U0Vpk=;
 b=jJtoOU/7QKY1/S76Z41qlhZGBkfvuscdHMGtDv1hlk/uLwdJqGARhkbj+1oD0QNhtdOEe+
 oXhzuisrlrDAoWPgCsptB+fexuh4y5oXn/DG/9PoI/7BCvYMTBPx+thWujhDYHxzXduaK1
 tQhTsnzRIDIm0RgGhO7ixmF04Kx701c=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-AjMdnI_3MRmjog293fDPzw-1; Mon, 03 Apr 2023 07:15:42 -0400
X-MC-Unique: AjMdnI_3MRmjog293fDPzw-1
Received: by mail-qk1-f197.google.com with SMTP id
 t23-20020a374617000000b0074a4dba4b5aso277847qka.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Apr 2023 04:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680520541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ur1wtGFej11roMtg3KU2Y0Q1CPjhKzuCIJeUQ2U0Vpk=;
 b=Z3Ceh+6500Ygfe5Xa0WsgclHv8DL++5KUXgTbxWMq7aofBcUOztVdQJHsCMbsk0FeU
 YR7Qlai/fQlOtVpbx1kP5WkLhgqKdxGgDAPyHNcF9mjq7EsNFHSlDLMO0hkPzFLDZeOW
 xqRwt1q/GjDWmgVeCQ7gFaRK9ZN0dHl9BDaJm0dmqhTOjYam0PF0xbsCiQxwXQGQJ53c
 Fir1fYWkiazW9d4pzeUJG2t6WWbNnKQbVL33B2fVu4tLJroIM9CKjlikX/HfA2Uj8TFp
 OHPFIlbrIM/jKDZmFCJniWGoZIgy1NCXHDmbtR2QelhEY/lUntiiQfh8CBvH8etYBB2I
 bSDw==
X-Gm-Message-State: AO0yUKVexlfS8xKYQu0tTSBbLHKM/G8E2M7xdrB+noaCIW5g0gbAk3Cu
 +zfqoHFLfT8MzUE85gw3MaZxDEaFqj6I+o3Y6kzX0PWvkNaWk4YmAZzsUWLmCoS/0ps5BnYv2Hz
 Eo/GYDYr2YtGxfL9sIbNRs5G0zcQ2bSfVfAPVP51DYA==
X-Received: by 2002:ac8:5cd2:0:b0:3bf:a061:6cb1 with SMTP id
 s18-20020ac85cd2000000b003bfa0616cb1mr62090922qta.46.1680520541583; 
 Mon, 03 Apr 2023 04:15:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set8HQpeyOJ/KXUSADH0MyprE5zMqtU8EoodOwfi6AnLSMUEFrXmYuk4bhITi/GbG6fLerg5XmQ==
X-Received: by 2002:ac8:5cd2:0:b0:3bf:a061:6cb1 with SMTP id
 s18-20020ac85cd2000000b003bfa0616cb1mr62090843qta.46.1680520540973; 
 Mon, 03 Apr 2023 04:15:40 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 m124-20020a375882000000b0073b8745fd39sm2682759qkb.110.2023.04.03.04.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Apr 2023 04:15:40 -0700 (PDT)
Date: Mon, 3 Apr 2023 13:15:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 2/3] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <veo5rzjqzzdamfml5hx2ycwgsbflv7l62trdicmdqcivklarq2@p5wiwzn35tea>
References: <5440aa51-8a6c-ac9f-9578-5bf9d66217a5@sberdevices.ru>
 <7715fd7f-1c50-7202-03c7-9d17c7f63cab@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <7715fd7f-1c50-7202-03c7-9d17c7f63cab@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
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

On Sun, Apr 02, 2023 at 09:16:46PM +0300, Arseniy Krasnov wrote:
>This removes behaviour, where error code returned from any transport
>was always switched to ENOMEM. This works in the same way as:
>commit
>c43170b7e157 ("vsock: return errors other than -ENOMEM to socket"),
>but for receive calls.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5f2dda35c980..413407bb646c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2043,7 +2043,7 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>
> 		read = transport->stream_dequeue(vsk, msg, len - copied, flags);
> 		if (read < 0) {
>-			err = -ENOMEM;
>+			err = read;
> 			break;
> 		}
>
>@@ -2094,7 +2094,7 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 	msg_len = transport->seqpacket_dequeue(vsk, msg, flags);
>
> 	if (msg_len < 0) {
>-		err = -ENOMEM;
>+		err = msg_len;
> 		goto out;
> 	}
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
