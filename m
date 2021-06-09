Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6D1C48BCF
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 23:27:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93153613DF
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 23:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93153613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 570FB400AB;
	Wed,  9 Jun 2021 23:27:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cf7yIK0HUG6; Wed,  9 Jun 2021 23:27:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4B2A402CC;
	Wed,  9 Jun 2021 23:27:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0E63C000E;
	Wed,  9 Jun 2021 23:27:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 050DBC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC38C605FB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 86hGlbX21QEM
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30C456066F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 23:27:30 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id k5so2534357pjj.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 16:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r8XBgJHTxrXFtSMQVzajzu+b1SL5llDzrX12khypvWk=;
 b=YRp7IbdiWcuBxknxIpOMnDJBEqWlQkSzds59gCQC/neXQhUv7TodzzMSjgPebbno6v
 DjYtvf2iGHZWtfrc1ZY7XrNh9THCH3+dTY57Ufq0FRt9WuV2NGz7tO4FvkTSL6kP9dQb
 YFDp5qCH3kq64w1N/wuk1gyt1TomnS5CRnzbnnaSSAAWWrMepYoAqxZpePjXNOnr4CGM
 upjKyAfXyekQquGm3/9krmhcaC22r9RUTuAYOXln8dpgUtmWIT7kEgECjxwr/cqfkDg/
 SDH0Nljo1ngY+lDXrpnv+w8fSbJOQfWdkolvfJPtsjrPoJny916dQwU8bPq2Rlob5eTP
 cXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=r8XBgJHTxrXFtSMQVzajzu+b1SL5llDzrX12khypvWk=;
 b=BXnanDoW8W3P0k9++tOu2WO2jcMl7xzWuJFdw5Es7LZ6fo8Rhcewyb3zKM5xOicnv4
 hiJ+7w/AWJqPeWFpMMFIRGcVZx20ps3XEdwkj6nx3DvqorVDEJbCy7KD70b0fgyX9m90
 ECtvZiEr0UE6jrAdQmpgG29PQRliRnbwQfGBvNaI6kqRj9TcCPtOTKj5jsonSUipBwCe
 mMa431N9KlRm2Q5T7fe2NdNS6sOhpDXp8+ND0S3rFbPG4K/p/oj9KOtzkgTO53VzSUXr
 2aQLKW/W8UViSCi74uGGFtNRINY9rg/LFpcpXV8IC8k0ZmPkxZzj+9W4alzihYA2IE9U
 Z+2A==
X-Gm-Message-State: AOAM532M3tvj4UtxSYCs3JIK3m4GqMtUESKedeAgToPdxLkrWfMbuaIc
 IheQ3vfQtdx5/YChSSiSKWeZcg==
X-Google-Smtp-Source: ABdhPJyxFSEKnaZ2ltvDInR67Ojfj4gWGKonXTvsJqyjudBs7otrxqn/jyoKEjVRgmlZu3AziO1Q1g==
X-Received: by 2002:a17:90a:f317:: with SMTP id
 ca23mr154709pjb.174.1623281249606; 
 Wed, 09 Jun 2021 16:27:29 -0700 (PDT)
Received: from n124-121-013.byted.org
 (ec2-54-241-92-238.us-west-1.compute.amazonaws.com. [54.241.92.238])
 by smtp.gmail.com with ESMTPSA id k1sm526783pfa.30.2021.06.09.16.27.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Jun 2021 16:27:29 -0700 (PDT)
From: Jiang Wang <jiang.wang@bytedance.com>
To: sgarzare@redhat.com
Subject: [RFC v1 1/6] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Date: Wed,  9 Jun 2021 23:24:53 +0000
Message-Id: <20210609232501.171257-2-jiang.wang@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210609232501.171257-1-jiang.wang@bytedance.com>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
Cc: cong.wang@bytedance.com, duanxiongchun@bytedance.com,
 Ingo Molnar <mingo@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, Norbert Slusarek <nslusarek@gmx.net>,
 stefanha@redhat.com, Colin Ian King <colin.king@canonical.com>,
 Jakub Kicinski <kuba@kernel.org>, arseny.krasnov@kaspersky.com,
 Alexander Popov <alex.popov@linux.com>, jhansen@vmware.comments,
 "David S. Miller" <davem@davemloft.net>, Andra Paraschiv <andraprs@amazon.com>
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

