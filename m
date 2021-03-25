Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9A3C433DB
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 09:37:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD14619E3
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 09:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD14619E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1BC940F19;
	Thu, 25 Mar 2021 09:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9nJFr1AnBOKp; Thu, 25 Mar 2021 09:37:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id E383B40EB0;
	Thu, 25 Mar 2021 09:37:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B2FCC000D;
	Thu, 25 Mar 2021 09:37:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E700C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4EFCD40F04
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMNh5lCpfqcj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:37:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28F2A40EB0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616665063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJmprqj60mO2lWaw1IZSUhyFWeosKgCMkgr1erB7bTU=;
 b=GXBYWAB0ykilkHjLW8GyjfcsX3kv6+vBUc7Hz/oJJbgiyFYEKTJU88M0RLNkQBmjv742/7
 ciCrHeGUNJSV8KLB6zdAgC9ONqPKdNp+yWb3ol3hMQwYbJf17dbHKdDbmwCCZcvbZD310Z
 /8vE8WyNTgEMYukZpLCw0fywAzEvKFM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-rX73qnhyPB2SUodGB5ptLQ-1; Thu, 25 Mar 2021 05:37:41 -0400
X-MC-Unique: rX73qnhyPB2SUodGB5ptLQ-1
Received: by mail-wr1-f69.google.com with SMTP id n16so2403813wro.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 02:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tJmprqj60mO2lWaw1IZSUhyFWeosKgCMkgr1erB7bTU=;
 b=mhv9ig+CV6Z2hH3yO33TFdW+4QtrqhV43QYdiC1Q1jFs9m1gv5aiZ+asQByyH5XnLz
 eatbF/UHsrHuwPFRTok5kyv2wU7wPNs0ESUBGyCd28KeKI3tcE+FekgB7pGpHOrRZANR
 nMmov9VTN9UiL6aybwQASTM6hcTUs+2uKbK3pWh+obT9i4o8iKUQT7SNPCRObkyxDmVI
 wFaNNAx1AEuImRh1wUJseuJGhwUNUcCYWaTf0UhCOBYxRwz5VOzqiUsyIgpAingT80by
 Zw1d2kzfoBII9AFwhxzQ3wNWcK9Q7wOC3JJ6YLD8w/7umcCQeCUAxYHeEQ3JF9Y1p9B5
 +HKQ==
X-Gm-Message-State: AOAM532cCGckqI1e7bpz8V5IItHCtKQZaDmHi//a+6HJ1KMsfpj+tMAo
 1n5yJF8HfycJSodcN0tcy9aIEs7vziopBTmOpr2qjScNb9/VaciFB5FHPFfLf3Hyu1lCAOXSzaI
 zzbifxivoD6J/pBWL9y3smrKxuoLgl0bIEk5HaGY5pA==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr6788645wrv.185.1616665060173; 
 Thu, 25 Mar 2021 02:37:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV06+jKR3eGl0aPDByqeGSXW8O7S5acvZEyvhMLUS/1hiKAP9QZVVCu+j26QpWA3McP4CQHw==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr6788616wrv.185.1616665059991; 
 Thu, 25 Mar 2021 02:37:39 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id r14sm7036453wrw.91.2021.03.25.02.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 02:37:39 -0700 (PDT)
Date: Thu, 25 Mar 2021 10:37:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 05/22] af_vsock: separate wait space loop
Message-ID: <20210325093736.h43s47ylrxcjd2qd@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323131026.2460194-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323131026.2460194-1-arseny.krasnov@kaspersky.com>
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

On Tue, Mar 23, 2021 at 04:10:23PM +0300, Arseny Krasnov wrote:
>This moves loop that waits for space on send to separate function,
>because it will be used for SEQ_BEGIN/SEQ_END sending before and
>after data transmission. Waiting for SEQ_BEGIN/SEQ_END is needed
>because such packets carries SEQPACKET header that couldn't be
>fragmented by credit mechanism, so to avoid it, sender waits until
>enough space will be ready.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  2 +
> net/vmw_vsock/af_vsock.c | 99 +++++++++++++++++++++++++---------------
> 2 files changed, 63 insertions(+), 38 deletions(-)

