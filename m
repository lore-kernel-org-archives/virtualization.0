Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE8AC433E0
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 11:02:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283BA64DE3
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 11:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283BA64DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA742834AE;
	Mon, 15 Mar 2021 11:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrUFsIS5Z0sW; Mon, 15 Mar 2021 11:02:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EADA83495;
	Mon, 15 Mar 2021 11:02:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31CFBC000B;
	Mon, 15 Mar 2021 11:02:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F656C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 001276ED68
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLdr1OxOFsh1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:02:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 264EA60707
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615806135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S/oWGawpXGhyQCD9KmbcPNHKcWmsnOSDhuC/sNGQZGI=;
 b=CrnWFDtveGdiLUbmvbydLmBN6TLTE7QMgQOJ12yZT8Vt6lkPCeWQZKw9Uo56yX3EiQOJaM
 6seAr11sAfbiAXgrs4UluURXSFstinoxjQjqDztwldNQ4DI0kNUMSahBp27aoaIfYqCiqs
 s8GYxEosPmumVk9z97/dJLNzjBiXlHg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-6UlMMsd-NzKNDgsAKMQlVg-1; Mon, 15 Mar 2021 07:02:14 -0400
X-MC-Unique: 6UlMMsd-NzKNDgsAKMQlVg-1
Received: by mail-wm1-f72.google.com with SMTP id z26so8033919wml.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 04:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S/oWGawpXGhyQCD9KmbcPNHKcWmsnOSDhuC/sNGQZGI=;
 b=nDchLNG4+mXooy4KiqFnUgoWh4+D1R9AGa9K0gSCHFRHBhLPHsIjXBNyf/clH5icPB
 2mbcYRFhMWhUdgBP7yIPoM/Wz0ENmcoLLbHRuDQMYvw5iBnLVSpan4kab2jItqNFRohv
 qFS2N2LJPfv4d4BBEL00DFpN+VS//87C++miKMftcU+YXn8DJBUAZltzjxI3/UqSE6xg
 +A/vpHCTQpSfJDsGwyLzXVKXQBfAT7uWndzutFBcFNlnVXeLkRxGACCnIDRaoHrt6n9L
 RD0IZ9W/2CIn8GMVY4zbiZt65M0H4QvSmUz8S8q9pkBhnfKTKWKBbiu1fhe6aqY8Kdrr
 zPJA==
X-Gm-Message-State: AOAM533UMYKhE3fH0NHVGWmBOb/Ps0V6DJIz9Odt2KsE+yzeuN05St0N
 kOAc37IGq3sM/HkoE+7l/PG/WgK9bXGn6cqGURiJXHa3fXOAEMVOdZer/zZf8b+JwnUFA4+Jlbt
 wGN4gfhkUhbZtjBAqw9FJHwT37OSeEShbAe3oUJTONA==
X-Received: by 2002:a05:6000:24b:: with SMTP id
 m11mr26777654wrz.393.1615806132210; 
 Mon, 15 Mar 2021 04:02:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxngqoRvyImvtrS1gTlOBvENXh/6EdwVXEpl38+sSZZ8VElzUNwwM/9wN8W829CrCnbUyofg==
X-Received: by 2002:a05:6000:24b:: with SMTP id
 m11mr26777627wrz.393.1615806132028; 
 Mon, 15 Mar 2021 04:02:12 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id a13sm16170382wrp.31.2021.03.15.04.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 04:02:11 -0700 (PDT)
Date: Mon, 15 Mar 2021 12:02:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 11/22] virtio/vsock: dequeue callback for
 SOCK_SEQPACKET
Message-ID: <20210315110209.xuaq5q3a2zp4u3g5@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180204.3465806-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307180204.3465806-1-arseny.krasnov@kaspersky.com>
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

On Sun, Mar 07, 2021 at 09:02:01PM +0300, Arseny Krasnov wrote:
>This adds transport callback and it's logic for SEQPACKET dequeue.
>Callback fetches RW packets from rx queue of socket until whole record
>is copied(if user's buffer is full, user is not woken up). This is done
>to not stall sender, because if we wake up user and it leaves syscall,
>nobody will send credit update for rest of record, and sender will wait
>for next enter of read syscall at receiver's side. So if user buffer is
>full, we just send credit update and drop data. If during copy SEQ_BEGIN
>was found(and not all data was copied), copying is restarted by reset
>user's iov iterator(previous unfinished data is dropped).
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> include/linux/virtio_vsock.h            |  13 +++
> include/uapi/linux/virtio_vsock.h       |  16 ++++
> net/vmw_vsock/virtio_transport_common.c | 116 ++++++++++++++++++++++++
> 3 files changed, 145 insertions(+)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index dc636b727179..466a5832d2f5 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -18,6 +18,12 @@ enum {
> 	VSOCK_VQ_MAX    = 3,
> };
>
>+struct virtio_vsock_seqpack_state {
>+	u32 user_read_seq_len;
>+	u32 user_read_copied;
>+	u32 curr_rx_msg_id;
>+};
>+
> /* Per-socket state (accessed via vsk->trans) */
> struct virtio_vsock_sock {
> 	struct vsock_sock *vsk;
>@@ -36,6 +42,8 @@ struct virtio_vsock_sock {
> 	u32 rx_bytes;
> 	u32 buf_alloc;
> 	struct list_head rx_queue;
>+
>+	struct virtio_vsock_seqpack_state seqpacket_state;

Following 'virtio_vsock_seq_hdr', maybe we can shorten in:

         struct virtio_vsock_seq_state seq_state;

The rest LGTM.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
