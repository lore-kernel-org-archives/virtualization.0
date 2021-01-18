Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95062C433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 14:52:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370BD22CA2
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 14:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370BD22CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D88092010A;
	Mon, 18 Jan 2021 14:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Io3tIUoqrZgC; Mon, 18 Jan 2021 14:52:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 152F02002B;
	Mon, 18 Jan 2021 14:52:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC292C088B;
	Mon, 18 Jan 2021 14:52:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8F89C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 14:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8F79386322
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 14:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 31RtPChFKVxz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 14:52:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4827886710
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610981525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bvHYXveaY1fYHKCh/4G0s4Eb72E980+xC2zhbE72Tuc=;
 b=Eo7xIaWrpBf4arroqUcI24j4LTPNU470Qtd4KJcelOMnpIpOa6vApPlpjayRStsnNw9SZ6
 bxc1etsJ5UBFW0+dRG11z6Zo9zTL7Sbdhu5hLTOkpjU3vIJK/TU94VRED+Mj6/XyDp2pmx
 TbqFE/j8MuWUt7V19iGaqALXTZqvLR0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-aVWoBJMONw26OaW-Vlm8FQ-1; Mon, 18 Jan 2021 09:52:03 -0500
X-MC-Unique: aVWoBJMONw26OaW-Vlm8FQ-1
Received: by mail-wr1-f69.google.com with SMTP id r11so8367663wrs.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bvHYXveaY1fYHKCh/4G0s4Eb72E980+xC2zhbE72Tuc=;
 b=qT1Dx7fXmBiPBNngcQoe+izVkrnwwaa7nF8GWWqGmNx4b15C27ujhq59gpQzuMIQFK
 o+R7LVrwaUPtjm0rxCuYNdLaWhIsjtVMwGFXJUm0Sd3Y47qfBwWWdgAmE3hYyoj/th1P
 bTH1LuVfuugcHIgTFrxME09trLWupzyLr+O3DnayVuEBSfqcdRqili8+kDz00zLX43c6
 0fbg1rIsgbK7FLiN5TBTzmfnbIvtkBEUDdVlraSFsstX0MWYMqvx0OZwBC4zuAirE+ZM
 9l4TMLTMnYfkSC5Y+fnJY/nwMKdx2WbzRlaJ9iBcZSsPAc+whPrFX4SjLBpDAslHzaFk
 j1wQ==
X-Gm-Message-State: AOAM531APHR9zWd0OpA9YwuEumUJrmcfL0LYwn65FTzOWOAd2R+3U/fA
 EQuMHgMNvWHwTRdEZDOdXiCChFYlDRKLic7d4NlP93Cv62t1DnFGhM3F1UZl3WSiBK5IiF1rrdG
 F+vBODwqgaUfWt89sQaSysgYrPjdr4VAJN/g8f7+QLw==
X-Received: by 2002:a5d:42d0:: with SMTP id t16mr26110644wrr.230.1610981522393; 
 Mon, 18 Jan 2021 06:52:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLYqyNMVyFEoAlbSpKAd9WKw+ODMCj85rmyuhMgWAf133vbbFpPK94WXLLheaXzynpxdDRUg==
X-Received: by 2002:a5d:42d0:: with SMTP id t16mr26110629wrr.230.1610981522214; 
 Mon, 18 Jan 2021 06:52:02 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id x25sm1728972wmk.20.2021.01.18.06.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 06:52:01 -0800 (PST)
Date: Mon, 18 Jan 2021 15:51:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 01/13] af_vsock: implement 'vsock_wait_data()'.
Message-ID: <20210118145158.ufakay5mbezjex4v@steredhat>
References: <20210115053553.1454517-1-arseny.krasnov@kaspersky.com>
 <20210115054028.1455574-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210115054028.1455574-1-arseny.krasnov@kaspersky.com>
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
 Jakub Kicinski <kuba@kernel.org>, Colin Ian King <colin.king@canonical.com>,
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

On Fri, Jan 15, 2021 at 08:40:25AM +0300, Arseny Krasnov wrote:
>This adds 'vsock_wait_data()' function which is called from user's read
>syscall and waits until new socket data is arrived. It was based on code
>from stream dequeue logic and moved to separate function because it will
>be called both from SOCK_STREAM and SOCK_SEQPACKET receive loops.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 47 ++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 47 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index b12d3a322242..af716f5a93a4 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1822,6 +1822,53 @@ static int vsock_stream_sendmsg(struct socket *sock, struct msghdr *msg,
> 	return err;
> }
>
>+static int vsock_wait_data(struct sock *sk, struct wait_queue_entry *wait,
>+			   long timeout,
>+			   struct vsock_transport_recv_notify_data *recv_data,
>+			   size_t target)
>+{
>+	int err = 0;
>+	struct vsock_sock *vsk;
>+	const struct vsock_transport *transport;

Please be sure that here and in all of the next patches, you follow the 
"Reverse Christmas tree" rule followed in net/ for the local variable 
declarations (order variable declaration lines longest to shortest).

>+
>+	vsk = vsock_sk(sk);
>+	transport = vsk->transport;
>+
>+	if (sk->sk_err != 0 ||
>+	    (sk->sk_shutdown & RCV_SHUTDOWN) ||
>+	    (vsk->peer_shutdown & SEND_SHUTDOWN)) {
>+		finish_wait(sk_sleep(sk), wait);
>+		return -1;
>+	}
>+	/* Don't wait for non-blocking sockets. */
>+	if (timeout == 0) {
>+		err = -EAGAIN;
>+		finish_wait(sk_sleep(sk), wait);
>+		return err;
>+	}
>+
>+	if (recv_data) {
>+		err = transport->notify_recv_pre_block(vsk, target, recv_data);
>+		if (err < 0) {
>+			finish_wait(sk_sleep(sk), wait);
>+			return err;
>+		}
>+	}
>+
>+	release_sock(sk);
>+	timeout = schedule_timeout(timeout);
>+	lock_sock(sk);
>+
>+	if (signal_pending(current)) {
>+		err = sock_intr_errno(timeout);
>+		finish_wait(sk_sleep(sk), wait);
>+	} else if (timeout == 0) {
>+		err = -EAGAIN;
>+		finish_wait(sk_sleep(sk), wait);
>+	}
>+

Since we are calling finish_wait() before return in all path, why not 
doing somethig like this:

out:
	finish_wait(sk_sleep(sk), wait);
>+	return err;
>+}

Then in the error paths you can do:

	err = XXX;
	goto out;

Thanks,
Stefano

>
> static int
> vsock_stream_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
