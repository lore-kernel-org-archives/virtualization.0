Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C21C433DB
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:08:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C6522CAD
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 20:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C6522CAD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 52C9E85329;
	Tue, 12 Jan 2021 20:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tcS6jUDiWi+x; Tue, 12 Jan 2021 20:08:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B8F4D85044;
	Tue, 12 Jan 2021 20:08:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B322C0893;
	Tue, 12 Jan 2021 20:08:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E352C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8678186F99
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DOjFk1ImJp4P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:08:43 +0000 (UTC)
X-Greylist: delayed 00:26:41 by SQLgrey-1.7.6
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 10EE486F92
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 20:08:43 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id a12so3806555wrv.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 12:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=95fcQ7XOzwxPXY92PHMXKGjY9iDFTd+3y3erYQ9GO9s=;
 b=1tCRinMHamPfSeGT7m65Y3aJyKfckJHdtuiPmHaE4Z5fAN3CngoISCY+eCrh3zIQAv
 EGhkjV84NQPvJCJxVOwNd9CE0wSnFoOAftnadDX8xYXaBW7qtglM9h/6WoA8pAgW+nL6
 4m82MlTv/1REnteWu+i3oDfcivx2yXiBbLVQWzMi+Tcckw3PucDqFLBtRMqasUzDWGmC
 Sab3HyYsjdlZjK/iK3QQ6jEyOIcH0Klo4LqQ2m33gvyaXOOJMwsc5ulFxyUXulZD4eRp
 /4MJfbr5A2VW61mdnl9hQIzqkj44NmcfjRN0ccLFjp1aO5yzGHEm11Np5MWflBTL9Wtv
 SGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=95fcQ7XOzwxPXY92PHMXKGjY9iDFTd+3y3erYQ9GO9s=;
 b=HikGSYL6YjkXnAkgoOac5SLjLGWGmc9RVvRHXMGf0cFeRSOPp9+VE1+usIk2a4velC
 Tzj8mtsr5uEL/1GSFE3/3uj/wRQCmWeYx+D7YxtjYpSiXfHKyF/+v6pn5D+TUpM1Rv4k
 ujJHVvKRL2KHAFbFHtix2zXM5deQRt4ITKgaycpIJTC+zIvZum6nvGnnt5ooJJSqV2te
 7GZ6vgGRPt64tKkrxbDjCklcg/CCpToUgQCIgSm5kpOOZnkQOJ8lWryr41HGJBnscLMd
 GuUpSbmmSDtMQeq8YPAAcaOrzySradc1xlIpc7uIwypK1qapvg3i6fTSjpUcsXIPY/U+
 fpAw==
X-Gm-Message-State: AOAM533xtbY+7aasUEbyuNldC1P8seXktgohqGabKxHbxrHk2qB1VDqG
 LdSAXzjXfEA7sm9ucVddIl5DRixZnFIY+yLQ
X-Google-Smtp-Source: ABdhPJwozaYVSn8b891ub9ZvGIip49TMHv9Wa+1fM6bn8ZY9QZR52VX9j+xhhl/b0ZukWBXo7jRRLw==
X-Received: by 2002:a5d:6c66:: with SMTP id r6mr446833wrz.86.1610480521047;
 Tue, 12 Jan 2021 11:42:01 -0800 (PST)
Received: from f2.redhat.com (bzq-79-183-72-147.red.bezeqint.net.
 [79.183.72.147])
 by smtp.gmail.com with ESMTPSA id z63sm4885315wme.8.2021.01.12.11.41.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Jan 2021 11:42:00 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: davem@davemloft.net, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, rdunlap@infradead.org, willemb@google.com,
 gustavoars@kernel.org, herbert@gondor.apana.org.au,
 steffen.klassert@secunet.com, nogikh@google.com, pablo@netfilter.org,
 decui@microsoft.com, cai@lca.pw, jakub@cloudflare.com, elver@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bpf@vger.kernel.org
Subject: [RFC PATCH 2/7] vhost: support for hash report virtio-net feature
Date: Tue, 12 Jan 2021 21:41:38 +0200
Message-Id: <20210112194143.1494-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112194143.1494-1-yuri.benditovich@daynix.com>
References: <20210112194143.1494-1-yuri.benditovich@daynix.com>
Cc: yan@daynix.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

