Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1A434991
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907114; cv=none; b=hs4Xz3+LXLKBCjtkGJp1dRBwJQWg3H0Vos3cZ4QjIxC/8QORayXcuQNx3GzkomgQl0VTJsTN/rZjtCERzdIDeHRhGQniDkW+X4C2nDe5OiV1mTARX+3mCGgLTWB7+JbR7L84It/nzXs0VTsgTSE4PH53MspGTf1nG+xGvdfwlQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907114; c=relaxed/simple;
	bh=/U5AIbq6dpv9hYmCEtYWD/LG4LRF7AuC0v8lt9FBAFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvkTBqPJiWtO1sHF/4306yv2QY3vQYexVibc4SG1dqKve9okZYvBmKJpVdjpS8EyAu8v0km6djnAWT+qu+4xyxSSiqNpuvEpW7z94b4Dbyv7Kcq9Vo8Q/SwTN322WHnkfJOmoKktO80yPZxG4BYmoojnwlAld1wpt67Fjj3uiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=acCQDNFs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nmm5MBPN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="acCQDNFs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nmm5MBPN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KBnnrB1761015
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JXnBYwBrV/5
	ZgHaXuhnSHXfV+y8bvDojjxpiwpZmEhE=; b=acCQDNFsvm9WSUfqgYZADNthi8m
	/uge79uOz95wTYj6x4RfHJFcc2ECmMqbSWI0WvO0EwjCBSkFgkcBTYkvaBRwgQN0
	9c/zEJTxBX+YQYi7aQAs0ScM6uEYF7btICn7WfzWL6bjohRe5bAIsFr4CsxvX6vo
	vN2HJt4JZbkuhks9di6XQpym8r9/txW9Jv1I+3kEYI/B0AMS4ZRUyDSsxrrJuF2N
	UJiM2VlpynlOHmqblPL5B8H4Ov99Vfmn6sXgLDq74DNZocXRwcS2JrMtoJSQxhJo
	COg7eemr03viYursGy6Cx5M+DlFZw+GFa/ULn9/aliBlrBnSskLd7qf2UBg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsk5ejv81-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:24:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94a158dc8so40473115ad.2
        for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789907098; x=1790511898; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JXnBYwBrV/5ZgHaXuhnSHXfV+y8bvDojjxpiwpZmEhE=;
        b=Nmm5MBPN9DWcknnzlmykWVom/o2THg5zQsFUg9PhoavbcsSV8JWgziIgFcqasuYEq7
         sm/DW5CRVZ7HXbzsAtOkwQJ28UxNXzexE3UAAmPpJfQuqTkK1PBNgt55EWDzOz7D20Q9
         xyLfFCoGpte7B+pey3lnLRlIWctZzXKJJ6nVgtt+g19v5GlLuc6O5//NS7ZCFlFw5KlO
         P7bp6txAQbthBZKZCtKHeyevPzqiDo/JAjCnYEG9jw2sXxF1GACyjcXXlz4nDVSC4Cs/
         tfBnabPIvvh9KWpXo19qhly7t2TrLpWIaZBn4S4wJSPUpgAVEPfkpwAnKsi44Syn1Deq
         meCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789907098; x=1790511898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JXnBYwBrV/5ZgHaXuhnSHXfV+y8bvDojjxpiwpZmEhE=;
        b=t/CTusOM+Wno4yeGaOOh7l2xOb1sID7RN6aHsVZ7qWCv6a7ect7keUzLzeSzSqJtqo
         /CS9fo9QCfvE7Ola5KjMyod2qCSN+51Ss1PwqBCGWwYp+9Ka5OMOORb+SXcFJ++Rpts6
         NygOwz24y44GHsdpfAltLZkcKmJ9MgYhqVwouypUXiW+9DdMrSvMAoWBuTyd/5QILDj9
         WDp6pA9jeaPRslgYz1/X3ewNW57MjijsxQKSkda5SIbIPH+PBGW96j8QyRX6X5r8fCNc
         5a2rEh8z/iEB78fwavmv7aTLJ3SWLvrKMYwZa9rmZiGu+v+xiMXFpkpo/O3SqayHtC8n
         ovXQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF3MRpEC2Q3x6pRJmVrzEkapy95uZd+8vLfLEd0J2qyJeeyYa6vZroCbjFVH1rxf7LiiRfLiHZSK4j+F5n+g==@lists.linux.dev
