Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678DA4F613
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771790; cv=none; b=FWReaNWvZQl6b4P9dX1mdVuhN2V7lBMypwyN0xW0llxwPLOIEfSqCM2ZBQt4ZBO/w2+GM6fYCer7XjEZeKOx9/sjHHCSzF24UyXheyMKABxcy7HdySaiMDwQjXwyp3T0YMU590+rG75/vcdwdVG62yLZcmDUThJmJdY7jKHUXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771790; c=relaxed/simple;
	bh=ITAI70NjeaKrkJrIc+02MfHU2bt8vzw+2K++tUngTyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=llbt1RHv7RFpDbqngPdK3io3jkaU7G+Sf0mYPveH+CQEmDmNT6byGLxxZPFTPyrCeEkb5WFiucs4TIAN8OOrJLGSxZHxPxs/DtzHoG8M+MWoy61xi6waclXVAgzv7a2Ri1F3YH7k4gdGTXl4rftxK5rd6Jq0OIcgBjBlnxghNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IOGEQbN4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IOGEQbN4"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed627829e6so4578984b3a.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771789; x=1714376589; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/EWE7HosrBQLSJgBRmTeatXRmpZ6JVLuxoFHN85xXc=;
        b=IOGEQbN4PVHLBSl98+ei2LemFklhVma7RnNGVF6O1W7biBeEjisMbJVZ5u/Toi28Xp
         kogBcVoEBTzKZ9w7PGK7D/IB86Zvlu2Op/maeSbPOQ2AcFDP9wbo/jnuvlZ2awt+GL8u
         G0pZyQH5HLsDr8c9k4+NrpDQB1g6WS9c12Ux4TxWHPVWcZnfkM8C0hlrqJ1Gx183vUda
         i0LXtVh+gc7m865+150sQc9KsvMG7tpVb766int3M0+MQS+U2VijIz8tyV+VQ4Pn9W0K
         VVePVr6I4Jm+GQmAW0sYEeDfZxAn2BwXcG1xv0zPcJaS+D3R/P/Ic0SzpHokddiBcgir
         +gag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771789; x=1714376589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/EWE7HosrBQLSJgBRmTeatXRmpZ6JVLuxoFHN85xXc=;
        b=omDAysL+w3GUDG3rtfXmWzNNFhvFTpSFvvVJJjj3w2ZKmVtNKul1YGt7mSlbgIZXwT
         eiwsM8m5UgK0Q7NWpRK6JaIN8l4qRqXSKIl1uuOkkhk1SJlA0/DEg05sXepTpNm9Cf1O
         t9oJN98pAkunHsoMUcZiqcNESgcFT2rm79eEp+RRSpo6oG34jZp00ds9Bl7JNeMqotdn
         awfxwFK1e2vsmA5fFSlZl96+L/4SLe7LMyVzzfcTdsgGKE198yVjHPkMyhdvAwRD5Pwk
         rLmBFVVNacVn8cOuNSPODV8Y4DOSdHsE41hwGsVfXuYcNGhh98iF6pYaUxAMLLQntHrC
         xz3A==
X-Forwarded-Encrypted: i=1; AJvYcCUf611Lail0EIqhXfBXC27UzgHd9X1I8Qr4x8JyDMNufZ5s59ZT6akkE/d5mlwV9kIjTY2bxoGq0OgQkG2DwTH84CqULk3jvr7TcoIz4iI=
X-Gm-Message-State: AOJu0YyMUWE7+Rm113OGYkRBdr41RsPwqq7dY4WeSf8IZWxUDK5LREtP
	NWc8RX7JM1XaGdDLgHtZH58hiL1aV+mxHOXckbPEspWLDaZ4yMJejoZA5uw9qcY=
X-Google-Smtp-Source: AGHT+IE2E7bgMyLmnmQSu1kHHGwGpjyE4p40kY0+jyTlKg2yf/aOeq6zrS4zsbnrUiBWDAWUZBb4Rw==
X-Received: by 2002:a05:6a21:348b:b0:1ac:3a2c:b42 with SMTP id yo11-20020a056a21348b00b001ac3a2c0b42mr12591466pzb.9.1713771788742;
        Mon, 22 Apr 2024 00:43:08 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:08 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 2/4] virtio_balloon: introduce oom-kill invocations
Date: Mon, 22 Apr 2024 15:42:52 +0800
Message-Id: <20240422074254.1440457-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422074254.1440457-1-pizhenwei@bytedance.com>
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the guest OS runs under critical memory pressure, the guest
starts to kill processes. A guest monitor agent may scan 'oom_kill'
from /proc/vmstat, and reports the OOM KILL event. However, the agent
may be killed and we will loss this critical event(and the later
events).

For now we can also grep for magic words in guest kernel log from host
side. Rather than this unstable way, virtio balloon reports OOM-KILL
invocations instead.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 1 +
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 59fe157e5722..87a1d6fa77fb 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -331,6 +331,7 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
 		    pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
 
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..b17bbe033697 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -71,7 +71,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
 #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
-#define VIRTIO_BALLOON_S_NR       10
+#define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
+#define VIRTIO_BALLOON_S_NR       11
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -83,7 +84,8 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
 	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
-	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
+	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

