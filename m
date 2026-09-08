Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC437FF68
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788845991; cv=none; b=GNZqLQ8qGLd3HBl6lDDDEbVSEWsEObzEmRVpJMIHjrWsqCuBvM2OyoDujh3XY1z/bi927bO3QBNzFgSsjGZAz0EUmOWolZTfJnsNa/vkXRg0pfC067te2H6gWiztA9oFc6/r5oWC6fhahauCpRvj2imvjUrzl7TwyzDN1zyWbk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788845991; c=relaxed/simple;
	bh=+h/0zeWFw84evQw0JV7uXbRDUk9bZb6gKcvHxLChX5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LcKtlWnZzi/AkOW3UbjgN5KODQWYXCvg9v32IJribd1jW9ICn4cMkVwUwo2Wn1cApMPnWXkg42xajvdNt0Xgv/VN1U0ZP8DDVOjOltLa/Fqv9ip9L+/bW7NM8kjzXeaQUyCDXjNwngfzCsk027atPf8TZKAUcjbc7pnzZ8UXauw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QnCOL6zM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnCOL6zM"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495590dde14so59962215e9.0
        for <virtualization@lists.linux.dev>; Mon, 07 Sep 2026 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788845985; x=1789450785; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PyvGIpKH+MV7CFSZeFmHniXCtrADstZbtULW+SJuxFg=;
        b=QnCOL6zMk8q4R19snvHyX9XLVwkTr0a/zH26oirlyUVAjpLUNWo2EYNH9jKuvu0emK
         bPqors2bGauR1daECHXSKmR+BHecfm+1doUt1a/CZ6WVTGnF0onINq2EjhzxRQD+x3hP
         CuaZHojSk2fBAP4D/fFz75VzPU3EGRco/VqTTQHIG1+R924fH6UMxJLV5fDsDJbj5UZd
         MH2NO8FP+l/W+vQcu0kuXuoOxiL/VyKpc52r4n1n8dm6iEr22+eLc/UZqWyWyGygDY6Z
         lUGWRn2kCFAKQL81sTsWi3xgeplrtF+G9zqDHjPglCxPj8Eq6wq/qaFFEsqvN5vsQ4Jv
         QDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788845985; x=1789450785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PyvGIpKH+MV7CFSZeFmHniXCtrADstZbtULW+SJuxFg=;
        b=Px90eHPFGXA9kLw61zx4OXBXuSIqbflo3K3G0DN1ARBrDPyIRGjwNAhlHGqY/M252a
         an3DjWVxvMoOneOs37wpsKwv0dBAYyzAfGoVB1Gtg0z9be/savOVl2i0PoozUZwDokrX
         flert1VpFK16o+crgjPL8xv3bG0g3si8KJ4JFNfmiU2CBAHvwaIXDgnWXO1SD0PYAHT5
         9doWGcZv49tU8RUfEHg6S4mSGsHNhxI9eiQbXuqgO8p7Em5sGg7GYZNUN9uGTwPyyYV0
         tYPcLkn+YtjFr2iz7Q5Jr4BVOa5NNuyPbr4yTfWPfJ4R9SFAOpdcTg4PgJj3Qf6J0x6Y
         ar/Q==
X-Forwarded-Encrypted: i=1; AKwUvByEytoFZ7CKY22qNnZ0taiyHd5LeQcvheXrEToTBQvuO8fZJ1PWAbJeWFWVps87qAg0CfKanId+SmX8oGYeUg==@lists.linux.dev
X-Gm-Message-State: AFuF++mxgSbCTppxiO14sSyVUTRqLLaEFyNTXB6S0HxLzRMzrz0G2qeT
	qsH/K5AA8YNENz2Oxv+FDgw/Tka2U7PRp8U+aYORy1hG01mFenUBNmCs
X-Gm-Gg: AYBFou3tcAFeDRUIzmAGpokuPdo4Rt6UGqnbKLbS619tosUtot8hQlxr+7SZ1Y2QjkP
	ym1mMkIsIVbA6Qh9N0OCO/MhMvys+k5Vo9pAlwLgydp3f0LbwwNsanUwh1xhjc2Y64PwtEbcRto
	f3shV7j/cdpW5AjBNZvZB7uQrotu/1+VP69OQpjrgSa7phyZPhglJxeV/uIOFJ0FEhEU3FDZ9GT
	GOWG0XxNPeEVMJ4JIg0m90y/Lb+Cqs79uzWBBwv/LNQC+2KYNf4QDJT9Mjg6OQ7hVsYsmAKNDtI
	9BtArde0E3k7tunsrXdBe0IJ1zvGEA26hxh+dv0dNh/HRdHeii98LymME/p1ldY3eMsgZ1v7Flh
	atlGYuaSAtV1RK1LiGjYEEUsKMFdKOpm2o5RevULIlERdPiB6e26JyirmXyYnQOHkFQytMMnzBd
	GTjFb/bQ5X58JrLFSvlFE+kl6CR6MMUsJRThuhPRovltbsbfsrwRj3+FQSWULe6Bz18f84zTdca
	j1CuncT4zS1xxFcymO6/XiXHVSLVLNEx5ypcc6RWJawGYGYIbUbtk8JzOyqIKxyKNFPlNDCxt74
	BgS1xZFD47ykfG4wDaNaUcurETegoJo=
X-Received: by 2002:a05:600c:a0a:b0:49c:e1f1:3dd5 with SMTP id 5b1f17b1804b1-49cf81e6cebmr470253545e9.4.1788845984552;
        Mon, 07 Sep 2026 22:39:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-170-066.95.117.pool.telefonica.de. [95.117.170.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm523841335e9.13.2026.09.07.22.39.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 22:39:44 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pawel Moll <pawel.moll@arm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-input@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 4/6] um: virtio_uml: implement synchronize_cbs()
Date: Tue,  8 Sep 2026 07:38:15 +0200
Message-Id: <20260908053817.26065-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260908053817.26065-1-kmehltretter@gmail.com>
References: <20260908053817.26065-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_uml invokes virtqueue callbacks from vu_interrupt() and
vu_req_interrupt(), which share vu_dev->irq. The core's
synchronize_rcu() fallback already covers these IRQ handlers.

Implement synchronize_cbs() with synchronize_irq() to synchronize with
that IRQ instead of waiting for an RCU grace period.

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/um/drivers/virtio_uml.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 7425a8548141..1f2e62e29a27 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -20,6 +20,7 @@
  *
  * Based on Virtio MMIO driver by Pawel Moll, copyright 2011-2014, ARM Ltd.
  */
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -869,6 +870,14 @@ static void vu_reset(struct virtio_device *vdev)
 	vu_dev->status = 0;
 }
 
+static void vu_synchronize_cbs(struct virtio_device *vdev)
+{
+	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
+
+	if (vu_dev->irq != UM_IRQ_ALLOC)
+		synchronize_irq(vu_dev->irq);
+}
+
 static void vu_del_vq(struct virtqueue *vq)
 {
 	struct virtio_uml_vq_info *info = vq->priv;
@@ -1121,6 +1130,7 @@ static const struct virtio_config_ops virtio_uml_config_ops = {
 	.reset = vu_reset,
 	.find_vqs = vu_find_vqs,
 	.del_vqs = vu_del_vqs,
+	.synchronize_cbs = vu_synchronize_cbs,
 	.get_features = vu_get_features,
 	.finalize_features = vu_finalize_features,
 	.bus_name = vu_bus_name,
-- 
2.39.5 (Apple Git-154)