When this feature is enabled, allocate 5 queues,
otherwise, allocate 3 queues to be compatible with
old QEMU versions.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
---
 drivers/vhost/vsock.c             |  3 +-
 include/linux/virtio_vsock.h      |  9 +++++
 include/uapi/linux/virtio_vsock.h |  3 ++
 net/vmw_vsock/virtio_transport.c  | 73 +++++++++++++++++++++++++++++++++++----
 4 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 5e78fb719602..81d064601093 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -31,7 +31,8 @@
 
 enum {
 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
-			       (1ULL << VIRTIO_F_ACCESS_PLATFORM)
+			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
+			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
 };
 
 enum {
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index dc636b727179..ba3189ed9345 100644
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
index 1d57ed3d84d2..b56614dff1c9 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -38,6 +38,9 @@
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
+/* The feature bitmap for virtio net */
+#define VIRTIO_VSOCK_F_DGRAM	0	/* Host support dgram vsock */
+
 struct virtio_vsock_config {
 	__le64 guest_cid;
 } __attribute__((packed));
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 2700a63ab095..7dcb8db23305 100644
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
@@ -333,7 +334,10 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
 	struct scatterlist sg;
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
+	if (vsock->has_dgram)
+		vq = vsock->vqs[VSOCK_VQ_EX_EVENT];
+	else
+		vq = vsock->vqs[VSOCK_VQ_EVENT];
 
 	sg_init_one(&sg, event, sizeof(*event));
 
@@ -351,7 +355,10 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
 		virtio_vsock_event_fill_one(vsock, event);
 	}
 
-	virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
+	if (vsock->has_dgram)
+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EX_EVENT]);
+	else
+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
 }
 
 static void virtio_vsock_reset_sock(struct sock *sk)
@@ -391,7 +398,10 @@ static void virtio_transport_event_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, event_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
+	if (vsock->has_dgram)
+		vq = vsock->vqs[VSOCK_VQ_EX_EVENT];
+	else
+		vq = vsock->vqs[VSOCK_VQ_EVENT];
 
 	mutex_lock(&vsock->event_lock);
 
@@ -411,7 +421,10 @@ static void virtio_transport_event_work(struct work_struct *work)
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
@@ -434,6 +447,10 @@ static void virtio_vsock_tx_done(struct virtqueue *vq)
 	queue_work(virtio_vsock_workqueue, &vsock->tx_work);
 }
 
+static void virtio_vsock_dgram_tx_done(struct virtqueue *vq)
+{
+}
+
 static void virtio_vsock_rx_done(struct virtqueue *vq)
 {
 	struct virtio_vsock *vsock = vq->vdev->priv;
@@ -443,6 +460,10 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
 }
 
+static void virtio_vsock_dgram_rx_done(struct virtqueue *vq)
+{
+}
+
 static struct virtio_transport virtio_transport = {
 	.transport = {
 		.module                   = THIS_MODULE,
@@ -545,13 +566,29 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
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
@@ -572,9 +609,30 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	vsock->vdev = vdev;
 
-	ret = virtio_find_vqs(vsock->vdev, VSOCK_VQ_MAX,
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
+			      vsock->vqs, ex_callbacks, ex_names,
+			      NULL);
+	} else {
+		ret = virtio_find_vqs(vsock->vdev, max_vq,
 			      vsock->vqs, callbacks, names,
 			      NULL);
+	}
+
 	if (ret < 0)
 		goto out;
 
@@ -695,6 +753,7 @@ static struct virtio_device_id id_table[] = {
 };
 
 static unsigned int features[] = {
+	VIRTIO_VSOCK_F_DGRAM,
 };
 
 static struct virtio_driver virtio_vsock_driver = {
-- 
2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