X-Gm-Message-State: AFuF++nlCtkpbY8eOII6eyn20f/eO5U9YOlfSQAS8mNG83LQhN8srvAX
	ltX46G1tpdbjuGew3eQU443B4PrfebRyS6E7elq6jvxmmPa1k1UfI1kBXG/9/dqvAlnyYW1HekY
	Lc5VmbN6dF1RbPQBMi6qUHw/d+I3BlnJ3lWZauCWvjlJKYMlFtjL+244rMxobqJXjDZ0zZQ==
X-Gm-Gg: AYBFou0G+tM8RIKFVVFk+hWmZetb2syBqPMeODnQwZ1QyhNJ2OwEl6y4/lilGpFYg79
	d+wn+bcmw3rkbLun29O60VaNE+vLbf226WzTQX0OIM33qwVEn+orE2z94xrIZifNWUOIRg8nzRY
	MNA3YQvxh/hczkemy+LJ7fe1aV15Muocv/mtnQT1q9vQxD8QrXGJ9+BOFJvSL2qKYdISWHJbaUI
	hBuNCFAfmrVpjH9qhxfHUVkUTA6ur5LyC1Ge7ucTPBIqjyv5HurpRmHlUMo23mZdqatWGYjDSKY
	VKUgLTjlNNvToyAl3akeLNJABwHcHiqpaV+q1Z+MKI9rDJZR6hWPr6a0OsRgIjBCp2RSjPjpmY5
	9RlEs1Wdc0ZCUiGu4qZ5iDQ85yeOgSYxsP09IA9DYgNlTmYcQG7XB2qxBFw==
X-Received: by 2002:a17:903:3c70:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2ddb1aca947mr136164335ad.1.1789907097862;
        Sun, 20 Sep 2026 05:24:57 -0700 (PDT)
X-Received: by 2002:a17:903:3c70:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2ddb1aca947mr136164035ad.1.1789907097339;
        Sun, 20 Sep 2026 05:24:57 -0700 (PDT)
Received: from u24-san1p10108.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aef9bsm12007386eec.25.2026.09.20.05.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 05:24:57 -0700 (PDT)
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
To: mst@redhat.com, jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
        stefanha@redhat.com
Cc: pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] virtio_blk: Add control virtqueue support
Date: Sun, 20 Sep 2026 05:24:31 -0700
Message-ID: <20260920122444.2549493-2-linlin.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
References: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tHzNU9oKMS4bVQY7wriPB8As2CvAiIbC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE4MCBTYWx0ZWRfX9YueZ1XH5c+r
 xzxuKbRWsYigu0JHLm2GQs330EGjcqeABrJzNA4iONypdiUzjU7Ntkle0Xe9iyhsypw+/QTYIpB
 mOoNSyMEZG+847O5onQA40hNgRKUiVCGnN0brQ6NQEq6XJ4JnbP7cZrtWWyeNkWmDWVmzt4aXgA
 q6st9j3aVo7msffRGMwUxsy4K8PdvOK0gTr7sSET0lHd+tscxgIMQpyJ8azhuJUSpr+Oumnzs8H
 ZWMzcUsx+n02CxnxBBbQ1hhzXgcHtw7DugqWT0iBzfMdDz74dU2SMeEgJRBnytrx9Q9UcyKfJWE
 sOD5MBSX03/02PqfLrKPA0kUW4su33xHKw3GHiwmmMhTwAEmrkpmdV5qHyAdWjgJMVBYsTuafBD
 bVjHzBLQhLUgqLGcKZphjuhKPxcGkY/gSSFyOTxmNBRfiyQImODuSP+5uKc0SPb37cEioFk98Ph
 IhFE5Tw8Pe/cv4UnHUw==
X-Authority-Analysis: v=2.4 cv=f8Ddl+yM c=1 sm=1 tr=0 ts=6aafd09a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=mWMrKjBDJ3x8XhIyD1MA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE4MCBTYWx0ZWRfX6V5/WGXcgoG6
 uAwBuZelm09rW7C0G9B5BkQff0oPg00GvyxEC+NRAwbneVL8//1TcgQcpEm4ZgLSeS4STRaXUsK
 Og7g/uJNxq7QC3gk6/BF2pAu2SrC4eo=
X-Proofpoint-ORIG-GUID: tHzNU9oKMS4bVQY7wriPB8As2CvAiIbC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200180

