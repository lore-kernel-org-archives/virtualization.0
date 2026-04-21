Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E8346AE3
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808900; cv=none; b=tN6eyCJzD5db6KBQNw2CN85qzXECG66H57IOEPc5VaEE3L6b5X1C8dKegct/ihH5c6Ob0yt5LfA28tdtJQTmfAyKMRpU7bz58kA0LvOSw56m4F2E/a5TN/2WxjX5nMuXRdX2WAJZtO7t7ukjc4fwyDmxrNmCDZICXL7WhnYxXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808900; c=relaxed/simple;
	bh=Ni2emDZHUT3ZFPskAmph4HwdB+pXcvb9empy5VSuXX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ARLeyap4Cks+JnfjEDR5TQubwCsUdmYvmG2xLNUktsSN5giDU4Kxj8UcJscVdJeTCrDvjkXI4gvLnbsX0ehwt+XCw4mgPsNvcVbz/XeCEG9N2NCyUAI8jjuEZDmejAleBRDlLVJBARJoR1U4G369GpeXbf3ld1BbxzSxhuHo3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HNUe5iu1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HNUe5iu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776808898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PFV0AQVcu3YAl0tYQcglaFwWX0QLOSqW8EZn+GtNSTo=;
	b=HNUe5iu16+HLGs6eCsvyHobn83ABh4InVOvFDB+HpTnxl2vDx2Soi98salBTD+S8MrQtow
	NeNpNFhLXK9+wWNJi0zmCzE8j8Z8YkKvIl5BrwWm9D5NoYZw9A9HOxe7y0ifBadbfTPWzM
	e993cg/r8qrw+PEHDgcAQi8yswJCVz8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-ngRDCYyBMfuKcrUtE0qkHw-1; Tue, 21 Apr 2026 18:01:37 -0400
X-MC-Unique: ngRDCYyBMfuKcrUtE0qkHw-1
X-Mimecast-MFC-AGG-ID: ngRDCYyBMfuKcrUtE0qkHw_1776808896
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43ea7a5da57so3712662f8f.1
        for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 15:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776808896; x=1777413696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFV0AQVcu3YAl0tYQcglaFwWX0QLOSqW8EZn+GtNSTo=;
        b=Wew+OFMfwavCMbBdOM+Dp3QdVbXs91UyjKF2Cuv2Xo+eoMOL/ln5KPNOPt3L2m44QL
         eESSQYup+TvL2qDCAbu8lnbhrXjp8UjNvEL9lIKZ4bbGdlO4y5o2s0wXDk1pbyQchgLH
         2E+4gBP/g4BfTOYuHXryspOZSd+1gBYBpuu6W5BUfc+Wx/h/fR2gclZNrcVoZo1BTWHX
         tcPwb1VYsbE/EpJiEaffrBnATHhZB+t7Gph2DvlLTsTBnqffM1B0MDRTq7nydPGUoVHU
         lzIZPE2PtzZDW1pxJ0ly4aAM1VN9krpeCQt3pbd3Hs/6xtbVNzYcgf2o5pKiB29qkEp8
         KWog==
X-Forwarded-Encrypted: i=1; AFNElJ9zwpYZPFFKgXX0wN0knvQWMQpD20LqIExlDg7AlnyzQOoDaiBK/gQ/yo3eYzIHWhxEORq8v4tm7vEyD9xlcw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLI/nhKLglTktWV+F+CP8cIoq/8BTQQ06jgDolwNybAezmR8hz
	PRzKbk2hBCZP717I4bLqF7t1P9svs6k4Hj/47nLZt1EBsF91TtC9GcNKge5us8lc7oQfzG4EXqo
	fGa5lhpBdzEX1JtTKU861dNSIDv7wBmeyHb0sufemO2f/aVnaGj4rNBL+ghF4i/iA1n8i
X-Gm-Gg: AeBDievWXxZm5AseiZ8Y8dLgcYdqoxC4QG4ZsZNTyFXtkAP/jw6HChvfb10TBytspag
	PhKUFbNlzeXm6tUFEh2HqJYD42ELdcVnFlYF2GptJRA+gFQjzWRLqKzY/YtIeJHzENZmP80j3o6
	97ufipwpwbqNAV13vxZTm/+GoxGPhJlb0cWMaddxZH5uH35kEKzUBXEvg2koCBzY5N7pom2K4Jt
	BrlRCzOnjlWeTKfC+GcDaPYcOecAqTznh13703Y6kAGeIM3seBhlo/bl+GREM4/bmc/4vT1E06d
	anBghAjOM3JSp5O/J6sLCzXozzrEFwVjCxc0vVt3HfBvys34rrsHM1+FYavugwklvJcre7O/U2k
	J9lh9eeOMfMrooylcgHmjQiklPJPD19h5l6PMPUgut4t4Yn/WFKfVfw==
X-Received: by 2002:a05:6000:18a5:b0:43c:ff58:35c3 with SMTP id ffacd0b85a97d-43fe3dc818fmr31329445f8f.10.1776808896338;
        Tue, 21 Apr 2026 15:01:36 -0700 (PDT)
X-Received: by 2002:a05:6000:18a5:b0:43c:ff58:35c3 with SMTP id ffacd0b85a97d-43fe3dc818fmr31329402f8f.10.1776808895818;
        Tue, 21 Apr 2026 15:01:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a174sm44697673f8f.18.2026.04.21.15.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:01:35 -0700 (PDT)
Date: Tue, 21 Apr 2026 18:01:32 -0400
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
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RFC v3 07/19] mm: use __GFP_ZERO in vma_alloc_anon_folio_pmd
Message-ID: <028a9602232ce76e2b207f730982ad3135897bc3.1776808210.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: vbgFEv2-Vm4mLj7IiS_m1MOpwWuy-50hjM-JT2kEt2Q_1776808896
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert vma_alloc_anon_folio_pmd() to pass __GFP_ZERO instead of
zeroing at the callsite.

Pass the exact fault address (not PMD-aligned) to vma_alloc_folio()
to ensure the cache locality optimization in folio_zero_user()
works correctly.  The NUMA interleave index computation already
shifts by PAGE_SHIFT + order, so the unmasked address gives the
same result.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/huge_memory.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e2746ea74ad..3f2a868cf9e9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1256,11 +1256,11 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 		unsigned long addr)
 {
-	gfp_t gfp = vma_thp_gfp_mask(vma);
+	gfp_t gfp = vma_thp_gfp_mask(vma) | __GFP_ZERO;
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
-	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
+	folio = vma_alloc_folio(gfp, order, vma, addr);
 
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
@@ -1279,14 +1279,6 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	}
 	folio_throttle_swaprate(folio, gfp);
 
-       /*
-	* When a folio is not zeroed during allocation (__GFP_ZERO not used)
-	* or user folios require special handling, folio_zero_user() is used to
-	* make sure that the page corresponding to the faulting address will be
-	* hot in the cache after zeroing.
-	*/
-	if (user_alloc_needs_zeroing())
-		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
 	 * folio_zero_user writes become visible before the set_pmd_at()
-- 
MST

