Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA44C43460
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:37:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2563561421
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 08:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2563561421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7800406A1;
	Wed, 21 Apr 2021 08:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JApcFwbaL073; Wed, 21 Apr 2021 08:37:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 00616406A4;
	Wed, 21 Apr 2021 08:37:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6A10C000E;
	Wed, 21 Apr 2021 08:37:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87F1BC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 75C4E83D73
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HykZyH20mWv8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:37:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CC7782D3C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618994263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sDT07Cw674WH/mojd5E+GUtnkF6CqYLs/uZ0jQ1hic0=;
 b=XkgKkRQMkjM1LmZEjFTayIc/EZSPHuoMv/7Xk6ikx0s+m54Az6ylLtbmZAI566b7WJwKLa
 bMokIlmqNnhjQkA5jjFkhxlEhyVhwJPIG+za/Kd5nSQtHgAYeLMz+6sN8doIxnpzEOtMRZ
 eFLkuE42E13tvRZQ+k2mwYqrB0v4qN4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-scHZReFgMMWdgsa_SdmVug-1; Wed, 21 Apr 2021 04:37:36 -0400
X-MC-Unique: scHZReFgMMWdgsa_SdmVug-1
Received: by mail-ed1-f72.google.com with SMTP id
 l7-20020aa7c3070000b029038502ffe9f2so8848742edq.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 01:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sDT07Cw674WH/mojd5E+GUtnkF6CqYLs/uZ0jQ1hic0=;
 b=eC9psLcn9Z0+IJnSVikqwv0a7aOS1SI4BYmgUnFqM0OB///LzNXGfuWYdCSBJ4fQGK
 5tAZUX0eT7sOWvMEa0PTWQT8Kq7qptcG5aSCpjlXGYmGqiO3oXkD6cTGK7czkjLEK0eX
 VvqRc8/kM8JbqhdMEAn0RGdxXtlim1qSh++sRx2WnvgZpIXxziS70Tfzje7TaFoVs1H6
 7hOR9/NHldtz3Lmfv9HGR9kbODYvB+HgFujuuKCQpoOxew3XrgGlRNQy4jnjsGAvCE9O
 lA4s7qWP3QL94GPVCs+mOyB6zdkNjK9SxWd9f+kqy5hlQQeoncC+WUD2C/bz971K1Ulp
 OkBw==
X-Gm-Message-State: AOAM530D+MLHuN8LX1qfGLZEU5dvEsHeNW7NcBMQ9FkgFixFNsSA3aD1
 hT3njgEaNyD6v4yK5zar1FDCXbHBmr15E98NiMYkwH+S7AnjIKOR7fQgj+eRAj8zHVmt3UtY9l/
 6MGPucN1Yo4E3V+u6abYBFomRlLT2Gf8BFoRylX9Rcg==
X-Received: by 2002:a17:907:1c01:: with SMTP id
 nc1mr31882939ejc.283.1618994255626; 
 Wed, 21 Apr 2021 01:37:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSP6XGvPrxAywAWr8b/JgEcImy2Q+kz2faESZbGiR2d6lEZWR9hpP8hNuyIR/PuDv+hiDtpg==
X-Received: by 2002:a17:907:1c01:: with SMTP id
 nc1mr31882918ejc.283.1618994255344; 
 Wed, 21 Apr 2021 01:37:35 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id m14sm2254201edr.45.2021.04.21.01.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 01:37:34 -0700 (PDT)
Date: Wed, 21 Apr 2021 10:37:32 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 04/19] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210421083732.hxlilatddifcokjx@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210413124250.3400313-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210413124250.3400313-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Tue, Apr 13, 2021 at 03:42:47PM +0300, Arseny Krasnov wrote:
>This adds receive loop for SEQPACKET. It looks like receive loop for
>STREAM, but there is a little bit difference:
>1) It doesn't call notify callbacks.
>2) It doesn't care about 'SO_SNDLOWAT' and 'SO_RCVLOWAT' values, because
>   there is no sense for these values in SEQPACKET case.
>3) It waits until whole record is received or error is found during
>   receiving.
>4) It processes and sets 'MSG_TRUNC' flag.
>
>So to avoid extra conditions for two types of socket inside one loop, two
>independent functions were created.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
>v7 -> v8:
> - Length of message is now not returned by callback, it returns only
>   length of data read by each call.
> - Previous case, when EAGAIN is return and dequeue loop restarted now
>   removed(in this simplified version we consider that message could not
>   be corrupted).
> - MSG_TRUNC in input flags is now handled by callback.
>
> include/net/af_vsock.h   |  4 +++
> net/vmw_vsock/af_vsock.c | 66 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 69 insertions(+), 1 deletion(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index b1c717286993..5175f5a52ce1 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -135,6 +135,10 @@ struct vsock_transport {
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>
>+	/* SEQ_PACKET. */
>+	ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>+				     int flags, bool *msg_ready);
>+
> 	/* Notification. */
> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
> 	int (*notify_poll_out)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index c4f6bfa1e381..d9fb4f9a3063 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1974,6 +1974,67 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
> 	return err;
> }
>
>+static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>+				     size_t len, int flags)
>+{
>+	const struct vsock_transport *transport;
>+	bool msg_ready;
>+	struct vsock_sock *vsk;
>+	ssize_t record_len;
>+	long timeout;
>+	int err = 0;
>+	DEFINE_WAIT(wait);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>+	msg_ready = false;
>+	record_len = 0;
>+
>+	while (1) {
>+		ssize_t tmp_record_len;

Maybe better a name like `partial_len`, `fragment_len`, or just `read`.

>+
>+		if (vsock_wait_data(sk, &wait, timeout, NULL, 0) <= 0) {
>+			/* In case of any loop break(timeout, signal
>+			 * interrupt or shutdown), we report user that
>+			 * nothing was copied.
>+			 */
>+			err = 0;
>+			break;
>+		}
>+
>+		tmp_record_len = transport->seqpacket_dequeue(vsk, msg, flags, &msg_ready);

I think we can avoid to pass 'flags' down to the transports.

We can require that seqpacket_dequeue() should always return the real 
size of the packet received, and then check below if 'MSG_TRUNC' was 
set...

>+
>+		if (tmp_record_len < 0) {
>+			err = -ENOMEM;
>+			break;
>+		}
>+
>+		record_len += tmp_record_len;
>+
>+		if (msg_ready)
>+			break;
>+	}
>+
>+	if (sk->sk_err)
>+		err = -sk->sk_err;
>+	else if (sk->sk_shutdown & RCV_SHUTDOWN)
>+		err = 0;
>+
>+	if (msg_ready && err == 0) {
>+		err = record_len;
>+
>+		/* Always set MSG_TRUNC if real length of packet is
>+		 * bigger than user's buffer.
>+		 */

...here:
		if (flags & MSG_TRUNC && record_len > len)

>+		if (record_len > len)
>+			msg->msg_flags |= MSG_TRUNC;
>+	}
>+
>+	return err;
>+}
>+
> static int
> vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 			  int flags)
>@@ -2029,7 +2090,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		goto out;
> 	}
>
>-	err = __vsock_stream_recvmsg(sk, msg, len, flags);
>+	if (sk->sk_type == SOCK_STREAM)
>+		err = __vsock_stream_recvmsg(sk, msg, len, flags);
>+	else
>+		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);
>
> out:
> 	release_sock(sk);
>-- )
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
