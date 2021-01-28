Return-Path: <SRS0=vMKq=G7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D82C433E0
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 16:55:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3AB364E07
	for <virtualization@archiver.kernel.org>; Thu, 28 Jan 2021 16:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3AB364E07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4F6472041A;
	Thu, 28 Jan 2021 16:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V12TreFUa5uT; Thu, 28 Jan 2021 16:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2686E20336;
	Thu, 28 Jan 2021 16:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 031FEC0FA8;
	Thu, 28 Jan 2021 16:55:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF82AC08A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AE07687406
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KaoA3Ro918TD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:55:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E0770873D4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611852925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgtxAPALtY+nCny47e18Ou0vNrOzLT1OduAQqQAsR8o=;
 b=dEF+xAKD3c90Ckg9ajmBEyYf4esEiK8KqqWcUEFXdKyMg1WTnavLwtr03Doug6PuwFkXwk
 hBbI5hXXCKibR2DHOc4aptOV+Y0EToCgePzqXWWRZE/C+q6+mQbR0HAa4EdnzA1ESykkBT
 I18uazIpo3+OKiCVFaF0jN8Mwy1TQwU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-ZQ2NH_mMOqC8fb9tB8yoBA-1; Thu, 28 Jan 2021 11:55:23 -0500
X-MC-Unique: ZQ2NH_mMOqC8fb9tB8yoBA-1
Received: by mail-wr1-f69.google.com with SMTP id n18so3422476wrm.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 08:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HgtxAPALtY+nCny47e18Ou0vNrOzLT1OduAQqQAsR8o=;
 b=H9s00ge7tuYw+aEhaveepOhzWX62m6jN6463+SgGwdfhG95gPf26a9xhL3AWLtQB9M
 kbnAXakp141s7kwWt0b75hXlW2YtMjHSd+n1UHYhPxKQ/ph18ifLQsCmOUFEaoJZQ/di
 wysoY5ocxKwavc1c4zZcrUxp41XivvEZB+v1ZWLRo5LqnoAad2mZJ74sxv/p3RggmmI6
 WDezGqL/An+tbCFZaoGveqoMd8M4PdRb/zmzYvjfxUze02MutZuO2JCmcZvU5AjFZTmz
 d09xXzg4DYIbDbUhW1cxQRwZS0jzDWAiB7atp0jKT9bTdJKgnFRW8WvjCczoZXwW3gam
 bv+g==
X-Gm-Message-State: AOAM530RaiV+o60lFyl0pDZjq8ATxC2Nbvx7bcywQRKiu06pPiVZVU3N
 M+npCCQImOdQS8uqQrzXRRtUbv7P2F7iV8IEiV6VayY+LHznWXD+v2qu7MlE58+f+1PR9ouPMTx
 WgJpUXdIzDPCy/NPG+W3Pdl+C4BA487fS0fRqlcNHEw==
X-Received: by 2002:a1c:a549:: with SMTP id o70mr135298wme.71.1611852922174;
 Thu, 28 Jan 2021 08:55:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyb6UPtRnhkfUKRNkSJfjFxJ3q1MvMrhDM7KtpKfLvcGV1YzLJVQtRahOZNlCd6vpRf46h8cQ==
X-Received: by 2002:a1c:a549:: with SMTP id o70mr135279wme.71.1611852921999;
 Thu, 28 Jan 2021 08:55:21 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id q6sm6320451wmj.32.2021.01.28.08.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Jan 2021 08:55:21 -0800 (PST)
Date: Thu, 28 Jan 2021 17:55:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v3 03/13] af_vsock: implement SEQPACKET rx loop
Message-ID: <20210128165518.ho3csm5u7v5pnwnd@steredhat>
References: <20210125110903.597155-1-arseny.krasnov@kaspersky.com>
 <20210125111239.598377-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210125111239.598377-1-arseny.krasnov@kaspersky.com>
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

On Mon, Jan 25, 2021 at 02:12:36PM +0300, Arseny Krasnov wrote:
>This adds receive loop for SEQPACKET. It looks like receive loop for
>SEQPACKET, but there is a little bit difference:
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
> include/net/af_vsock.h   |   5 ++
> net/vmw_vsock/af_vsock.c | 102 ++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 106 insertions(+), 1 deletion(-)
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
>index 524df8fc84cd..3b266880b7c8 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2006,7 +2006,107 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
> static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 				     size_t len, int flags)
> {
>-	return -1;
>+	const struct vsock_transport *transport;
>+	const struct iovec *orig_iov;
>+	unsigned long orig_nr_segs;
>+	ssize_t dequeued_total = 0;
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
>+	msg->msg_flags &= ~MSG_EOR;

Maybe add a comment about why we need to clear MSG_EOR.

>+	orig_nr_segs = msg->msg_iter.nr_segs;
>+	orig_iov = msg->msg_iter.iov;
>+
>+	while (1) {
>+		ssize_t dequeued;
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
>+			continue;
>+		}
>+
>+		finish_wait(sk_sleep(sk), &wait);
>+
>+		if (ready < 0) {
>+			err = -ENOMEM;
>+			goto out;
>+		}
>+
>+		if (dequeued_total == 0) {
>+			record_len =
>+				transport->seqpacket_seq_get_len(vsk);
>+
>+			if (record_len == 0)
>+				continue;
>+		}
>+
>+		/* 'msg_iter.count' is number of unused bytes in iov.
>+		 * On every copy to iov iterator it is decremented at
>+		 * size of data.
>+		 */
>+		dequeued = transport->seqpacket_dequeue(vsk, msg,
>+					msg->msg_iter.count, flags);
                                         ^
                                         Is this needed or 'msg' can be 
                                         used in the transport?
>+
>+		if (dequeued < 0) {
>+			dequeued_total = 0;
>+
>+			if (dequeued == -EAGAIN) {
>+				iov_iter_init(&msg->msg_iter, READ,
>+					      orig_iov, orig_nr_segs,
>+					      len);
>+				msg->msg_flags &= ~MSG_EOR;
>+				continue;

Why we need to reset MSG_EOR here?

>+			}
>+
>+			err = -ENOMEM;
>+			break;
>+		}
>+
>+		dequeued_total += dequeued;
>+
>+		if (dequeued_total >= record_len)
>+			break;
>+	}

Maybe a new line here.

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

s/that/than

>+		 */
>+		if (record_len > len)
>+			msg->msg_flags |= MSG_TRUNC;
>+	}
>+out:
>+	return err;
> }
>
> static int
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
