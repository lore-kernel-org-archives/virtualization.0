Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E39C43460
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:32:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6188613E6
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 09:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6188613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B0B340617;
	Wed, 21 Apr 2021 09:31:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PMOeaKD4ILgp; Wed, 21 Apr 2021 09:31:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A5B4405F4;
	Wed, 21 Apr 2021 09:31:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF9AC000F;
	Wed, 21 Apr 2021 09:31:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EFF8C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:31:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0930E60701
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:31:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G6nHZZIOAMuc
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:31:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17E1A6064F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618997513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U7X4vCyOCjQHI1jpddaKwHHtP8FwpBjh+EKBeCw5TnU=;
 b=TfXPdUdxHT72SWl54ZG8wdY8y1g3EOdia5XDakL7yPsEvRM4IOy5CfjVQR64eyegq3qE/9
 pWJV6ETdQeO03q7GtwC8faH+ZqgnpMkqQXhwT4g16Jcy/Pg8rulVWJ/0QRD3YCe6Qcl7TL
 7/osFQDWs59WeHO1obUfiymqxpHKtHA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Q_9BIlPgMkG5Vxzq8flgpw-1; Wed, 21 Apr 2021 05:31:49 -0400
X-MC-Unique: Q_9BIlPgMkG5Vxzq8flgpw-1
Received: by mail-ed1-f71.google.com with SMTP id
 l22-20020a0564021256b0290384ebfba68cso10856396edw.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 02:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U7X4vCyOCjQHI1jpddaKwHHtP8FwpBjh+EKBeCw5TnU=;
 b=AjqfPJE4hxLzX7U6BFlD0vqms+9H+LrSA+hZCtR0rjHRrhBrMdHbm6tkBDVSm28GrF
 ytiQ8Ap0bgKpGIk0shUwI/dlZVm962bqir4JCzsAGvwx5jQPG1nG2L217yLz/lqTUyvx
 6siPw+lqz7k6UqYPPy0sgzg9Clwjg6+0a1f+D87eyoRWo0hCmXA4uITwYeNSpnX6axjd
 dGzMCcJqR0YXHuDCibwBodkc5O/TXvbuX+8JjAeLD9PM7c/GRosUFPQEcaB/PO7IIuVQ
 j1K+2LPD53VzFvwXu3uOjgEOuWcOLqYdur2Hqv5nNaNztyRSiI8j0aP5GJuXGJRivNKB
 jP2g==
X-Gm-Message-State: AOAM533swHjYJpzolas5X1/5NbZR1PBLElXwfpblCGfJCWHXOwXvHKIy
 iYneGQe2h0GG9NpcQKPZSexfYVTJAXzNvagDNI7M8WmjizP1bBknQfbc3bgIOY6kBcaRBPhTi2s
 Y7FRGnAWfxn2QOxRlMvk5Kjt2SC2GrmZxVEUXD7E2XA==
X-Received: by 2002:a17:906:cc8e:: with SMTP id
 oq14mr31701028ejb.15.1618997508454; 
 Wed, 21 Apr 2021 02:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN/DH6KxnWUcPdJgeufxW/nKNOm0u9lF15XFa52b8iP6VK1HSTTtkVWzaEX8ZgOYphJXxEGA==
X-Received: by 2002:a17:906:cc8e:: with SMTP id
 oq14mr31701007ejb.15.1618997508240; 
 Wed, 21 Apr 2021 02:31:48 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id k5sm2856590edk.46.2021.04.21.02.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Apr 2021 02:31:47 -0700 (PDT)
Date: Wed, 21 Apr 2021 11:31:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 15/19] vhost/vsock: enable SEQPACKET for transport
Message-ID: <20210421093145.ev375dexrxr4jrod@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210413124620.3405764-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210413124620.3405764-1-arseny.krasnov@kaspersky.com>
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
 David Brazdil <dbrazdil@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jorgen Hansen <jhansen@vmware.com>, Alexander Popov <alex.popov@linux.com>
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

