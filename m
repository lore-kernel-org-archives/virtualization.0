Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF70FC433E6
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 12:17:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F35C64E9A
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 12:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F35C64E9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D0DD787509;
	Thu, 11 Feb 2021 12:17:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JZINovjl7cFU; Thu, 11 Feb 2021 12:17:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A6032874CE;
	Thu, 11 Feb 2021 12:17:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CA09C0891;
	Thu, 11 Feb 2021 12:17:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D557C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 12:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 09F8E6F52A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 12:17:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EZQA2K_dlrx0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 12:17:11 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 273C66F5CB; Thu, 11 Feb 2021 12:17:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A94C86F52A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613045828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E1yuAMx44/76bqf49DYn2JPHR26BQBuYBzfgeTpXepM=;
 b=KWiWyuSznwEJ9pJGtsD9tGKV8TGI+4qn/cUyC/lvausgwslgVPE6aAOiqAvlkwZ673NLX+
 x7MAX2RBir7Ax0wgfP/pc/6B+12nm5/raX/fRppMSbJ6K5l5L7NrRKcBZzlZuViA4Jpsyw
 9cw5e3UdrhpPZnrNuvs9eSii0L6ugRM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-AQXoTudtPmKW0W1WtAIbjw-1; Thu, 11 Feb 2021 07:17:06 -0500
X-MC-Unique: AQXoTudtPmKW0W1WtAIbjw-1
Received: by mail-ej1-f71.google.com with SMTP id jz15so4786231ejc.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 04:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=E1yuAMx44/76bqf49DYn2JPHR26BQBuYBzfgeTpXepM=;
 b=iV5jDzynKcpJODIjn5GNcKoE7VKDQVwPwnObLye+MrFVS4yJLuifuN/B7xg6BNIKue
 Co5R82pPjV56Sqohh29poKhL5neiXTvYmTSNLijkduVF93O+yn0emUMaVst9jsIbrAb9
 CdavOz6vnbNE60V3suNsPNFDEotZzzEUk+5htDoTYjbCZhKYMDTNx+6xavRS/m9cgIsk
 D9ytDl+GxYN4wIO/tMf8+sZi9LAtqeVzt7GFqKJ0g6ZOa9CQrqXC6hnHAeFsYLawc8yb
 vYI5KPD8eLO+bjxXMq7KDRGnBE9mkpjEEQ+NOaTlC+WaSzTOArOPDizpkJv/UKkEV9h3
 Hh1Q==
X-Gm-Message-State: AOAM532OhL4w5IH2CwT02QTS+tv5MexTr+Es+kmp8p0Fm5PaLd4qpbaM
 1+cv2NNa9d5ZJmehaOur/ibjBBJ7k++vlsQif3JYU/tCMR6vx4M1S2IjUjQT3rKEet5AXyzKyYq
 xGr4a+dQJpkrOEsPZ2mdvW4KvdPtQKs9eOb31TttEoA==
X-Received: by 2002:aa7:d6c2:: with SMTP id x2mr8057383edr.225.1613045825201; 
 Thu, 11 Feb 2021 04:17:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxarfD0dC+o1lTaNaYi8iRDZFDf94i0xlVO9sO1P+pAXgRHpADAlujD3wU7pg5278zwtG18ww==
X-Received: by 2002:aa7:d6c2:: with SMTP id x2mr8057363edr.225.1613045825000; 
 Thu, 11 Feb 2021 04:17:05 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id hr31sm4057322ejc.125.2021.02.11.04.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 04:17:04 -0800 (PST)
Date: Thu, 11 Feb 2021 13:17:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 06/17] af_vsock: implement send logic for SEQPACKET
Message-ID: <20210211121701.4em23vgsqfdkdp5j@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151600.804998-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151600.804998-1-arseny.krasnov@kaspersky.com>
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

On Sun, Feb 07, 2021 at 06:15:57PM +0300, Arseny Krasnov wrote:
>This adds some logic to current stream enqueue function for SEQPACKET
>support:
>1) Send record's begin/end marker.
>2) Return value from enqueue function is whole record length or error
>   for SOCK_SEQPACKET.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/net/af_vsock.h   |  2 ++
> net/vmw_vsock/af_vsock.c | 22 ++++++++++++++++++++--
> 2 files changed, 22 insertions(+), 2 deletions(-)
>
>diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
>index 19f6f22821ec..198d58c4c7ee 100644
>--- a/include/net/af_vsock.h
>+++ b/include/net/af_vsock.h
>@@ -136,6 +136,8 @@ struct vsock_transport {
> 	bool (*stream_allow)(u32 cid, u32 port);
>
> 	/* SEQ_PACKET. */
>+	int (*seqpacket_seq_send_len)(struct vsock_sock *, size_t len, int flags);
>+	int (*seqpacket_seq_send_eor)(struct vsock_sock *, int flags);

As before, we could add the identifier of the parameters.

Other than that, the patch LGTM.

Stefano

> 	size_t (*seqpacket_seq_get_len)(struct vsock_sock *);
> 	int (*seqpacket_dequeue)(struct vsock_sock *, struct msghdr *,
> 				     int flags, bool *msg_ready);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ea99261e88ac..a033d3340ac4 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1806,6 +1806,12 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 	if (err < 0)
> 		goto out;
>
>+	if (sk->sk_type == SOCK_SEQPACKET) {
>+		err = transport->seqpacket_seq_send_len(vsk, len, msg->msg_flags);
>+		if (err < 0)
>+			goto out;
>+	}
>+
> 	while (total_written < len) {
> 		ssize_t written;
>
>@@ -1852,9 +1858,21 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
>
> 	}
>
>+	if (sk->sk_type == SOCK_SEQPACKET) {
>+		err = transport->seqpacket_seq_send_eor(vsk, msg->msg_flags);
>+		if (err < 0)
>+			goto out;
>+	}
>+
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
