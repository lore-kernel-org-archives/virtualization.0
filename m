Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A143A6F05
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808942; cv=none; b=J6Q8oq18ebbOcV1FdKjdbgAZbamPwhrkGdFYsIL45LiZmr4d61yf///jdlFah1wa0J/xdZIBWQLwE15ikAWNmXeOCmDAZgUxiW2n4iQJ3d5pUqF3Z0q8OARLpGHunzPLDkWIjUoa8IYl5bkcchfHE0cuA9xKkA20J4vqoRvDPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808942; c=relaxed/simple;
	bh=w7yku+W4GfSSG96SUrLMIOzLwQD5fzXNoQPFKEr+ev4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oy7pGwmuLl1l+IFSf4b3OX+5emZLN6fN/hUu7ZI+sEgIobC22soksrCX3dElKwk/gbjEXyz+jx4OnPVWpyNPKHysU4JAyOKwq8fqxnrLbd36KtswJWRFL3+cw6PJau7+1JBtfcR9sH3LMQwv1imiHz1yh+k4ZGtNT/eIznwNKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zqiczn97; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zqiczn97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WzL0/LIharUBH04VP2SJLM2VLBD1UEvntqvv4vY+Hyg=;
	b=Zqiczn971++LrWtiCmygieeZ/SUPSlLXlPpJFuP4Uu8yO2Ed6+TeLdxe4dRMAIMaA6MawU
	q8NRef4ZRzbV3p5Pv96N4XT8HUy96YtAdXUKYkQ7Iwbe7o0nKPgSgKUHfep+zLaz0g0end
	ffxvbg7U6Op3FX9ggqWuzpeg5Vxl4Qc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-lW9iTX-XMZiognH9w-Wrjg-1; Tue, 21 Apr 2026 18:02:18 -0400
X-MC-Unique: lW9iTX-XMZiognH9w-Wrjg-1
X-Mimecast-MFC-AGG-ID: lW9iTX-XMZiognH9w-Wrjg_1776808938
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c82b4701so27484755e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808938; x=1777413738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzL0/LIharUBH04VP2SJLM2VLBD1UEvntqvv4vY+Hyg=;
        b=RyxHJmub6bGdua2EtWFQ9qr/LlE32ue6vxLRAMJangVl6SalZrQis+UKk2XVwTj3rV
         r/BjDNC87XGg6r1gCyrLG3S1uOFAPM6KpQJsaJ0qsjyQKKrYyOdbvxf/WXgoI5eNiTAh
         gZwQSyKnP0ZQSwXIeRzlhGs3KQaut2mLpiBgnMVbyjOpDVLvOWh5rK7e/VdcajoDLqlG
         KyAT2yJ4Hd4ESx5Hc/Y3kKbx3HJq9Gk2DUtn00p7OP1AaFYYeXi2XySrsyt12fXu3Ui4
         l5eDAsDLOGRJj04Y11rQs5x+pOTnDiOXQ53GnTAvWKjoQeTi9iTuIClWbfNYSEKKPEFa
         9zpA==
X-Forwarded-Encrypted: i=1; AFNElJ/I8wL3RvFc1PHRvOWvRNWxrlU82x95HEaxVfahMWczGAbY6dli1y5nR2aNszCNRCq/ftxdqcD+S/LlZiHEqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC8AhbyqIeTuSJP1IZVsiGWx0ElIRP7w2yRokgVQRiDm5ee1V7
	PI46sTduQE8AmfwhfFp8gA+jZz3VUW7JLGD2FH1Gn4BZ6tmmCSa3QAqUkQRuiqDmsVc6ZiNTMxD
	QfqKfymfaE8U6EDujSRmRDmzRJVEKSEVCdnv0S8xdrSw9bkdy6LdR5flzFV1Ttz1oBDxP
X-Gm-Gg: AeBDieu7DQCvuLvrJotGrQb/xfVAUPQUafPndP5wvx89609V0rGQmWTZNFJ/TSJnC3i
	SnBjNT26w98jr8dS5oDeEJlCm5h1fJnytD4FP8MpxCqO4ffoQEFSsZm1UDzbz2p/PdKDmfFGBdh
	II9R0SqdOJwskiu4fBgclHs4IKjIDctksxiXKhueJQCVWjxzKY56h/98DVDAZwQ+JCQignSmlCh
	q8iEXUJedOv8Xc1OyD/SfBu1NKdprQEjd5dnb4rg3Ng1kIBKl52prlqAS2hdXqXJ9QWFhepE4Iu
	JVDj0teCU3jXoRVSz7J1tGoSHUYzWF2wM/r6qEHUEntRSX2hme0GWHliMDlIUWnJSutQLkcx5mO
	Vo/cD9XC8PO03JHswu3z2B4JaQiomgYinsK4P2ZnyVAUzOinOQX+igA==
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a53390f6cmr90666165e9.9.1776808937666;
        Tue, 21 Apr 2026 15:02:17 -0700 (PDT)
X-Received: by 2002:a05:600c:b96:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a53390f6cmr90665755e9.9.1776808937145;
        Tue, 21 Apr 2026 15:02:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0b4c85sm383193925e9.0.2026.04.21.15.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:02:16 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:02:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PATCH RFC v3 19/19] virtio_balloon: mark deflated pages as zeroed
Message-ID: <e1c6c87f459904ca5cec26ef167ee6cbedd6ae70.1776808210.git.mst@redhat.com>
References: <cover.1776808209.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776808209.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KN0DsYC6MLT6_vfN4QD-Tk6o5zUqBeZ3tpyvQApavU0_1776808938
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When host_zeroes_pages is set, the host has zeroed the balloon
pages on reclaim.  Use put_page_zeroed() during deflation so
the freed pages are marked as zeroed in the buddy allocator,
allowing the next allocation to skip redundant zeroing.

put_page_zeroed() is best-effort: if the balloon is the sole
holder (the common case), the zeroed hint reaches the buddy
allocator via free_frozen_pages_zeroed().  If someone else
holds a reference, the hint is silently lost.

Once balloon pages are converted to frozen pages (no refcount),
this can switch to free_frozen_pages_zeroed() directly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 drivers/virtio/virtio_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 165b123caa64..3058d48fc8de 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -299,7 +299,10 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 
 	list_for_each_entry_safe(page, next, pages, lru) {
 		list_del(&page->lru);
-		put_page(page); /* balloon reference */
+		if (host_zeroes_pages && !page_poisoning_enabled_static())
+			put_page_zeroed(page);
+		else
+			put_page(page); /* balloon reference */
 	}
 }
 
-- 
MST

