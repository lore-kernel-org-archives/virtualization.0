Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D195C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:35:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35ED96100B
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 15:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35ED96100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EAD7D60592;
	Thu,  3 Jun 2021 15:35:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0SjYvAJItjke; Thu,  3 Jun 2021 15:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id D20816068B;
	Thu,  3 Jun 2021 15:35:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 966AEC000E;
	Thu,  3 Jun 2021 15:35:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 369F2C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B159405C3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OuPzW4TMLL3e
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:35:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11B35405B8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622734506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HHcM+IgNoZ1DlGmkHUu2OKnC00B3Yz63C0t0xp+6d/4=;
 b=OE4g2yQeVixNBtZ4DaHjzKPGXhNBG1bBEX001i/qY38SrfWgXgHuzGI1/d32SggR+CKmm1
 9tN2rchPqJfI6Ln5LXL1FREy6loidvqRMePt16SgUjYRDMnmf2Bn6HajWKOcbFRl2dpgn2
 yJNnRU7cF4CU05v/4DUDxvb/ODBbPvk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-_UipOKqOOLGzcX9fiu0LaQ-1; Thu, 03 Jun 2021 11:35:05 -0400
X-MC-Unique: _UipOKqOOLGzcX9fiu0LaQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 mp38-20020a1709071b26b02903df8ccd76fbso2091584ejc.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 08:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HHcM+IgNoZ1DlGmkHUu2OKnC00B3Yz63C0t0xp+6d/4=;
 b=i7+J/1R52PN/bs6qTs79W+I/eSo19zanotO/0emTuyEHgrJbATG0umBcgEA543pnqB
 orehH2UQjSYZdNA04mqgQBB2suydkcZVxOZwXaffZSqqh+ke1pFX9f72bL8iwRSxvZME
 Y3gMBamJ7x8HsgQSFx71CxGl4jaj9DlBsuwjunu+eSQdQQXuVnR72+9028cXVWcXaydP
 FL46XcJjBG8+iB6QQQrMQIwwPQY2gjtnLPJhg+S8BW1xicz5VgOIw/1/LEKSx/b6yEgo
 K/AtaHcwHl5vai2XDavMQa0OGpUvtePUYn+N/WaBS625L5282hpucRU00497zzutKJA4
 ApaQ==
X-Gm-Message-State: AOAM532+iCYTqAZ+IN2+gue8WIqHLSjoh7Oxp5KPLg+gbY3r+AJJ2P2Z
 82vdjjkjkGIQ62vYjc5dXeFg11cwIblXcBP5dkgUFp2WIts2r0o21vdO2iyiwEmxhOKbaGT8Sej
 LjRR/rtuODGER0k5LR0Qr70J7ZAKNZmh+dJK//+jh3w==
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr66163edx.189.1622734504257; 
 Thu, 03 Jun 2021 08:35:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqFolPWO7BwpcoKlZ9srf0hFGk5LbsUjrn2R3ivE3G00+T3IVZ522WwOzS0fxGTdmkJwWkVw==
X-Received: by 2002:a05:6402:702:: with SMTP id w2mr66134edx.189.1622734504040; 
 Thu, 03 Jun 2021 08:35:04 -0700 (PDT)
Received: from steredhat ([5.170.129.82])
 by smtp.gmail.com with ESMTPSA id p13sm1920100edq.67.2021.06.03.08.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 08:35:03 -0700 (PDT)
Date: Thu, 3 Jun 2021 17:34:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH v10 15/18] vhost/vsock: support SEQPACKET for transport
Message-ID: <20210603153459.4qncp25nssuby4vp@steredhat>
References: <20210520191357.1270473-1-arseny.krasnov@kaspersky.com>
 <20210520191916.1272540-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210520191916.1272540-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
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

On Thu, May 20, 2021 at 10:19:13PM +0300, Arseny Krasnov wrote:

Please describe better the changes included in this patch in the first 
part of the commit message.

