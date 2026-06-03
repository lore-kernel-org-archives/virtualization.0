Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E348C8A4
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 21:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780520813; cv=none; b=VayQmrUJSXgl6Ar8F2+QxQCCaLEV8E1S7Pi5A5MWbz75mrjB7wydNWCdRMdvkaOqKt46uCPhg/EwvVF0f9+YvLJVHYzifvbTXjY92xMM9pmx1DX5xRp8v5t7Y6BNnQP8wh5fx50DXRBE2hM4dcYhTZZxLJkDoXLF1HYyVVMieXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780520813; c=relaxed/simple;
	bh=blg25tedHsr6nNuL9TCZv+jpZjqCo8VlNLK3icmEBd8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DynmmiOgE3PV8uxuy7fXuQIisQt8IodN3oOMGCfa9R5N8UyJXnpehXrBgLitCdkXjV4u0dPTOSE5GcyE64efMiXhBpMFGoPmnZKRO291mpnq/N8rzYin8b67Cqw0vHGbw5IJSiwxhdJJ88Hg7Fz3UmUAYD0kd8E+xcuHdLztzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjbWxvSN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjbWxvSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780520811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xmb1ChIChkMfraENvR3dGIWDnpnux6Qlr9M0UKpRYSo=;
	b=OjbWxvSN2cyX5tCcAySAxM4mDmU4dZQA7/HbWuF/zR7e/oQ9RhFgfH17cnSwLg5qrHpkxp
	2tQk36MnQuKZVnXrpS0hTf9s+lt+9eDWf3ZvjJPbPcj0wDgZbyQfmWXVbZhNc+Loi/731t
	EQ8fgIv2ZTh3BlTbjSR+NGTf1lEteKs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-UX0ZJjO6PJ2kLCGHwm3yMg-1; Wed, 03 Jun 2026 17:06:46 -0400
X-MC-Unique: UX0ZJjO6PJ2kLCGHwm3yMg-1
X-Mimecast-MFC-AGG-ID: UX0ZJjO6PJ2kLCGHwm3yMg_1780520806
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef0af9517so4984426f8f.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 14:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780520806; x=1781125606;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmb1ChIChkMfraENvR3dGIWDnpnux6Qlr9M0UKpRYSo=;
        b=FaUXV5wuW+C8XVjFK8r5ZZU/eIaeVYd7H/LVUSseS8gHMdyaFGnVIQW95f2aaJlDMe
         n9GunDCM5g3Wa08GneedrrCYlPvbxIgjrpDhb3g/R4b5lG9vNSdqhiH++QTtiFfQgSg3
         mX0Pa4PqLlB2zPhu/6UjFV1uNSe11sLwD3xu5x1srzsB5WUdqSXOIll5F2yNrQ0rS6xF
         oohkyR+0DgXZvwVM+YsyAvoPahxrOgZ6+wHvtr9n90b3/fsr187FdCWZAsBbdwUeF0Bb
         Eh4jln82gyyCWGINnqU/K0ksVSWGKxiZjgpK+g5hwObgGo/eg3ZzKLD0vWNjBh112cug
         L/NQ==
X-Forwarded-Encrypted: i=1; AFNElJ+FSH0szbvM+AFSIz52H2K7YnBVMYPakR9t8CxkXRmbx1YSg8hRBF8AqyNVuNjGM9LmFShFhuUTqdKJsGW0gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyMz2wJB5rzngDJl8UbgqdckIaFjeQV3kas9Zo6JWaSe60YHZx
	RAicpsj7Q3lJO6vuJ9uRy/xUEseyigi4QxBs8ZZgU+Xo83v614HhCoAlyEEjtUwqewEReCb7/kK
	wSwN056bzuiVr2vcGII1YWA2HhLsHsXcVbRPp5J9fygqKsWFoasCgZVH7Nsc1xDQSA8O9
X-Gm-Gg: Acq92OFzXCd51TWqVMB3HAUG3ooAkjgOLV97pxaPa+uDjsdn+GD6PUlmkGB0Q+sCxaJ
	vt3S8CfvpJCHa5wdpqbr3yizc+uDeZkqt6JWXTZxyQHvg75AgzsYiVEeQ5rH3emVM6D1L9eu9qT
	A9jflqYalhyB21znxn3MTZidpvn8VG93DeZdLXsux3OtyMYG2ye6aOemXtl0RR4MoUhYl3U0kTh
	Gk/4Rdgz+jTXbvn/jGSHSVubpaudMGg5DIh+cZKsP2PdlKMExcfJA+DXdcr+KMcdn9CYujZEs5T
	KnNmn+ZnucTJtBL7kEniZ/nVRVXn9uqG3YFrwpJ+ZptJfdV52floRJ19QnZmFNNPr8OvykSynDo
	eJ6bE/eHKVNcywCCYwGgbxMGaX97uFUCpeGELQpyYxG683JSDhYHklg==
X-Received: by 2002:a05:600c:5288:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490b5ed01damr84818025e9.28.1780520805626;
        Wed, 03 Jun 2026 14:06:45 -0700 (PDT)
X-Received: by 2002:a05:600c:5288:b0:48a:53ea:140b with SMTP id 5b1f17b1804b1-490b5ed01damr84817595e9.28.1780520805193;
        Wed, 03 Jun 2026 14:06:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413adbsm20086155e9.15.2026.06.03.14.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 14:06:44 -0700 (PDT)
Date: Wed, 3 Jun 2026 17:06:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH] tools/virtio: fix build for kmalloc_obj API and missing stubs
Message-ID: <a0bd4b5bed56c49626c92a754d7aceab3325de25.1780520728.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kAe1SD3dflOTHvCffoq5Lu4O11nLouAqmb6cChcmgv4_1780520806
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add stubs for kmalloc_obj() and kmalloc_objs() to the tools/virtio
test harness, matching the new kernel allocator API. Also add the
DMA_ATTR_CPU_CACHE_CLEAN definition and include kernel.h from err.h
for the unlikely() macro.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/dma-mapping.h | 2 ++
 tools/virtio/linux/err.h         | 1 +
 tools/virtio/linux/kernel.h      | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
index fddfa2fbb276..8d1a16cb20db 100644
--- a/tools/virtio/linux/dma-mapping.h
+++ b/tools/virtio/linux/dma-mapping.h
@@ -60,4 +60,6 @@ enum dma_data_direction {
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
+#define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
+
 #endif
diff --git a/tools/virtio/linux/err.h b/tools/virtio/linux/err.h
index 0943c644a701..b7b4cb516dc9 100644
--- a/tools/virtio/linux/err.h
+++ b/tools/virtio/linux/err.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ERR_H
 #define ERR_H
+#include <linux/kernel.h>
 #define MAX_ERRNO	4095
 
 #define IS_ERR_VALUE(x) unlikely((x) >= (unsigned long)-MAX_ERRNO)
diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 416d02703f61..104abf9d1aee 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -65,6 +65,12 @@ static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
 	return kmalloc(n * s, gfp);
 }
 
+#define kmalloc_obj(VAR_OR_TYPE, ...) \
+	((typeof(VAR_OR_TYPE) *)kmalloc(sizeof(typeof(VAR_OR_TYPE)), 0))
+
+#define kmalloc_objs(VAR_OR_TYPE, COUNT, ...) \
+	((typeof(VAR_OR_TYPE) *)kmalloc(sizeof(typeof(VAR_OR_TYPE)) * (COUNT), 0))
+
 static inline void *kzalloc(size_t s, gfp_t gfp)
 {
 	void *p = kmalloc(s, gfp);
-- 
MST