From: linlzhan <linlin.zhang@oss.qualcomm.com>

Add support for the optional virtio-blk control virtqueue.

If control queue feature bit is negociated, this allows the driver
to manage control-queue requests independently from the data path
and to safely handle outstanding requests during device removal
and suspend.

No control command is submitted by this change. The control virtqueue
will be used by a subsequent inline encryption implementation.

Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
---
 drivers/block/virtio_blk.c      | 241 +++++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_blk.h |   1 +
 2 files changed, 238 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9d..2fad86e8f7a9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -6,6 +6,7 @@
 #include <linux/hdreg.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/virtio.h>
 #include <linux/virtio_blk.h>
@@ -52,6 +53,15 @@ struct virtio_blk_vq {
 	char name[VQ_NAME_LEN];
 } ____cacheline_aligned_in_smp;
 
+struct virtio_blk_ctrl_vq {
+	struct virtqueue *vq;
+	struct mutex mutex;
+	spinlock_t lock;
+	unsigned int inflight;
+	bool dead;
+	struct completion drained;
+};
+
 struct virtio_blk {
 	/*
 	 * This mutex must be held by anything that may run after
@@ -83,6 +93,9 @@ struct virtio_blk {
 
 	/* For zoned device */
 	unsigned int zone_sectors;
+
+	/* Control virtqueue state. */
+	struct virtio_blk_ctrl_vq ctrl_vq;
 };
 
 struct virtblk_req {
@@ -110,6 +123,20 @@ struct virtblk_req {
 	struct scatterlist sg[];
 };
 
+struct virtblk_ctrl_request {
+	__virtio32 type;
+	u8 status;
+
+	struct completion *compl;
+	/*
+	 * Set when virtblk_ctrl_vq_request()'s waiter timed out and moved on
+	 * without freeing this request. Whichever of virtblk_ctrlq_callback()
+	 * or virtblk_ctrl_vq_drain() later retrieves the buffer must free
+	 * @compl and this struct instead of calling complete() on them.
+	 */
+	bool abandoned;
+};
+
 static inline blk_status_t virtblk_result(u8 status)
 {
 	switch (status) {
@@ -863,11 +890,184 @@ static int virtblk_getgeo(struct gendisk *disk, struct hd_geometry *geo)
 	return ret;
 }
 
+#define VIRTBLK_CTRL_VQ_TIMEOUT (10 * HZ)
+
+/* Prevent new submissions and wait for in-flight requests to complete. */
+static void virtblk_ctrl_vq_quiesce(struct virtio_blk *vblk)
+{
+	unsigned long flags;
+	bool need_wait;
+
+	if (!vblk->ctrl_vq.vq)
+		return;
+
+	init_completion(&vblk->ctrl_vq.drained);
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	vblk->ctrl_vq.dead = true;
+	need_wait = vblk->ctrl_vq.inflight != 0;
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+
+	if (need_wait &&
+	    !wait_for_completion_timeout(&vblk->ctrl_vq.drained,
+					  VIRTBLK_CTRL_VQ_TIMEOUT))
+		dev_warn(&vblk->vdev->dev,
+			 "timed out waiting for control queue requests to complete\n");
+}
+
+/* Fail requests left in the control queue after reset. */
+static void virtblk_ctrl_vq_drain(struct virtio_blk *vblk)
+{
+	struct virtblk_ctrl_request *creq;
+	unsigned long flags;
+
+	if (!vblk->ctrl_vq.vq)
+		return;
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	while ((creq = virtqueue_detach_unused_buf(vblk->ctrl_vq.vq)) != NULL) {
+		bool abandoned = creq->abandoned;
+
+		if (WARN_ON_ONCE(!vblk->ctrl_vq.inflight))
+			;
+		else
+			vblk->ctrl_vq.inflight--;
+		if (!abandoned)
+			creq->status = VIRTIO_BLK_S_IOERR;
+		spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+		if (abandoned) {
+			kfree(creq->compl);
+			kfree(creq);
+		} else {
+			complete(creq->compl);
+		}
+		spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	}
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+}
+
+static void virtblk_ctrlq_callback(struct virtqueue *vq)
+{
+	struct virtio_blk *vblk = vq->vdev->priv;
+	struct virtblk_ctrl_request *creq;
+	unsigned long flags;
+	unsigned int len;
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((creq = virtqueue_get_buf(vq, &len)) != NULL) {
+			bool drained = false;
+			bool abandoned = creq->abandoned;
+
+			if (WARN_ON_ONCE(!vblk->ctrl_vq.inflight)) {
+				/*
+				 * Still resolve the request.  Never leave a
+				 * synchronous caller blocked because the accounting
+				 * state was already inconsistent.
+				 */
+				spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+				if (abandoned) {
+					kfree(creq->compl);
+					kfree(creq);
+				} else {
+					complete(creq->compl);
+				}
+				spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+				continue;
+			}
+
+			if (--vblk->ctrl_vq.inflight == 0 && vblk->ctrl_vq.dead)
+				drained = true;
+			spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+			if (drained)
+				complete(&vblk->ctrl_vq.drained);
+			if (abandoned) {
+				kfree(creq->compl);
+				kfree(creq);
+			} else {
+				complete(creq->compl);
+			}
+			spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+		}
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+}
+
+/* Submit a control-queue request and wait for completion. */
+static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
+				    struct virtblk_ctrl_request *creq,
+				    struct scatterlist *sgs[],
+				    unsigned int out_sgs, unsigned int in_sgs)
+{
+	struct completion *comp;
+	unsigned long flags;
+	int err;
+
+	/*
+	 * GFP_NOIO: this may be reached on the bio-submission path
+	 * (memory reclaim writing back dirty pages to this same device),
+	 * so GFP_KERNEL could self-deadlock.
+	 */
+	comp = kmalloc_obj(*comp, GFP_NOIO);
+	if (!comp)
+		return -ENOMEM;
+	init_completion(comp);
+
+	mutex_lock(&vblk->ctrl_vq.mutex);
+	creq->compl = comp;
+	creq->abandoned = false;
+
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	if (vblk->ctrl_vq.dead) {
+		spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+		mutex_unlock(&vblk->ctrl_vq.mutex);
+		kfree(comp);
+		return -ENODEV;
+	}
+	err = virtqueue_add_sgs(vblk->ctrl_vq.vq, sgs, out_sgs, in_sgs, creq, GFP_ATOMIC);
+	if (!err) {
+		vblk->ctrl_vq.inflight++;
+		virtqueue_kick(vblk->ctrl_vq.vq);
+	}
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+	if (err) {
+		mutex_unlock(&vblk->ctrl_vq.mutex);
+		kfree(comp);
+		return err;
+	}
+
+	if (wait_for_completion_timeout(comp, VIRTBLK_CTRL_VQ_TIMEOUT)) {
+		mutex_unlock(&vblk->ctrl_vq.mutex);
+		kfree(comp);
+		return 0;
+	}
+
+	/*
+	 * The host hasn't responded within the timeout. @creq is still
+	 * owned by the device, so don't touch its DMA-target fields or
+	 * free it here. Mark it abandoned and hand ownership of both @creq
+	 * and @comp to whichever of virtblk_ctrlq_callback() or
+	 * virtblk_ctrl_vq_drain() retrieves the buffer later; unlock the
+	 * mutex so subsequent requests aren't serialized behind an
+	 * unresponsive host.
+	 */
+	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
+	creq->abandoned = true;
+	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
+	mutex_unlock(&vblk->ctrl_vq.mutex);
+
+	dev_warn(&vblk->vdev->dev,
+		 "control queue request timed out, abandoning\n");
+	return -ETIMEDOUT;
+}
+
 static void virtblk_free_disk(struct gendisk *disk)
 {
 	struct virtio_blk *vblk = disk->private_data;
 
 	ida_free(&vd_index_ida, vblk->index);
+	mutex_destroy(&vblk->ctrl_vq.mutex);
 	mutex_destroy(&vblk->vdev_mutex);
 	kfree(vblk);
 }
@@ -965,6 +1165,8 @@ static int init_vq(struct virtio_blk *vblk)
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	unsigned short num_poll_vqs;
+	unsigned short total_vqs;
+	bool has_ctrl_vq;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -993,12 +1195,19 @@ static int init_vq(struct virtio_blk *vblk)
 				vblk->io_queues[HCTX_TYPE_READ],
 				vblk->io_queues[HCTX_TYPE_POLL]);
 
