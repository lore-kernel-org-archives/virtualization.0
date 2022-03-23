Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DE7C433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 17:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C4C5400E2;
	Wed, 23 Mar 2022 17:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gT01N5xodDSb; Wed, 23 Mar 2022 17:36:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E889940C2B;
	Wed, 23 Mar 2022 17:36:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF1C6C001A;
	Wed, 23 Mar 2022 17:36:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CB52C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B500613D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sjao3KLewzDh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1851A607E1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 17:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648056997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/auHUunRKmj44ZRhZ4Uljn8hCNOGxN6qXBgu6Qo8Sg=;
 b=UyrNdnWvpydwYo9+WJNDu1xsS/doXU99Z+eTBeEPxjcmpQ7o/B0tZ3tsM8ehV9EKZRXKl2
 fHcQRDLl3ss65G937wXet9xxQVic9OWiyErQk2vXPcDIv0F1ZaeaLWRst1WbZnHlZNW+W2
 LAi8sc+AtFK4T8ky2XGfqfanhqo9+TU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-A_NOy1sROS6_dVsAzOfR3w-1; Wed, 23 Mar 2022 13:36:36 -0400
X-MC-Unique: A_NOy1sROS6_dVsAzOfR3w-1
Received: by mail-qt1-f199.google.com with SMTP id
 g22-20020ac870d6000000b002e20a1508ecso1729821qtp.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 10:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B/auHUunRKmj44ZRhZ4Uljn8hCNOGxN6qXBgu6Qo8Sg=;
 b=7oewj1fQb/q/gNhgxPHTPgRbtD11pOEzZTkB1cfuYlH2wfd6KmUfHpt3+o4adgCW1/
 jXulQ91/gZgMchphGnkZ2w+5BxoZ2rL9LPh+rf6cm3iMaXNm9EGp9SxNooQvvWvmLVsV
 VgJQVm3yditmY+vMA0VJOba0hWE4RajImnaH9+pmRhoikOMDj5dJfBAjTDW9owRIEuFw
 s29THxbakIxAMIn1dJnmem5V5eIbyyq6ukgTxMl3LR2SmaO5g36g02vGYF7tecejr4t2
 S11epNJvQ9hy+C7ghq/UD4HpwS41OLsURjU+QTwZTAy8kU685ukrlKK6c6JQwzyYoK98
 FPpA==
X-Gm-Message-State: AOAM532nxNsW77fgHGF5xtgOx8TBJz27BPRqpioifyxN7rqvPc9N03Zx
 t+7qeudNRjIev+HwwLYZq3j8gidZNy7r+YKxN5j7YRgIjtvG5D+Getgj9olmK12JhW0R9/1iuW+
 X0wieLBJoIZraiA0Vl1d/mWHFFrHlkHTgTgvjHrsUdQ==
X-Received: by 2002:a05:620a:15cf:b0:67d:f378:5cf8 with SMTP id
 o15-20020a05620a15cf00b0067df3785cf8mr745284qkm.354.1648056995705; 
 Wed, 23 Mar 2022 10:36:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTUiRkn6eha8XU1o1IqDFFHEY3objSBoDDAqSNfC0KM2Zb1piJWjlVMzOTuJp+NKhZ0Bg0SA==
X-Received: by 2002:a05:620a:15cf:b0:67d:f378:5cf8 with SMTP id
 o15-20020a05620a15cf00b0067df3785cf8mr745251qkm.354.1648056995111; 
 Wed, 23 Mar 2022 10:36:35 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it.
 [87.12.25.114]) by smtp.gmail.com with ESMTPSA id
 h14-20020a05622a170e00b002e1a65754d8sm476127qtk.91.2022.03.23.10.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 10:36:34 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Subject: [PATCH net v3 1/3] vsock/virtio: initialize vdev->priv before using
 VQs
Date: Wed, 23 Mar 2022 18:36:23 +0100
Message-Id: <20220323173625.91119-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323173625.91119-1-sgarzare@redhat.com>
References: <20220323173625.91119-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Asias He <asias@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Arseny Krasnov <arseny.krasnov@kaspersky.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

When we fill VQs with empty buffers and kick the host, it may send
an interrupt. `vdev->priv` must be initialized before this since it
is used in the virtqueue callbacks.

Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5afc194a58bb..3e5513934c9f 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -622,6 +622,8 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
 	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
 
+	vdev->priv = vsock;
+
 	mutex_lock(&vsock->tx_lock);
 	vsock->tx_run = true;
 	mutex_unlock(&vsock->tx_lock);
@@ -639,7 +641,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_SEQPACKET))
 		vsock->seqpacket_allow = true;
 
-	vdev->priv = vsock;
 	rcu_assign_pointer(the_virtio_vsock, vsock);
 
 	mutex_unlock(&the_virtio_vsock_mutex);
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
