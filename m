Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00E612FB2C
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254519; cv=none; b=hi+QNwbdjvdMA/TZH2Inf4Peg/ooCjc7d5LUo2G30lfjYXAveNZNbaJSoXoemOP9anRgf/BmBi9Zyl9/dn/m5tl8bzW0/I2xQTCQiJqNxVToChVceE0YUpFpZNY/eHx91QWuIK8QSDCxKUdWa4LvteNS/MTd2VzC0E8PY561a44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254519; c=relaxed/simple;
	bh=9WVteE8/l/unSLKa7liIDhpua1SzUqUC58ee5t95ahA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XUjmeYdZZwPax/cGS2BQFF26EqW9nCZ+Z24NOwoVjH0zXjdYQcX/IGpCuwmuQ0U2+Pu0IVoOugFCg7cLeSBgw4GrqYAjS/nupX5HFNNP8A1BNvq2LdrLapXKK945WbxzjB0yrzPLJMU3MQxNrwbFnM9lQUP5JpLdJSN2L2sa52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glK2bPaM; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glK2bPaM"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 455D061074
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 18:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LT71WITBKwSU for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Apr 2024 18:15:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com; envelope-from=dreaming.about.electric.sheep@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E77EE61070
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E77EE61070
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=glK2bPaM
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E77EE61070
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Apr 2024 18:15:15 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-343b4601415so563960f8f.0
        for <virtualization@lists.linux-foundation.org>; Thu, 04 Apr 2024 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712254514; x=1712859314; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kY+E2shk9TTjvlmztMnEOs4NCqRmJnXfRKrkxZqUteg=;
        b=glK2bPaMW2+wptB+39ceQUMpDIxJUlO63XlMGcOsFnYCubby85wetUygtqlIBu4bmo
         VW1WCImm/uqu6a3qPe/HsxtjNQD1haUUMGSNUvZWT1bV0ClxNIo632MnSq5uRE20Arf5
         lhCuRVw8JIwnhTC/8Hy3HZ0GEKRChM9eVP1XTOM+MGbtbtYR4vTa28UW2zdg1rUHyZNN
         DyMmEGWEQmGWTIy3m/BSXIjch1ngXBre+/bZct5iyQsnnmsmUt85zBzCNWRvcG170GFa
         itKWKlDPl54paQW2oNZG6Tc/lU8DZ5W3DUVuzMW2IOqz8CJNRpCmOJU/Xhz8GPV2/eaH
         VFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254514; x=1712859314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kY+E2shk9TTjvlmztMnEOs4NCqRmJnXfRKrkxZqUteg=;
        b=sIIrFyeLf6DchQrcjJvlgor9w/YflSxPh1b9POp5V2E2LTTn2BatTrohNXEmHO4KY9
         b/9FwTKkud2/tIVh/IgnOHC7MlwLvVWlYRyBfO3dWtmOjN1uX9KC7QJ4ZPImR9N1tXGq
         rHM+FZwaSpkKHLQz87F8GhBiGQ/4d3wKO9TXnedhMiMpx+3P8+js6dTLvot6IzbLSzeV
         JAyojOUqZVsJvmF8lva/0zdVDlTtp7R3FRXmLH+A9l+SmjzuPC5YY5zaUlVEVk5591f9
         2Fz9brOlkVmXtGZwXRrX34ewb3DaTOZ95tRK8SvwY1ZwSwdqEcWPy92HXCMUc4PaEoXa
         zyGw==
X-Forwarded-Encrypted: i=1; AJvYcCWATpOUQX7YVvxvXrEGDGHI/14N1nZ0OlERbedb6l2haAz+qFH/saNLSyzujf/XMVh5UUB+9yMNmx+3G4rrTRcjDaZ59dOknSbapvY+DkIZ7YdJRADTxgrVbQ==
X-Gm-Message-State: AOJu0YxS3Q4M+heEbkkm9sFL4J4NV2mB+mJTDALRgUteey94u2OqURxF
	/Gh7DDu/HrJI6n96d98vCqHjGKRyl4o7DaRJLD7kBrNJ0AYpSSkP
X-Google-Smtp-Source: AGHT+IHey30qEJp/mXGAUejbX5U+sc9AsyKeLlyJm3AU7cl7lDPEg0sOe+zZaC4lHxBG8L9bfNGSWA==
X-Received: by 2002:a5d:56c2:0:b0:341:c473:2919 with SMTP id m2-20020a5d56c2000000b00341c4732919mr206426wrw.14.1712254513709;
        Thu, 04 Apr 2024 11:15:13 -0700 (PDT)