+	/*
+	 * The control vq is appended after the data vqs whenever
+	 * F_CTRL_VQ is negotiated.
+	 */
+	has_ctrl_vq = virtio_has_feature(vdev, VIRTIO_BLK_F_CTRL_VQ);
+	total_vqs = num_vqs + (has_ctrl_vq ? 1 : 0);
+
 	vblk->vqs = kmalloc_objs(*vblk->vqs, num_vqs);
 	if (!vblk->vqs)
 		return -ENOMEM;
 
-	vqs_info = kzalloc_objs(*vqs_info, num_vqs);
-	vqs = kmalloc_objs(*vqs, num_vqs);
+	vqs_info = kzalloc_objs(*vqs_info, total_vqs);
+	vqs = kmalloc_objs(*vqs, total_vqs);
 	if (!vqs_info || !vqs) {
 		err = -ENOMEM;
 		goto out;
@@ -1015,8 +1224,13 @@ static int init_vq(struct virtio_blk *vblk)
 		vqs_info[i].name = vblk->vqs[i].name;
 	}
 
+	if (has_ctrl_vq) {
+		vqs_info[num_vqs].callback = virtblk_ctrlq_callback;
+		vqs_info[num_vqs].name = "control";
+	}
+
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, vqs_info, &desc);
+	err = virtio_find_vqs(vdev, total_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
@@ -1025,6 +1239,9 @@ static int init_vq(struct virtio_blk *vblk)
 		vblk->vqs[i].vq = vqs[i];
 	}
 	vblk->num_vqs = num_vqs;
