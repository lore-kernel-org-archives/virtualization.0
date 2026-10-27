Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069804;
	b=2xPCqZC90vN71gvd7JA9yeQzMvNUqVCfPVBmYNOfyN7+GrmE/OX8mfHaUFFNWSIt09Iv
	 0nrjm6jzNRxoI5R4rrLyalLk0kUgNj5zduivc9XYz/0fmHJRfqHCVcCFmWzcXkoJKeMok
	 wua8YuRzInrjqD5oE/0ab3SY4ixuspiEB3VJB/YVEpsY9H85PjP2TOvxIHbYRs7qWXEXv
	 KYg58B0GTjk3+zAsHAg5G6Rhzft4ljuWK4qSW73dhrDlK4lqBFscI8SySHjq9aXOGDHpv
	 PTsJJPyOT3NbsVKnie6I3OXJ6DTMlOGL5tZwENLvE7+1G6cbk93UL28pjwhy5zHyZdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=0uzqgwftXz/DV+yjf2QpwILGgyMTBZAoH8uvJ/r3lMk=;
	b=OH5ttMxAFjci2zfDMMOYs0YptRl1WASvAmsp3XeXn28lYSQ954xlaf76ETNiezKm6e8u
	 aBmgikb6uMEgVIYugVkP/KHfBdVtd33G+iPeZCa2sHip1J3A8kgAmpEHsmGHM045iHMVs
	 jgEu4gPoTqsCK/4RyEFZImZdDcj/vvTXkQctuio4Gi6SqvsaUBuCd4dzrNFbz27eqJZrG
	 rElWzVsuB5r0bXPFvg5Z+syi7i71qmre72w61gcl/yGM39EEep3pwg4LGu5rhLmpvlpbX
	 I204X+vBnJOpxjW8NYf3csNtIFfca7R07ogjuVsnOeLebFHJ45iKdlurO0rTyReZDqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=R96l0y3Q;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50667606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50667606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=R96l0y3Q
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c734afb8deso5325371b6e.1
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069803; x=1793674603; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0uzqgwftXz/DV+yjf2QpwILGgyMTBZAoH8uvJ/r3lMk=;
        b=R96l0y3QMeVeRvrYJF3zS8bpoTVQFTp5jLbd4TpISzzseySFR8xy28Sekl/FBTxa2z
         yGcgPdefGE3n4DBuX7WM65KMP9CANzFKL5ubyF7Ud+aA1wjiu4DtVatC0quga1RWZ54d
         jOic0RM9BYjbU25tScRWiG0AAhXzgYBQY/XcazUzPIX9cvacZbDOg5YwBPsNKnhQ19lf
         wMRTcoE84/o0S4sKgRloBxXLEP6ECuffzBayh5AwRKEU57vzsAWJa0gYveZfygtGPDX6
         2djuej0blkmMANCyQrcLPGBHoOsh20FRVt09ZP2RpDhU07lok+bTnNBs7PRpx+gCTJES
         TLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069803; x=1793674603;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0uzqgwftXz/DV+yjf2QpwILGgyMTBZAoH8uvJ/r3lMk=;
        b=OimUVVpCWzyyoYCZs07ObemaG/8BlzpTpzaLDTPWTVYocAWPeBVnmhGzxVFlDhdcCD
         D5ar4g/aaTNIwQ++vdF2v4o/+8rNaQLpOFjsCS8DNwLVvnKUn7sR5kylvyJh+8AufM2m
         uHYlPhWc/npEPsYyMK7mzCLzrGCQqKLL7rXUZme0cJcmdcQQLacXD+n7JPiUKMDUAciw
         msmoEvyYxm497o4YWw87oqsX3JLLRyCJ5Sth19vVteXdtQDoxcnmdBTsaDBXvsxHeINn
         aCFZ58oUOgTStRK7PV7ezF0KIuTeEKXdqRLk1PgNRBeB3AAdjWewdfbyoHbHHabgvUVA
         SaWw==