>As vhost places data in buffers of guest's rx queue, keep SEQ_EOR
>bit set only when last piece of data is copied. Otherwise we get
>sequence packets for one socket in guest's rx queue with SEQ_EOR bit
>set. Also remove ignore of non-stream type of packets, handle SEQPACKET
>feature bit.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> v9 -> v10:
> 1) Move 'restore_flag' handling to 'payload_len' calculation
>    block.
>
> drivers/vhost/vsock.c | 44 +++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 40 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 5e78fb719602..63d15beaad05 100644
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
>@@ -56,6 +57,7 @@ struct vhost_vsock {
> 	atomic_t queued_replies;
>
> 	u32 guest_cid;
>+	bool seqpacket_allow;
> };
>
> static u32 vhost_transport_get_local_cid(void)
>@@ -112,6 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		size_t nbytes;
> 		size_t iov_len, payload_len;
> 		int head;
>+		bool restore_flag = false;
>
> 		spin_lock_bh(&vsock->send_pkt_list_lock);
> 		if (list_empty(&vsock->send_pkt_list)) {
>@@ -168,9 +171,15 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		/* If the packet is greater than the space available in the
> 		 * buffer, we split it using multiple buffers.
> 		 */
>-		if (payload_len > iov_len - sizeof(pkt->hdr))
>+		if (payload_len > iov_len - sizeof(pkt->hdr)) {
> 			payload_len = iov_len - sizeof(pkt->hdr);
>

Please, add a comment here to explain why we need this.

>+			if (le32_to_cpu(pkt->hdr.flags) & 
>VIRTIO_VSOCK_SEQ_EOR) {
>+				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+				restore_flag = true;
>+			}
>+		}
>+
> 		/* Set the correct length in the header */
> 		pkt->hdr.len = cpu_to_le32(payload_len);
>
>@@ -181,6 +190,9 @@ vhost_transport_do_send_pkt(struct vhost_vsock 
>*vsock,
> 			break;
> 		}
>
>+		if (restore_flag)
>+			pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+

Maybe we can restore the flag only if we are queueing again the same 
packet, I mean in the `if (pkt->off < pkt->len) {` branch below.

What do you think?

> 		nbytes = copy_to_iter(pkt->buf + pkt->off, payload_len,
> 				      &iov_iter);
> 		if (nbytes != payload_len) {
>@@ -354,8 +366,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> 		return NULL;
> 	}
>
>-	if (le16_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_STREAM)
>-		pkt->len = le32_to_cpu(pkt->hdr.len);
>+	pkt->len = le32_to_cpu(pkt->hdr.len);
>
> 	/* No payload */
> 	if (!pkt->len)
>@@ -398,6 +409,8 @@ static bool vhost_vsock_more_replies(struct 
>vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>+
> static struct virtio_transport vhost_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -424,6 +437,10 @@ static struct virtio_transport vhost_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+		.seqpacket_enqueue        = virtio_transport_seqpacket_enqueue,
>+		.seqpacket_allow          = vhost_transport_seqpacket_allow,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>@@ -441,6 +458,22 @@ static struct virtio_transport vhost_transport = {
> 	.send_pkt = vhost_transport_send_pkt,
> };
>
>+static bool vhost_transport_seqpacket_allow(u32 remote_cid)
>+{
>+	struct vhost_vsock *vsock;
>+	bool seqpacket_allow = false;
>+
>+	rcu_read_lock();
>+	vsock = vhost_vsock_get(remote_cid);
>+
>+	if (vsock)
>+		seqpacket_allow = vsock->seqpacket_allow;
>+
>+	rcu_read_unlock();
>+
>+	return seqpacket_allow;
>+}
>+
> static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> {
> 	struct vhost_virtqueue *vq = container_of(work, struct vhost_virtqueue,
>@@ -785,6 +818,9 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
> 			goto err;
> 	}
>
>+	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
>+		vsock->seqpacket_allow = true;
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