+	vblk->ctrl_vq.vq = has_ctrl_vq ? vqs[num_vqs] : NULL;
+	vblk->ctrl_vq.dead = false;
+	vblk->ctrl_vq.inflight = 0;
 
 out:
 	kfree(vqs);
@@ -1464,14 +1681,18 @@ static int virtblk_probe(struct virtio_device *vdev)
 	}
 
 	mutex_init(&vblk->vdev_mutex);
+	mutex_init(&vblk->ctrl_vq.mutex);
+	spin_lock_init(&vblk->ctrl_vq.lock);
 
 	vblk->vdev = vdev;
 
 	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
 
 	err = init_vq(vblk);
-	if (err)
+	if (err) {
+		dev_err(&vdev->dev, "init virt queue failed: err = %d\n", err);
 		goto out_free_vblk;
+	}
 
 	/* Default queue sizing is to fill the ring. */
 	if (!virtblk_queue_depth) {
@@ -1553,6 +1774,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 out_free_vq:
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
+	vblk->ctrl_vq.vq = NULL;
 out_free_vblk:
 	kfree(vblk);
 out_free_index:
@@ -1571,16 +1793,21 @@ static void virtblk_remove(struct virtio_device *vdev)
 	del_gendisk(vblk->disk);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
+	virtblk_ctrl_vq_quiesce(vblk);
+
 	mutex_lock(&vblk->vdev_mutex);
 
 	/* Stop all the virtqueues. */
 	virtio_reset_device(vdev);
+	virtblk_ctrl_vq_drain(vblk);
 
 	/* Virtqueues are stopped, nothing can use vblk->vdev anymore. */
 	vblk->vdev = NULL;
 
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
+	vblk->vqs = NULL;
+	vblk->ctrl_vq.vq = NULL;
 
 	mutex_unlock(&vblk->vdev_mutex);
 
@@ -1593,13 +1820,17 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 	struct request_queue *q = vblk->disk->queue;
 	unsigned int memflags;
 
+
 	/* Ensure no requests in virtqueues before deleting vqs. */
 	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue_nowait(q);
 	blk_mq_unfreeze_queue(q, memflags);
 
+	virtblk_ctrl_vq_quiesce(vblk);
+
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
+	virtblk_ctrl_vq_drain(vblk);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
@@ -1612,6 +1843,7 @@ static int virtblk_freeze_priv(struct virtio_device *vdev)
 	 * pointers safely.
 	 */
 	vblk->vqs = NULL;
+	vblk->ctrl_vq.vq = NULL;
 
 	return 0;
 }
@@ -1672,6 +1904,7 @@ static unsigned int features[] = {
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_ZONED,
+	VIRTIO_BLK_F_CTRL_VQ,
 };
 
 static struct virtio_driver virtio_blk = {
diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
index 3744e4da1b2a..0a16972a1535 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -42,6 +42,7 @@
 #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
 #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
 #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
+#define VIRTIO_BLK_F_CTRL_VQ			22	/* Control queue */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
-- 
2.34.1

