Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18550C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 11:53:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F31F64DA5
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 11:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F31F64DA5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09E36839CD;
	Mon, 22 Feb 2021 11:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GXYByhGu_QnU; Mon, 22 Feb 2021 11:53:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 545A8839A4;
	Mon, 22 Feb 2021 11:53:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C94A2C000A;
	Mon, 22 Feb 2021 11:53:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CA51C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:53:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8B24685B3B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:53:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ETJdLyYHWVC2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:53:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8BAAE857FB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613994819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uwBWTvI52wqLrpQP0Tt3FcCpkL+x02v8vMn3ChAyK8U=;
 b=LNzyHk06RiKCAYINq4QZC6lrPg5PEY6YZpEImEmS0/D8XG3uY5fW7Q/rwksbVthnqfN9Py
 Kqd08wUlhnBn0MDjHfY+HJnmEUZkNXGn0zbzgQYwlV/2Z/M7fBpN/qhtKFjBH2DbCMQ+QM
 cgSxxIyQ5o1XFWiGEeD8gKJS1F/VXoI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-xRWRwc6eMpayXnhXMkN3Lw-1; Mon, 22 Feb 2021 06:53:37 -0500
X-MC-Unique: xRWRwc6eMpayXnhXMkN3Lw-1
Received: by mail-wr1-f70.google.com with SMTP id t14so2680867wrr.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uwBWTvI52wqLrpQP0Tt3FcCpkL+x02v8vMn3ChAyK8U=;
 b=mOxXhq7gCsJYLOpY9LkS+bOjHkQfE0YwOMEj+0sZrb3jRWvdCth4FgchI7H6dH5h/x
 iZE07Gx0f8/Zaw1MWQm57rsujYXpUxz1GGZN60aVfHLahg2N2N5nbyBTiQzL1t45kbLD
 NEUJdl2TS5Kxrw/kvO+pz0XX2Plir9u+lMhr8SxOHzvGADKUKr6IFfDjSCyIviCV7vAh
 h6h0saf4V7vY8zLf2vBRmoh/8/bTQ7XfqEe+zqsYAnqUZl1Ucld0UEWF1sa3i/sn+MdG
 349IcCl/Bf1HgpWQ2mqbMBvLxbqGdPtKr5GNj5mELl4PknnixL/jMVFKD4TIGuMUh0xx
 FwYA==
X-Gm-Message-State: AOAM531sLouTXWBHMAO5u5CZNMFFEnTFdXh09WA+VoVND7uDQ3U+BSTL
 f1QZEywJHPRjHC5mkc1HFA6b0VMoWHv86zlgVhm1R3arbHogBj2QqPv+bkvzLdHN6T5RDbFjS5u
 FiTlUDcVsMbgkyBxUhTooZ7F3dYstONcuIZLt4jGvgQ==
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr21259243wra.42.1613994816250; 
 Mon, 22 Feb 2021 03:53:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwF3z2re71U2qX2sBvyIA4CC2xz2iu5FyqhwdzeqbDwD5LQo1ZoMCLS2hsoaBHr951kbzi9wg==
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr21259216wra.42.1613994816075; 
 Mon, 22 Feb 2021 03:53:36 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id v15sm28906877wra.61.2021.02.22.03.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 03:53:35 -0800 (PST)
Date: Mon, 22 Feb 2021 12:53:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 04/19] af_vsock: implement SEQPACKET receive loop
Message-ID: <20210222115332.bmfwqzbytimk65ta@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053719.1067237-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218053719.1067237-1-arseny.krasnov@kaspersky.com>
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

On Thu, Feb 18, 2021 at 08:37:15AM +0300, Arseny Krasnov wrote:
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
> include/net/af_vsock.h   |  5 +++
> net/vmw_vsock/af_vsock.c | 97 +++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 101 insertions(+), 1 deletion(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index b1c717286993..01563338cc03 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -135,6 +135,11 @@ struct vsock_transport {
> 	bool (*stream_is_active)(struct vsock_sock *);
> 	bool (*stream_allow)(u32 cid, u32 port);
>
>+	/* SEQ_PACKET. */
>+	size_t (*seqpacket_seq_get_len)(struct vsock_sock *vsk);
>+	int (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
>+				     int flags, bool *msg_ready);

I think this should be:
	int (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
				 int flags, bool *msg_ready);

To avoid:
$ ./scripts/checkpatch.pl --strict -g HEAD
CHECK: Alignment should match open parenthesis
#35: FILE: include/net/af_vsock.h:141:
+	int (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
+				     int flags, bool *msg_ready);

>+
> 	/* Notification. */
> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
> 	int (*notify_poll_out)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index d277dc1cdbdf..b754927a556a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1972,6 +1972,98 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
> 	return err;
> }
>
>+static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
>+				     size_t len, int flags)
>+{
>+	const struct vsock_transport *transport;
>+	const struct iovec *orig_iov;
>+	unsigned long orig_nr_segs;
>+	bool msg_ready;
>+	struct vsock_sock *vsk;
>+	size_t record_len;
>+	long timeout;
>+	int err = 0;
>+	DEFINE_WAIT(wait);
>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	timeout = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
>+	orig_nr_segs = msg->msg_iter.nr_segs;
>+	orig_iov = msg->msg_iter.iov;
>+	msg_ready = false;
>+	record_len = 0;
>+
>+	while (1) {
>+		err = vsock_wait_data(sk, &wait, timeout, NULL, 0);
>+
>+		if (err <= 0) {
>+			/* In case of any loop break(timeout, signal
>+			 * interrupt or shutdown), we report user that
>+			 * nothing was copied.
>+			 */
>+			err = 0;
>+			break;
>+		}
>+
>+		if (record_len == 0) {
>+			record_len =
>+				transport->seqpacket_seq_get_len(vsk);
>+
>+			if (record_len == 0)
>+				continue;
>+		}
>+
>+		err = transport->seqpacket_dequeue(vsk, msg,
>+					flags, &msg_ready);
>+

Sorry, I expressed myself wrong.

Here it's fine to avoid the blank line as in the previous version, by 
single line I meant the seqpacket_dequeue() call, something like this:

		err = transport->seqpacket_dequeue(vsk, msg, flags, &msg_ready);
		if (err < 0) {


>+		if (err < 0) {
>+			if (err == -EAGAIN) {
>+				iov_iter_init(&msg->msg_iter, READ,
>+					      orig_iov, orig_nr_segs,
>+					      len);
>+				/* Clear 'MSG_EOR' here, because dequeue
>+				 * callback above set it again if it was
>+				 * set by sender. This 'MSG_EOR' is from
>+				 * dropped record.
>+				 */
>+				msg->msg_flags &= ~MSG_EOR;
>+				record_len = 0;
>+				continue;
>+			}
>+
>+			err = -ENOMEM;
>+			break;
>+		}
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
>+	if (msg_ready) {
>+		/* User sets MSG_TRUNC, so return real length of
>+		 * packet.
>+		 */
>+		if (flags & MSG_TRUNC)
>+			err = record_len;
>+		else
>+			err = len - msg->msg_iter.count;
>+
>+		/* Always set MSG_TRUNC if real length of packet is
>+		 * bigger than user's buffer.
>+		 */
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
>@@ -2027,7 +2119,10 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
