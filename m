Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C6C48BDF
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:40:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E8E613D6
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 09:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E8E613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7060B6066A;
	Fri, 18 Jun 2021 09:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZD4rwBUP9FY4; Fri, 18 Jun 2021 09:40:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C04FD60613;
	Fri, 18 Jun 2021 09:40:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D72BC000D;
	Fri, 18 Jun 2021 09:40:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5356C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7980B40477
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PbLS0KZojW6Z
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:40:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3698440388
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 09:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1624009202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OTgWym34MWOytQh3dCOiJZNfcSTFJBcg5/VEusdTLU=;
 b=ZdtXk6nosnkcRs0wDJU5YOYdRj5/NZ2W7RxVPA2dOzohJnaws7G3iewakCtshBbnqYH/oe
 edV5an5+YckDdrCipXyrrVlDrQFsjUz+v5Xu7byKgF+CkkYCs/jZS+/UDeNSQCjJxxTR2y
 0iVH9YmwMstKjE4Du8uPnFxMoKubnWw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-5WmbsILXNruC7EN4FGeD9w-1; Fri, 18 Jun 2021 05:39:58 -0400
X-MC-Unique: 5WmbsILXNruC7EN4FGeD9w-1
Received: by mail-ed1-f69.google.com with SMTP id
 h11-20020a50ed8b0000b02903947b9ca1f3so1423810edr.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 02:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9OTgWym34MWOytQh3dCOiJZNfcSTFJBcg5/VEusdTLU=;
 b=Lm/bcDPTWIGbLjq9+kdlkyac0cDHt0WB597mzd0JrkJTSHrshbHX3LvO9Ib2HbQSNh
 G+CLasS4nLWNdFpKL6ZybrdiJiMSPru9Uti3gqL4InfKC5EP0tKgQEe+50ovXxEulJ3e
 UA1h0DL9+JlJQSDVymN7zXbE7rVPUiWbD7vqQnOGL2IXA2HZXxPCufGf//Y8TcJwGep8
 dD2LspaMNrlMTFKO7wfckZY6kREhWgkSIwrWIS8ImnSnJvMhZefDK0FXFA98p2HIYzP1
 XenYOrT/bo+4yHS725zzWR+5J3xBCP7qHMZNEbQ5+RZJDEOhbND4uNoUMN6MZI8r4TAJ
 sEBA==
X-Gm-Message-State: AOAM533RDfTvobtdRUvOTTEnQbIKR7lMiK4LGvd5DXCJgQHn4bVR/0xL
 2EiUQznGnRQPsEkivu0uvtZS8LDWkzQJ2BqFGL9kTj0I5ezVDdy3GlSPngqNL7hGk3uxEuBULh7
 M4B67d1mrSIO9eb/LV0CHG9X6Pi3nQBvahYhYj7QJJQ==
X-Received: by 2002:a17:907:10d7:: with SMTP id
 rv23mr10004038ejb.163.1624009197508; 
 Fri, 18 Jun 2021 02:39:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTSy+T330jfiNVwwXxtw5wBYMmXh7NS4dAyo6bHcMvj8+O+LrLu6QAkLP5Y7ZJJZ2IwLSP8w==
X-Received: by 2002:a17:907:10d7:: with SMTP id
 rv23mr10004014ejb.163.1624009197332; 
 Fri, 18 Jun 2021 02:39:57 -0700 (PDT)
Received: from steredhat.lan ([5.170.128.252])
 by smtp.gmail.com with ESMTPSA id u12sm810511eje.40.2021.06.18.02.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 02:39:57 -0700 (PDT)
Date: Fri, 18 Jun 2021 11:39:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jiang Wang <jiang.wang@bytedance.com>
Subject: Re: [RFC v1 1/6] virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
Message-ID: <20210618093951.g32htj3rsu2koqi5@steredhat.lan>
References: <20210609232501.171257-1-jiang.wang@bytedance.com>
 <20210609232501.171257-2-jiang.wang@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210609232501.171257-2-jiang.wang@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jun 09, 2021 at 11:24:53PM +0000, Jiang Wang wrote:
