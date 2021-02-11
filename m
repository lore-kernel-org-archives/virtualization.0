Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E115EC433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 11:38:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E47164DB1
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 11:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E47164DB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28E066F5BA
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 11:38:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UEOi9tj2FcDX for <virtualization@archiver.kernel.org>;
	Thu, 11 Feb 2021 11:38:07 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 260E16F5E5; Thu, 11 Feb 2021 11:38:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2DB1C6F477;
	Thu, 11 Feb 2021 11:38:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9D7AC0174;
	Thu, 11 Feb 2021 11:38:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E881C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 11:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 402B48732C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 11:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0HZB7UkN8ydA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 11:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5842B87313
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613043481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jBJpn4LbluSU72a0eU+ANLaBQa/dsUCCbpTQvGN+K1w=;
 b=KEAjFLeqkPki6Ru7m7UHjEQDlm1f3Ay3nJ2nKgOhNSb/tMkBg0BIvCzYWFU1BzFSBHiSou
 cw0vnq4b03HVmURfOxs+vikNcYm4jMkBZ/sheZtQQrywmZCELjpCYfqZtVJsK44qwu2h/w
 rNePU4+370piFgDLgcqAX9N0om3xlAE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-HqpgJ1qsPC6O2-iD16ORLA-1; Thu, 11 Feb 2021 06:37:57 -0500
X-MC-Unique: HqpgJ1qsPC6O2-iD16ORLA-1
Received: by mail-ed1-f70.google.com with SMTP id bd22so4505508edb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 03:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jBJpn4LbluSU72a0eU+ANLaBQa/dsUCCbpTQvGN+K1w=;
 b=QutMS/6gLLQ7xy1xxf6a3di9IdjPJoEDyGT/E362Phm5aZbR0GbXNT2T7S434p09xN
 GwJsAqoLW+eEtTuXTO0d7Y8c+qLKNelITf3B/gMwoe/SqLXJaHFNfKjYuyW89wGU+Uy6
 1zAdA44LvAOQ7LEsdVrc3oV9+I+82LzcRwmS1PyQxxOAIIvhCqeOZpgoJgGDLBfZNXtj
 o18rJI40JZ0encWQAbMPcso4SYSzqMIdxCgmWxrQYdSmaCyaCAnYwgtC2Jn0JSOPmunR
 GAposlmh9/r/Bf4DO4UatLgCA0RjioIPsmDNTucK3cVxUEXMjqaJMeOxf81+Z/El53wX
 l1MQ==
X-Gm-Message-State: AOAM530T1fK4JpDPmNwyUARjMtyUfkN1bhNZDRwxTJuDtSKNhlscv4JF
 KFUi/KqZRKg/4BqqQ2+f7f7cuZsLPgeKjJGy16NsxFu6/HeHrSL2e3CqkAs0jguCBYGJsohMgbp
 FRwvgTeYkuylwOXlj8mFguFrDefd44l0Jd2IRPKigmA==
X-Received: by 2002:a17:906:37c1:: with SMTP id
 o1mr7920794ejc.488.1613043476412; 
 Thu, 11 Feb 2021 03:37:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJnUUecMhZKbbTG7xRbeEA9y+GaY0YJsrOqETOe26tn0T3XY70P75PsWnGdEkMaW63FaTK2w==
X-Received: by 2002:a17:906:37c1:: with SMTP id
 o1mr7920773ejc.488.1613043476196; 
 Thu, 11 Feb 2021 03:37:56 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id m7sm3982087ejk.52.2021.02.11.03.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 03:37:55 -0800 (PST)
Date: Thu, 11 Feb 2021 12:37:53 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 03/17] af_vsock: separate receive data loop
Message-ID: <20210211113753.o4zco3yromuxpvo2@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151508.804615-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151508.804615-1-arseny.krasnov@kaspersky.com>
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

