Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B2C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 13:42:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEC5564E21
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 13:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC5564E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DD0283AA7;
	Tue, 23 Feb 2021 13:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OCFCRhp7b_nF; Tue, 23 Feb 2021 13:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43D938305C;
	Tue, 23 Feb 2021 13:42:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9CCBC000A;
	Tue, 23 Feb 2021 13:42:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F352C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F153C605FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:42:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEqg6QHCODKg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:42:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C75CA605AD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614087729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T755Caf6XtrQLBTeIFHgN6zyFn1ttppOwK8TU+o0JY4=;
 b=egiM21JAgBMEvb94EDBCSfTXqm6la5oIvCFi13h3ZGdZEHpYWON26ok5WIy2Vj0MIiwVYX
 au9Yjtt9kRI74ALpVrgbXEZc64BJ9KfxB15IwxsYPtY3O+qNUmouypFjxBPC5N+MPBI8X+
 8wsjmh9jLulsmX45GDc8xo3jxGi2dPY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-KJ5pWL65OnSUOlkBqqLaqw-1; Tue, 23 Feb 2021 08:42:07 -0500
X-MC-Unique: KJ5pWL65OnSUOlkBqqLaqw-1
Received: by mail-wm1-f71.google.com with SMTP id h16so1200774wmq.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 05:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T755Caf6XtrQLBTeIFHgN6zyFn1ttppOwK8TU+o0JY4=;
 b=ILE62GwUK7O5Ss09uV4/6gWPdZH6a53Gbw/tbMhsAJQ//+px8d+meEizKEyJ0KhIDN
 +IUsxzjrZkckGBhtYHY8q+Wq9sgefLkrwpf0vRgjr+PaXg4T6L/SQ1jultWW2c3sMmZn
 R7YgtjzAEPVVqzuJz/8/gZIdbA8AzrRwlXdAiz8+UwC3Nz42DMtkBudrJd15RiEmRQmO
 FQEiRZKt1QeuR+z5paWfJO8r2gBkCmuyHx9v/f6g+BwgNxADZZtQjRV1P4PXMN7M7KlV
 LGkSMaysO1XZHnl7Ptdh3IGoswNUhwxpe2xKf4O3sOoe3Xu2nwRHWWGdgQwcOgQ0rhKk
 Ac/g==
X-Gm-Message-State: AOAM533rtHGI/anM2/fyEXvvYy4k9zsz75VwpfzCADCbWush5CF2o7QL
 uzQvF0Y4jt/ltjm67KQM4P8lc3RJKvCu5kBt1j0xjUov3Z1WlXkRmALm5/2p1DjrIBYdnTRuPXR
 CGmehdxG7KXNY/XG9B8oU/Ku/8XHMC4Yk0agX3/CkKA==
X-Received: by 2002:adf:ee84:: with SMTP id b4mr26135689wro.339.1614087726316; 
 Tue, 23 Feb 2021 05:42:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZVU1NvopjmxfatT6LCxEP+oMjLr10zL2agkulUPEA937Vn2kT6c6DL5dAaA4iEyqUcHv2ig==
X-Received: by 2002:adf:ee84:: with SMTP id b4mr26135672wro.339.1614087726037; 
 Tue, 23 Feb 2021 05:42:06 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id 6sm40195921wra.63.2021.02.23.05.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 05:42:05 -0800 (PST)
Date: Tue, 23 Feb 2021 14:42:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v5 09/19] virtio/vsock: set packet's type in send
Message-ID: <20210223134202.qepkmphp34onaesw@steredhat>
References: <20210218053347.1066159-1-arseny.krasnov@kaspersky.com>
 <20210218053906.1067920-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210218053906.1067920-1-arseny.krasnov@kaspersky.com>
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

The title is a little cryptic, maybe a something like:

virtio/vsock: set packet's type in virtio_transport_send_pkt_info()

On Thu, Feb 18, 2021 at 08:39:02AM +0300, Arseny Krasnov wrote:
>This moves passing type of packet from 'info' srtucture to send

Also here replace send with the function name.

>function. There is no sense to set type of packet which differs
>from type of socket, and since at current time only stream type
>is supported, so force to use this type.

I'm not a native speaker, but I would rephrase a bit the commit message:

     There is no need to set type of packet which differs from type of 
     socket. Since at current time only stream type is supported, set
     it directly in virtio_transport_send_pkt_info(), so callers don't 
     need to set it.

>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 7 ++-----
> 1 file changed, 2 insertions(+), 5 deletions(-)

If I haven't missed something, we can remove 'type' parameter also from 
virtio_transport_send_credit_update(), right?


>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e4370b1b7494..1c9d71ca5e8e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -179,6 +179,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	struct virtio_vsock_pkt *pkt;
> 	u32 pkt_len = info->pkt_len;
>
>+	info->type = VIRTIO_VSOCK_TYPE_STREAM;
>+
> 	t_ops = virtio_transport_get_ops(vsk);
> 	if (unlikely(!t_ops))
> 		return -EFAULT;
>@@ -624,7 +626,6 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.vsk = vsk,
> 	};
>
>@@ -636,7 +637,6 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.flags = (mode & RCV_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> 			 (mode & SEND_SHUTDOWN ?
>@@ -665,7 +665,6 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RW,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>@@ -688,7 +687,6 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RST,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.reply = !!pkt,
> 		.vsk = vsk,
> 	};
>@@ -990,7 +988,6 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> {
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RESPONSE,
>-		.type = VIRTIO_VSOCK_TYPE_STREAM,
> 		.remote_cid = le64_to_cpu(pkt->hdr.src_cid),
> 		.remote_port = le32_to_cpu(pkt->hdr.src_port),
> 		.reply = true,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