On Tue, Apr 13, 2021 at 03:46:18PM +0300, Arseny Krasnov wrote:
>This removes:
>1) Ignore of non-stream type of packets.
>This adds:
>1) Handling of SEQPACKET bit: if guest sets features with this bit cleared,
>   then SOCK_SEQPACKET support will be disabled.
>2) 'seqpacket_allow()' callback.
>3) Handling of SEQ_EOR bit: when vhost places data in buffers of guest's
>   rx queue, keep this bit set only when last piece of data is copied.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
>v7 -> v8:
> - This patch merged with patch which adds SEQPACKET feature bit to
>   virtio transport.
> - It now handles VIRTIO_VSOCK_SEQ_EOR bit(see commit msg).
>
> drivers/vhost/vsock.c | 31 ++++++++++++++++++++++++++++---
> 1 file changed, 28 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 5e78fb719602..0969cdc87830 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -31,7 +31,8 @@
>
> enum {
> 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
>-			       (1ULL << VIRTIO_F_ACCESS_PLATFORM)
>+			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>+			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
> };
>
> enum {
>@@ -112,6 +113,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		size_t nbytes;
> 		size_t iov_len, payload_len;
> 		int head;
>+		bool restore_flag = false;
>
> 		spin_lock_bh(&vsock->send_pkt_list_lock);
> 		if (list_empty(&vsock->send_pkt_list)) {
>@@ -174,6 +176,12 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		/* Set the correct length in the header */
> 		pkt->hdr.len = cpu_to_le32(payload_len);
>
>+		if (pkt->off + payload_len < pkt->len &&
>+		    pkt->hdr.flags & VIRTIO_VSOCK_SEQ_EOR) {
                              ^
                             (1)
>+			pkt->hdr.flags &= ~VIRTIO_VSOCK_SEQ_EOR;
                                  ^
                                 (2)
>+			restore_flag = true;
>+		}
>+
> 		nbytes = copy_to_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
> 		if (nbytes != sizeof(pkt->hdr)) {
> 			virtio_transport_free_pkt(pkt);
>@@ -181,6 +189,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			break;
> 		}
>
>+		if (restore_flag)
>+			pkt->hdr.flags |= VIRTIO_VSOCK_SEQ_EOR;
                                  ^
                                 (3)
In these 3 points we should use cpu_to_le32()/le32_to_cpu().

>+
> 		nbytes = copy_to_iter(pkt->buf + pkt->off, payload_len,
> 				      &iov_iter);
> 		if (nbytes != payload_len) {
>@@ -354,8 +365,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	if (le16_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_STREAM)
>-		pkt->len = le32_to_cpu(pkt->hdr.len);
>+	pkt->len = le32_to_cpu(pkt->hdr.len);
>
> 	/* No payload */
> 	if (!pkt->len)
>@@ -398,6 +408,8 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_seqpacket_allow(void);
>+
> static struct virtio_transport vhost_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -424,6 +436,10 @@ static struct virtio_transport vhost_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = 
> 		virtio_transport_stream_allow,
>
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>+		.seqpacket_allow          = vhost_transport_seqpacket_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>@@ -439,8 +455,14 @@ static struct virtio_transport vhost_transport = {
> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>+	.seqpacket_allow = false
> };
>
>+static bool vhost_transport_seqpacket_allow(void)
>+{
>+	return vhost_transport.seqpacket_allow;
>+}

I think here it's even worse then virtio_transport.c, because there may 
be more instances with different guests and some may require the feature 
and some may not, we can't definitely save this information in struct 
virtio_transport, we should put it in `struct vhost_vsock`.

>+
> static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> {
> 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
>@@ -785,6 +807,9 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 			goto err;
> 	}
>
>+	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
>+		vhost_transport.seqpacket_allow = true;
>+
> 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> 		vq = &vsock->vqs[i];
> 		mutex_lock(&vq->mutex);
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