X-Gm-Message-State: AFq9FYKuvsyzGokNpCu7WwWe3+q3dqQdHD9sMHKWnQ1Ps3CMJETVbxoQ
	F/UfQEZk2pQ2ibWCNbAohFI36+Z4K4O8v6tXGYGejvUGKL86QizG1GvSLiDvh+aIGDSfI2xyy5Y
	JDojKbTfPBxQgU65PrFJpICHs4bTXf+qdrg==
X-Received: from ioxz3.prod.google.com ([2002:a05:6602:17c3:b0:9c7:733a:80ab])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:448b:b0:4ea:14ab:142d with SMTP id 5614622812f47-55c002fc7b3mr5525425b6e.40.1793069802970;
 Mon, 26 Oct 2026 19:56:42 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:05 +0000
In-Reply-To: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027025616.1632690-3-kevinloughlin@google.com>
Subject: [PATCH 02/13] virtio_balloon: add reporting_vq DMA map ops
From: Kevin Loughlin <kevinloughlin@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>
Cc: virtualization@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sidharth Telang <sidtelang@google.com>, Punit Salian <psalian@google.com>, 
	Peter Gonda <pgonda@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Jacky Li <jackyli@google.com>, Steve Rutherford <srutherford@google.com>, 
	David Skidmore <davidskidmore@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

In confidential computing guests where VIRTIO_F_ACCESS_PLATFORM is
negotiated, the standard DMA mapping layer rejects mapping unencrypted
or swiotlb-bounced scatterlists when reporting large free page blocks
through reporting_vq. However, the host VMM only inspects the guest
physical address and length of reported free page ranges in the
virtqueue descriptor table and never reads or writes the reported guest
memory payload.

When guest memory encryption is active (CC_ATTR_GUEST_MEM_ENCRYPT),
attach custom per-virtqueue mapping operations (balloon_reporting_map_ops)
to reporting_vq that translate scatterlist entries directly to guest
physical addresses without allocating swiotlb bounce buffers or
decrypting guest memory.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 drivers/virtio/virtio_balloon.c | 56 ++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index ab3e3d887e00..11f74848fdc4 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/cc_platform.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -580,6 +581,55 @@ static void update_balloon_size_func(struct work_struct *work)
 		finish_wakeup_event(vb);
 }
 
+static dma_addr_t balloon_reporting_map_page(union virtio_map map,
+					     struct page *page,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir,
+					     unsigned long attrs)
+{
+	/*
+	 * Free page reporting transfers physical address and size metadata
+	 * via vring descriptors; the device/host never accesses or transfers
+	 * data on the page itself. Return the true physical address without
+	 * DMA mapping / bounce buffering.
+	 */
+	return (dma_addr_t)page_to_phys(page) + offset;
+}
+
+static void balloon_reporting_unmap_page(union virtio_map map,
+					 dma_addr_t map_handle, size_t size,
+					 enum dma_data_direction dir,
+					 unsigned long attrs)
+{
+}
+
+static void balloon_reporting_sync_single(union virtio_map map,
+					  dma_addr_t map_handle, size_t size,
+					  enum dma_data_direction dir)
+{
+}
+
+static bool balloon_reporting_need_sync(union virtio_map map,
+					dma_addr_t map_handle)
+{
+	return false;
+}
+
+static int balloon_reporting_mapping_error(union virtio_map map,
+					   dma_addr_t map_handle)
+{
+	return 0;
+}
+
+static const struct virtio_map_ops balloon_reporting_map_ops = {
+	.map_page		= balloon_reporting_map_page,
+	.unmap_page		= balloon_reporting_unmap_page,
+	.sync_single_for_cpu	= balloon_reporting_sync_single,
+	.sync_single_for_device	= balloon_reporting_sync_single,
+	.need_sync		= balloon_reporting_need_sync,
+	.mapping_error		= balloon_reporting_mapping_error,
+};
+
 static int init_vqs(struct virtio_balloon *vb)
 {
 	struct virtqueue_info vqs_info[VIRTIO_BALLOON_VQ_MAX] = {};
@@ -641,8 +691,12 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
+		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+			virtqueue_set_map_ops(vb->reporting_vq,
+					      &balloon_reporting_map_ops);
+	}
 
 	return 0;
 }
-- 
2.56.0.307.g5fe7bd680c-goog

