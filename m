Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13936C09C
	for <virtualization@lists.linux.dev>; Wed,  3 Sep 2025 18:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925990; cv=none; b=orcwu58MjsKOt5omfJT0UXamuSPCgiqkLjGNAYZzS+0l/+iLfJgI91cWreEcxjGK9CP/Bwkghrt9omMx6eeoeBYph0MGMLm9WNhzjJY54K4EtEYmSyaGVob6vwAcJL8bHTYmaDB8sFPL0xrGlEcUIPEbgsoVAOjDDH07aLy7+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925990; c=relaxed/simple;
	bh=9inLvC2KfY6Q8SKkB8WqxnCMttpVG+lmNs2hVN/EM80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBzLHaLG8yMRzEou9myljwItKHzeHtjjwjteJv+t2frSjf03YahRenZPC4tjQQMI4XNmD1HsreUHoAcwV/LVJUCQqL4Z+J1l2Gb0NaC7OGKMfZ229njF47b6kPIZXbTtaA2RiFvcW5q6sfajjzXuztntBCkdv3fOPv7TjUQwgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmYAq+mN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmYAq+mN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24884d9e54bso2891205ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Sep 2025 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756925987; x=1757530787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xP13CUGWmP4Epf7561SmRsYIMeFmCIW416h7MJfMP4=;
        b=BmYAq+mNVQ6O2wRL5mDxdYuv7io4B3LxhLGGLbLhjYffZ+LaMAkIc78i+aIOTfagOt
         uRgo5Bwpo/ncrcr0B2K+J6weo3XSoL9W53ijjRjeJlHGqZCQuNKb7PEkIthstcPMvOtV
         NNV1uG867B6ELmSvImujLh3ZZhzSUzYdQ1w07KM4xEJMK/fi6rIRDzGhO7+KPpJlrqJX
         ajfBB9J882CBH56eJvPaD99YTQAsPse0/ca23RY5PLZyp6RTjicYtC5eB+5HZEEED4MR
         XidK1OSQjPgipIxWj1jsEXcZ8WnEjkpS2SUD37O00p/VmUGNR+Z2ik7+rVeiXt+QyMJ1
         dd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756925987; x=1757530787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xP13CUGWmP4Epf7561SmRsYIMeFmCIW416h7MJfMP4=;
        b=ncKRXNhZMQejpKMyzB8gMRi2rUUQ0NlTS7VWDb9jBdxNO36qFS4eZKGkCvujkXqTao
         Cb3rh60WjuMj/Q1d0/yAaKbRJ3ryTDdD1cXCshQPOFHJVEa2jLfwoyHg0o6Knq4TK9AK
         qeROwl6aATocTZz3BRanK/F2Z38PP1Ii0QPPnI7sxus8VjeCgY4hlYLVzxtlqLBg/fTH
         jm3Li8vtKbnjorAOP4SgSWEERaw8okUMOpVoRc/hGAbcdPs3LVoah4jl+n50mFq7uqx7
         FxJEr51NJzQB57g7qfaeBIM4b7N18hsinkt5kLXkv8hblEAT8EmfXB5d5eHphtAH/Q9/
         BaLA==
X-Forwarded-Encrypted: i=1; AJvYcCV1I/W9MVBJS5xnXLJeiJ8NSZYdDXN4C4/OO3Or0p4Xp8VRJn9KBCOtrZlEbfiO9gekbUUt42gToYSmP6xq5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaDNXJe/bN6sFF3wGt5VCluNQNRFHNjfahxLUTc5Ymr7CV0oqw
	mt58oVuxs9eyzremC5pfpvfBZZDEGROza5WsjYPUay7++OTHS8FBYOZy
X-Gm-Gg: ASbGncsGMyZeMpNloeORM6oSO0zh7XyuzSZ5cBTTJ5UQh0ZVjS3X3KuT2N6XSUFty0e
	NMa3yvqwkRHb00E/xwARwxqXvP3Yqu4iT+JoW3BfElK2jBCxrp9toXvYD5pIBTsijiUMjTeDLqr
	M2um+LBdHJsBWdWFwBNkCr+kacKhn2BgPwc9fHh5qv166Ni943wZVwY145ejrTj2QIkfCWvVF5o
	I11aI/rXLhimpOlpNVS6/7R/+ZcxyZAWwBwb0jAU05TpxbYKr/FErfF5PLOxxfbwMfiWSUv/tn+
	FEiKXUjrDdJX7Yl74I+CcElUpcTs3vkLKNxiLRDFpE1UwOHv5xyblCJmMZ2LwLGmYU4q/VgbLIU
	kFtD2tJJdLtlQOBN6P8tlqGoCbLKgteH/vOKsI/mryjMDOc4Ax/kIqWsZzDy2pTkO
X-Google-Smtp-Source: AGHT+IGWl2NVhEd4Mf3PXgbO9PNmoIZrvx3puV/+d96WnhVgMh+tacbQQZaHLdVwJGJAzq5ejH+5QQ==
X-Received: by 2002:a17:902:e5d0:b0:24b:1766:cc70 with SMTP id d9443c01a7336-24b1766d2d6mr89341175ad.39.1756925986861;
        Wed, 03 Sep 2025 11:59:46 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-249065ab343sm169403475ad.126.2025.09.03.11.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 11:59:46 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	virtualization@lists.linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 7/7] virtio_balloon: Stop calling page_address() in free_pages()
Date: Wed,  3 Sep 2025 11:59:21 -0700
Message-ID: <20250903185921.1785167-8-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903185921.1785167-1-vishal.moola@gmail.com>
References: <20250903185921.1785167-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pages() should be used when we only have a virtual address. We
should call __free_pages() directly on our page instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 drivers/virtio/virtio_balloon.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index eae65136cdfb..7f3fd72678eb 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -488,8 +488,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
 		page = balloon_page_pop(&vb->free_page_list);
 		if (!page)
 			break;
-		free_pages((unsigned long)page_address(page),
-			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 	}
 	vb->num_free_page_blocks -= num_returned;
 	spin_unlock_irq(&vb->free_page_list_lock);
@@ -719,8 +718,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 	if (vq->num_free > 1) {
 		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
 		if (unlikely(err)) {
-			free_pages((unsigned long)p,
-				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+			__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 			return err;
 		}
 		virtqueue_kick(vq);
@@ -733,7 +731,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 		 * The vq has no available entry to add this page block, so
 		 * just free it.
 		 */
-		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
+		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
 	}
 
 	return 0;
-- 
2.51.0

