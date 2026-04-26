Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611C261B70
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777240084; cv=none; b=Mp6x4vj8evgCNjYbO1LI82QBoqs+0h0iQS0Jag9un/klwM0M2zq1vO9f1pmEthhv//QUUD4QBunjnNfFoenISvXEBKlbi73z3Pn2RiTJjaeG4iML49Z/noX0/Dv+5MeQGzaWfIxIytY7U267V6lA0ThQSIU89yu90K7BHtULEbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777240084; c=relaxed/simple;
	bh=B4v7SD6SJ84KapLgBy+iXreANiiaF75HE81bu1RBt3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=olmwb0WO4CHa7txtPGEZ4yb/cxLBPQkyT5J9qdv8iXm47gTR83mzn6o3vfdALKOFNlRgK8B96oNahnPFK1OU2v1xD9Nn+wkYXN6RizqMvCB9iDJWDw3qs+5ETUV3KA6tZonXQMtE4lhULo1/S3itW42kAfIqRpX641VwFpesaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBYQtPNa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBYQtPNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777240081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
	b=FBYQtPNa6FbEbUe9XYYtF+5Ya8sj3GRqd3S66O6cGdiZ1wdsNbBZVk2hKE7xOZ2sHZrMYT
	0hH/EmlXbopng1KAribTZbTwVUJgGt4qhzRSJxracFb0T+svTox8XL0wY6P7dMsoWlXnie
	NoQfbzXE400ixKH5tIPdbYTy9/XGQ28=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-kKNFZCPlPkuIMk94VzESDw-1; Sun, 26 Apr 2026 17:47:58 -0400
X-MC-Unique: kKNFZCPlPkuIMk94VzESDw-1
X-Mimecast-MFC-AGG-ID: kKNFZCPlPkuIMk94VzESDw_1777240077
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c0120047so56215155e9.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777240077; x=1777844877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
        b=ZpBB8FQ2qYntSaPPe8jUiTW44EL/ObDLa63glZmos8oAy9E6ADylGl2NpA6MV2vcox
         UmP+fy2u/HzgQKoXqlyKTWpr6U+z0H+WWYVy4WJRWMCgUahOhLMR3D6Rgjdabp5VZS1B
         jrAmi4ksDoR4p66WfwQfPQB1aYDT0sinvGY/YBH7uRNc+x8MFpmAaZGje3r8o3Xo0GJD
         DWALRkF7MIqg2vv+Vi90di2eZGvRV0LYct3cLVPEAdgE9DRc5py4GiFtY2n1k4Y5vPlE
         3ra+Y4nLIL4ngqHWdPDzNmskMZowLfD4LZBTbHsocrp2RqhaUsJYomDoBFJlOAFknI67
         kaow==
X-Forwarded-Encrypted: i=1; AFNElJ8YHhDlrKC/aK+RCvDUg3UH8xyQ+PWs2IDuZ7c7OK5psVlrpbSIigCRA6yT2C70FuICAcBTF9T9yUe6cLtaUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBw9JAY9iec4x1faVUepIcZhw5ceoDQbOhiLPnJcnG4oW7Ljau
	69e2BPaFXJGeUJYRnzQT0orlEdpdHS+zVXpfUhuPHqsoVLedu9tXD7xKreUKtgTCa1Pyu/5opdl
	znF4kFHF3G49UMnOx5QNkaSqn7q9p81jF/R4wOi7VaELkGnDo2Ra3n1yvNa1JQq2qBjB8
X-Gm-Gg: AeBDievLiakuusxOq7QrbhO3pDpRt0Igx/bSf7U2rnkqhhoDcu525BkvJ+t46r0Qoz3
	PnakaKD10org5ZJyTUlDXf3FHxGP+r+qlU8sOq/q7c4mAH1GfSdneYseYOX64XU12hrOVZS2Xj9
	VKGpQheHSFeHtdApAoMuoehmIwDicaFD1ipT0ttRRTMcoQZZW/keHoYohP7jRrakPpfIn9foPeh
	pIfeFLPoFmNpvJpahmYHoQKQY1bT5VL41wfxp0uWDV1gS2wCEGe4jKIRPpFJU1rGTdCJyd+w/ZB
	I7D97SVps69dTd0ucvURonyTHLn6rMEMs/wJF46rXLfs39vf9woCCCv7j/YlL4UulzhiYtiO5xw
	SRaWPj4JIuMfXQVlq43V3+ZArYGzkTjXe6xadnkR2j1y66Ww2Y07FVHco
X-Received: by 2002:a05:600c:348d:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48a677401c7mr138303955e9.20.1777240076799;
        Sun, 26 Apr 2026 14:47:56 -0700 (PDT)
X-Received: by 2002:a05:600c:348d:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48a677401c7mr138303755e9.20.1777240076353;
        Sun, 26 Apr 2026 14:47:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a525a0b1asm218200665e9.2.2026.04.26.14.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:47:55 -0700 (PDT)
Date: Sun, 26 Apr 2026 17:47:52 -0400
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
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH RFC v4 07/22] mm: use __GFP_ZERO in
 vma_alloc_zeroed_movable_folio
Message-ID: <5cfba90528b7abc1ebee68ac17efb6e3813fd916.1777223007.git.mst@redhat.com>
References: <cover.1777223007.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1777223007.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q80dKfgacMAtKni2lwKzRhJOlfvr4i5F1WiIz7hYLBI_1777240077
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that post_alloc_hook() handles cache-friendly user page
zeroing via folio_zero_user(), convert vma_alloc_zeroed_movable_folio()
to pass __GFP_ZERO instead of zeroing at the callsite.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/highmem.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index af03db851a1d..ffa683f64f1d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -320,13 +320,8 @@ static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 				   unsigned long vaddr)
 {
-	struct folio *folio;
-
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr);
-	if (folio && user_alloc_needs_zeroing())
-		clear_user_highpage(&folio->page, vaddr);
-
-	return folio;
+	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO,
+			      0, vma, vaddr);
 }
 #endif
 
-- 
MST

