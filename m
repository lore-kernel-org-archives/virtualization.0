Return-Path: <SRS0=LSNt=OE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFF5C433FE
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 05:55:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B946560F6D
	for <virtualization@archiver.kernel.org>; Tue, 14 Sep 2021 05:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B946560F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F18E607DE;
	Tue, 14 Sep 2021 05:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEYH_CFfjGqs; Tue, 14 Sep 2021 05:55:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DF6BF607C9;
	Tue, 14 Sep 2021 05:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9D6FC0011;
	Tue, 14 Sep 2021 05:55:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ACA3C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B897607D9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FxrtbJE_b0pU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13FD8607C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 05:55:23 +0000 (UTC)
Received: by mail-pg1-x530.google.com with SMTP id e7so11726877pgk.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fcrREBHmUss8HUTYx3tNLzB0BZ/FP/l7HKKTmPrsNB0=;
 b=g8225Mo4a48P+CZC64h/29+Mrj5CMYapoXxB6t3Q8hqT/hIbf/ybQ/zOm1Mj1DCdzR
 AGqxPG34/pJm+uVVr3VYNgwu0O8oJkCJ1IJQ7KxQcnHGX/XvOZOQ9/rzx1MXKBzRjVO2
 2zFCnzovaRErZIMGVpBYTCcqb2nCdMooQyq6U9DQkFDOUoNOdW2G/aRsZ5l5fVR87FO7
 3VBB8kJ7j0d5Ggk8bEqPYA0JNtgn/DgV9GZPIg+DOVzM+BIGIcdBwZPZ1vglavSpaoFC
 xYjW/V0yLUaZ7G/TYw6MiryPR4CHi8EKzVH4T1zFKpISXVI/Eu8WO1GsMgPgLoK3Y+Js
 73Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fcrREBHmUss8HUTYx3tNLzB0BZ/FP/l7HKKTmPrsNB0=;
 b=gG47+XwpZFrU7EJmijb1He8DVGRYcPqgFDtOUEYMJB8b9A+2+MrfWl+ZhzW4k2PXr7
 tPSWmL+pRHV0i4BQtc1UPaC2+1xezesqXnCqAzziJLZAN4ClnmHYYLdRFkx8gek10vfY
 TBDweGZspgXD0A7Ff4DwT+8C0DSgUI0kw0FZHYK/uqwoJFO3hILHXwxJAyKLhzDpXRtj
 VmoU/TG0WrSZhEM7JFeKwAnwQSTJc4rZjgAdoxZuxgUtVnw1obnlnC6Ijagmd7dxPuiP
 ngG3tgggl2hpymiDtQmeYyJOYUEzNb43f5AZjY5xMIx1fhz+egPWu51K4eT1eOXHjKnk
 gvMQ==
X-Gm-Message-State: AOAM533mfdCvwOIFwtgHKBf4WqWLmzQWBm3fDUO/CvMrRe+/vKsH/uYJ
 6OKUy+rc3AAnWDf8Oi7C5T4Bfw==
X-Google-Smtp-Source: ABdhPJx1lRSMYoXfZ7QwZluqQ2H35nMPToRIhOxCTMYPW4JwOzZ+KXvDJmRHHGEPRLfI4tlcypSidw==
X-Received: by 2002:a63:ec06:: with SMTP id j6mr14261115pgh.259.1631598923320; 
 Mon, 13 Sep 2021 22:55:23 -0700 (PDT)
Received: from ip-10-124-121-13.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id v14sm719432pfi.111.2021.09.13.22.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 22:55:22 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: jiangleetcode@gmail.com
Subject: [RFC v2 1/5] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Date: Tue, 14 Sep 2021 05:54:34 +0000
Message-Id: <20210914055440.3121004-2-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210914055440.3121004-1-jiang.wang@bytedance.com>
References: <20210914055440.3121004-1-jiang.wang@bytedance.com>
MIME-Version: 1.0
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, stefanha@redhat.com,
 Jakub Kicinski <kuba@kernel.org>, arseny.krasnov@kaspersky.com,
 Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 jhansen@vmware.com
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

When this feature is enabled, allocate 5 queues,
otherwise, allocate 3 queues to be compatible with
old QEMU versions.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 drivers/vhost/vsock.c             |  3 +-
 include/linux/virtio_vsock.h      |  9 ++++
 include/uapi/linux/virtio_vsock.h |  2 +
 net/vmw_vsock/virtio_transport.c  | 79 +++++++++++++++++++++++++++----
 4 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index f249622ef11b..c79789af0365 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -32,7 +32,8 @@
 enum {
 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
 			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET)
