Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069821;
	b=y7O+7l5t/GCwfk3QpfCI9EXZN9nT7D7bfGKNPg+pLpGOj5fsyACUSt9t16j7pZ8+qLHW
	 s67db1M0EbXCJixJvezbWsXDpgqaOkO8su7OdvQFMAg9p7exta13yPts4SMACPpzVa2a2
	 5ztrfG0NBYjoBV1iwKly/eBwa0SdkTCs1KTKrlecB6/H1psfT+eht+Q10fhpEqGLqGnLS
	 orBf0wcfcRn/fKDxf7xMbLISJ76D5VqcfEs6TzaK81wTTuEzl9qinyF7xVMBaJ2HBQCib
	 c7wgvEdm2ZDjEV2TKDXZ+6LSxROgLk1z9puDDfEbC8tc6wEPIvnDN/j6hybte3Ro54Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=CMgB+FzrQPZBtoyno0UE3jQCmYhoPeFOpiZUNmu3S6w=;
	b=Ps4mITlqbwI3oN3o7P1FmKmCl1kn76AIkrEcVAS921VCuCfX56lq01zHA4SMGx9OpHRE
	 kL29rVlZNCbynii/7YaLNYa25NRJAXmcSiBnHGM8JsL4wPxEPmJhQD7S+uViwOxqrx2wO
	 9waccJcd3ylsg6QrcGykp+Kv3S0b1JUcPlMS3NVIuN9zay0iOVV/0P7Naxqe5mvirKT4I
	 4MMPBDem6/7v2cd6GRljeH5KyX0oB5WdoSGn+mAHhU8k3ayWmlVdVuazbvef86TfK8tdC
	 U6Sx1MkpMDFX59qzR3OlagAel+cx3lPjOwwum354aHuLkqSRiHUfHiN1bYe+zY55pYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AcJ3FXmv;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417260A3824
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6417260A3824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AcJ3FXmv
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c307941971so5068234b6e.1
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069820; x=1793674620; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMgB+FzrQPZBtoyno0UE3jQCmYhoPeFOpiZUNmu3S6w=;
        b=AcJ3FXmv3hCfPJfGmf5idBCx6VMc9HUOH/Xs1bBFT9Wt1PO2dw1UZzDOmzaIOcoyg2
         w1K0mZkEkOA+lBGyxbx5sA7bxtjGnz4IMWxZSwoEAIfVuSmuayXpy4HaI7S+aAk3BcxM
         cAmrUq64kCnDe0FRKyZQk4Ijnih0mxAK6tyefoxYK5Q2aHjaT8U6U2N12H3iIRgDvzcg
         DQFfmOCzlYhdwNRGpanl0NTKfez/rgiiseE5jxUNe+GisYuq57n7OutthHWla+oXUpFd
         kLuIAjPli2yZYGNhK7/uWF+h7acWB/mu1Hr/dovvW0AkhAIcEcNJ9hGubhYpsPxAYhby
         2p/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069820; x=1793674620;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMgB+FzrQPZBtoyno0UE3jQCmYhoPeFOpiZUNmu3S6w=;
        b=Vg1PKRAjkc2EpqEZkvZZAS44vElKrACNNYmK5O9202JTs+xRqmRUhD/Q2RdMxxOz6K
         ywA/nRPdPZfS3AvuxG8zibhmm+2GsQ/4m6YjdEiTCeqFmrkIEbVcmomgMga9PQ9481P1
         ihrPF9GXo2IPym8Oi6QfhwWMpAWtzGLx7yhc+u2Ti34/jOR4LhOwms+AZ/mtZ3Is/w7Z
         1HY2RnBjgBEoRKfhNtIKDw5q0etyBmvuzHY2baZDsqM86ENsn3NOAe04UZB/052Dhg3/
         hxh1qWULqOTfLhLMwV6C9pUBH3OQln01bfCgl7ygpU5sdf3FNTY0RO+lsEQeotY8S8fG
         yttw==
X-Gm-Message-State: AFq9FYLg7oEBHg4OVQQczUVGR2E1Xo5rSqzorbefNyzw5X5qFiDr+Tmk
	RQh/+1MmSJDJ4CCndAfWYFutzZVWQloT5cuXIy1XYRJ6n0EMe6TGyeS7BTKyO+S8eluTdDj9O0L
	mS3pnrOct8vm/S1t6CVD2tCMBrog3QTwDUg==
X-Received: from iovf14.prod.google.com ([2002:a05:6602:38e:b0:9c8:5014:752e])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:50a3:b0:549:e9e3:9490 with SMTP id 5614622812f47-55c0023237emr5583862b6e.23.1793069820114;
 Mon, 26 Oct 2026 19:57:00 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:15 +0000
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
Message-ID: <20261027025616.1632690-13-kevinloughlin@google.com>
Subject: [PATCH 12/13] virtio_balloon: unaccept inflated balloon pages
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

When pages are allocated for balloon inflation in confidential
computing guests requiring page state transitions, mark the allocated
pages as unaccepted via mark_memory_unaccepted() before notifying the
host VMM. When those pages are later deflated and released via
put_page(), the page allocator routes them to zone->unaccepted_pages
for lazy re-acceptance on demand.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 drivers/virtio/virtio_balloon.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e10bd792ef7c..217431e75751 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -329,6 +329,15 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 		unsigned int pfns = (1 << page_order) * VIRTIO_BALLOON_PAGES_PER_PAGE;
 
 		list_del(&page->lru);
+		if (virtballoon_cc_needs_state_transition()) {
+			unsigned long page_size = (1UL << page_order) * PAGE_SIZE;
+			phys_addr_t paddr = page_to_phys(page);
+
+			if (mark_memory_unaccepted(paddr, page_size)) {
+				put_page(page);
+				continue;
+			}
+		}
 		balloon_page_enqueue(&vb->vb_dev_info, page);
 
 		vb->num_pages += pfns;
-- 
2.56.0.307.g5fe7bd680c-goog

