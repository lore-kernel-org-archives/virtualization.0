Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069823;
	b=rFu3z6xF1Bel/mQSiOFBto4uC1+5hPUPNv/SPNvvAa0fkK+YXx9oVYNbHYi2BO7jGJeX
	 Zkm56+Zgl4qh6asi6/Hbh2TBrRX1U85mI3ePY9R+6xvKVgdV+P6l3ZEw8R/5prTxeRWiE
	 XP7sCP2Or07q4Hw1NpTmWd9v7jjqt3hBPpwxFnXdUUQqoToB71yCfVfiF+9AHhP6+lu7f
	 U9GbBVG6pyjfcD1GCMTlyEejUvRScPg8fnrQyfXMZxIZoH8ZvBDh6UXEV14mLajl1cvjU
	 UuO/eYHcxhqjnFXkpd7doozavLJJEZkizoaqSHRSErliHCYP/CwEGg3WvvMVuWgNxDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=0dhD+kOKqUQOH4NXaqpvq7snu+OHZ+U62/aV76eABXw=;
	b=tTDCT89ZKtsVvLj6nS6g0AZqZzfJxo9Q4cv4glUzxPxovcQX9M46GTIgfY9KLW0AQPZ/
	 ByPXqCqxQ3WHyEt+xW80sBGwarSYyRs4T6I0jGkKIBjZXnBiwA9nN+JsdrqLX1RkNofRY
	 E9Bs0DsRqjRChvl6Wnt4jDp5hQnYaZciatlUIzmcYmVZu9e0U4aB7FchEjbICPuQ1mubn
	 JnXl4vTcO+MFRapGKpHFUUnI3NjQpztphw33eVaXjgf3+BJXeuJ9gTj5ufnejse/g/ICG
	 vJyRj5MwdOiOq08R517KVgNsimFGYbT/cySpzGlp4RdKXB+4mODdTqcM5tme2KFO4dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JymU9vxZ;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F660A3833
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A5F660A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JymU9vxZ
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ea2c058e67so6006815b6e.1
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069822; x=1793674622; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0dhD+kOKqUQOH4NXaqpvq7snu+OHZ+U62/aV76eABXw=;
        b=JymU9vxZ5d2BzUGP9POXyuRxZGRn3DxifwQvlKwxe4+IPRa/LKgy1ec/JsdJR2TbPM
         VCexoGlBKd/YD9yOsFlbZvAKmKr+VUczGwswa/7aFot7SRIMbOzNtuLGoVPdQYIukioC
         mDPyN8ya2YQSp4YBbIX+wPu2zc8vgERstJ6+Q40yxmFMpPSMxqNZ7v/HYpOExM/5adXz
         a6kEqV5zRzRDX46T9hwDDUangIvYQVeb8csjO+a1M4u2Zaj/vFziTyTu1xxx5PopgtZI
         cmzqBPAjETvBqVRKjHWrjh9RPVVjN1daOkyQ4he2h+JZbL1RrrhQWnrdTbR6uPAsnBBs
         05jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069822; x=1793674622;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0dhD+kOKqUQOH4NXaqpvq7snu+OHZ+U62/aV76eABXw=;
        b=osZ1WZ3XayM33fSj9qZ7wTtU2O9dq4dvP0JAB2pFxklk8MUzVvZafmGsMaMwEWm5Sg
         cso+rieH1KcdGaK/6lGk1ng4roGHVnGObr4xxTOnEfDj8j3SOCaGl/MrJvTUA0YnFgNI
         EUIiZPXYUrfagqXWwxZpkRy70WShOPhVq7HfJ7odkRlOJrgy/hAi66HZ4vpH8Db1wykc
         pR6hFtQLBF0XTC/dfc3cCHkPQLKd0Q4JRZqS0VwUipb0DI2o+eGQ9UFM89kI0UTR+c2/
         7gKOHlMGAYI906v2rRBK4K1ceM5rKQRsB0J/PgU6Sh8t5cZ6mT1dETpksHR57dwF41CX
         2/gQ==
