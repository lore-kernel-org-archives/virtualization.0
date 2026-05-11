Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F013C555B
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490151; cv=none; b=T56CU7YprUr1PgfdEOY1damiU346NwIZtEe5OCbBmLABUKe18aorwAMINRCuvYwyZUmYLBH8TTsoLJE7Ww8yvjnArQJyJlzwxXT5UQmFE6ET5igJJM6I4jWbS1+PJjxcQ/l2ryVt1Pb80jTTHjI22WZCbxWo3JBFZJtDrTcIdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490151; c=relaxed/simple;
	bh=B4v7SD6SJ84KapLgBy+iXreANiiaF75HE81bu1RBt3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Fhm8QCQhHmOaliKTtzl5BVD44m6Alns9h1pNtSsCFBJhrZ4NGeSMWZU2xYyOOEU6PmRwTIP/yZ/A5gOnImrFrP234F0ng3dYeOOcx7yKjZq58Dg4ClyBtJgzs3dioEOSrB/lrUkbCaFzxZTbsoGTlLoVkJvkbkYTuwSd8AE6Ny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijurj5ur; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijurj5ur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
	b=ijurj5ursZI6LBsVPyLvZ/NdcoLvuz8kk/10D4qNen8VhJ71YBtcAyNK5OXQI3CHRKqYrx
	ymuzOR4621H6C3uX/dwUjLOoGqYmq4FBAn0cWKaKwnm2CqfvNiBZgEXNiARpKRkZYnCsLp
	23EYC/7TYFzxu6Xvk/WMZEA+oqJcIAU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-fybP7VMGPDejocO6gaKl-w-1; Mon, 11 May 2026 05:02:27 -0400
X-MC-Unique: fybP7VMGPDejocO6gaKl-w-1
X-Mimecast-MFC-AGG-ID: fybP7VMGPDejocO6gaKl-w_1778490147
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a122a5128so3130644f8f.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490146; x=1779094946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
        b=eVhGrjTv0PggDjNLmpD8AxlO0Mv+dLyRh8v2z0HvN7PG3PIocQvFB35Ej0wxrU9d3W
         72RXGiTt2HnDDk/9cDYOQJ1Aj7AABdOtORCtCA3Sc5ffI7Lx0I4WsruNT+o4QFgUtOE0
         hWa0mVv1RV7e9OEQOw+AcWzoKkq1OmxY88DE7G/t8yMq11FxgFQwpvTyim1YFjcQRfZf
         rPGzVtk1YwOkvKPhEPo3HIFxLSQT3hovVAICjk3SlR1AdhoimRpVze5iC9qWwigu1bR2
         OOJdQWj7GD2ZE7pv7KJ030mfVhAtgEEhV0RyaNIjqwSPsDVkIYZ0/jlUaPx/gIbbihd2
         oE4g==
X-Forwarded-Encrypted: i=1; AFNElJ+QeQyMYvZs1+S0/DVDm4KkcXVBAzjkU+GbpxoXd/CIxArGAfLYcdrL8U/mez8DEGT6WN4X9j84ZyWqOQJNuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSuYU7bMVk5INvJHxIg7J6fIkEtjLiGXD95ZRHIJHv0jm5vB6c
	FeUKpWw2APaeP7S289DdoLVdn1KMAX+q6Z2D+XiAr/lkOhkBBRrp9rjR6JL2Kuaor0SCeMOF3UA
	Ldu1ST/7ErIjYGnPZEoEk91zEmBSyXhbXdjBdn45SETFTw4Kbce4IkMHucMMx5zaMt+pM
X-Gm-Gg: Acq92OH9pCWV05yEQ2wTzsr9iBYomMU1LW3qN5RgB7x/dkxVmOZOu4ygnZY00NriruY
	uZWu9n8ML3Rs49OKCI2Rz9MznGHS7SNkT1KGjE2jkwScL5MSDb1mXpIvxhz2/fkQGgHaejwwu6B
	S7GJsWbbubccGWFouPeorqxuPgCZ88IgDYlfLvuWSrjCkol7EdAH77lh2/wnljFBcogDCbFYXZ9
	C225NHDTfyPt1KQPCA76Fx6xCu6IO88PnA5Dw4yaJjakPRZW6I1WQUNUhC2URkPEZrg5S07bJIx
	0b3ppoV67w9HPSJpZFBL1BYNmO601DNoo9ie+iFeeUn+vkWYXBjb0LNmbZaZ9NL6dTSbRwUD5Bf
	+yJiDKCcNNxVMXbs2HdcVvZmAknsnRPYA7+US3z9E
X-Received: by 2002:a05:6000:310a:b0:446:96b1:f51 with SMTP id ffacd0b85a97d-45462c34296mr20229234f8f.22.1778490146340;
        Mon, 11 May 2026 02:02:26 -0700 (PDT)
X-Received: by 2002:a05:6000:310a:b0:446:96b1:f51 with SMTP id ffacd0b85a97d-45462c34296mr20229157f8f.22.1778490145663;
        Mon, 11 May 2026 02:02:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120ec0asm23630828f8f.17.2026.05.11.02.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:25 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:19 -0400
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
Subject: [PATCH resend v6 07/30] mm: use __GFP_ZERO in
 vma_alloc_zeroed_movable_folio
Message-ID: <c9448249c53681297f44d18c3396a3329b50d7eb.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: QnzlgyNd3zQgTe1siyfx00Ne60NsOCzFeO8H85cV6fA_1778490147
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