On Sun, Feb 07, 2021 at 06:15:05PM +0300, Arseny Krasnov wrote:
>This moves STREAM specific data receive logic to dedicated function:
>'__vsock_stream_recvmsg()', while checks that will be same for both
>types of socket are in shared function: 'vsock_connectible_recvmsg()'.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 117 +++++++++++++++++++++++----------------
> 1 file changed, 68 insertions(+), 49 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 38927695786f..66c8a932f49b 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1898,65 +1898,22 @@ static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
> 	return err;
> }
>
>-static int
>-vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>-			  int flags)
>+static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>+				  size_t len, int flags)
> {
>-	struct sock *sk;
>-	struct vsock_sock *vsk;
>+	struct vsock_transport_recv_notify_data recv_data;
> 	const struct vsock_transport *transport;
>-	int err;
>-	size_t target;
>+	struct vsock_sock *vsk;
> 	ssize_t copied;
>+	size_t target;
> 	long timeout;
>-	struct vsock_transport_recv_notify_data recv_data;
>+	int err;
>
> 	DEFINE_WAIT(wait);
>
>-	sk = sock->sk;
> 	vsk = vsock_sk(sk);
>-	err = 0;
>-
>-	lock_sock(sk);
>-
> 	transport = vsk->transport;
>
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
>-
>-		goto out;
>-	}
>-
>-	if (flags & MSG_OOB) {
>-		err = -EOPNOTSUPP;
>-		goto out;
>-	}
>-
>-	/* We don't check peer_shutdown flag here since peer may actually shut
>-	 * down, but there can be data in the queue that a local socket can
>-	 * receive.
>-	 */
>-	if (sk->sk_shutdown & RCV_SHUTDOWN) {
>-		err = 0;
>-		goto out;
>-	}
>-
>-	/* It is valid on Linux to pass in a zero-length receive buffer.  This
>-	 * is not an error.  We may as well bail out now.
>-	 */
>-	if (!len) {
>-		err = 0;
>-		goto out;
>-	}
>-
> 	/* We must not copy less than target bytes into the user's buffer
> 	 * before returning successfully, so we wait for the consume queue to
> 	 * have that much data to consume before dequeueing.  Note that this

At the end of __vsock_stream_recvmsg() you are calling release_sock(sk) 
and it's wrong since we are releasing it in vsock_connectible_recvmsg().

Please fix it.

>@@ -2020,6 +1977,68 @@ vsock_connectible_recvmsg(struct socket *sock, 
>struct msghdr *msg, size_t len,
> 	return err;
> }
>
>+static int
>+vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>+			  int flags)
>+{
>+	struct sock *sk;
>+	struct vsock_sock *vsk;
>+	const struct vsock_transport *transport;
>+	int err;
>+
>+	DEFINE_WAIT(wait);
>+
>+	sk = sock->sk;
>+	vsk = vsock_sk(sk);
>+	err = 0;
>+
>+	lock_sock(sk);
>+
>+	transport = vsk->transport;
>+
>+	if (!transport || sk->sk_state != TCP_ESTABLISHED) {
>+		/* Recvmsg is supposed to return 0 if a peer performs an
>+		 * orderly shutdown. Differentiate between that case and when a
>+		 * peer has not connected or a local shutdown occurred with the
>+		 * SOCK_DONE flag.
>+		 */
>+		if (sock_flag(sk, SOCK_DONE))
>+			err = 0;
>+		else
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
>+	if (sk->sk_shutdown & RCV_SHUTDOWN) {
>+		err = 0;
>+		goto out;
>+	}
>+
>+	/* It is valid on Linux to pass in a zero-length receive buffer.  This
>+	 * is not an error.  We may as well bail out now.
>+	 */
>+	if (!len) {
>+		err = 0;
>+		goto out;
>+	}
>+
>+	err = __vsock_stream_recvmsg(sk, msg, len, flags);
>+
>+out:
>+	release_sock(sk);
>+	return err;
>+}
>+

The rest of the patch LGTM.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
