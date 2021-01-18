Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B70C433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:04:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E92C22228
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 15:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E92C22228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16B5686686;
	Mon, 18 Jan 2021 15:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HZx3NNzTnsl9; Mon, 18 Jan 2021 15:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D7B8686676;
	Mon, 18 Jan 2021 15:04:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9825AC088B;
	Mon, 18 Jan 2021 15:04:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50257C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3DB378667A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YUwawa3iCy59
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:04:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 180EA86676
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610982280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SLOedUuUAetYBtp0/6k8K8pT2ynnPsFK+R3zYe7flUQ=;
 b=Bt/82uFNI1bhSVeHx5PPuXiFgpd2IzHga3zFSlR5p6rtUc78sVEdX05/cIiIMQeJlLmkPs
 ehYzVX33MeRcPk62uaGhzEJJArjDx47XWsb+jc2IHb8/BsfwvAjQZLluGwH0dNbGYepa+E
 FIA77+G/NeMdOw8gd6vlotrlQOhE2kk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-Pw5AKwjPNn-PeflqlDMw6w-1; Mon, 18 Jan 2021 10:04:39 -0500
X-MC-Unique: Pw5AKwjPNn-PeflqlDMw6w-1
Received: by mail-wm1-f69.google.com with SMTP id d2so862502wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 07:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SLOedUuUAetYBtp0/6k8K8pT2ynnPsFK+R3zYe7flUQ=;
 b=i/j27T2sY49bMXBa+dcEc0s5QGiA5Dg/pBzgm17MiuI75O10kaM4TRol9vaz9XKb48
 hm0VbFeEa2/0c0qSE1mZgiWD93+ya3i7MwxewpUluA6VdhN48VJfIH3qdq1O2/gLUn7i
 C9XStPpRlY8dS3JD2bv1TuwAPT4pMyY7Q59lij//7L4v2kOYViFT8Fzvm1cqmTYK+kMQ
 R/K9LihCIOl5U49vIaVVJTMVrBu/lK9iox+gRZmNkgDagETWwOc4sQjYHH3CVUsMErzg
 F51WjdlGAfFBfj90ysOS+HRsPniL8Wc4gKvuuNnspUGGxaR6lBG2h9dOt6DpPfG8dfh0
 lZtw==
X-Gm-Message-State: AOAM530WgYrMO9yoBOIAybOlsynD53W2Fk+G8rw0ITS5R0y3YdC4V+e/
 9SHO9vpwlkZIjWDF6FrsVvQKCRhY3PZMypcSWitKDK3J3rVNlPk5Qund+KhTBCnfJaRD7ty5lJp
 yWEVLrp3hW0yJD/LOAm4U+1fZR0Lo61esYxI1fRODug==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr21765373wmc.64.1610982277938; 
 Mon, 18 Jan 2021 07:04:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAocm4YOtLjCr5k37DjhAHDbUBhVkU09C7Q2qMpBxBR3X3zOVzn936ICMee7QrKjcDbvR50g==
X-Received: by 2002:a1c:68c5:: with SMTP id d188mr21765236wmc.64.1610982276528; 
 Mon, 18 Jan 2021 07:04:36 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id u205sm26786291wme.42.2021.01.18.07.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 07:04:35 -0800 (PST)
Date: Mon, 18 Jan 2021 16:04:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 02/13] af_vsock: separate rx loops for
 STREAM/SEQPACKET.
