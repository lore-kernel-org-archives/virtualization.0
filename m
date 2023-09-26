Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7282FE7E62F
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 12:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E953782310;
	Tue, 26 Sep 2023 12:55:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E953782310
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F2uh2LRe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Lkk-X9JKSOn; Tue, 26 Sep 2023 12:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BCE98230E;
	Tue, 26 Sep 2023 12:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BCE98230E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 436ABC0039;
	Tue, 26 Sep 2023 12:55:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B71CEC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 852248230F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:55:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 852248230F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rDgeEPWSy86f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:55:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C36338230E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 12:55:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C36338230E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695732900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2uW5BPkL7G62EXjKucVaT4hjcyiDQF9d1Ksud/nFSa4=;
 b=F2uh2LRekgMw6h7iAASK4puNgf47moQBrHHV9zbt4iArrZCvarzcQl8kRlER7L3WZVDVPF
 lgZUk6csC65UEYfebH7mHXVT0CRtJQEedTzJuSLimKtBnuQS7Qi0xpomu7n1j2fNRNJtfo
 3UjjVFS6SYBsfFzvfS5frMXHT8DPLw8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-7F2fy3CoP-C0-0VtLMshQw-1; Tue, 26 Sep 2023 08:54:59 -0400
X-MC-Unique: 7F2fy3CoP-C0-0VtLMshQw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c038a1e2f6so134383481fa.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695732897; x=1696337697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2uW5BPkL7G62EXjKucVaT4hjcyiDQF9d1Ksud/nFSa4=;
 b=FMiMZXcMpQBfnXNVIfVYmyhXc/TCzK+JZm6yh1TtP7xwt/G5dvrOjmD+FeCwODSrJ0
 W26rOZJdLfbWlFYBlW5t08y1/xx4UXkDXtrqu+n/qVM8efIPtzV2Qh6t99ZH6Ma7TaAE
 j3RXsEUX6XKLVreaWTZtmXNrSLtYLyV8f7+4jR0wqqt0xOHz6ErZb4f+rrY9KL5CpwGi
 +zihEPAMKGFpyzy2MWLwhOkLUgFGh2VXGY5Heh5GGAbzZlX/k2Bvv11XY/O6uP7D/j7a
 ZsE9xA+qncM23uEGSPeXnaXs4h5E049qemhfYj97n17djDDupe3f792dFG/9+ud2eKNG
 YvSw==
X-Gm-Message-State: AOJu0Yz6O1gGRKo7g4C2P7QZCEk4AVZ20GOtQlyAIVvhot0q1p2m5ZOc
 Ibhx1DnAlGaB+MaywpQpgIkQJAH4PNa3LnV+HPqqdY4dkeLWpHB6UP1l/sZfhjXQAKyEJjyCoiH
 LJoQ/maQF5eBkvgF8pxtekUPhp4WmjQ41VqlU2SYGlA==
X-Received: by 2002:a2e:b04c:0:b0:2bb:a28b:58e1 with SMTP id
 d12-20020a2eb04c000000b002bba28b58e1mr8106208ljl.41.1695732897289; 
 Tue, 26 Sep 2023 05:54:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5q2QvU/4B+w5gQ4LBJ4yGShJuspgZAbJhAjCh9mTkszev9SWItBdbop+W/rBkb0q5Yimnxw==
X-Received: by 2002:a2e:b04c:0:b0:2bb:a28b:58e1 with SMTP id
 d12-20020a2eb04c000000b002bba28b58e1mr8106195ljl.41.1695732896938; 
 Tue, 26 Sep 2023 05:54:56 -0700 (PDT)
Received: from sgarzare-redhat ([46.6.146.182])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170906279100b0099329b3ab67sm7735262ejc.71.2023.09.26.05.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:54:56 -0700 (PDT)
Date: Tue, 26 Sep 2023 14:54:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v1 01/12] vsock: fix EPOLLERR set on non-empty
 error queue
Message-ID: <lj3wjq4ccplc6ia7mehuu4onzpgntaykvwpyzlavqj5uek2amg@oo3vyfiteysx>
References: <20230922052428.4005676-1-avkrasnov@salutedevices.com>
 <20230922052428.4005676-2-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230922052428.4005676-2-avkrasnov@salutedevices.com>
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

On Fri, Sep 22, 2023 at 08:24:17AM +0300, Arseniy Krasnov wrote:
>If socket's error queue is not empty, EPOLLERR must be set. Otherwise,
>reader of error queue won't detect data in it using EPOLLERR bit.
>Currently for AF_VSOCK this is reproducible only with MSG_ZEROCOPY, as
>this feature is the only user of an error queue of the socket.

So this is not really a fix. I'd use a different title to avoid
confusion on backporting this on stable branches or not.

Maybe just "vsock: set EPOLLERR on non-empty error queue"

The change LGTM.

Stefano

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> net/vmw_vsock/af_vsock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 013b65241b65..d841f4de33b0 100644
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