I had already reviewed this one as well and it doesn't seem to have 
changed :-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 74ac8a4c4168..7232f6c42a36 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -204,6 +204,8 @@ void vsock_remove_sock(struct vsock_sock *vsk);
> void vsock_for_each_connected_socket(void (*fn)(struct sock *sk));
> int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk);
> bool vsock_find_cid(unsigned int cid);
>+int vsock_wait_space(struct sock *sk, size_t space, int flags,
>+		     struct vsock_transport_send_notify_data *send_data);
>
> /**** TAP ****/
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index fa0c37f97330..617ffe42693d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1692,6 +1692,65 @@ static int vsock_connectible_getsockopt(struct socket *sock,
> 	return 0;
> }
>
>+int vsock_wait_space(struct sock *sk, size_t space, int flags,
>+		     struct vsock_transport_send_notify_data *send_data)
>+{
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	long timeout;
>+	int err;
>+
>+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+	timeout = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
>+	err = 0;
>+
>+	add_wait_queue(sk_sleep(sk), &wait);
>+
>+	while (vsock_stream_has_space(vsk) < space &&
>+	       sk->sk_err == 0 &&
>+	       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
>+	       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
>+
>+		/* Don't wait for non-blocking sockets. */
>+		if (timeout == 0) {
>+			err = -EAGAIN;
>+			goto out_err;
>+		}
>+
>+		if (send_data) {
>+			err = transport->notify_send_pre_block(vsk, send_data);
>+			if (err < 0)
>+				goto out_err;
>+		}
>+
>+		release_sock(sk);
>+		timeout = wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
>+		lock_sock(sk);
>+		if (signal_pending(current)) {
>+			err = sock_intr_errno(timeout);
>+			goto out_err;
>+		} else if (timeout == 0) {
>+			err = -EAGAIN;
>+			goto out_err;
>+		}
>+	}
>+
>+	if (sk->sk_err) {
>+		err = -sk->sk_err;
>+	} else if ((sk->sk_shutdown & SEND_SHUTDOWN) ||
>+		   (vsk->peer_shutdown & RCV_SHUTDOWN)) {
>+		err = -EPIPE;
>+	}
>+
>+out_err:
>+	remove_wait_queue(sk_sleep(sk), &wait);
>+	return err;
>+}
>+EXPORT_SYMBOL_GPL(vsock_wait_space);
>+
> static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 				     size_t len)
> {
>@@ -1699,10 +1758,8 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 	struct vsock_sock *vsk;
> 	const struct vsock_transport *transport;
> 	ssize_t total_written;
>-	long timeout;
> 	int err;
> 	struct vsock_transport_send_notify_data send_data;
>-	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>
> 	sk = sock->sk;
> 	vsk = vsock_sk(sk);
>@@ -1740,9 +1797,6 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 		goto out;
> 	}
>
>-	/* Wait for room in the produce queue to enqueue our user's data. */
>-	timeout = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>-
> 	err = transport->notify_send_init(vsk, &send_data);
> 	if (err < 0)
> 		goto out;
>@@ -1750,39 +1804,8 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 	while (total_written < len) {
> 		ssize_t written;
>
>-		add_wait_queue(sk_sleep(sk), &wait);
>-		while (vsock_stream_has_space(vsk) == 0 &&
>-		       sk->sk_err == 0 &&
>-		       !(sk->sk_shutdown & SEND_SHUTDOWN) &&
>-		       !(vsk->peer_shutdown & RCV_SHUTDOWN)) {
>-
>-			/* Don't wait for non-blocking sockets. */
>-			if (timeout == 0) {
>-				err = -EAGAIN;
>-				remove_wait_queue(sk_sleep(sk), &wait);
>-				goto out_err;
>-			}
>-
>-			err = transport->notify_send_pre_block(vsk, &send_data);
>-			if (err < 0) {
>-				remove_wait_queue(sk_sleep(sk), &wait);
>-				goto out_err;
>-			}
>-
>-			release_sock(sk);
>-			timeout = wait_woken(&wait, TASK_INTERRUPTIBLE, timeout);
>-			lock_sock(sk);
>-			if (signal_pending(current)) {
>-				err = sock_intr_errno(timeout);
>-				remove_wait_queue(sk_sleep(sk), &wait);
>-				goto out_err;
>-			} else if (timeout == 0) {
>-				err = -EAGAIN;
>-				remove_wait_queue(sk_sleep(sk), &wait);
>-				goto out_err;
>-			}
>-		}
>-		remove_wait_queue(sk_sleep(sk), &wait);
>+		if (vsock_wait_space(sk, 1, msg->msg_flags, &send_data))
>+			goto out_err;
>
> 		/* These checks occur both as part of and after the loop
> 		 * conditional since we need to check before and after
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
