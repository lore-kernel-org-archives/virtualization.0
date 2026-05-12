Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B93CAE69
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620082; cv=none; b=pxAu6ZvH888KWj/e/aoX7F0WWQ1CqqmoSnUzB5cAU6VG6cZWDBWe4OEVJJCO/uRc5RVle1tojbX0bF5WAvc/Zq1ehCiGJuFHpi+26bmtGS7l+uDFdo4IonaYDoz1TM3rlNK6hm5Agv3WJXLpkkykAyEvpEn5S5XsBkGEm4lhZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620082; c=relaxed/simple;
	bh=mQqx6N7f4HKujpbDEae/MRGG23U+Ado82zzAxmBrUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D61c9E/grlvYr4a9eFvlWJWyHiP5zPGygtSrNnzg+pdqzF7xZSqgjivtS8/DxiC9NYNxt01HVndb8a+cGEbNRx6vZ4wcUv9A220R8+ovBKu3ungz9I4FBwMeKcDey+6KJEryKhUvXPUnviTVQWC2w+rpGBcgNmjIP5JCFSqrL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7qa6Vka; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7qa6Vka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpBn8Jg+yemSfT/rKcYB8AJ8VmedmgkSc9fIviOsi3s=;
	b=i7qa6VkajSjCeEaGLBAW2kS5S5G+5oa8xrAovN5CtfePTFcpP6WQ35ZeLEwec25CK8QuXc
	beOM8ndkYoD1Z+Wa9g29hdBUYm6UaVv06pkC1ZJw+LT8tvM+BKGZ/3HciM0imVQsI7B8Mk
	0h32+vH29dpZWBFphFCvQOJb3ayn6WM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-elCSrIvIP3KJNZj_vE5XcQ-1; Tue, 12 May 2026 17:07:59 -0400
X-MC-Unique: elCSrIvIP3KJNZj_vE5XcQ-1
X-Mimecast-MFC-AGG-ID: elCSrIvIP3KJNZj_vE5XcQ_1778620078
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so5576431f8f.2
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620078; x=1779224878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpBn8Jg+yemSfT/rKcYB8AJ8VmedmgkSc9fIviOsi3s=;
        b=B8UfvVwlYtLw5x3PXmsVTEVZF1sbtHyDYtDlxvSGz8EPu+gUTxTKmzX82wCzWmaoOm
         tAG8hBdYok/k4HvFfWrzAXlJVMnbyaOY/hqUIjmkJDqlcXdh7bURc57zjkgU6UeaJkZq
         rPgyTq/844XNIBOhgwgGGx4ucqwsVvl3qBBot9wNk1/SpMkpCuqVaR+tV3jFRMJBVmUd
         jXl09GAEylq+lPZl5gWbZdUzetMrIFTsTiHmOipmj/Ug5kYCsAXBzruVPEumLVOSqy2F
         1kGB9M6o8N9ssEFjgCL9bPp85QzPOKnXf7ZpMYBFDdLEVxvUEPCZaOrjdE8aj1uiYVI/
         XOzg==
X-Forwarded-Encrypted: i=1; AFNElJ8j19i4vVUysko2grUt7OaLmtNtqU5mNv83ivW8he/LPEo0DkIjujMxp728cUtvLZDB+6dVDnCC+qoF29fYUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoaFWc9z8JhMiFmbbxFBBekJooqbgF6WoqX0wDG2t80FVrLgUU
	Onf6i4qdM2BIjmGDeuicWelZkZ0+fZQ3JC5jBT3aiQj0uiSkohwiy/2vxm+oZaGC4wuDj409/JW
	TT6R7Q6HLoboNeW/UX/vm2xnFUt2A4GWJkykMRIV0pJD+ZE/3hv8FRY8HsN+uKN8aweWq
X-Gm-Gg: Acq92OHXrnrzVFpkTFeL6nlrcu4ZNjt0qcHz4OD9R8F5o6GpLMu64BCKG0aH93bWiOK
	WTJnjteFR8NcOasjI5neDWHTc2+1wuu8dTDhr1Sku5cce61Wms1UUyui19fbWmXg+r2AvPdrIZT
	YsRGeO1sIO61TXIzXFoRcKmO1axEeSUFlaV7T2fn1ySuQNiGkTcEnzAoexhAH+yJGOnoVb7/vPt
	kEhrYbmjiRIAx7i2mDYFP4HsIYZH4iWSGNNDonJrfKVTJFZXHraLTXGjcIkoJI1TDu7/Sl+ykYI
	obeXUOGv5ybWjvAKx72R29vYwbJgl1L0GDf9C969Z0avidl5bQj14XHACg7pvGsio7y/EISsigm
	K8S1PQswUyCxcONJclF0ltxdQzR40xApUpRVAng8Y
X-Received: by 2002:a05:600d:9:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48fc9a03148mr4865415e9.1.1778620077997;
        Tue, 12 May 2026 14:07:57 -0700 (PDT)
X-Received: by 2002:a05:600d:9:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48fc9a03148mr4864945e9.1.1778620077400;
        Tue, 12 May 2026 14:07:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce066eeasm50325e9.7.2026.05.12.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:56 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:51 -0400
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
Subject: [PATCH v7 31/31] mm: balloon: use put_page_zeroed for zeroed balloon
 pages
Message-ID: <13d76c12caad0008bee3d659cd986aeaf9a5fea2.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QI7urtXzQmBNqJ31tTGwgLhjOSCPv8TfKMrmiSO1Ef4_1778620078
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a balloon page marked PageZeroed is freed during migration,
use put_page_zeroed() to propagate the zeroed hint to the buddy
allocator. Previously the hint was silently lost via plain put_page().

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/balloon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/balloon.c b/mm/balloon.c
index 96a8f1e20bc6..1bf7eb2642a9 100644
--- a/mm/balloon.c
+++ b/mm/balloon.c
@@ -324,7 +324,12 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	balloon_page_finalize(page);
 	spin_unlock_irqrestore(&balloon_pages_lock, flags);
 
-	put_page(page);
+	if (PageZeroed(page)) {
+		__ClearPageZeroed(page);
+		put_page_zeroed(page);
+	} else {
+		put_page(page);
+	}
 
 	return 0;
 }
-- 
MST