According to the virtio specification if VIRTIO_NET_F_HASH_REPORT
feature acked the virtio-net header is extended to hold the hash
value and hash report type.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 drivers/vhost/net.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 531a00d703cd..31a894b9a992 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -73,7 +73,8 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			 (1ULL << VIRTIO_F_ACCESS_PLATFORM)
+			 (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
+			 (1ULL << VIRTIO_NET_F_HASH_REPORT)
 };
 
 enum {
@@ -1108,14 +1109,16 @@ static void handle_rx(struct vhost_net *net)
 		.msg_controllen = 0,
 		.msg_flags = MSG_DONTWAIT,
 	};
-	struct virtio_net_hdr hdr = {
-		.flags = 0,
-		.gso_type = VIRTIO_NET_HDR_GSO_NONE
+	struct virtio_net_hdr_v1_hash hdrv1 = {
+		{
+			.flags = 0,
+			.gso_type = VIRTIO_NET_HDR_GSO_NONE
+		}
 	};
 	size_t total_len = 0;
 	int err, mergeable;
 	s16 headcount;
-	size_t vhost_hlen, sock_hlen;
+	size_t vhost_hlen, sock_hlen, extra_hlen;
 	size_t vhost_len, sock_len;
 	bool busyloop_intr = false;
 	struct socket *sock;
@@ -1137,9 +1140,12 @@ static void handle_rx(struct vhost_net *net)
 	vhost_hlen = nvq->vhost_hlen;
 	sock_hlen = nvq->sock_hlen;
 
+
 	vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
 		vq->log : NULL;
 	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
+	extra_hlen = vhost_has_feature(vq, VIRTIO_NET_F_HASH_REPORT) ?
+		sizeof(hdrv1) - sizeof(hdrv1.hdr) : 0;
 
 	do {
 		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
@@ -1201,8 +1207,8 @@ static void handle_rx(struct vhost_net *net)
 		}
 		/* Supply virtio_net_hdr if VHOST_NET_F_VIRTIO_NET_HDR */
 		if (unlikely(vhost_hlen)) {
-			if (copy_to_iter(&hdr, sizeof(hdr),
-					 &fixup) != sizeof(hdr)) {
+			if (copy_to_iter(&hdrv1, sizeof(struct virtio_net_hdr),
+					 &fixup) != sizeof(struct virtio_net_hdr)) {
 				vq_err(vq, "Unable to write vnet_hdr "
 				       "at addr %p\n", vq->iov->iov_base);
 				goto out;
@@ -1211,7 +1217,7 @@ static void handle_rx(struct vhost_net *net)
 			/* Header came from socket; we'll need to patch
 			 * ->num_buffers over if VIRTIO_NET_F_MRG_RXBUF
 			 */
-			iov_iter_advance(&fixup, sizeof(hdr));
+			iov_iter_advance(&fixup, sizeof(struct virtio_net_hdr));
 		}
 		/* TODO: Should check and handle checksum. */
 
@@ -1223,6 +1229,18 @@ static void handle_rx(struct vhost_net *net)
 			vhost_discard_vq_desc(vq, headcount);
 			goto out;
 		}
+		if (unlikely(extra_hlen)) {
+			if (unlikely(vhost_hlen)) {
+				if (copy_to_iter(&hdrv1.hash_value, extra_hlen,
+						&fixup) != extra_hlen) {
+					vq_err(vq, "Unable to write extra_hdr "
+					"at addr %p\n", vq->iov->iov_base);
+					goto out;
+				}
+			} else {
+				iov_iter_advance(&fixup, extra_hlen);
+			}
+		}
 		nvq->done_idx += headcount;
 		if (nvq->done_idx > VHOST_NET_BATCH)
 			vhost_net_signal_used(nvq);
@@ -1624,6 +1642,9 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 			       (1ULL << VIRTIO_F_VERSION_1))) ?
 			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
 			sizeof(struct virtio_net_hdr);
+	if (features & (1ULL << VIRTIO_NET_F_HASH_REPORT)) {
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash);
+	}
 	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
 		/* vhost provides vnet_hdr */
 		vhost_hlen = hdr_len;
-- 
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
