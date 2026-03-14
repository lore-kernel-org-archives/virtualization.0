Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA97F311940
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773457594; cv=none; b=HX3o6hw/eg0oWIGbYFKR81Ex/qbBGRpmwtJe3+1QAhMJlD1QMDwXU7l/TTaj3VvYEiKTE6uzWOdnEP5z44Y7EP4heszYdhF+mgk8URpW7X5voOW9upmea7peSVfYegLcpaSK9EKQQ1sSy1FCUnV/bv1x+C2bqbUHVd8K/TAVXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773457594; c=relaxed/simple;
	bh=AR35kwCEfJo7sEZa1YVF3bya3llxgaU0XwOpvFCQj3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdgaWEc4NM0SAm2BhH9THdUD85Y24GFulyM3D7TPmVNqotN5F5rc69i+L0237O7PIsPe+wYCj3HCP7hta2vh/5ZczdYoU66NeVLcqkI0OMM3/9fJWdrsbrxaBvMSWglWT/KbDUVjNNQRf1xMzxPx2mFp7Mq5iJ4vy0yMX0qq8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=CNEhYsMD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="CNEhYsMD"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829a9d08644so1668407b3a.1
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 20:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1773457593; x=1774062393; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKbNTW+AGr0VJ4W7ZqAbg3vbau3fq7bpOdvTyaTfwlU=;
        b=CNEhYsMDqpQH96GYBZl1S42awml6R6carHK1MaBZdYKJT20RN+iaL5kahqSlVz2hF5
         GJ5etnRJSBvh28HTGCIcf2HGaGjMiyHcCRcG+0wanD1BeQgpUw55fSUwASkqLG4Jtiud
         O37N23yNN01vPVr75Sb40YWE73CTNB52KNcQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773457593; x=1774062393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pKbNTW+AGr0VJ4W7ZqAbg3vbau3fq7bpOdvTyaTfwlU=;
        b=aZFEuZ+COleIfBGqYHSNF/xhmM5sOS+8m1vN+NMrfKR99YQAlUSqAc1vy5LeniAfAR
         8oxGt5v90MbvlnRsgWRt2cUwgDhvbzVdn3NHMvLmn7YrEvAKcTgK7VLFIzE2FEGJ2lJ4
         /cOzwiArLd8r92Axdw/S1tX53sp81QW6kp+43uxvpNLWXH3GqBQGFp9/4yiUfHKoeBTW
         OcFNglLzr+aD6/l/uuLScAxkqOyyfjfAIoTtRJ5CWg5w2gwYWXuEKYU4Nkr/zJMRxGi4
         OXeRfMOWS41l/1CRbigo/jd7YQkM2R3Jpnk6sxFc6II6boP+nE3kuOuodMPVa+LJU8Ru
         XPug==
X-Gm-Message-State: AOJu0YySUUwSvXWaEhkb6XdDozdU8E/q3T8drZOZoZRQHl8bQAOgekf+
	wukU8aBvOHMTA5uSPWSn+JbZJ7x2X9257vdAlKWD4023Nc+yI9v5R/kt09MbjeMdDVY=
X-Gm-Gg: ATEYQzwombCBbw0ZNCcHsAUTJ5VjXJaNfBGQqfoyRKkvC8qcBFxTpvOwlUbIt5c7TKy
	nwzsxJGG8m1I3R741BVmWj3eKCEJkMAwuVxwmK7FUotQ2E7eXAzbVZt95LEI2yAlrzCi4Liou6o
	Fp7M8xzK67GUMHlCj8Ft6RHZmXnrMbdh86rkl4YBP5emK3Om7CkTolo85OvQm20eX69VZfjJf3m
	FpNlOmWhJYgb8h1/jsHSEo57CWOiNQ8UKF4/WHUyRa38R//YoCMChUx7BrCxmaLQjabnIVthldj
	oZQLnJ/0PnVXSyoD0JbTzPDtXsroDy5mknYkHhlOYBzR6tzsjG+gIdopGKZjfgooUKK4glab7rz
	WQoCklXZNKkUL4zCWab4UfwTX8vtxGEopLfrngfIOKuTqEnxrhWUpzRH1h4y9FVVPhSq1vsXmBZ
	wBKGzMz5npLXpa0F0Kb28HCOooDn97rwhydMg5fPVW5TUD5t+yqi4xkBKUGVWs8NW7ZFmpBBDus
	n2K6FOEArPOAFy+
X-Received: by 2002:a05:6a00:2e99:b0:829:88e7:c88b with SMTP id d2e1a72fcca58-82a196db76dmr5417644b3a.19.1773457593159;
        Fri, 13 Mar 2026 20:06:33 -0700 (PDT)
Received: from kinako.work.home.arpa (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.167.218.150])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a13a2f2d6sm8630734b3a.9.2026.03.13.20.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 20:06:30 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	arnd@kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH 1/2] virtio-mmio: Replace sizeof x with sizeof(x)
Date: Sat, 14 Mar 2026 12:06:10 +0900
Message-ID: <20260314030612.1949420-2-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260314030612.1949420-1-daniel@thingy.jp>
References: <20260314030612.1949420-1-daniel@thingy.jp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch wants the braces.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/virtio/virtio_mmio.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 595c2274fbb5..dda915b2ac9f 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -152,21 +152,21 @@ static void vm_get(struct virtio_device *vdev, unsigned int offset,
 	switch (len) {
 	case 1:
 		b = readb(base + offset);
-		memcpy(buf, &b, sizeof b);
+		memcpy(buf, &b, sizeof(b));
 		break;
 	case 2:
 		w = cpu_to_le16(readw(base + offset));
-		memcpy(buf, &w, sizeof w);
+		memcpy(buf, &w, sizeof(w));
 		break;
 	case 4:
 		l = cpu_to_le32(readl(base + offset));
-		memcpy(buf, &l, sizeof l);
+		memcpy(buf, &l, sizeof(l));
 		break;
 	case 8:
 		l = cpu_to_le32(readl(base + offset));
-		memcpy(buf, &l, sizeof l);
-		l = cpu_to_le32(ioread32(base + offset + sizeof l));
-		memcpy(buf + sizeof l, &l, sizeof l);
+		memcpy(buf, &l, sizeof(l));
+		l = cpu_to_le32(ioread32(base + offset + sizeof(l)));
+		memcpy(buf + sizeof(l), &l, sizeof(l));
 		break;
 	default:
 		BUG();
@@ -194,22 +194,22 @@ static void vm_set(struct virtio_device *vdev, unsigned int offset,
 
 	switch (len) {
 	case 1:
-		memcpy(&b, buf, sizeof b);
+		memcpy(&b, buf, sizeof(b));
 		writeb(b, base + offset);
 		break;
 	case 2:
-		memcpy(&w, buf, sizeof w);
+		memcpy(&w, buf, sizeof(w));
 		writew(le16_to_cpu(w), base + offset);
 		break;
 	case 4:
-		memcpy(&l, buf, sizeof l);
+		memcpy(&l, buf, sizeof(l));
 		writel(le32_to_cpu(l), base + offset);
 		break;
 	case 8:
-		memcpy(&l, buf, sizeof l);
+		memcpy(&l, buf, sizeof(l));
 		writel(le32_to_cpu(l), base + offset);
-		memcpy(&l, buf + sizeof l, sizeof l);
-		writel(le32_to_cpu(l), base + offset + sizeof l);
+		memcpy(&l, buf + sizeof(l), sizeof(l));
+		writel(le32_to_cpu(l), base + offset + sizeof(l));
 		break;
 	default:
 		BUG();
-- 
2.51.0

