Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C7AC433DB
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 16:33:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992AD64DEE
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 16:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992AD64DEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1E23E86949;
	Thu, 28 Jan 2021 16:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LhBit-KOeRpw; Thu, 28 Jan 2021 16:33:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4FBED868C7;
	Thu, 28 Jan 2021 16:33:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 337BEC1825;
	Thu, 28 Jan 2021 16:33:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49816C0FA8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 45341868F3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EFpgPxAKiubs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:33:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2537F868B6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611851586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FdUYV04vZro17uutaKWrqsCYU3iMGEHyKXk4ksXfiJ4=;
 b=e/iRoAudk4azzwbw7HbMuk1wyrXbil8BjdAJ/2cmPsmzaz4bxm7DVQo+djQ1kOcHLVDyyB
 M40BjDZSkf2SA/hTS0O82BWhT5QMJkf0KLQG/kUCpxewLQRX3A+7cbZ6vjvIt6f60jc8dl
 sDn9dpWAVyjT+MR+2u4cZwvdkR8Xe5o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-MXdY79RgPTCYCGoZTDplDQ-1; Thu, 28 Jan 2021 11:33:04 -0500
X-MC-Unique: MXdY79RgPTCYCGoZTDplDQ-1
Received: by mail-wm1-f70.google.com with SMTP id b62so2640130wmc.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 08:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FdUYV04vZro17uutaKWrqsCYU3iMGEHyKXk4ksXfiJ4=;
 b=R+bLi9p77UItQJM61zz4Di+q1iHpYO5bpYkZU8nFiu+JCwq8AFQz+wyBDo0L4teKlk
 ajDeibDh4pGlUCLciZw32ZgM4fzLVEk+XfLz1n8gGj5qAGwRl1JhBhBiA4fQ9VhUyhAe
 x0tN5BtAbfVGi/crP1rbRl+D9PQBbTSdH/xdUGQk0yWbmD8Dc/q34F3hGHqVtcw32ejb
 tptfDN3aWs1xYiiVEroUxovI8XZKETdgDLR/52v4sStMju9fHhgXxkdGzHp8lJK5OOSa
 4sId3TBw1VCm6Oukp49bT1jGBL/pOwZzy/2tkhYll8qAFwyAmQf6IUwmOZfwDQFQh3oa
 7sLA==
X-Gm-Message-State: AOAM532zXhH2SCIXl6HdvUspeJD3S1SPr0X8GxkcwxEnMb6tfPv4hI89
 OD8onUCMb88gGgP0c5spqDDUKlcfVv3espYyt0e7I2iWrGCW8a2wwSJT+epHH1PHB38jV8yWWmh
 QPgm+cA7zSAwIYPkLrm3pZ7Q49nmlQjeOO+AKNTyWvg==
X-Received: by 2002:adf:f849:: with SMTP id d9mr17491595wrq.349.1611851582943; 
 Thu, 28 Jan 2021 08:33:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF+ScPOLAhB6bXIWSvwvFKyZ7WpX/FQO/3pX5dZXvg16LtuNb18msqzMvprBKdi2kv2PiLwg==
X-Received: by 2002:adf:f849:: with SMTP id d9mr17491573wrq.349.1611851582752; 
 Thu, 28 Jan 2021 08:33:02 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id w25sm6657568wmc.42.2021.01.28.08.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jan 2021 08:33:02 -0800 (PST)
Date: Thu, 28 Jan 2021 17:32:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 02/13] af_vsock: prepare
 'vsock_connectible_recvmsg()'
Message-ID: <20210128163259.3lhcy43tm4t6ejys@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111200.598103-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210125111200.598103-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
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

