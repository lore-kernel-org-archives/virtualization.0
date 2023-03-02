Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABE3C678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 10:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEDE760A63;
	Thu,  2 Mar 2023 10:06:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEDE760A63
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EvABAh4x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZhpybW9jH9f0; Thu,  2 Mar 2023 10:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 45FFD606B0;
	Thu,  2 Mar 2023 10:06:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 45FFD606B0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D275C0071;
	Thu,  2 Mar 2023 10:06:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80F7DC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 10:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 478868188A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 10:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 478868188A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EvABAh4x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mL62hAtSZyxk
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 10:06:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD6268186A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD6268186A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677751589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXAIi3FZLIk/yQi9mz4FXN1H3EGTGEpaBHWX86aG/j0=;
 b=EvABAh4xSodyJz806LZCr+YMxRRV+2qJ/SMIR4zhqDLBvNlp9Rw96jik0tMsuCgZFhckv5
 rTMXcEKrJYyxzInGZ6VlVCLibzJY9W9OT2MkwCfr9+hMizUQk+bUxgB/Amfka4HLfq01aG
 OtqjIK8jFsq3LTGNH1jjqfTkaigcm08=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-5D4pm7MPPN2CCAJQs6pNbA-1; Thu, 02 Mar 2023 05:06:26 -0500
X-MC-Unique: 5D4pm7MPPN2CCAJQs6pNbA-1
Received: by mail-wm1-f72.google.com with SMTP id
 m28-20020a05600c3b1c00b003e7d4662b83so1065205wms.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 02:06:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677751585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXAIi3FZLIk/yQi9mz4FXN1H3EGTGEpaBHWX86aG/j0=;
 b=lQ2AXesmarrcuGmVCXbOG+sNSPM4S+d3RJTzexoUDSdBEbXLd38aMWJNXvoSoj/oAZ
 no1TFBTk0MMrTQk7vDca17QzTJTtpBcdkuIH+lE+aub0MtWcku6/P7p1fjYqsCGl9KVu
 Lq2cRgGnn994wHXWZfhOefFscv4yxNtfHugyTcN402Ey7QEE6OAjVxYqRo3tUKP1PVJi
 uO+1hwtpWgQBm47Ttu815cksmAl6uKipadXSzfNWod1FED1K1XIuzMH4nFzjtMxIYBb4
 XbDHi7Kl0YCASettBvrVbYoZnc5P7KdBZem6fLeOeszOXUrS3djvayMHg0f1WvSP0b8A
 uQkg==
X-Gm-Message-State: AO0yUKWjsr+tU9JzjSlJiCpveOaD94TeKAR0fiXGNv4NDj0opQ/hQAyT
 BMqLSMjp8Ms2lRwHH5L4afQmFzEEDkcS6W+1lkveX8X11bSk0Q7eQXQV7GNTze6H5fSlCgmcBm2
 Uy8afhNRn2swgy73RNxZLOBfn2xnbP5AhC6WWbs5qVA==
X-Received: by 2002:a05:600c:170a:b0:3eb:37ce:4c3d with SMTP id
 c10-20020a05600c170a00b003eb37ce4c3dmr3352989wmn.38.1677751585592; 
 Thu, 02 Mar 2023 02:06:25 -0800 (PST)
X-Google-Smtp-Source: AK7set+/xE0Y8UibIuJEFr88ZiU69bExip1GW+fSy6pdjECNlMGo6eFU0GAAnaHnmHflDCn7D3uYEg==
X-Received: by 2002:a05:600c:170a:b0:3eb:37ce:4c3d with SMTP id
 c10-20020a05600c170a00b003eb37ce4c3dmr3352969wmn.38.1677751585285; 
 Thu, 02 Mar 2023 02:06:25 -0800 (PST)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a05600c474900b003eb5a0873e0sm2571290wmo.39.2023.03.02.02.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 02:06:24 -0800 (PST)
Date: Thu, 2 Mar 2023 11:06:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1] vsock: check error queue to set EPOLLERR
Message-ID: <20230302100621.gk45unegjbqjgpxh@sgarzare-redhat>
References: <76e7698d-890b-d14d-fa34-da5dd7dd13d8@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <76e7698d-890b-d14d-fa34-da5dd7dd13d8@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, oxffffaa@gmail.com, kernel@sberdevices.ru,
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

On Wed, Mar 01, 2023 at 08:19:45AM +0300, Arseniy Krasnov wrote:
>EPOLLERR must be set not only when there is error on the socket, but also
>when error queue of it is not empty (may be it contains some control
>messages). Without this patch 'poll()' won't detect data in error queue.

Do you have a reproducer?

>This patch is based on 'tcp_poll()'.

LGTM but we should add a Fixes tag.
It's not clear to me whether the problem depends on when we switched to 
using sk_buff or was pre-existing.

Do you have any idea when we introduced this issue?

Thanks,
Stefano

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 19aea7cba26e..b5e51ef4a74c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1026,7 +1026,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
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
