Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A429C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:09:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74AE60FC4
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 09:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D74AE60FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1E8A82974;
	Wed, 11 Aug 2021 09:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sjglsiOuoK_N; Wed, 11 Aug 2021 09:09:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 45C6281045;
	Wed, 11 Aug 2021 09:09:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10468C001A;
	Wed, 11 Aug 2021 09:09:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28549C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:09:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17C7E81BC0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:09:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FRM1oNQ6ewjO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:09:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DA0881045
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 09:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628672975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsN+R/kO/sC5UDsvg+cIZCQho4j0aHbcm1E8m8xMoHI=;
 b=Y/3A+zGV2Z8Oy4FxnskduYhm7DD+LHXbjZvqIYP0YrVripAY68OyW/Hv1NR/1damZeIsMt
 1YVyjvnb7d+cwZuAAsfEnKbA0j5NGjZHfha6J1SvQsFqfh+/FSPVodWezqhRJ0eibf6dKj
 nmAa0Mt6LgwUhluSVqlCVnCg3VHWTRw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-KgzpRxgmMfWobyh-NWiNXw-1; Wed, 11 Aug 2021 05:09:34 -0400
X-MC-Unique: KgzpRxgmMfWobyh-NWiNXw-1
Received: by mail-ej1-f72.google.com with SMTP id
 h17-20020a1709070b11b02905b5ced62193so434680ejl.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MsN+R/kO/sC5UDsvg+cIZCQho4j0aHbcm1E8m8xMoHI=;
 b=frC6mnnncuI/6TrpaLFlEmpS5NRCSTguf9rugE+UHi31azZW3u8m5TUffyRyTPNgQ/
 3m9EpL9hHYdkxvbfjm8+X9obv7bZx+rpkNxjhr+2hP2mnSaHwrAwrP2RkWCng3PSm5PV
 kbLiM6bxHb5oT1/m6myJSrwyjb3BGD1Gz1uSEEhVOHwv4bdBxM4z35QNurNRGR9W1Zxw
 kQ/0JAsFetvZ9DhKp8FYom0T0bDv8rCx3zCjCchLbxzEZ0V9h0dQKgZnzjdSuAOjtvDH
 zkpSL3DRBl7l0jsXC71BBHHNrVMUhMDhMTbn2RyPv83WeoLdjXU+Xg0x4jkOLflRsm/x
 0wAA==
X-Gm-Message-State: AOAM530Pl5qaJPnLZhkd3l9cQHNJ/Pfd1VgvpGxl3iS25gO2mCrRYDG5
 mCXpUN7A1aQ91XZfnXaWVSqS37YijojDbanwdOnuL2BrXXTe4y5tSFqTkBApszxtZ2p6A1ZnBdP
 6S5LUbySqQfXnCSNrawkJWrzh0JnZj9wnpDvcM4wPjQ==
X-Received: by 2002:a17:907:d09:: with SMTP id
 gn9mr2650704ejc.447.1628672972940; 
 Wed, 11 Aug 2021 02:09:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlojArCBZxB67seYKuyq7LpLZcorxhEMExKVIxApxzWQgjZz0IoO7BwSDRdptosrXZNyCPQA==
X-Received: by 2002:a17:907:d09:: with SMTP id
 gn9mr2650687ejc.447.1628672972737; 
 Wed, 11 Aug 2021 02:09:32 -0700 (PDT)
Received: from steredhat (a-nu5-14.tin.it. [212.216.181.13])
 by smtp.gmail.com with ESMTPSA id v24sm7840824edt.41.2021.08.11.02.09.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Aug 2021 02:09:32 -0700 (PDT)
Date: Wed, 11 Aug 2021 11:09:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 4/5] af_vsock: rename variables in receive loop
Message-ID: <20210811090930.mormg24hnnle7qq3@steredhat>
References: <20210810113901.1214116-1-arseny.krasnov@kaspersky.com>
 <20210810114103.1214897-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210810114103.1214897-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Colin Ian King <colin.king@canonical.com>,
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

On Tue, Aug 10, 2021 at 02:41:00PM +0300, Arseny Krasnov wrote:
>Record is supported via MSG_EOR flag, while current logic operates
>with message, so rename variables from 'record' to 'message'.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/af_vsock.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 3e02cc3b24f8..e2c0cfb334d2 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2014,7 +2014,7 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> {
> 	const struct vsock_transport *transport;
> 	struct vsock_sock *vsk;
>-	ssize_t record_len;
>+	ssize_t msg_len;
> 	long timeout;
> 	int err = 0;
> 	DEFINE_WAIT(wait);
>@@ -2028,9 +2028,9 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 	if (err <= 0)
> 		goto out;
>
>-	record_len = transport->seqpacket_dequeue(vsk, msg, flags);
>+	msg_len = transport->seqpacket_dequeue(vsk, msg, flags);
>
>-	if (record_len < 0) {
>+	if (msg_len < 0) {
> 		err = -ENOMEM;
> 		goto out;
> 	}
>@@ -2044,14 +2044,14 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 		 * packet.
> 		 */
> 		if (flags & MSG_TRUNC)
>-			err = record_len;
>+			err = msg_len;
> 		else
> 			err = len - msg_data_left(msg);
>
> 		/* Always set MSG_TRUNC if real length of packet is
> 		 * bigger than user's buffer.
> 		 */
>-		if (record_len > len)
>+		if (msg_len > len)
> 			msg->msg_flags |= MSG_TRUNC;
> 	}
>
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
