Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D513AFD16
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907672; cv=none; b=UEFssLENxp8GMftverEfRpEc/TfZOMR+1GiiEq1wB9nyt7DAmiP/NJWGVbrNcQ9LObmPjmJ9qKivYxcz/l07qasiYQ80NJrrLNzT5O0Qx4bgX25Oiay4gXuRoJCPp0ldUhp9pVaLCIPjz7yG2vmFPATOHwDrzB8j0E8NLtr/Qi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907672; c=relaxed/simple;
	bh=yI1iGkmiSzMFJtnw1lJVP5u1P/QKkpQHXLglYhfy84A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=BKIKu0QYz8AIgt2NrOCD8PNRvPDjLbzzEQeSwJZXt5aaVDxRSsRlwOSuZtTaFvshEDD44lNWT4WtkVK8lYZK8Qi7mPmEEbkbhc6nmMEI+foktAZZnLFX4GYmnd+gWGOS7WM6t1FER6j4yQXjEgyTm+Qm6iWdCSRwLam3BzGsUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAGS5DA2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAGS5DA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780907668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=315e7bSessxyz662R8s4IU7FTBDlj+mVbEZvVNtQrTU=;
	b=FAGS5DA2XHd3Prj76/6miRgXLK53dgOAlHzeT8idn2hg8gE/oJ4X93blTaCj28WdYwFkh9
	7Ix0GBMQRDP9NwWboKxqAcXoLLDMq+VLdO1PkAHnZI86qGRKQ1yaxt5vviSqGHGaGan4LN
	pxXpkZihIUdifKYqWSWtzXYXQgOQugo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Q_BlyhCPMwih5xdRpkDMqg-1; Mon, 08 Jun 2026 04:34:27 -0400
X-MC-Unique: Q_BlyhCPMwih5xdRpkDMqg-1
X-Mimecast-MFC-AGG-ID: Q_BlyhCPMwih5xdRpkDMqg_1780907666
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso41768785e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907666; x=1781512466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=315e7bSessxyz662R8s4IU7FTBDlj+mVbEZvVNtQrTU=;
        b=NprQz0IdkDg0xnP4zc/I5/NhMuZWj0T6953RYAHnuBqsKjygL4Tq5f2Ia9me1ja36L
         S1fk/RKyczuvmKknIYX94Qv7XXlBGmZZZdQpIMR9bAR+7BFiQF/4k/6QF85T7W6NSdT5
         B3UPLhwiHA3vlxYCpkBggWE4cN2Ejf1tdsIjm7yTSNVbZZl6fENO4aZfQXGAUVueVhE8
         nrLx+80Qo+JwovrxLDmTTyueeGtiqjTTvKQsHVHIaAy2tk3Y82C8lE9ieUhcWhc8Q7jb
         r12TpRc0UuLAwvSAkioTNn6hP5WSBunCmCnEPobb0ingC9Xvx8seX+351SkC8IhWxPqb
         OFLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Xz2xqr+TKgqppQ7hBybB/PgKbb9eau48hWutqOppYOhJkV/8gE3YtCpMahNKMOulRAtbC0IRB+e67ge0R6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFA2rVapGXnJFgu7fa8X7ipFJEeVyFTA9XNoCNiXPNc0AE/cRz
	Lyg4LhwCMXQkdLRFy0Uw8pT46op5l5Sh0AmNHUERUJG9wJWJkhxskJudCUHOng6PxtabHO6blW/
	W5/ftcW9eM653RjOiOjZG84Ky+VWcwQgWuYT9xjQkZBGD2NLOgAXLPthwtFkelCyz+26y
X-Gm-Gg: Acq92OEXckbYa2InyW5W2g1f/H1EFr6BXIy7xf9WItLMihFOwRjHAbCOKOZfaGatZUs
	/7MqW0tJsFPSSvA2q/kZLh6P/e+0T2tN+gb8Cz8mjVicKXh5jWWgntuHT/Zpeh+OcwKwGykZ7uP
	3kg8aqO4mp5Rjr/xHWHgoTG8Xnop7niw/mnBbQqZDCG8hHAxOc0xsdNLWd2RANJiUG8LrTIxkeE
	MzrHt6hDFcQ8C2uFnn71a7u19yFeduzVaDaaJPakjuqJMCWmHN9HdJDPlsh7kcU334drVkWYOXJ
	sVPSK3QXOnA701Tpet0fLEhxK/Q3llt7mPBesjQdn3ToD/2yK9eIXe6Zgbt/K/xqXb4wjA/6Ee3
	kCxmVszZ3tAjLkO/P5PpSwRI=
X-Received: by 2002:a05:600c:4708:b0:490:bd66:e522 with SMTP id 5b1f17b1804b1-490c26038d2mr235215895e9.29.1780907665042;
        Mon, 08 Jun 2026 01:34:25 -0700 (PDT)
X-Received: by 2002:a05:600c:4708:b0:490:bd66:e522 with SMTP id 5b1f17b1804b1-490c26038d2mr235213495e9.29.1780907663108;
        Mon, 08 Jun 2026 01:34:23 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm356368295e9.10.2026.06.08.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:34:22 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:34:06 -0400
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
Subject: [PATCH v10 01/37] mm: mempolicy: fix interleave index calculation
Message-ID: <f5b1dcc97baae7183e96743873b943315d93cdb6.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: IEdti1ZFYeDzCns1nhgNFRJ4w3QvA0yeKNkyKGsm01w_1780907666
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The NUMA interleave index was computed as two separate terms:

    *ilx += vma->vm_pgoff >> order;
    *ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);

This has two problems:

1. When vm_start is not aligned to the folio size, the
   subtraction before the shift lets low bits affect the
   result via borrows.

2. For file-backed VMAs, shifting vm_pgoff and the VMA
   offset independently loses carries between them, giving
   wrong chunk indices when vm_pgoff is not aligned to order.

Combine into a single expression that adds vm_pgoff and
the page-granularity VMA offset first, then shifts once:

    *ilx += (vma->vm_pgoff +
            (addr >> PAGE_SHIFT) -
            (vma->vm_start >> PAGE_SHIFT)) >> order;

For anonymous VMAs, vm_pgoff equals vm_start >> PAGE_SHIFT,
so the vm_pgoff and vm_start terms cancel and the result
reduces to addr >> (PAGE_SHIFT + order), same as before.

For file-backed VMAs, the sum vm_pgoff + (addr >> PAGE_SHIFT)
- (vm_start >> PAGE_SHIFT) gives the file page offset of addr.
Shifting by order gives the correct file chunk index.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Gregory Price <gourry@gourry.net>
---
 mm/mempolicy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4e4421b22b59..d139b074a599 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2048,8 +2048,9 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 		pol = get_task_policy(current);
 	if (pol->mode == MPOL_INTERLEAVE ||
 	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
-		*ilx += vma->vm_pgoff >> order;
-		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
+		*ilx += (vma->vm_pgoff +
+			(addr >> PAGE_SHIFT) -
+			(vma->vm_start >> PAGE_SHIFT)) >> order;
 	}
 	return pol;
 }
-- 
MST

