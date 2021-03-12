Return-Path: <SRS0=06fY=IK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A88C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:10:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF5F64FDC
	for <virtualization@archiver.kernel.org>; Fri, 12 Mar 2021 15:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF5F64FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC223606CA;
	Fri, 12 Mar 2021 15:10:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Te3xXm95RQoG; Fri, 12 Mar 2021 15:10:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7404F605C0;
	Fri, 12 Mar 2021 15:10:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BF72C000B;
	Fri, 12 Mar 2021 15:10:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1439DC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02F9B605E1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:10:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9cEGnRTRDwIr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:10:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49650605C0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615561833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=At+gLYpOVuwtYiPKDJPSOAsFyXGyFQ/Ei1/8xDCko3E=;
 b=En2MHtPiD96hkZOTsX2qKCg85mhFLqzC+/13T9cXG705fR2AkWjEagBdGde9wt9sCACTPM
 ioZWn5sB/aNju4xRjc9stXALmqiTiQiAR8FdO4pomo/Eaqta8Pldsv6rKiVi0PdEFiL+qR
 6/jjMawkdz5OoME2VFIFVByx+vzbZkQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-5dqkBBoSMVCk4TLhEkW2Rw-1; Fri, 12 Mar 2021 10:10:32 -0500
X-MC-Unique: 5dqkBBoSMVCk4TLhEkW2Rw-1
Received: by mail-wr1-f70.google.com with SMTP id z17so11263255wrv.23
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 07:10:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=At+gLYpOVuwtYiPKDJPSOAsFyXGyFQ/Ei1/8xDCko3E=;
 b=XT2gjQiO0/uFgaow8cykGGK43eZDz8Bd4FmoXjyFY874F16pfdJSnWWUe13h2oosvb
 Q/8LXrf40wU7mmjQvmPGfpXl+qjo1N2+JQWFdUDvI7WaKZOblFsYCsJKUn/eLzvBuqML
 nM13b4c3SpAii90yN+bd94SAShdhqztuix5A+hEMXpNdT4glyR9+b84vVi71V75LY1UC
 bHOqV4r2kSrGrc3ZmquK7R4bffPJuqABosXdSlxIqaj9eIR8uAOz/T9vtiRIGfHeHMLs
 X5xqd2GwJgHNkzW9d+KJvSFmW3q7nrDxreqfr0FnxnMo3UGLlg55EaIRqtP6Ip2xR62O
 h7dw==
X-Gm-Message-State: AOAM530sBhv2CTLjvczy8Maz7QBe6UhNi4hR2DNI+jWG5sNIRnYWZ2GX
 W0k0KO/8l30QlfZKcltxqMQ8hntMcSCqz9XdIdVejZdPaMnxrda9NHwR4/iEYb9v0xzStZQzoh+
 22Nh76+bSX+rVydqvq/XHbgcE9NFoeW7TAcvumeioMg==
X-Received: by 2002:adf:90c2:: with SMTP id i60mr14448412wri.75.1615561830790; 
 Fri, 12 Mar 2021 07:10:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBUQ6H37FhlxEuc6bIG9e30/3DvMV1YlOPohF80Djr/3IK1mCCHCFlpAvMtmDgq0mHUGX6jQ==
X-Received: by 2002:adf:90c2:: with SMTP id i60mr14448382wri.75.1615561830569; 
 Fri, 12 Mar 2021 07:10:30 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id t8sm8072008wrr.10.2021.03.12.07.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Mar 2021 07:10:30 -0800 (PST)
Date: Fri, 12 Mar 2021 16:10:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 06/22] af_vsock: implement send logic for SEQPACKET
Message-ID: <20210312151027.kamodty37ftspkmc@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180030.3465161-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307180030.3465161-1-arseny.krasnov@kaspersky.com>
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

On Sun, Mar 07, 2021 at 09:00:26PM +0300, Arseny Krasnov wrote:
>This adds some logic to current stream enqueue function for SEQPACKET
>support:
>1) Use transport's seqpacket enqueue callback.
>2) Return value from enqueue function is whole record length or error
>   for SOCK_SEQPACKET.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  2 ++
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++------
> 2 files changed, 18 insertions(+), 6 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index a8c4039e40cf..aed306292ab3 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -139,6 +139,8 @@ struct vsock_transport {
> 	size_t (*seqpacket_seq_get_len)(struct vsock_sock *vsk);
> 	int (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
> 				 int flags, bool *msg_ready);
>+	int (*seqpacket_enqueue)(struct vsock_sock *vsk, struct msghdr *msg,
>+				 int flags, size_t len);
>
> 	/* Notification. */
> 	int (*notify_poll_in)(struct vsock_sock *, size_t, bool *);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5bf64a3e678a..a031f165494d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1830,9 +1830,14 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 		 * responsibility to check how many bytes we were able to send.
> 		 */
>
>-		written = transport->stream_enqueue(
>-				vsk, msg,
>-				len - total_written);
>+		if (sk->sk_type == SOCK_SEQPACKET) {
>+			written = transport->seqpacket_enqueue(vsk,
>+						msg, msg->msg_flags,

I think we can avoid to pass 'msg->msg_flags', since the transport can 
access it through the 'msg' pointer, right?

>+						len - total_written);
>+		} else {
>+			written = transport->stream_enqueue(vsk,
>+					msg, len - total_written);
>+		}
> 		if (written < 0) {
> 			err = -ENOMEM;
> 			goto out_err;
>@@ -1844,12 +1849,17 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 				vsk, written, &send_data);
> 		if (err < 0)
> 			goto out_err;
>-
> 	}
>
> out_err:
>-	if (total_written > 0)
>-		err = total_written;
>+	if (total_written > 0) {
>+		/* Return number of written bytes only if:
>+		 * 1) SOCK_STREAM socket.
>+		 * 2) SOCK_SEQPACKET socket when whole buffer is sent.
>+		 */
>+		if (sk->sk_type == SOCK_STREAM || total_written == len)
>+			err = total_written;
>+	}
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