On Mon, Jan 25, 2021 at 02:11:57PM +0300, Arseny Krasnov wrote:
>This prepares 'vsock_connectible_recvmg()' to call SEQPACKET receive
>loop:
>1) Some shared check left in this function, then socket type
>   specific receive loop is called.
>2) Stream receive loop is moved to separate function.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 242 ++++++++++++++++++++++-----------------
> 1 file changed, 138 insertions(+), 104 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index c9ce57db9554..524df8fc84cd 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1858,65 +1858,69 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> 	return vsock_connectible_sendmsg(sock, msg, len);
> }
>
>-
>-static int
>-vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>-			  int flags)
>+static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
>+			   long timeout,
>+			   struct vsock_transport_recv_notify_data *recv_data,
>+			   size_t target)
> {
>-	struct sock *sk;
>+	int err = 0;
> 	struct vsock_sock *vsk;
> 	const struct vsock_transport *transport;
>-	int err;
>-	size_t target;
>-	ssize_t copied;
>-	long timeout;
>-	struct vsock_transport_recv_notify_data recv_data;
>-
>-	DEFINE_WAIT(wait);
>
>-	sk = sock->sk;
> 	vsk = vsock_sk(sk);
> 	transport = vsk->transport;
>-	err = 0;
>-
>-	lock_sock(sk);
>-
>-	if (!transport || sk->sk_state != TCP_ESTABLISHED) {
>-		/* Recvmsg is supposed to return 0 if a peer performs an
>-		 * orderly shutdown. Differentiate between that case and when a
>-		 * peer has not connected or a local shutdown occured with the
>-		 * SOCK_DONE flag.
>-		 */
>-		if (sock_flag(sk, SOCK_DONE))
>-			err = 0;
>-		else
>-			err = -ENOTCONN;
>
>+	if (sk->sk_err != 0 ||
>+	    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
>+		err = -1;
> 		goto out;
> 	}
>-
>-	if (flags & MSG_OOB) {
>-		err = -EOPNOTSUPP;
>+	/* Don't wait for non-blocking sockets. */
>+	if (timeout == 0) {
>+		err = -EAGAIN;
> 		goto out;
> 	}
>
>-	/* We don't check peer_shutdown flag here since peer may actually shut
>-	 * down, but there can be data in the queue that a local socket can
>-	 * receive.
>-	 */
>-	if (sk->sk_shutdown & RCV_SHUTDOWN) {
>-		err = 0;
>-		goto out;
>+	if (recv_data) {
>+		err = transport->notify_recv_pre_block(vsk, target, recv_data);
>+		if (err < 0)
>+			goto out;
> 	}
>
>-	/* It is valid on Linux to pass in a zero-length receive buffer.  This
>-	 * is not an error.  We may as well bail out now.
>-	 */
>-	if (!len) {
>-		err = 0;
>+	release_sock(sk);
>+	timeout = schedule_timeout(timeout);
>+	lock_sock(sk);
>+
>+	if (signal_pending(current)) {
>+		err = sock_intr_errno(timeout);
>+		goto out;
>+	} else if (timeout == 0) {
>+		err = -EAGAIN;
> 		goto out;
> 	}
>
>+out:
>+	finish_wait(sk_sleep(sk), wait);
>+	return err;
>+}
>+
>+static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>+				  size_t len, int flags)
>+{
>+	struct vsock_transport_recv_notify_data recv_data;
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	ssize_t copied;
>+	size_t target;
>+	long timeout;
>+	int err;
>+
>+	DEFINE_WAIT(wait);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
> 	/* We must not copy less than target bytes into the user's buffer
> 	 * before returning successfully, so we wait for the consume queue to
> 	 * have that much data to consume before dequeueing.  Note that this
>@@ -1937,85 +1941,53 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>
>
> 	while (1) {
>+		ssize_t read;
> 		s64 ready;
>
> 		prepare_to_wait(sk_sleep(sk), &wait, 
> 		TASK_INTERRUPTIBLE);
> 		ready = vsock_stream_has_data(vsk);

Maybe we can move also these lines in vsock_wait_data() that can return 
'ready' or an error.

>
> 		if (ready == 0) {
>-			if (sk->sk_err != 0 ||
>-			    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>-			    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
>-				finish_wait(sk_sleep(sk), &wait);
>-				break;
>-			}
>-			/* Don't wait for non-blocking sockets. */
>-			if (timeout == 0) {
>-				err = -EAGAIN;
>-				finish_wait(sk_sleep(sk), &wait);
>-				break;
>-			}
>-
>-			err = transport->notify_recv_pre_block(
>-					vsk, target, &recv_data);
>-			if (err < 0) {
>-				finish_wait(sk_sleep(sk), &wait);
>-				break;
>-			}
>-			release_sock(sk);
>-			timeout = schedule_timeout(timeout);
>-			lock_sock(sk);
>-
>-			if (signal_pending(current)) {
>-				err = sock_intr_errno(timeout);
>-				finish_wait(sk_sleep(sk), &wait);
>-				break;
>-			} else if (timeout == 0) {
>-				err = -EAGAIN;
>-				finish_wait(sk_sleep(sk), &wait);
>+			if (vsock_wait_data(sk, &wait, timeout, &recv_data, target))
> 				break;
>-			}
>-		} else {
>-			ssize_t read;
>+			continue;
>+		}
>
>-			finish_wait(sk_sleep(sk), &wait);
>+		finish_wait(sk_sleep(sk), &wait);

And also this one can be moved in vsock_wait_data().
>
>-			if (ready < 0) {
>-				/* Invalid queue pair content. XXX This should
>-				* be changed to a connection reset in a later
>-				* change.
>-				*/
>+		if (ready < 0) {
>+			/* Invalid queue pair content. XXX This should
>+			 * be changed to a connection reset in a later
>+			 * change.
>+			 */
>
>-				err = -ENOMEM;
>-				goto out;
>-			}
>+			err = -ENOMEM;
>+			goto out;
>+		}
>
>-			err = transport->notify_recv_pre_dequeue(
>-					vsk, target, &recv_data);
>-			if (err < 0)
>-				break;
>+		err = transport->notify_recv_pre_dequeue(vsk,
>+					target, &recv_data);
>+		if (err < 0)
>+			break;
>+		read = transport->stream_dequeue(vsk, msg, len - copied, flags);
>
>-			read = transport->stream_dequeue(
>-					vsk, msg,
>-					len - copied, flags);
>-			if (read < 0) {
>-				err = -ENOMEM;
>-				break;
>-			}
>+		if (read < 0) {
>+			err = -ENOMEM;
>+			break;
>+		}
>
>-			copied += read;
>+		copied += read;
>
>-			err = transport->notify_recv_post_dequeue(
>-					vsk, target, read,
>+		err = transport->notify_recv_post_dequeue(vsk,
>+					target, read,
> 					!(flags & MSG_PEEK), &recv_data);
>-			if (err < 0)
>-				goto out;
>+		if (err < 0)
>+			goto out;
>
>-			if (read >= target || flags & MSG_PEEK)
>-				break;
>+		if (read >= target || flags & MSG_PEEK)
>+			break;
>
>-			target -= read;
>-		}
>+		target -= read;
> 	}
>
> 	if (sk->sk_err)
>@@ -2031,6 +2003,68 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	return err;
> }
>
>+static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>+				     size_t len, int flags)
>+{
>+	return -1;
>+}
>+