Received: from localhost (ec2-18-175-17-34.eu-west-2.compute.amazonaws.com. [18.175.17.34])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d4ece000000b00343dc6a0019sm136463wrv.68.2024.04.04.11.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:15:13 -0700 (PDT)
From: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
To: mripard@kernel.org
Cc: 1054514@bugs.debian.org,
	airlied@redhat.com,
	carnil@debian.org,
	daniel@ffwll.ch,
	dreaming.about.electric.sheep@gmail.com,
	dri-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	timo.lindfors@iki.fi,
	tzimmermann@suse.de,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/1] Revert "drm/qxl: simplify qxl_fence_wait"
Date: Thu,  4 Apr 2024 19:14:48 +0100
Message-Id: <20240404181448.1643-2-dreaming.about.electric.sheep@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404181448.1643-1-dreaming.about.electric.sheep@gmail.com>
References: <20240327-cuddly-smooth-trogon-59c02d@houat>
 <20240404181448.1643-1-dreaming.about.electric.sheep@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 5a838e5d5825c85556011478abde708251cc0776.

Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
result in a '[TTM] Buffer eviction failed' exception whenever it reached a
timeout.
Due to a dependency to DMA_FENCE_WARN this also restores some code deleted
by commit d72277b6c37d ("dma-buf: nuke DMA_FENCE_TRACE macros v2").

Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
Link: https://lore.kernel.org/regressions/ZTgydqRlK6WX_b29@eldamar.lan/
Reported-by: Timo Lindfors <timo.lindfors@iki.fi>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1054514
Signed-off-by: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_release.c | 50 +++++++++++++++++++++++++++----
 include/linux/dma-fence.h         |  7 +++++
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 368d26da0d6a..9febc8b73f09 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -58,16 +58,56 @@ static long qxl_fence_wait(struct dma_fence *fence, bool intr,
 			   signed long timeout)
 {
 	struct qxl_device *qdev;
+	struct qxl_release *release;
+	int count = 0, sc = 0;
+	bool have_drawable_releases;
 	unsigned long cur, end = jiffies + timeout;
 
 	qdev = container_of(fence->lock, struct qxl_device, release_lock);
+	release = container_of(fence, struct qxl_release, base);
+	have_drawable_releases = release->type == QXL_RELEASE_DRAWABLE;
 
-	if (!wait_event_timeout(qdev->release_event,
-				(dma_fence_is_signaled(fence) ||
-				 (qxl_io_notify_oom(qdev), 0)),
-				timeout))
-		return 0;
+retry:
+	sc++;
+
+	if (dma_fence_is_signaled(fence))
+		goto signaled;
+
+	qxl_io_notify_oom(qdev);
+
+	for (count = 0; count < 11; count++) {
+		if (!qxl_queue_garbage_collect(qdev, true))
+			break;
+
+		if (dma_fence_is_signaled(fence))
+			goto signaled;
+	}
+
+	if (dma_fence_is_signaled(fence))
+		goto signaled;
+
+	if (have_drawable_releases || sc < 4) {
+		if (sc > 2)
+			/* back off */
+			usleep_range(500, 1000);
+
+		if (time_after(jiffies, end))
+			return 0;
+
+		if (have_drawable_releases && sc > 300) {
+			DMA_FENCE_WARN(fence,
+				       "failed to wait on release %llu after spincount %d\n",
+				       fence->context & ~0xf0000000, sc);
+			goto signaled;
+		}
+		goto retry;
+	}
+	/*
+	 * yeah, original sync_obj_wait gave up after 3 spins when
+	 * have_drawable_releases is not set.
+	 */
 
+signaled:
 	cur = jiffies;
 	if (time_after(cur, end))
 		return 0;
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index e06bad467f55..c3f9bb6602ba 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -682,4 +682,11 @@ static inline bool dma_fence_is_container(struct dma_fence *fence)
 	return dma_fence_is_array(fence) || dma_fence_is_chain(fence);
 }
 
+#define DMA_FENCE_WARN(f, fmt, args...) \
+	do {								\
+		struct dma_fence *__ff = (f);				\
+		pr_warn("f %llu#%llu: " fmt, __ff->context, __ff->seqno,\
+			 ##args);					\
+	} while (0)
+
 #endif /* __LINUX_DMA_FENCE_H */
-- 
2.39.2

