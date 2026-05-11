Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57313CA4A8
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490172; cv=none; b=bRPklxiwfE7H3pmhjPGHqMOlOhzX2+NYbu489cGM457CXOryezx4fMNh3ewK3FTFDa8fa0fFCFbqHmGgTysJhhH8n9+IKZGwqXYmOTR97tyG+u392sEgROMnFthlm8a6o8HFV6f2HC6EBT0aC3YHatEp46teiJe9s9F1BtbyMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490172; c=relaxed/simple;
	bh=WO4MHxi65GFX0xUNciL8bEMuUsPiR9dGIohoqGtzw3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=c67KGJG3Ff5a9TUX8iE/Gusxed23qRnN6hUNfXeo0qlL1A3/GSt2eshF9+ZSKOSrjt0aZnfvRnn+XGhvGKSDEvYrn5b6gzgH4NvrO1SxypB3brX0MLspczv5rOxbq7eHHeJ6O+Wb3PqZpAisujpN6ZeUpYLtJAim+K7QHJMe5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xh+P1VJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh+P1VJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XL/pBrxkXlfOOto9pZb2YfWp+jJTrqFtHfQ0Ihv6FSM=;
	b=Xh+P1VJwceM3i8FqqViaES2OkslPRzTCzMTo3W+/0549V0WWIjx4fPsOeAD/V+TvA7qj5F
	7fE0ajb32aY/49lxhXN+AUwX4DwUroGficr6X+pkgE5LRdHnAvSErXV3ioxOOlbMcIfm1Z
	Nr/UlV1vejooTsNjfBx+RXV5fjwBxD0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-LfexliE8O7WXhmITltelug-1; Mon, 11 May 2026 05:02:48 -0400
X-MC-Unique: LfexliE8O7WXhmITltelug-1
X-Mimecast-MFC-AGG-ID: LfexliE8O7WXhmITltelug_1778490166
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e5df7e6ecso24056845e9.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490166; x=1779094966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL/pBrxkXlfOOto9pZb2YfWp+jJTrqFtHfQ0Ihv6FSM=;
        b=UPlb2KzDh2Wy3VyHIGL1Y20MpjcWJk71GAN2x7v0f9C0T7AA9Cc55fyrpDImdfZi+A
         4OBbK4mSZnRo/sFjYsYGRHtW9TZLxjgk0osYaS4iJa5/sbpPNmehGHjAmcJGCRszHzsq
         7wvrIc2URJ9NhueivbvNH//l3YHZKQBsZEyxUHHdt2CRCS+C0r84b+cUGUf2MWKbZaYe
         FKHZeS48tTikzALut2icMG4kZjqdGbQ5Dnok9KFes4wQSCZrYQnjhiYltHq0zoWQgBZ8
         SJ5+fEHlGIGfuMapIK3mClybfWnKnLokCpvq2FnY5a48AkiiUfa1Wki6vCfhS9UVyEZv
         TbFg==
X-Forwarded-Encrypted: i=1; AFNElJ8qBJmQDFqQui3egLcTaB0YIh7XcQ1z8EEtC53YgxqXV/euGs+TIvwaQmwcTLQFSQye5+03cIQhEy95Dt4Taw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBeDSGal4j8kq+IPjgm34Cfiai5U+IcVGN822wo9DKmC+Su3JN
	dOpebqYRFZ1LnYitMvX0Y0qfOxxEkOvGmmUxs4eJKoHFdjo8efl80qkxuIk4736iotyfLHEODDN
	kNaV5JxRr8wKhV4P/g3EWiOGv+cb5Vi+34ay2ioMlV+LrFG/gHjjqGHInnm5h2Z1+zm8R
X-Gm-Gg: Acq92OEnB+3CSgv1YxL8PU65xdVu+e4TEu9W1szvvAn0NePo23Y5AVmWFVRvk5qvP3s
	3pZeSg0mObLsMbNpE5M6gdP1Yjz6DgqelZhByPluNBn17qwpBD0YYMyjWz6jOQOEMGKzagd01R1
	NsSWeWjDQL88b7wfaGGEHlldGrNnIms0iRIDGB2Kekz1TylgIhu3oI4M+yppVxrkhnepA6fooH/
	pmi4SQpm5ltQSJwYVS8Dw+DHgU+VI7ziX7sRidB/Mu1I5BW9MQK21XrPRVUxQrWWVwGen4c8jfJ
	WbcV36ClZwkM6O4PJ58o2WfSTi/pjG+6h1oDvry6OyXSTxB1gjm+reHHEe20SE9wdOW/KLNJ4wC
	dR3uzxFDtqOmRY0rcsCqd860RlB4UAy9EU+pSVuzgTCNIEJG6oBs=
X-Received: by 2002:a05:600c:190e:b0:48e:82af:d9 with SMTP id 5b1f17b1804b1-48e82af0239mr50308715e9.29.1778490165870;
        Mon, 11 May 2026 02:02:45 -0700 (PDT)
X-Received: by 2002:a05:600c:190e:b0:48e:82af:d9 with SMTP id 5b1f17b1804b1-48e82af0239mr50307675e9.29.1778490165221;
        Mon, 11 May 2026 02:02:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-458b3664e3esm8472285f8f.3.2026.05.11.02.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:44 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: [PATCH resend v6 10/30] mm: alloc_swap_folio: pass raw fault address
 to vma_alloc_folio
Message-ID: <369a08b86f51572b2715a9ec577de27ea98000d3.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vRYcW-_XPEl4kUSq4Axa6gHaObfwXiyaEqvKyesh5W0_1778490166
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Same change as the previous patch but for alloc_swap_folio:
pass vmf->address directly instead of ALIGN_DOWN(vmf->address, ...).

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0824441a6ba1..74523bc00d8a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4734,8 +4734,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
-		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
+		folio = vma_alloc_folio(gfp, order, vma, vmf->address);
 		if (folio) {
 			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
 							    gfp, entry))
-- 
MST