Message-ID: <20210118150433.kj4wuoecddyng632@steredhat>
References: <20210115053553.1454517-1-arseny.krasnov@kaspersky.com>
 <20210115054054.1455729-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210115054054.1455729-1-arseny.krasnov@kaspersky.com>
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
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Fri, Jan 15, 2021 at 08:40:50AM +0300, Arseny Krasnov wrote:
>This adds two receive loops: for SOCK_STREAM and SOCK_SEQPACKET. Both are
>look like twins, but SEQPACKET is a little bit different from STREAM:
>1) It doesn't call notify callbacks.
>2) It doesn't care about 'SO_SNDLOWAT' and 'SO_RCVLOWAT' values, because
>   there is no sense for these values in SEQPACKET case.
>3) It waits until whole record is received or error is found during
>   receiving.
>4) It processes and sets 'MSG_TRUNC' flag.
>
>So to avoid extra conditions for two types of socket inside on loop, two
>independent functions were created.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |   5 +
> net/vmw_vsock/af_vsock.c | 202 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 207 insertions(+)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index b1c717286993..46073842d489 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -135,6 +135,11 @@ struct vsock_transport {
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>
>+	/* SEQ_PACKET. */
>+	size_t (*seqpacket_seq_get_len)(struct vsock_sock *);
>+	ssize_t (*seqpacket_dequeue)(struct vsock_sock *, struct msghdr *,
>+				     size_t len, int flags);
>+
> 	/* Notification. */
> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
> 	int (*notify_poll_out)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index af716f5a93a4..afacbe9f4231 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1870,6 +1870,208 @@ static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
> 	return err;
> }
>
>+static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>+				     size_t len, int flags)
>+{
>+	int err = 0;
>+	size_t record_len;
>+	struct vsock_sock *vsk;
>+	const struct vsock_transport *transport;
>+	long timeout;
>+	ssize_t dequeued_total = 0;
>+	unsigned long orig_nr_segs;
>+	const struct iovec *orig_iov;
>+	DEFINE_WAIT(wait);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>+	msg->msg_flags &= ~MSG_EOR;
>+	orig_nr_segs = msg->msg_iter.nr_segs;
>+	orig_iov = msg->msg_iter.iov;
>+
>+	while (1) {
>+		s64 ready;
>+
>+		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>+		ready = vsock_stream_has_data(vsk);
>+
>+		if (ready == 0) {
>+			if (vsock_wait_data(sk, &wait, timeout, NULL, 0)) {
>+				/* In case of any loop break(timeout, signal
>+				 * interrupt or shutdown), we report user that
>+				 * nothing was copied.
>+				 */
>+				dequeued_total = 0;
>+				break;
>+			}

Maybe here we can do 'continue', remove the next line, and reduce the 
indentation on the next block.

>+		} else {
>+			ssize_t dequeued;
>+
>+			finish_wait(sk_sleep(sk), &wait);
>+
>+			if (ready < 0) {
>+				err = -ENOMEM;
>+				goto out;
>+			}
>+
>+			if (dequeued_total == 0) {
>+				record_len =
>+					transport->seqpacket_seq_get_len(vsk);
>+
>+				if (record_len == 0)
>+					continue;
>+			}
>+
>+			/* 'msg_iter.count' is number of unused bytes in iov.
>+			 * On every copy to iov iterator it is decremented at
>+			 * size of data.
>+			 */
>+			dequeued = transport->seqpacket_dequeue(vsk, msg,
>+						msg->msg_iter.count, flags);
>+
>+			if (dequeued < 0) {
>+				dequeued_total = 0;
>+
>+				if (dequeued == -EAGAIN) {
>+					iov_iter_init(&msg->msg_iter, READ,
>+						      orig_iov, orig_nr_segs,
>+						      len);
>+					msg->msg_flags &= ~MSG_EOR;
>+					continue;
>+				}
>+
>+				err = -ENOMEM;
>+				break;
>+			}
>+
>+			dequeued_total += dequeued;
>+
>+			if (dequeued_total >= record_len)
>+				break;
>+		}
>+	}
>+	if (sk->sk_err)
>+		err = -sk->sk_err;
>+	else if (sk->sk_shutdown & RCV_SHUTDOWN)
>+		err = 0;
>+
>+	if (dequeued_total > 0) {
>+		/* User sets MSG_TRUNC, so return real length of
>+		 * packet.
>+		 */
>+		if (flags & MSG_TRUNC)
>+			err = record_len;
>+		else
>+			err = len - msg->msg_iter.count;
>+
>+		/* Always set MSG_TRUNC if real length of packet is
>+		 * bigger that user buffer.
>+		 */
>+		if (record_len > len)
>+			msg->msg_flags |= MSG_TRUNC;
>+	}
>+out:
>+	return err;
>+}
>+
>+static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>+				  size_t len, int flags)
>+{
>+	int err;
>+	const struct vsock_transport *transport;
>+	struct vsock_sock *vsk;
>+	size_t target;
>+	struct vsock_transport_recv_notify_data recv_data;
>+	long timeout;
>+	ssize_t copied;
>+
>+	DEFINE_WAIT(wait);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	/* We must not copy less than target bytes into the user's buffer
>+	 * before returning successfully, so we wait for the consume queue to
>+	 * have that much data to consume before dequeueing.  Note that this
>+	 * makes it impossible to handle cases where target is greater than the
>+	 * queue size.
>+	 */
>+	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
>+	if (target >= transport->stream_rcvhiwat(vsk)) {
>+		err = -ENOMEM;
>+		goto out;
>+	}
>+	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>+	copied = 0;
>+
>+	err = transport->notify_recv_init(vsk, target, &recv_data);
>+	if (err < 0)
>+		goto out;
>+
>+	while (1) {
>+		s64 ready;
>+
>+		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
>+		ready = vsock_stream_has_data(vsk);
>+
>+		if (ready == 0) {
>+			if (vsock_wait_data(sk, &wait, timeout, 
>&recv_data, target))
>+				break;

The same also here.

>+		} else {
>+			ssize_t read;
>+
>+			finish_wait(sk_sleep(sk), &wait);
>+
>+			if (ready < 0) {
>+				/* Invalid queue pair content. XXX This should
>+				 * be changed to a connection reset in a later
>+				 * change.
>+				 */
>+
>+				err = -ENOMEM;
>+				goto out;
>+			}
>+
>+			err = transport->notify_recv_pre_dequeue(vsk,
>+						target, &recv_data);
>+			if (err < 0)
>+				break;
>+			read = transport->stream_dequeue(vsk, msg, len - copied, flags);
>+
>+			if (read < 0) {
>+				err = -ENOMEM;
>+				break;
>+			}
>+
>+			copied += read;
>+
>+			err = transport->notify_recv_post_dequeue(vsk,
>+						target, read,
>+						!(flags & MSG_PEEK), &recv_data);
>+			if (err < 0)
>+				goto out;
>+
>+			if (read >= target || flags & MSG_PEEK)
>+				break;
>+
>+			target -= read;
>+		}
>+	}
>+
>+	if (sk->sk_err)
>+		err = -sk->sk_err;
>+	else if (sk->sk_shutdown & RCV_SHUTDOWN)
>+		err = 0;
>+	if (copied > 0)
>+		err = copied;
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
