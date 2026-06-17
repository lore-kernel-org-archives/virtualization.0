Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945831A807
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676329; cv=none; b=DhE6Q9L9XGXjuDXCx2APLEYk2JiDwRxLs7kV0GxwZgy2FRloNEqKWL6cB87e/TcKReP2U6HZm4JGKQ/Ul2BRzh2/WrNUj1DdT+YHn98QNe3PXAeWMRmJop4vF6ThJS5WRF5Ah6MU+w19pc3eAqGDeMXHfGPfVxCcojT8ODqNCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676329; c=relaxed/simple;
	bh=blg25tedHsr6nNuL9TCZv+jpZjqCo8VlNLK3icmEBd8=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zsx2G+BOcXZDwnCB/+IZ6+qVP//dhHRbN7gQxfrk7GAAEpc7HXjSd65oCiYuOSguqx5YplsIpJen+janfoV0UUaCPPWOd+okJY+yly5MB0S3P3Szk1oVkhtG4y0AjmGQU365F7NHSfpqLo/wNFwCfwQLWba16fFmMYjqCjtOd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwpeHAzN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwpeHAzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781676327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type;
	bh=xmb1ChIChkMfraENvR3dGIWDnpnux6Qlr9M0UKpRYSo=;
	b=ZwpeHAzNGI4jQtEuk9iBU4HHiwxEw+0wOVwZKrskj3w3wZJqpbbXzLkfDzIOQjTKcdmASj
	7fY0dos2dgjzOuFoalLS5RElxFF/eGq1zzdtDTbwAPOfSeHzJXUseSPTP2wehOw+B2Flji
	+TQmkjvv0raC0W0kgN1NVMI0qe6Y4Ik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-ysWFLL9vMS2yIu_SUes0zA-1; Wed, 17 Jun 2026 02:05:25 -0400
X-MC-Unique: ysWFLL9vMS2yIu_SUes0zA-1
X-Mimecast-MFC-AGG-ID: ysWFLL9vMS2yIu_SUes0zA_1781676324
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef0af9517so4965876f8f.3
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 23:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676324; x=1782281124;
        h=content-disposition:mime-version:message-id:subject:cc:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmb1ChIChkMfraENvR3dGIWDnpnux6Qlr9M0UKpRYSo=;
        b=tTv2CGvpxieisTEOyZeKZv310PGfIMYszha3+xSb4RQbveqwGbsg/XgJ3OC6w2eX9p
         B3nM+nrpWSRTrAHtmErFC/TgE5TY/1iLO4Fm7k0gs1JBvUAX1ITkMSm6Qo5wJKLqvAhD
         i/SWOXeLC9SRAib9qogeS6l5UoTjpveIfcuo+mF5OSsCJmT7oJYzHzRo6zB0OJYiVgBc
         vUdgChBelFdJNDohniZhQvl+i8vzVyqkIW1X04BczBfSzHSL4KtAaas3EN8EgKNuo+AA
         U2dcmyFI3hdeBzoj7beAdK6dmnOLIXN5TB/eaB097P8dREBq24p/xykEnRcuzfOs+kFk
         QZXA==
X-Forwarded-Encrypted: i=1; AFNElJ+umXdDJ4B6hisHvFvS9JFHIFMTcd6w6IM5a3L2TKXI/AkLUpuP5DCahYl+/vKnv0R+I7tG3gSIMloiYgKEMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyst09stJpnvJiZlJBN88YZHbZo+2ai3rcAXtwjEsLhxJy/q0h5
	EZyUxPWiJymuWd/bk7+e4/K+84XDbL3EGftcYXPy+SRj4kYT3DhbrZY2DpL8wazKLsO2UWBlB3B
	WJ6eBvzJ8x1R8meIVxR1OpvhJoVraAM89Qtn5IADIfXma/MIq1G8Afx6fqMgSFvON4IPK
X-Gm-Gg: AfdE7cmfWWcEW6+2koNnsNXvf4yafA4mIHpN0W287o/0iC7cHoh9k8Q62RhqIwHpwy7
	fojHuXdi2CJZoouqslQL48YP+rfLW6I7d1rKlq6iIxDEoCUbkdMPq8uPYOX8LHrUZJsqbG+nq57
	cc18QZv24sEvvc7ukalBwnE8w/OiXqsHIS+EbxHhb27DsXLFQ0XoH4t0Uw6pmNIyDl7C67YIjkF
	7RKu4e6iHmsyG5nRAGIRJTRA3yvb7j9aWO/oLdAxyoIDp3aakQNqQRy54MONjLOZvS83XCYQGJe
	g+51aWefSMEdmT83radKpoOuGtooCo+6KxZNYovOAvDFguTeKtvOFsCCrm0u5r93t2N7q21P2oZ
	v5QZIqC9X4Bvgn/N7pYGsI1AB3YPsMROg
X-Received: by 2002:a05:6000:22c5:b0:460:5979:8a63 with SMTP id ffacd0b85a97d-4623955bc0cmr3982797f8f.42.1781676323909;
        Tue, 16 Jun 2026 23:05:23 -0700 (PDT)
X-Received: by 2002:a05:6000:22c5:b0:460:5979:8a63 with SMTP id ffacd0b85a97d-4623955bc0cmr3982729f8f.42.1781676323375;
        Tue, 16 Jun 2026 23:05:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4619a041986sm26448066f8f.23.2026.06.16.23.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:05:22 -0700 (PDT)
Date: Wed, 17 Jun 2026 02:05:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH] tools/virtio: fix build for kmalloc_obj API and missing stubs
Message-ID: <a0bd4b5bed56c49626c92a754d7aceab3325de25.1780520728.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 2
X-Mimecast-MFC-PROC-ID: xGPjYfdWVmLOOEFCEOJrPSSBz82X3agHK5pDsM70avs_1781676324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID: <20260617060521.2JtULcAt86KpAbF-nsXsVSP9GlqfKewMQVDZmgv481w@z>

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

