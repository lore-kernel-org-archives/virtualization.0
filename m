Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CD375AA1
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432945; cv=none; b=g/EmkW1tTR0M9pUxfHMEJ9aVIJILUxMiLVaGbA9rBcp7HkznkcPh4MfASolRKPb5DwwwDpzjMCUclklXb7jQ9NtktJZ9LmKCf/QWRafXHvvDu+Xzvg5blfoaeSfTGqRe9obYPF0a9YN4IMlm2+iirZfgYigk5TUK2mECtL5kei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432945; c=relaxed/simple;
	bh=eTMe5owLpd6fJTbocIxLhNrLvVXdrBoqyF5Kn1ZFt6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HX28ZtG89PcTFrNplUmcdT8Vw+NHJZkhTdgTi7Zk5nWj1E2kpKo5RU1Mq2lPLAeElsvfoG53DoUmwWrwfsD83gNeA7hFDIdJWShtSUt9Z9i0wwmqc4/It6GXc2DiHVq1P2ojWRXbzGpRhvIB7djMTA7iLoDnyQkUD1cF+gNmysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX6Hrqsb; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX6Hrqsb"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76c067bc51so286831a12.0
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776432944; x=1777037744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5XV/aTMjGl4rij/mQzWRn5Aq74xFtFSJgvscfZnyWI=;
        b=SX6HrqsbOM9dcRX8i55zCB3iTBCJ/zNPJXN4s5MxEtcBr40lbvWiPRbsj8a+MCk8s7
         kuCuI8K2D+d7tmXwogEgaFfRudZcdDyKmLMZWJGo4LC2Lp6DOab4XYDU9tIWHEJQBhZb
         8nXbuNho+d6Pv/BRdVzy8vHqWopc/Aixm6oPQvGExFOvbBGbgEyFcZ3vQd7gd3Mm/8rQ
         Jh1hAlV9W2YRUHW+CyVwuWQthQPkk4rsiNSwb/CVINwmheU0CnmiL0kvOSwmQ3y0YGvB
         qK8nKmLtQ88AwBHl+FhVph31xyFmAMKaaFUmW5Ps/B/b2bgBpaT+FRhh0TQ60yeUsVjd
         JVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432944; x=1777037744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/5XV/aTMjGl4rij/mQzWRn5Aq74xFtFSJgvscfZnyWI=;
        b=OC6+zgmiK8oyExLIKkghDAzd5FhhdCYG5nBarCy2hxQgFWlOTlAsfDkMT0XqJLWs7C
         3hT+tdkNq+cN2TXk6lpKHTSklrkzO53CR9qqYS/MzzqHGdy+se7k1M3labjGNUvQUjrR
         iRiN3d29iP5kbpnGVpplqK0WAk6Y1xB7oDpUPk7I+elGi74pYgIwricSf5Ub3T3+XQhV
         udtcypBhY0cod6NaJ+dw+zXTwu5OZ4r3OxvoX3U5FmOmyqeOrPmK/nzEPatETo3ChxT1
         6CW8gTR+qyZ8owYLemT+cho9s/TpTX4pRBcpsEFt6zy2avFo+Ecq/l9FzF9kesSLhdov
         u9hw==
X-Forwarded-Encrypted: i=1; AFNElJ+OIMK0vqLQwqmnJE9LCEBW3M/na4QYYBcNSe4pTsIp3077zfLdu//yOPDYpUNBgOiggCKHTH+NV50x0W82PA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzG3t2WLhAEOE55FO9Npqhat8Z6K8w7xuLv0yQxa28UEr49rNC
	ElYrsR0hlAl+TA2sR3VRqfRP9ky768z4DiG3Me8a3KbaQNPbRIjAvqrP
X-Gm-Gg: AeBDievd/2kGsfAfYQHozq7nf+0ClCALXFwYIbj3pgBGzrSzcSUjmtWbD6uQl0oiG83
	KWxx4Vl7iAzs90fjd+cLcQMKYHDdOoW9vJd6qLZ9LzMZ+zO7njdIbR0wpurtFf1qlCrUTmVjncV
	jQDkXtvAJdOXepKPnnmmb8QoBBT5drYLbvYFdYIN0pmcHIvdKhEY1e50Su3SbZuYXw+kjfcYaLk
	oYWxMsXLeX+ureL87MKCRpEgYdk6VewbWPOEVYGU12AZAIZGLEI5N2jad1SRiS0aa19MrLOPjSN
	oWpIbYhyeR5Gpk3dkJVc+JoPNqgAh/HDTvmZLnsiPWr0xMvzBJHrtdAmvDFHirNpoXiazvsNH9O
	UPReMjOMWfyT658NG/yK2TNHClVkDPY8GGenLgvCoytRImUgka938sb0kW8IVv/t/S2kRsIUxv6
	kegWUWnHR5RmIdE4S95SfiIL/H1VOmAppt3PAlOJClxkN/fza/HamNYARb81WtuhUkEGm0hQxXz
	7xa0E9IJKaDdPhP+qObU9fV2zK9S9AiE46wJw==
X-Received: by 2002:a05:6a20:a109:b0:398:9403:49f4 with SMTP id adf61e73a8af0-3a08d89fa27mr3174513637.30.1776432943930;
        Fri, 17 Apr 2026 06:35:43 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm1421272a12.14.2026.04.17.06.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:35:43 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v2 2/4] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Fri, 17 Apr 2026 22:34:28 +0900
Message-Id: <20260417133430.507-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417133430.507-1-baver.bae@gmail.com>
References: <20260417133430.507-1-baver.bae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

After a device reset in noirq context the existing vrings must be
re-initialized without any memory allocation, because GFP_KERNEL is
not available.

The internal helpers virtqueue_reset_split() and
virtqueue_reset_packed() already reset vring indices and descriptor
state in place.  Add a thin exported wrapper, virtqueue_reinit_vring(),
that dispatches to the appropriate helper based on the ring layout.

This will be used by a subsequent patch that adds noirq system-sleep
PM callbacks for virtio-mmio.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio_ring.c | 19 +++++++++++++++++++
 include/linux/virtio_ring.h  |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce1c6bf..a57c625b5936 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3936,5 +3936,24 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
 
+/**
+ * virtqueue_reinit_vring - reinitialize vring state without reallocation
+ * @_vq: the virtqueue
+ *
+ * Reset the avail/used indices and descriptor state of an existing
+ * virtqueue so it can be reused after a device reset.  No memory is
+ * allocated or freed, making this safe for use in noirq context.
+ */
+void virtqueue_reinit_vring(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (virtqueue_is_packed(vq))
+		virtqueue_reset_packed(vq);
+	else
+		virtqueue_reset_split(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_reinit_vring);
+
 MODULE_DESCRIPTION("Virtio ring implementation");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c97a12c1cda3..26c7c9d0a151 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -118,6 +118,9 @@ void vring_del_virtqueue(struct virtqueue *vq);
 /* Filter out transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev);
 
+/* Reinitialize a virtqueue without reallocation (safe in noirq context) */
+void virtqueue_reinit_vring(struct virtqueue *_vq);
+
 irqreturn_t vring_interrupt(int irq, void *_vq);
 
 u32 vring_notification_data(struct virtqueue *_vq);
-- 
2.43.0

