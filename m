Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6B3A3E62
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689469; cv=none; b=CDzcbG4CeztsAP79KNU89rkkJ1VxX+POPjGsCjofvBb6HBGMnGloMe9RHUb50SEJHWJ2zfIK+SBEJjZhoX0nynlGI3KRlM5CMSPkqedyRXBZbNz+qHn/XA3UfM0pLak8guuU8RA7yedht/URWqLcJMEWGmNX/CX1wdg7HxNIS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689469; c=relaxed/simple;
	bh=AZKQuPir2M6D9nuVJhXEkkcoZRJ4ZuK7KdkVVibbYjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TiZH9NBVkklFFdPcTpmgDK3xOX95CWaYKULBk9DN7Lpwcn25JcPXyXgx2H9kKaX0wjOfINVSp6ndlIL3Y5AgnhdP+HJ0LQ7zMqRWvVTV9ZA0Xh5rp9HlgODVPx869T7L8rxkXSqk92qOr1lubPpj495T4yayzLzFb+/pA/4lIyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BFmtyi1l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFmtyi1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tQ3NH90R6jD51b/2nlDfTNF+z8a8ZXOca/8W5MzOPpI=;
	b=BFmtyi1lF2KPessxrrE4u/n/LLma1HlpAV1pmeFBKpbm53qHjyqgamA8EHWZexaCoBwJ78
	hIZ2lqVNt5yAdDcvCHVc/YZpJEwLFhtJsel0bJ5NIK3AuowUQiUoR8W8w9gThu9UgTUc78
	HNyIJ7RKs6veMr4n1mC3jbq2lonJkgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-gzf-c6nPOI-r9o8qe2mkHQ-1; Mon, 20 Apr 2026 08:51:05 -0400
X-MC-Unique: gzf-c6nPOI-r9o8qe2mkHQ-1
X-Mimecast-MFC-AGG-ID: gzf-c6nPOI-r9o8qe2mkHQ_1776689464
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488bd1ee9e7so21560985e9.1
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689464; x=1777294264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQ3NH90R6jD51b/2nlDfTNF+z8a8ZXOca/8W5MzOPpI=;
        b=h5E+ylXA+1pHMktTTi7hx18/OloPKA1CSE/mq7hYiWZyiCxXRrVNCfxPJMAiYGerJe
         lWixbP9IsDNT+/nTZfIR1iCczHGRCKEqWrNxnV0abZ+m/bXHEYSoytOUxS+LIwyfinn7
         guYEgu/EWRbQ5W4enqGoIzbyPGu2P7TfU4BI05KvGr040b22Psgb4tuJK4i6OcfGJ5yJ
         +tyxgFN0jcNTwE9X7cO5POKN2l6pvMeDAUYIR4k6OFbhJY68pXcG9zuV6rdI9eA4dE+P
         Ep4nAYGfN+aLhv1E5ctBDVBRSVqlTD2Qdmy3T7qzurSej4jwVDvTPqfA2NADfk4bMRSz
         H90g==
X-Forwarded-Encrypted: i=1; AFNElJ8ctbm74Z+1JjqZie3Nb82ozUHvBDhy0nfuen9vEdmTWbspP8fgy6YnYG3mmFzLyMyzaj6BzhSnKyjkrZQ1fg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8VMtRbEAARi4x9b7REOKG4pZbToQw14M6xkaLg0qq5MWEC4Au
	02i9DP+FYjC5YUE1id6RTlV5t2oEyNtzcAVk3KmZ3VAbwdofZ/QR9ygJEzM4jl39HzN1ld+rIS9
	vGp2mkIjgFtRuzcXfJlbjE/ImV3p7jtoVkudGmBoSNKVkcXQONef+qFn3/tup/KJII/cg
X-Gm-Gg: AeBDiet1mTkm1cK/MJJU8gHMw0mUCym2mOmcaTB90eNQclCjC15z1RXRNNFWEk6eDDV
	L6ugybf8LK70gJpgweUhgfrIz4NUWo9rIi8xpEEaTetkTBbtbkon7+aJub2jmff+bd8770ZvQV8
	An6ona/NYpgSKafkmb/AgTC8/O/k534c8ocqkxc8DdKLtFi5aqGwg4ZF2yxBrPtg1kcOt+dmyan
	3uik1G1+3b1dXt/lykfwR4N1rKXUUQJcm4mpu56eWgmP5J9urPMFEQsh4sohPNuhO6Jfk91broA
	ShgiL41MgHoupT7TrffDZNJd4CuRAFokbMDnoIymJ9w3NkRKGU1ENxqYDS8gHcA3eg4mRMmDFM2
	3g/jV7NUB7IsQQ8t1VNiDdIOnbHV1pzMauWCtBBQqS1YN9C984TK0qg==
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr196781085e9.23.1776689464236;
        Mon, 20 Apr 2026 05:51:04 -0700 (PDT)
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr196780585e9.23.1776689463650;
        Mon, 20 Apr 2026 05:51:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-489393ddd69sm12665675e9.10.2026.04.20.05.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:51:03 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:51:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v2 15/18] virtio_balloon: add host_zeroes_pages module
 parameter
Message-ID: <0667676f47ce42c1b9086dc80987773d96f73861.1776689093.git.mst@redhat.com>
References: <cover.1776689093.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776689093.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nSwHYPdETf0w8yxM1Nt-W0fC_W99r_nnaq26ixA_qZo_1776689464
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a module parameter to opt in to the pre-zeroed page
optimization.  A proper virtio feature flag is needed before
this can be merged.

  insmod virtio_balloon.ko host_zeroes_pages=1

When host_zeroes_pages is set, callers skip folio_zero_user() for
pages that are known to have been zeroed by the host.  This is safe
on cache-aliasing architectures because the hypervisor invalidates
guest cache lines when reclaiming page backing (e.g. MADV_DONTNEED),
so no stale cache state exists when the guest re-maps the page.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 drivers/virtio/virtio_balloon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d1fbc8fe8470..2e524bf6f934 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,11 @@
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
 
+static bool host_zeroes_pages;
+module_param(host_zeroes_pages, bool, 0444);
+MODULE_PARM_DESC(host_zeroes_pages,
+		 "Host zeroes reported pages, skip guest re-zeroing");
+
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
  * multiple balloon pages.  All memory counters in this driver are in balloon
@@ -1039,6 +1044,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		vb->pr_dev_info.order = 5;
 #endif
 
+		vb->pr_dev_info.host_zeroes_pages = host_zeroes_pages;
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
-- 
MST

