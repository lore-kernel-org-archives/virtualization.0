Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AA0C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 10:11:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BF86103C
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 10:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30BF86103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DC8694032C;
	Thu, 28 Oct 2021 10:11:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WfNqxlwpqOFW; Thu, 28 Oct 2021 10:11:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3EB3F401FC;
	Thu, 28 Oct 2021 10:11:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27625C0012;
	Thu, 28 Oct 2021 10:11:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9646C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 10:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D858540413
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 10:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p3u8SRZnt9mR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 10:11:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 369E940233
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635415903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmVOjxLeJWEmyCqfs0Tb1bLYB+sc0BhB8/yHgn5Iolk=;
 b=TmPf1cKiBYdtp2Oc2UK8bpD2keg1FMvBzeINXYRGr1OrB/C303RV2elfNRPT5G3K2Nk7uN
 dMMmiHAdkuwkOcoCunetZb482mODlk9+V0xhzfgpkchvkxPk9agBYy717pOc9oqy7kRKUQ
 wh4j6m7OAFKS9KnFJdVrsIHzN2i+QYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-jX_5fmHnMCy2UBIWTqUp1w-1; Thu, 28 Oct 2021 06:11:37 -0400
X-MC-Unique: jX_5fmHnMCy2UBIWTqUp1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 135D710A8E00;
 Thu, 28 Oct 2021 10:11:36 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.39.194.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C02BE60CA0;
 Thu, 28 Oct 2021 10:11:31 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] hwrng: virtio - add an internal buffer
Date: Thu, 28 Oct 2021 12:11:08 +0200
Message-Id: <20211028101111.128049-2-lvivier@redhat.com>
In-Reply-To: <20211028101111.128049-1-lvivier@redhat.com>
References: <20211028101111.128049-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, amit@kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, rusty@rustcorp.com.au,
 virtualization@lists.linux-foundation.org,
 Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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

hwrng core uses two buffers that can be mixed in the
virtio-rng queue.

If the buffer is provided with wait=0 it is enqueued in the
virtio-rng queue but unused by the caller.
On the next call, core provides another buffer but the
first one is filled instead and the new one queued.
And the caller reads the data from the new one that is not
updated, and the data in the first one are lost.

To avoid this mix, virtio-rng needs to use its own unique
internal buffer at a cost of a data copy to the caller buffer.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index a90001e02bf7..208c547dcac1 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
 struct virtrng_info {
 	struct hwrng hwrng;
 	struct virtqueue *vq;
-	struct completion have_data;
 	char name[25];
-	unsigned int data_avail;
 	int index;
 	bool busy;
 	bool hwrng_register_done;
 	bool hwrng_removed;
+	/* data transfer */
+	struct completion have_data;
+	unsigned int data_avail;
+	/* minimal size returned by rng_buffer_size() */
+#if SMP_CACHE_BYTES < 32
+	u8 data[32];
+#else
+	u8 data[SMP_CACHE_BYTES];
+#endif
 };
 
 static void random_recv_done(struct virtqueue *vq)
@@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
 }
 
 /* The host will fill any buffer we give it with sweet, sweet randomness. */
-static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
+static void register_buffer(struct virtrng_info *vi)
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, buf, size);
+	sg_init_one(&sg, vi->data, sizeof(vi->data));
 
 	/* There should always be room for one buffer. */
-	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
+	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
 
 	virtqueue_kick(vi->vq);
 }
@@ -55,6 +62,8 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 {
 	int ret;
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
+	unsigned int chunk;
+	size_t read;
 
 	if (vi->hwrng_removed)
 		return -ENODEV;
@@ -62,19 +71,33 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	if (!vi->busy) {
 		vi->busy = true;
 		reinit_completion(&vi->have_data);
-		register_buffer(vi, buf, size);
+		register_buffer(vi);
 	}
 
 	if (!wait)
 		return 0;
 
-	ret = wait_for_completion_killable(&vi->have_data);
-	if (ret < 0)
-		return ret;
+	read = 0;
+	while (size != 0) {
+		ret = wait_for_completion_killable(&vi->have_data);
+		if (ret < 0)
+			return ret;
+
+		chunk = min_t(unsigned int, size, vi->data_avail);
+		memcpy(buf + read, vi->data, chunk);
+		read += chunk;
+		size -= chunk;
+		vi->data_avail = 0;
+
+		if (size != 0) {
+			reinit_completion(&vi->have_data);
+			register_buffer(vi);
+		}
+	}
 
 	vi->busy = false;
 
-	return vi->data_avail;
+	return read;
 }
 
 static void virtio_cleanup(struct hwrng *rng)
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
