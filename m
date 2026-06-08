Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B43B47DF
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907839; cv=none; b=dIXd7TMBJ9r89ssUn2w64yqhIvSiRqfOXK8SbR/P6vVIETbHE7XWGypLtMh1/dEByhi3zSCHMAIrR6wJ6DVkVDzNQkniQus4pKBF3WD+OPn9JYxoYQVUhuJDkdNl2g0wzQ0GBXB6yPRCYg+ymqrq5gXr7xdQw6+7QcPmzH087nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907839; c=relaxed/simple;
	bh=K42PFe6eLQ++q/LDnGpg3rhqNCEgPv/tPyRqfoqSjPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fKP8d11k+okS+w6aLlhpyBWZpx5+LTzF+U21UXc7xOqXVwt7uvWXLfGX2MbEFGkVfo1cS7YkuQyiuueRuzHm+7h7uot44m8wy6TXfaRp0D8qe4EAym81RdDc+zgrzGk2qYsiQySkgs8EUcpHrNIqrxDiWFvBJSyUGhoeJRXvMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BY41vsfk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BY41vsfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A0GMQhTq7ZqaOlkJiK0dDinX7wgaWZxvF9PWDzI1B0I=;
	b=BY41vsfkjogBsDCO1r74phosP1LcNoWaZOLJTJc0rAB5Q4mKBbbXYOifkvSvWWa5TpePaO
	gVKAl3zKqLxTdUcI3JH4p0oWrkoLTGjN8DCH29FTzL7xuGx3Fti7yJnrI1dtrjeeCsB2z2
	ltIvCl/0lw6kcXv1munIq/ivc9Wegn0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-kenZxYVuOLSQ_1bwJVLiQg-1; Mon, 08 Jun 2026 04:37:09 -0400
X-MC-Unique: kenZxYVuOLSQ_1bwJVLiQg-1
X-Mimecast-MFC-AGG-ID: kenZxYVuOLSQ_1bwJVLiQg_1780907829
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4601daf4c65so2320092f8f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907829; x=1781512629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0GMQhTq7ZqaOlkJiK0dDinX7wgaWZxvF9PWDzI1B0I=;
        b=p+CIM9g8LanwngG6pv2g5KSmhxYQbBfAZAux/0IDrpCpz1Hjr2ndTMcANaWIRb4sp5
         xJWWQIoCmzj9S8Fwjx124p7sHdmangzgMT9n/RInjXz9gUQNiG6fdzWQLxbQLplTge1P
         eEbwzwnK3VeZLmkPCUboObQQcFuJN35ObHk6/Y3ei3iQ36epke+uuWaBW8Y1nd2wPmuD
         iL0WerE4p360khq7Y/RJ5WXBPEVepo/+xu1E6rtz9vv6qzLkZ6MlVvBNeXb0gQeNbYdn
         U1gkVK5oTnufV+rULhNJ6UXbqnxWNU7ZBCiBPU9uZZsCXW94RJPdR12e1ubp6xah0Rzh
         dABw==
X-Forwarded-Encrypted: i=1; AFNElJ9WaArBgjBzCu8Ui2NO3dCr50NAHwstj5HE+FjzDdo8z2b3hFZu4UBrzTv0UYzq1ivR9Y9rYgMDgXM3gi7WkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt6OJb9BPe+CGb3ecUYtFPAOIju6K1omg6slKP8+4SLo841UvC
	/guIPZsqdq+YC5Jy0TSvA45xNsUftB15WTB9Y4QE12W33Sgkw4zNCWkOqUCGBai0n8mzXAOkyER
	vMO1JaDcASgnN3t5uy0qczLELGNV3dxWzb/ee9UFjHL5QwZDn2c75X7dbVudW+XW3oCnC
X-Gm-Gg: Acq92OHhNeLu3+g+9rBwrVISj3v1pBs3y2YxHvx+ELGVg5/WAfxR2OBcAKRE7UukdSg
	F8sdP4Ba7Bg+EjFXO6/zxWCsl3AWRLTl5AftcT/9XLlnaXr6oXcUGb42ELXSiMGIYEIaIHjW+JF
	8aISImbAMldhlVTu6e4fg1orhTCXIsWWQSSzSvPkFN1iX7eC6qL7/2nl8zUIi+LPiAgBfMAW1xB
	JUPqvUtMZAYljtpxXYZOeLVJuIyVMfpgpSJ3UI5PztTnyybUF/+9sij75a0T+3+j+1fRzkZVm3W
	a+NfsBkyZydP1Tgs2Yk6X6mrUDo68/eo95UIQYxV7e1qHwnfnbqLcIPaWWhWL7VnFJ0MdUN9tu0
	Bnd0IitLnZbbRMurbv1beo7A=
X-Received: by 2002:a05:6000:137a:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-46030648ba8mr16182358f8f.26.1780907828500;
        Mon, 08 Jun 2026 01:37:08 -0700 (PDT)
X-Received: by 2002:a05:6000:137a:b0:43c:fdd:ea96 with SMTP id ffacd0b85a97d-46030648ba8mr16182281f8f.26.1780907827908;
        Mon, 08 Jun 2026 01:37:07 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f5612sm48449848f8f.15.2026.06.08.01.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:37:07 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:36:51 -0400
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
	"Liam R. Howlett" <liam@infradead.org>,
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v10 13/37] mm: use __GFP_ZERO in
 vma_alloc_zeroed_movable_folio
Message-ID: <862a59e98104db76ee3998460bfc55e937c218c4.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z22aNMUcrPm64GbcYJ07vUDwH11K85EFzo7kPbfEmwc_1780907829
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that post_alloc_hook() handles cache-friendly user page
zeroing via folio_zero_user(), convert vma_alloc_zeroed_movable_folio()
to pass __GFP_ZERO instead of zeroing at the callsite.

Note: before this series, replacing clear_user_highpage() with
__GFP_ZERO was unsafe on cache-aliasing architectures because
__GFP_ZERO uses clear_page() without a dcache flush. With this
series, it is safe if the caller passes a valid user address
(not USER_ADDR_NONE) to vma_alloc_folio() etc., which delivers
it to post_alloc_hook() for the dcache flush via
folio_zero_user(). It is only unsafe if USER_ADDR_NONE is passed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/highmem.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index d7aac9de1c8a..8b0afaabbc6e 100644
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

