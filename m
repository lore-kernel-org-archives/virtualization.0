Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18693987B
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170493; cv=none; b=oBsS7uOWP66jWMUD4Bj357lEY9UHoyN3zcUH35pbQl9aCjCEK0mUqYoQC/4GY7U6o797v3F/lJkoWpQ9m6CtBKhiJ0XyU75bjMkkMDiS5GUnD/a/P+j/GCAoJRduB/wBGIz+alM8KaLa+edqMNfmD38ikUN9dS3tQk7Z0HiCD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170493; c=relaxed/simple;
	bh=7/Cb3EbaM1UDAA5Kb72FztigJLQVxjyacKvxcUVA7Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKCtirkfMRGMkTxUjMy7b9FbY8R6/ywdG4tagAlkQg0wAWQgFbGWMrN9TQwHQdXwQQaDa61aghuMWfYStWSRkue63Bsd6h20BknRWCBLkiado+hUez79/EtY06v5wzobiRy4PmOouPLTyhCdzq+i49q2RzJjIb7Z5R1qu05bXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j4Gr73a/; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j4Gr73a/"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7c7f3f66d17so112993839f.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713170491; x=1713775291; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12B6L10PsA9Jh230IG9uEJXqT+JXXSEjbmkq482lFPs=;
        b=j4Gr73a/EvvGIVKl1/+7Xw0wRs1iNBuMr7AUxrl/T4nzi5zvlVpj5J2byEqfEi1PIB
         sVQ83TPpj/NNVJ9/iyoM21GwDLpd6lYWiSW4k2MVfUIKt7haS9MI8EVDCoKPJwq0yuKQ
         FX63SVJgTl+0ZR4cFWINUYHozcEtTc5IMkPQAB7Nqsddc3FElUsB02UZPQewBfLTXLO3
         AqwqWAnxURc8BSXqmk80p40CskRGJyksTZG00aQ4eRhdN1GXh+z9oCN9qV14ITTEbLBE
         76aZDBxh98T/7pysVDLHo5KgTnctfw/aoCwj08aFTqfFTcu6i9K+Tar/Pbw+t4AOzQqt
         bjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170491; x=1713775291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12B6L10PsA9Jh230IG9uEJXqT+JXXSEjbmkq482lFPs=;
        b=hw1PEN5/0bMQIm3rw66Rv/RULpHov3IXCUV9goEDx0F7tVmno0yR1th+Eu7y9+UIdu
         v8ziNuFu7YS9QC5UhCCCG7teA/g0yzXpTcm3Ikj+vJFa0qG3LdjsMQKirU79Nqdx+5p4
         4dW6k1xNvzpFwxbqAf3W33RzPeYIxRmrJVj9OGTtnwHMOarBuBt/IoOKjepPcNVlX+eT
         0q8nFi1vHSpfNcE7aDAmFuaFodA++34QtIlc05+cP0GTc5kd2GsndolTJM4GuE4l30pC
         gvkIG6+mC+TrmG8Qr4t5JjuapUU9QJ/oNYca8LVezZFMm3S9K0ZelRjyjyeGV5P1OVDg
         amjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8Be0buU/8hk11vhVnmHRNL+myllj3f12MczIEIc4rjzo6BSeYT0eb94ocZVo99+hW68QHneZhm40RMd0WSSJ++laZQEhobUn9LXgtyc=
X-Gm-Message-State: AOJu0YxQ760u4igYaI0U4GNrlbPqeb1goFnXd3XiyC13fH2fAR6B6Jii
	g8K67QCh7J4aatDlAB01XpEyi25CZUiiBVjyhvoN9xTWW4GotB7lJd4jx9RTmjI=
X-Google-Smtp-Source: AGHT+IHu3Id3boHE0EmOQ8pWwfFovlaejeViuBMnTD/yfIQaRW2940ghQ6qCZwrhul6FRmwhdLfOtQ==
X-Received: by 2002:a92:cd81:0:b0:36b:214:bb21 with SMTP id r1-20020a92cd81000000b0036b0214bb21mr11364794ilb.25.1713170490833;
        Mon, 15 Apr 2024 01:41:30 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm6575685pgc.21.2024.04.15.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:41:30 -0700 (PDT)
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
Subject: [RFC 1/3] virtio_balloon: introduce oom-kill invocations
Date: Mon, 15 Apr 2024 16:41:11 +0800
Message-Id: <20240415084113.1203428-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415084113.1203428-1-pizhenwei@bytedance.com>
References: <20240415084113.1203428-1-pizhenwei@bytedance.com>
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 2 ++
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..fd8daa742734 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -352,6 +352,8 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(available));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHES,
 				pages_to_bytes(caches));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL,
+				events[OOM_KILL]);
 
 	return idx;
 }
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..cde5547e64a7 100644
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
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1