+			       (1ULL << VIRTIO_VSOCK_F_SEQPACKET) |
+			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
 };
 
 enum {
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 35d7eedb5e8e..87d849aeb3ec 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -18,6 +18,15 @@ enum {
 	VSOCK_VQ_MAX    = 3,
 };
 
+enum {
+	VSOCK_VQ_STREAM_RX     = 0, /* for host to guest data */
+	VSOCK_VQ_STREAM_TX     = 1, /* for guest to host data */
+	VSOCK_VQ_DGRAM_RX       = 2,
+	VSOCK_VQ_DGRAM_TX       = 3,
+	VSOCK_VQ_EX_EVENT       = 4,
+	VSOCK_VQ_EX_MAX         = 5,
+};
+
 /* Per-socket state (accessed via vsk->trans) */
 struct virtio_vsock_sock {
 	struct vsock_sock *vsk;
diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 3dd3555b2740..cff54ba9b924 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -40,6 +40,8 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+/* The feature bitmap for virtio net */
+#define VIRTIO_VSOCK_F_DGRAM	0	/* Host support dgram vsock */
 
 struct virtio_vsock_config {
 	__le64 guest_cid;
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f7c99dfd16c..bb89f538f5f3 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -27,7 +27,8 @@ static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
 
 struct virtio_vsock {
 	struct virtio_device *vdev;
-	struct virtqueue *vqs[VSOCK_VQ_MAX];
+	struct virtqueue **vqs;
+	bool has_dgram;
 
 	/* Virtqueue processing is deferred to a workqueue */
 	struct work_struct tx_work;
@@ -334,7 +335,10 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
 	struct scatterlist sg;
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
+	if (vsock->has_dgram)
+		vq = vsock->vqs[VSOCK_VQ_EX_EVENT];
+	else
+		vq = vsock->vqs[VSOCK_VQ_EVENT];
 
 	sg_init_one(&sg, event, sizeof(*event));
 
@@ -352,7 +356,10 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
 		virtio_vsock_event_fill_one(vsock, event);
 	}
 
-	virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
+	if (vsock->has_dgram)
+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EX_EVENT]);
+	else
+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
 }
 
 static void virtio_vsock_reset_sock(struct sock *sk)
@@ -395,7 +402,10 @@ static void virtio_transport_event_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, event_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
+	if (vsock->has_dgram)
+		vq = vsock->vqs[VSOCK_VQ_EX_EVENT];
+	else
+		vq = vsock->vqs[VSOCK_VQ_EVENT];
 
 	mutex_lock(&vsock->event_lock);
 
@@ -415,7 +425,10 @@ static void virtio_transport_event_work(struct work_struct *work)
 		}
 	} while (!virtqueue_enable_cb(vq));
 
-	virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
+	if (vsock->has_dgram)
+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EX_EVENT]);
+	else
+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
 out:
 	mutex_unlock(&vsock->event_lock);
 }
@@ -438,6 +451,10 @@ static void virtio_vsock_tx_done(struct virtqueue *vq)
 	queue_work(virtio_vsock_workqueue, &vsock->tx_work);
 }
 
+static void virtio_vsock_dgram_tx_done(struct virtqueue *vq)
+{
+}
+
 static void virtio_vsock_rx_done(struct virtqueue *vq)
 {
 	struct virtio_vsock *vsock = vq->vdev->priv;
@@ -449,6 +466,10 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
 
 static bool virtio_transport_seqpacket_allow(u32 remote_cid);
 
+static void virtio_vsock_dgram_rx_done(struct virtqueue *vq)
+{
+}
+
 static struct virtio_transport virtio_transport = {
 	.transport = {
 		.module                   = THIS_MODULE,
@@ -571,13 +592,29 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 		virtio_vsock_tx_done,
 		virtio_vsock_event_done,
 	};
+	vq_callback_t *ex_callbacks[] = {
+		virtio_vsock_rx_done,
+		virtio_vsock_tx_done,
+		virtio_vsock_dgram_rx_done,
+		virtio_vsock_dgram_tx_done,
+		virtio_vsock_event_done,
+	};
+
 	static const char * const names[] = {
 		"rx",
 		"tx",
 		"event",
 	};
+	static const char * const ex_names[] = {
+		"rx",
+		"tx",
+		"dgram_rx",
+		"dgram_tx",
+		"event",
+	};
+
 	struct virtio_vsock *vsock = NULL;
-	int ret;
+	int ret, max_vq;
 
 	ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
 	if (ret)
@@ -598,9 +635,30 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	vsock->vdev = vdev;
 
-	ret = virtio_find_vqs(vsock->vdev, VSOCK_VQ_MAX,
-			      vsock->vqs, callbacks, names,
-			      NULL);
+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
+		vsock->has_dgram = true;
+
+	if (vsock->has_dgram)
+		max_vq = VSOCK_VQ_EX_MAX;
+	else
+		max_vq = VSOCK_VQ_MAX;
+
+	vsock->vqs = kmalloc_array(max_vq, sizeof(struct virtqueue *), GFP_KERNEL);
+	if (!vsock->vqs) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (vsock->has_dgram) {
+		ret = virtio_find_vqs(vsock->vdev, max_vq,
+				      vsock->vqs, ex_callbacks, ex_names,
+				      NULL);
+	} else {
+		ret = virtio_find_vqs(vsock->vdev, max_vq,
+				      vsock->vqs, callbacks, names,
+				      NULL);
+	}
+
 	if (ret < 0)
 		goto out;
 
@@ -725,7 +783,8 @@ static struct virtio_device_id id_table[] = {
 };
 
 static unsigned int features[] = {
-	VIRTIO_VSOCK_F_SEQPACKET
+	VIRTIO_VSOCK_F_SEQPACKET,
+	VIRTIO_VSOCK_F_DGRAM
 };
 
 static struct virtio_driver virtio_vsock_driver = {
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