You can add this function later, when you implement it...

>+static int
>+vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+			  int flags)
>+{
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	struct sock *sk;
>+	int err = 0;
>+
>+	sk = sock->sk;
>+
>+	lock_sock(sk);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	if (!transport || sk->sk_state != TCP_ESTABLISHED) {
>+		/* Recvmsg is supposed to return 0 if a peer performs an
>+		 * orderly shutdown. Differentiate between that case and when a
>+		 * peer has not connected or a local shutdown occurred 
>with the
>+		 * SOCK_DONE flag.
>+		 */
>+		if (!sock_flag(sk, SOCK_DONE))
>+			err = -ENOTCONN;
>+
>+		goto out;
>+	}
>+
>+	if (flags & MSG_OOB) {
>+		err = -EOPNOTSUPP;
>+		goto out;
>+	}
>+
>+	/* We don't check peer_shutdown flag here since peer may actually shut
>+	 * down, but there can be data in the queue that a local socket can
>+	 * receive.
>+	 */
>+	if (sk->sk_shutdown & RCV_SHUTDOWN)
>+		goto out;
>+
>+	/* It is valid on Linux to pass in a zero-length receive buffer.  This
>+	 * is not an error.  We may as well bail out now.
>+	 */
>+	if (!len)
>+		goto out;
>+
>+	if (sk->sk_type == SOCK_STREAM)
>+		err = __vsock_stream_recvmsg(sk, msg, len, flags);
>+	else
>+		err = __vsock_seqpacket_recvmsg(sk, msg, len, flags);

...and also this 'else' branch.

>+
>+out:
>+	release_sock(sk);
>+	return err;
>+}
>+
> static int
> vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 		     int flags)
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