>When this feature is enabled, allocate 5 queues,
>otherwise, allocate 3 queues to be compatible with
>old QEMU versions.
>
>Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
>---
> drivers/vhost/vsock.c             |  3 +-
> include/linux/virtio_vsock.h      |  9 +++++
> include/uapi/linux/virtio_vsock.h |  3 ++
> net/vmw_vsock/virtio_transport.c  | 73 +++++++++++++++++++++++++++++++++++----
> 4 files changed, 80 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 5e78fb719602..81d064601093 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -31,7 +31,8 @@
>
> enum {
> 	VHOST_VSOCK_FEATURES = VHOST_FEATURES |
>-			       (1ULL << VIRTIO_F_ACCESS_PLATFORM)
>+			       (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>+			       (1ULL << VIRTIO_VSOCK_F_DGRAM)
> };
>
> enum {
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index dc636b727179..ba3189ed9345 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -18,6 +18,15 @@ enum {
> 	VSOCK_VQ_MAX    = 3,
> };
>
>+enum {
>+	VSOCK_VQ_STREAM_RX     = 0, /* for host to guest data */
>+	VSOCK_VQ_STREAM_TX     = 1, /* for guest to host data */
>+	VSOCK_VQ_DGRAM_RX       = 2,
>+	VSOCK_VQ_DGRAM_TX       = 3,
>+	VSOCK_VQ_EX_EVENT       = 4,
>+	VSOCK_VQ_EX_MAX         = 5,
>+};
>+
> /* Per-socket state (accessed via vsk->trans) */
> struct virtio_vsock_sock {
> 	struct vsock_sock *vsk;
>diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
>index 1d57ed3d84d2..b56614dff1c9 100644
>--- a/include/uapi/linux/virtio_vsock.h
>+++ b/include/uapi/linux/virtio_vsock.h
>@@ -38,6 +38,9 @@
> #include <linux/virtio_ids.h>
> #include <linux/virtio_config.h>
>
>+/* The feature bitmap for virtio net */
>+#define VIRTIO_VSOCK_F_DGRAM	0	/* Host support dgram vsock */
>+
> struct virtio_vsock_config {
> 	__le64 guest_cid;
> } __attribute__((packed));
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..7dcb8db23305 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -27,7 +27,8 @@ static DEFINE_MUTEX(the_virtio_vsock_mutex); /* protects the_virtio_vsock */
>
> struct virtio_vsock {
> 	struct virtio_device *vdev;
>-	struct virtqueue *vqs[VSOCK_VQ_MAX];
>+	struct virtqueue **vqs;
>+	bool has_dgram;
>
> 	/* Virtqueue processing is deferred to a workqueue */
> 	struct work_struct tx_work;
>@@ -333,7 +334,10 @@ static int virtio_vsock_event_fill_one(struct virtio_vsock *vsock,
> 	struct scatterlist sg;
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_EVENT];
>+	if (vsock->has_dgram)
>+		vq = vsock->vqs[VSOCK_VQ_EX_EVENT];
>+	else
>+		vq = vsock->vqs[VSOCK_VQ_EVENT];
>
> 	sg_init_one(&sg, event, sizeof(*event));
>
>@@ -351,7 +355,10 @@ static void virtio_vsock_event_fill(struct virtio_vsock *vsock)
> 		virtio_vsock_event_fill_one(vsock, event);
> 	}
>
>-	virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
>+	if (vsock->has_dgram)
>+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EX_EVENT]);
>+	else
>+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
> }
>
> static void virtio_vsock_reset_sock(struct sock *sk)
>@@ -391,7 +398,10 @@ static void virtio_transport_event_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, event_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_EVENT];
>+	if (vsock->has_dgram)
>+		vq = vsock->vqs[VSOCK_VQ_EX_EVENT];
>+	else
>+		vq = vsock->vqs[VSOCK_VQ_EVENT];
>
> 	mutex_lock(&vsock->event_lock);
>
>@@ -411,7 +421,10 @@ static void virtio_transport_event_work(struct work_struct *work)
> 		}
> 	} while (!virtqueue_enable_cb(vq));
>
>-	virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
>+	if (vsock->has_dgram)
>+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EX_EVENT]);
>+	else
>+		virtqueue_kick(vsock->vqs[VSOCK_VQ_EVENT]);
> out:
> 	mutex_unlock(&vsock->event_lock);
> }
>@@ -434,6 +447,10 @@ static void virtio_vsock_tx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->tx_work);
> }
>
>+static void virtio_vsock_dgram_tx_done(struct virtqueue *vq)
>+{
>+}
>+
> static void virtio_vsock_rx_done(struct virtqueue *vq)
> {
> 	struct virtio_vsock *vsock = vq->vdev->priv;
>@@ -443,6 +460,10 @@ static void virtio_vsock_rx_done(struct virtqueue *vq)
> 	queue_work(virtio_vsock_workqueue, &vsock->rx_work);
> }
>
>+static void virtio_vsock_dgram_rx_done(struct virtqueue *vq)
>+{
>+}
>+
> static struct virtio_transport virtio_transport = {
> 	.transport = {
> 		.module                   = THIS_MODULE,
>@@ -545,13 +566,29 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 		virtio_vsock_tx_done,
> 		virtio_vsock_event_done,
> 	};
>+	vq_callback_t *ex_callbacks[] = {

'ex' is not clear, maybe better 'dgram'?

What happen if F_DGRAM is negotiated, but not F_STREAM?

>+		virtio_vsock_rx_done,
>+		virtio_vsock_tx_done,
>+		virtio_vsock_dgram_rx_done,
>+		virtio_vsock_dgram_tx_done,
>+		virtio_vsock_event_done,
>+	};
>+
> 	static const char * const names[] = {
> 		"rx",
> 		"tx",
> 		"event",
> 	};
>+	static const char * const ex_names[] = {
>+		"rx",
>+		"tx",
>+		"dgram_rx",
>+		"dgram_tx",
>+		"event",
>+	};
>+
> 	struct virtio_vsock *vsock = NULL;
>-	int ret;
>+	int ret, max_vq;
>
> 	ret = mutex_lock_interruptible(&the_virtio_vsock_mutex);
> 	if (ret)
>@@ -572,9 +609,30 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
>
> 	vsock->vdev = vdev;
>
>-	ret = virtio_find_vqs(vsock->vdev, VSOCK_VQ_MAX,
>+	if (virtio_has_feature(vdev, VIRTIO_VSOCK_F_DGRAM))
>+		vsock->has_dgram = true;
>+
>+	if (vsock->has_dgram)
>+		max_vq = VSOCK_VQ_EX_MAX;
>+	else
>+		max_vq = VSOCK_VQ_MAX;
>+
>+	vsock->vqs = kmalloc_array(max_vq, sizeof(struct virtqueue *), GFP_KERNEL);
>+	if (!vsock->vqs) {
>+		ret = -ENOMEM;
>+		goto out;
>+	}
>+
>+	if (vsock->has_dgram) {
>+		ret = virtio_find_vqs(vsock->vdev, max_vq,
>+			      vsock->vqs, ex_callbacks, ex_names,
>+			      NULL);
>+	} else {
>+		ret = virtio_find_vqs(vsock->vdev, max_vq,
> 			      vsock->vqs, callbacks, names,
> 			      NULL);
>+	}
>+
> 	if (ret < 0)
> 		goto out;
>
>@@ -695,6 +753,7 @@ static struct virtio_device_id id_table[] = {
> };
>
> static unsigned int features[] = {
>+	VIRTIO_VSOCK_F_DGRAM,
> };
>
> static struct virtio_driver virtio_vsock_driver = {
>-- 
>2.11.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
