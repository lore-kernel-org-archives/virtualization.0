Return-Path: <SRS0=IaGE=IX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E71AC433C1
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 09:06:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE95261A0E
	for <virtualization@archiver.kernel.org>; Thu, 25 Mar 2021 09:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE95261A0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82F436062A;
	Thu, 25 Mar 2021 09:06:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ix84GfphneC6; Thu, 25 Mar 2021 09:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CA0D60755;
	Thu, 25 Mar 2021 09:06:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3721C000D;
	Thu, 25 Mar 2021 09:06:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FFFEC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2DA394018B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y1hAoqesJx98
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:06:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 030DB40187
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 09:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1616663201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTJfubzS7O7K/IVv79ceaGJUkFP1xXgqWQXScYQW8Qg=;
 b=hOoVl6wr6qLS4KPiFvlpAmOgrwy+Zg9zNhfgBJ/FUpkvFdbSxCvriPMM7tOTCC3bEQvGXL
 iJ2xSpmhg+wk+SrjwD5+t0tKXDkqO23DIRwUJDGmPIee36nDr3UCkZDcn6rvZJ8OlHHc3s
 YTXnRBtJxCdXxSLenc+F16793ARKtwU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-BYrIJSP-MvKVSVnv1ERD3Q-1; Thu, 25 Mar 2021 05:06:37 -0400
X-MC-Unique: BYrIJSP-MvKVSVnv1ERD3Q-1
Received: by mail-wm1-f71.google.com with SMTP id z26so1411967wml.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 02:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yTJfubzS7O7K/IVv79ceaGJUkFP1xXgqWQXScYQW8Qg=;
 b=a9gxsKJYLHcS9o4geM1+VRSGjNRkbokbbjQpS0MFjfPAF7a+y2bXS1RRIRvQH3v1fo
 WNf4RARsbH+39DIu0fcwRMipSHZIwl9IEWdSX7irHfhY7vVfoRifFudBqHFPCPGQo43B
 FgCB6Np7KQY9b0zIcI2+uO82tPBUHZ7LUrd2F/+FVM/vEDJK2qMIpDiI/QLGuVmagLTz
 ir6yY5/2Z/1n/BrvvKV52JS5UwmsHa9UZMDSy21lMt7v9bXYr+7v7rBUSPzq4R+NrpgB
 qEA68c6zLwgMK+JuBDwYMiaGc4RMQn4rHvZfwk3VrHuKhUkb1u0SmSUtUw8Iartiuorz
 H2ug==
X-Gm-Message-State: AOAM532aIfQ8KL6cMawn54yDyWoDgq6A234z6HDTNOM7rSPd59CM81S0
 U6SGT0XLtRmFcRyY4VAN2392FOMx7/scsDRADdHgeOIbh75BqrzhBca2jzwfgAgoadSz6s/6Dve
 I6GkRcRv5cQai5pHVdyxDVpqKS8X1d8w20bROHDpDkQ==
X-Received: by 2002:a05:600c:4f8e:: with SMTP id
 n14mr6987776wmq.34.1616663195629; 
 Thu, 25 Mar 2021 02:06:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxor6DwX21nVsRBJYaahvDSiYmgc/i+EkrFRyebbt+hCSZ3Fo4Ng/+V2eKVoZdbnmON15WOqQ==
X-Received: by 2002:a05:600c:4f8e:: with SMTP id
 n14mr6987710wmq.34.1616663194922; 
 Thu, 25 Mar 2021 02:06:34 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id 81sm5626680wmc.11.2021.03.25.02.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 02:06:34 -0700 (PDT)
Date: Thu, 25 Mar 2021 10:06:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v7 03/22] af_vsock: separate receive data loop
Message-ID: <20210325090631.4o5lc2kgyb4uzslh@steredhat>
References: <20210323130716.2459195-1-arseny.krasnov@kaspersky.com>
 <20210323130939.2459901-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210323130939.2459901-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Norbert Slusarek <nslusarek@gmx.net>,
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

On Tue, Mar 23, 2021 at 04:09:36PM +0300, Arseny Krasnov wrote:
>Move STREAM specific data receive logic to '__vsock_stream_recvmsg()'
>dedicated function, while checks, that will be same for both STREAM
>and SEQPACKET sockets, stays in 'vsock_connectible_recvmsg()' shared
>functions.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 116 ++++++++++++++++++++++-----------------
> 1 file changed, 67 insertions(+), 49 deletions(-)

I had already reviewed this in v5 and in v6 you reported the R-b tag.

Usually the tag gets removed if you make changes to the patch or the 
reviewer is no longer happy. But this doesn't seem to be the case.

So please keep the tags between versions :-)


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 421c0303b26f..0bc661e54262 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1895,65 +1895,22 @@ static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
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
>@@ -2012,6 +1969,67 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
