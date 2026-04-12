Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B332314A6B
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034265; cv=none; b=q5jJzO6MHkR20w5OXKzlnQU/EFXecdcpGYivxC+4DLmmIZOXIDqTcZB4bQEvlmsu4wIa9O5a3z0XqVPywFgQBUCJL4GbP/O6X+nbfPuc687iNH1Ta0tCkqxQnDG1aD5MsArpComMk02HezAG1UphweIk/XXuzfram68l2OuS9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034265; c=relaxed/simple;
	bh=aYuD9Wu7xKcWs694vDzcw0w1jYymMhPxxEVr4FRcmuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=swYVUcNp6l8ql/CPILNmrsiw1J3VMkAQ8pT2+fjVP9lZ6MoTmSqCTUBUeqVWdQoh6KuNX6aDWqh6vZflS9/GJXWONVJ/RsPXmHn2nM/o24m2zWlj5VlyQTClL/H7YLtuJvSD1fH+D46Oug+xmg2/LFaOBD+lGI66a1tvRGDz8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThpzgpiG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThpzgpiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeiS9llWPPLpjQcwO7WKyNbjSAhoiU1ctMTrblj5iUo=;
	b=ThpzgpiGEilohy9xmI3VntK6cShj0czlB5sowe6FT31pL4aAq7oKCv96vLuEwxtr2CG6R/
	0pgUi5tpDNpKcuCbF6FR9JOyA+WX9DNSBpWSgvMVpaIGmYNjkPIcFTqxKFG6KHnuB0kJco
	XuSlj4hwLLgF3Gp68/+fH0yEvAAj8zY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-t8j-dQ9sOO6mrjqMVf7ROg-1; Sun, 12 Apr 2026 18:51:02 -0400
X-MC-Unique: t8j-dQ9sOO6mrjqMVf7ROg-1
X-Mimecast-MFC-AGG-ID: t8j-dQ9sOO6mrjqMVf7ROg_1776034261
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d7b7bacddso17529f8f.0
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034261; x=1776639061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeiS9llWPPLpjQcwO7WKyNbjSAhoiU1ctMTrblj5iUo=;
        b=Q1dRTCu38Y5yuwRvOQ13eeR7+jVnmasjm+hrSc6AJXp5uwYg8loKYUbixbrzGs5ZMG
         hTwWdgvI4mtdjbR9LpOqvW6kuddcdEERo529jg5ic+yl7h952xFev2PbsSkwqtb/uKNd
         Tx5UTFbRx7Z8HWmAS2QpJCvcSmlmbRNNaZTmKlwnLX2/+ZPTBMdz540HubaOx5uk2wtt
         +O1UExo8DrfrSbLS1WEdODnBza5EWS5se1SVF2J1bDZz4tFnwYL39fwbfkVHViiDi1pl
         rFhJ+XM1cl3W33XGjC5ItyXA1nL0Zknrw7LVqNDwaBxRgI3rcwu5a+LRqrTewO/7LRYS
         lL1A==
X-Forwarded-Encrypted: i=1; AFNElJ8i3Lh5gkFXqyWn27UIccmUkP0gl37H2CV9/4BcVIrHgJR/iRqyew68cySlC2/raPahx4iEnsThVlxBXGxSUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+YWiAtEQb+Tw0ghl/rYCsEb0OAn3d4xg0ZAfYWThg3NgwwtCD
	77/NBLYF9Ugf5CZ5YGcx6WnvlhEPZ9Mkua8qLnRcaqsM9R7WVxAl5lC3Ajoiexl9oHgBFzOMN19
	8DNDrH0oimcAMcSZAzjQRREjgyYFxQ+M819BpYlxm7Ww5uwAInk4APV+GfJZLUaR71/et
X-Gm-Gg: AeBDievKK8iik83ecuZ25krDzZxXyjFbDPFFYakbWHoviXPT1IUDLm1wMccEn3cmlRj
	1uH5B6S0EvIRJtdvnpjhwdJdvoP/ZCsAVrg9PvuyfyHoqZe1C7CHDWI/m808S2Ks76V7vThvVPr
	bv5vlo5dXgmWRuwaZDa8WwxJxJmITC8bYG/5yzrgPbWrQhQMTuS14A5+nXCTQug0+tN1w0KIhJI
	87B55IQoPGOPrlXwF22BKLNNaVeKe13sF3y6wDttd+2/8ozHGDupkL5CSOJ0hKuNqnu9XKb4mRY
	BJwgU515X7HkMd2cpbkNNqJH0Ih/58aJxVhKsp8NnDjKxFzppqtQGDilHS94aWyGNTOOXvpLxwl
	JSMJqTI+017GXGNeg+JojJXEBxyeEEuBpueyLh7YnQes=
X-Received: by 2002:a05:6000:208a:b0:43b:3be3:9a16 with SMTP id ffacd0b85a97d-43d642c1484mr16295640f8f.38.1776034261115;
        Sun, 12 Apr 2026 15:51:01 -0700 (PDT)
X-Received: by 2002:a05:6000:208a:b0:43b:3be3:9a16 with SMTP id ffacd0b85a97d-43d642c1484mr16295620f8f.38.1776034260688;
        Sun, 12 Apr 2026 15:51:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6f4bf2b4sm12414218f8f.20.2026.04.12.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:51:00 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:50:57 -0400
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
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RFC 6/9] mm: skip zeroing in vma_alloc_anon_folio_pmd for
 pre-zeroed pages
Message-ID: <7287019f2665c85a7a7fb5ffc25d7203bdfa9a9c.1776033771.git.mst@redhat.com>
References: <cover.1776033471.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776033471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sgvoZ4G3rNGOjf7rJxJXYskVNLpp7TcjKZoPiL3ZhIE_1776034261
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use __GFP_PREZEROED and folio_test_clear_prezeroed() to skip
folio_zero_user() in the PMD THP anonymous page allocation path
when the page is already zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8e2746ea74ad..3b9b53fad0f1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1256,7 +1256,7 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 		unsigned long addr)
 {
-	gfp_t gfp = vma_thp_gfp_mask(vma);
+	gfp_t gfp = vma_thp_gfp_mask(vma) | __GFP_PREZEROED;
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
@@ -1285,7 +1285,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	* make sure that the page corresponding to the faulting address will be
 	* hot in the cache after zeroing.
 	*/
-	if (user_alloc_needs_zeroing())
+	if (user_alloc_needs_zeroing() && !folio_test_clear_prezeroed(folio))
 		folio_zero_user(folio, addr);
 	/*
 	 * The memory barrier inside __folio_mark_uptodate makes sure that
-- 
MST

