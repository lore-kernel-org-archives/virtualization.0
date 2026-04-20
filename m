Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DAC3A0B3D
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689463; cv=none; b=fbJ3BjNJPNM3RorVNt5vvDpxFQRyOUzJiE1Vsh1ZfNqBJcM05ujI9FCN9M3MEHeJDi8YWACpJanVB2JyLJnYyZ3BwlgFfAnutCV+7UewA51gp9kJIaSWVGoirNuRsIQU4Xd1hclCn06TG9J4vfAiVQnGC7LYI34dycy+6Yl6fEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689463; c=relaxed/simple;
	bh=ql8e9Lky0a/Rf32U0epNADUsxCMgGk+QrdwhemywB2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ICfyGjVZgrkX0gVmsxz/A/4A3jRcl5j2Qw5k+Z+yH8nVu9SJZ05ApIXj/AzFlH/lkbxONqOSVmdasmVvPDn7QBD7jcvUt9koagZk4Wqd3+ez49bgDXTj8+xwN7uG7p38kju7MVJyF+lbQKFN3aD3lkfbh8RKu+mJGjDNxkDO7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6qczxgT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6qczxgT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WG7QrmBRTIxkiVXS8Xfp7FbXBMDCD9dVlS0gg72QVn4=;
	b=g6qczxgT/5Sr60NHgc3lg4q3VjKY+4QHC850QCWg/qabgYotOViQJq3W5P8W0Giud9zJn0
	MMISMXUx+ImbCENfCaVZSyfKWAL34cRMHtvgQEm9c0Mk6xkbMYVsl9wPD+UOZQtgXUIS5j
	PQ93b44hL8ugzDR/8V3GgwJtcwXAFx8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-v7KXj2beOp-IKw4wh0tt2g-1; Mon, 20 Apr 2026 08:51:00 -0400
X-MC-Unique: v7KXj2beOp-IKw4wh0tt2g-1
X-Mimecast-MFC-AGG-ID: v7KXj2beOp-IKw4wh0tt2g_1776689459
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cff5ef652so1988787f8f.2
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689459; x=1777294259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WG7QrmBRTIxkiVXS8Xfp7FbXBMDCD9dVlS0gg72QVn4=;
        b=NWQcvAInHUH+PID3gI03LTlxpBJCNP8ySmie+UM4oQNL+VuDgyja4dOuNfLOYBXRMd
         nKKY8WG7WMukndzPaed/ea/B2BtMVphFh9QVKkByltN42S7OLvOJ7LZ1flRIBJUwXw7t
         ULHCGwo7wRaYJWgS5FPlHPdXClvUsAxT+p5lvQsMpz5eGUXJ9M/nwIcMYAYcMpFiw7I2
         JeDFeQbSW+Sdxvgs4RpPekWAOib35lhjHogWHLyXLONPBnUv6ftTm8yhXJX4LVm3i17Q
         F7diJK+kMGC3cGjoPOPNfzu6pC68nhmqpF/VwtNFWsoYxy4ib4sWxcnAzjzWhv1Pr5kk
         LDBA==
X-Forwarded-Encrypted: i=1; AFNElJ/VqiZBFPSGR2lpiYAgEz4naioZ8PoYUsLIja+wE3IJSJ5eCiigyl12Y7h4we/vhAtIzL0Reu1PBgzVTKukaw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6FoSBBkBfLL0px/f++aMlxPHy4XLNkK8WKmvZ+YCsdrWoMXS+
	te0afPkBVLG8//ketuGhRNj4XwM5QDVbFmVQKwDHj1dRI8nNRVJtzeAuTLUZHl2FU3TzwomeDLg
	l0rN0/SwvQ21Cd2zbekEjmy8i+CLlchAcB7Vr4FAufyf9u/MkMVcseSRh7Vbl0GhUKePf
X-Gm-Gg: AeBDietOUitgIDOZarpw5Q+3RbviNr+Q2VQrjnR0cL/Xlxd6Z7PcyKBMrDE7DEILjQ5
	GIkZ1W7Wy3+Qdhf2ChL91SNeysqOscCzWRq7w7N2FWEqJSvqoY01Ooeu46rkidMGGUmvVDSiWOn
	jFpykCopurO2SBj7JBxkuNPODqJn0bOIaAz2v8sBcupF9oWmjidprlKoTZYI2rc/GiW7BkMvIOg
	EyXj6huGywTy/zU0hTqOvdBDxZIqeYTC4TGUm2fkmTQqadwHrDUkZs7J6jvHOeZK8Np1ttmmdBv
	gnvvVNVl5uh9ZEfawFLVPuSkcgZHsW6VKcdwgWyC347rSGDsOW4LsE7n2ZH55BtIxzoDeyi8q1Y
	2IpK+jCOToiHtTLPFXbhxB3K8b1ttSj/SXdd6BkDyxyQvJvMv/fR2MQ==
X-Received: by 2002:a05:6000:184d:b0:43d:e31:68d1 with SMTP id ffacd0b85a97d-43fe3dd958amr21385885f8f.21.1776689458823;
        Mon, 20 Apr 2026 05:50:58 -0700 (PDT)
X-Received: by 2002:a05:6000:184d:b0:43d:e31:68d1 with SMTP id ffacd0b85a97d-43fe3dd958amr21385818f8f.21.1776689458282;
        Mon, 20 Apr 2026 05:50:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm28270624f8f.33.2026.04.20.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:50:57 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:55 -0400
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
	virtualization@lists.linux.dev, Lorenzo Stoakes <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RFC v2 13/18] mm: skip zeroing in vma_alloc_anon_folio_pmd
 for pre-zeroed pages
Message-ID: <551567632643dc1b5cdf08284039aeba0b296b6d.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 1uEhgThpHAOFOY4dTdxBirT450Ksw4zMLRY9Yn9Vu70_1776689459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use vma_alloc_folio_hints() and check PGHINT_ZEROED to skip
folio_zero_user() in the PMD THP anonymous page allocation path
when the page is already zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/huge_memory.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b298cba853ab..243592452ead 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1259,8 +1259,10 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	gfp_t gfp = vma_thp_gfp_mask(vma);
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
+	pghint_t hints;
 
-	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
+	folio = vma_alloc_folio_hints(gfp, order, vma, addr & HPAGE_PMD_MASK,
+				      &hints);
 
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
@@ -1279,13 +1281,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-       /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
-	* or user folios require special handling, folio_zero_user() is used to
-	* make sure that the page corresponding to the faulting address will be
-	* hot in the cache after zeroing.
-	*/
-	if (user_alloc_needs_zeroing())
+	if (user_alloc_needs_zeroing() && !(hints & PGHINT_ZEROED))
 		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
-- 
MST

