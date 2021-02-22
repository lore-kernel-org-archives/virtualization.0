Return-Path: <SRS0=djY9=HY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2352C433DB
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 11:44:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A4864ED6
	for <virtualization@archiver.kernel.org>; Mon, 22 Feb 2021 11:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A4864ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7459987167;
	Mon, 22 Feb 2021 11:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id odRTlFmOm94b; Mon, 22 Feb 2021 11:44:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66A6087095;
	Mon, 22 Feb 2021 11:44:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 366CAC000A;
	Mon, 22 Feb 2021 11:44:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58C58C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4202E85579
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:44:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S9sSUCfv_6gK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:44:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 69C9885522
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 11:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613994239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jMggRyrmt7rUz3sFUZulBpW7f6YfWViL3qR4aD0gP18=;
 b=Orbl4EtsY1JZOUmXtxtIA3MU2nsI0t+UwdKBj8T0RwI0v8lS2F1IeF2zt22XBuH4wG1pP7
 8Qb/qSS2UI4Si8Qi2ziGllF30tN4EonvzXtL39uzfw8hATKb/o6QaKBxzKz9IiPVCP6Tmt
 9j18fIv+E3nQbP/ubj3AvCfgRG9N5Qw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-mMf_bWLgO3eD_naMGaKG5Q-1; Mon, 22 Feb 2021 06:43:56 -0500
X-MC-Unique: mMf_bWLgO3eD_naMGaKG5Q-1
Received: by mail-wr1-f72.google.com with SMTP id k5so933720wrw.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Feb 2021 03:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jMggRyrmt7rUz3sFUZulBpW7f6YfWViL3qR4aD0gP18=;
 b=n/XX8ExweJ7H+JVPKAuvCDlzlWRK4udmuF7S7FXEacSFtgWamBb79kpG11v7a3H8Bx
 J/m1V6irv5f4zlzaxH/gylNgRhBoEgdg37VqlGTiukmPoEyYMo9xS+IykfjTMD0CXYLz
 4SaV2afHeF/Kt8wZGD9HUNO7AUQO8ntYzuGYu/hDybbHKHTmMSuKVVFH91BKcz2nl/0E
 W3EOHZEsZSQaE7ZRyZ46vdBkkogm0PpG2/g/x7d0Tob+5bAiFrn1mA8oOW9vzQqokH3t
 VEqeCWJ662PcAekOTYIGHwUpUbEJSYBRsJlFv9XXm1b1j4RFmhxPmwZdibx96EVpLbdo
 tqJw==
X-Gm-Message-State: AOAM533U8QYjbvE8vBPrGgDu/RhXBSp+gSUcBZDly2hwZr3S2l4s0xFb
 AaY14ozyK9+gIpknLD9j6I0H1XffU7UEjJ8SThgFZN7Jj5yP9BcJI/PFPRyFBcTLsD0D88MbMLT
 w+Q+sC0yEDX6U7VcC58BV1DOIbAcH+8A8gmsbTh63kw==
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr21223401wra.42.1613994235725; 
 Mon, 22 Feb 2021 03:43:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxh4bkeSBk/Aof8/0ud063mP9B8es8pjQc7OR5fltHgLTpr3ahl7wR4tuzSs4XfoCBOiy7e3A==
X-Received: by 2002:adf:a2c7:: with SMTP id t7mr21223379wra.42.1613994235557; 
 Mon, 22 Feb 2021 03:43:55 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id h17sm20352349wrw.74.2021.02.22.03.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Feb 2021 03:43:55 -0800 (PST)
Date: Mon, 22 Feb 2021 12:43:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 03/19] af_vsock: separate receive data loop
Message-ID: <20210222114352.u5byc3lbndwtorjo@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053653.1067086-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218053653.1067086-1-arseny.krasnov@kaspersky.com>
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

On Thu, Feb 18, 2021 at 08:36:50AM +0300, Arseny Krasnov wrote:
>This moves STREAM specific data receive logic to dedicated function:
>'__vsock_stream_recvmsg()', while checks that will be same for both
>types of socket are in shared function: 'vsock_connectible_recvmsg()'.

I'm not a native speaker, but I would rewrite this message like this:

Move STREAM specific data receive logic to '__vsock_stream_recvmsg()'
dedicated function, while checks, that will be same for both STREAM
and SEQPACKET sockets, stays in 'vsock_connectible_recvmsg()' shared
functions.

Anyway the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 116 ++++++++++++++++++++++-----------------
> 1 file changed, 67 insertions(+), 49 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 6cf7bb977aa1..d277dc1cdbdf 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1894,65 +1894,22 @@ static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
> 	return data;
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
>-		 * peer has not connected or a local shutdown occured 
>with the
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
>@@ -2011,6 +1968,67 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	if (copied > 0)
> 		err = copied;
>
>+out:
>+	return err;
>+}
>+
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
>+		 * orderly shutdown. Differentiate between that case and 
>when a
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
> out:
> 	release_sock(sk);
> 	return err;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