X-Gm-Message-State: AFq9FYKOYNSNswcvmXD/Xz/alwAJ1oeo0NMA1SSVJ8xg2jAwReoyyKfQ
	0svO8CmMWWb5TfWW+QTLDGAuS80HHicdmQ8WVd66TtQHKP5nZ4z4mqS9yQwJpjXZKr7TcqICrnw
	StC9mi08VN2dlI8XrVnKXTt/WVro1cxDwJg==
X-Received: from jacnq31-n1.prod.google.com ([2002:a05:6638:e21f:10b0:61c:8e68:e95d])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c1c4:b0:4c7:7ce5:a32a with SMTP id 5614622812f47-55bfff7e470mr5562520b6e.4.1793069821819;
 Mon, 26 Oct 2026 19:57:01 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:16 +0000
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
Message-ID: <20261027025616.1632690-14-kevinloughlin@google.com>
Subject: [PATCH 13/13] virtio_balloon: enforce ACCESS_PLATFORM in CoCo
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

In confidential computing environments (CC_ATTR_GUEST_MEM_ENCRYPT),
virtio devices require VIRTIO_F_ACCESS_PLATFORM to negotiate restricted
memory access and DMA bounce buffering for virtqueue rings and
metadata buffers.

Currently, virtballoon_validate() unconditionally clears
VIRTIO_F_ACCESS_PLATFORM, causing virtio_features_ok() to reject probing
the balloon device (-ENODEV) when restricted memory access is active.

Preserve VIRTIO_F_ACCESS_PLATFORM in virtballoon_validate() when
CC_ATTR_GUEST_MEM_ENCRYPT is active, clear VIRTIO_BALLOON_F_FREE_PAGE_HINT
in CoCo since free_page_vq maps MAX_PAGE_ORDER blocks through standard DMA
ops without unaccepting them. Reject probing (-ENODEV) on CoCo
platforms where balloon page state transitions are unsupported.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 drivers/virtio/virtio_balloon.c | 36 ++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 217431e75751..ae011636c07f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1311,6 +1311,14 @@ static int virtballoon_restore(struct virtio_device *vdev)
 }
 #endif
 
+static bool virtballoon_cc_supported(void)
+{
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return has_unaccepted_memory();
+
+	return cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT);
+}
+
 static int virtballoon_validate(struct virtio_device *vdev)
 {
 	/*
@@ -1318,7 +1326,17 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	 * initialized. If we cannot do that then we should disable
 	 * page reporting as it could potentially change the contents
 	 * of our free pages.
+	 *
+	 * In encrypted guests without unaccepted memory (e.g. SEV-ES), the
+	 * hypervisor cannot populate discarded pages with guest-encrypted
+	 * poison/zero values and the guest does not re-initialize reported
+	 * pages on return. Clear VIRTIO_BALLOON_F_PAGE_POISON so reporting
+	 * is disabled when init_on_free or page_poison is active.
 	 */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    !has_unaccepted_memory())
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+
 	if (!want_init_on_free() && !page_poisoning_enabled_static())
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
@@ -1329,7 +1347,23 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	 * virtqueue_add during page reporting.
 	 */
 	__virtio_clear_bit(vdev, VIRTIO_RING_F_INDIRECT_DESC);
-	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
+
+	/*
+	 * The balloon bypasses the DMA API for page addresses and cannot
+	 * support a physical or virtual IOMMU on non-CoCo guests. In CoCo
+	 * guests, VIRTIO_F_ACCESS_PLATFORM is required for bounce-buffering
+	 * virtqueue rings and metadata. Disable free page hinting in CoCo
+	 * guests as free_page_vq maps MAX_PAGE_ORDER blocks through standard
+	 * DMA ops, and reject probing on CoCo platforms where balloon page
+	 * state transitions are not supported.
+	 */
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+		__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
+	} else {
+		if (!virtballoon_cc_supported())
+			return -ENODEV;
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT);
+	}
 	return 0;
 }
 
-- 
2.56.0.307.g5fe7bd680c-goog

