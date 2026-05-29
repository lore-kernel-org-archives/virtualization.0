Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9563B341650
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068136; cv=none; b=MEjNYrgFPt04VZTVRTdukPlwe+zgkH3FCW0/XRYs2Gl69qUk8pHYQuiFckzKtZEF6SoeoZdr02b1pKAmOyD7RDSy7FEJ6tHiKMS4NGzcWsOyK5QIRMX4JLdRsZR+WAmhUIvIMRjVMeiXGDhtf+4/ndbIDk2HzhwdjsUr2byVlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068136; c=relaxed/simple;
	bh=yI1iGkmiSzMFJtnw1lJVP5u1P/QKkpQHXLglYhfy84A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nKS1F+WsbUPzItfieTii5LHQt9CWuhIVook6s3yto2Ol5nD/hC5PU1k8Ony3Ru2mi+iU0Q0YFTro1AK9pgrSxCKPbqzzIh6IMyDmEi3rXld1eM51Z3jIJDsv/GdfI48y+KeABzzwT/qDaq5UUtfZlWM7ocO0dACW1I8LN5Bk5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ES/pdulu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ES/pdulu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=315e7bSessxyz662R8s4IU7FTBDlj+mVbEZvVNtQrTU=;
	b=ES/pduludp2aYGXqaSG437nkkK1KqnvyK8CfoKoPA6ZD65saVYx5C9hxjBjgyhaM5rlIdr
	h1APbunb4/3aHjuau8Kt67Uj44ZMBw0IO095NwA42axjRE78TkUxsFRAFycq3H1qh5f+Sa
	feQXsKXs2MaMeAC3FPaNoHShaC/sPPs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-wRB42CtTPjmFJTSYX1OpLw-1; Fri, 29 May 2026 11:22:13 -0400
X-MC-Unique: wRB42CtTPjmFJTSYX1OpLw-1
X-Mimecast-MFC-AGG-ID: wRB42CtTPjmFJTSYX1OpLw_1780068132
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49043386b3fso70721865e9.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068131; x=1780672931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=315e7bSessxyz662R8s4IU7FTBDlj+mVbEZvVNtQrTU=;
        b=naHEuM5zqhQFI+dxBAnWm0o45enfU259I7iy0dXnQbB8Julv1sNo0VJFuJPNIri4NE
         kT3yKUbdAJSBthqIzVCXBXQ53SCTt3tgk5snYr3UsZBp2KctkGSnC647gg0QXe9pkC9L
         0kOS2SzjWn5UkGmruSScI11mXV7vKbMlOwF8Y6KajfSd7l9IsIxeMa5qJWqOyW2mVPnh
         6Kxd3PxkBm5WW8P0lNcmkAQLQ/nSeW6pFGNTBbpbF5uMTiR2D/FGpAJrLaYaX8soWTs/
         KowKqDuxtE1kzH7ibkT9SWVQY2mptC8VDXXDieVSF8IEMmBdl79cxY9q18cNhfCaDHRl
         VNxA==
X-Forwarded-Encrypted: i=1; AFNElJ/97Wi6wNzrciXynJvSNBb9I7nVa9rYE7UTudCZbvMadybYXdxU56DbjpTOnhm15AyaqKJqtR7stZwpZsN3BQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyC0gyT/edWCbvan50ScSCMLmBfLDvDfBcLolxXfJDssNouPyzZ
	L21ZT0e5WJjpZ3Ck5TDiECTxycB2dTA0No1g+VD5OKU+m30YzpjlmCzrGfWj556IwlaeYcFinZ7
	VVZ5tA/eDYH2hK63QGqJW5eyLbMtWB94uZZKbKHkFgZvoiuAKkMDzP5TmpZDm3rdNBiXw
X-Gm-Gg: Acq92OFb36dCjEar6lEkdzAhqAGm+1vThSlz1nUkKZZv5ocFrPfzji6LJbJEQFnzFyl
	2Sw5s/5fov5PxwRrQK5Q3QhoBc26NlV97HhYmwhfn6wGXwnVnyJWhhSHSB35i896VVmt1/76OuD
	YuCFBS2e7uZUwDUJ6Fi27yAOnn4O095DsbYnOTqCQGpwUEmwsNT8X5f13D4ME5Tfexl/9FKGJgd
	4csDi3dGGJUO8QYjVivFZu1bbAFj+3ON5J9WOpkUQzx4xPV+gBV77pxNglz2LXcidICWYcjvspb
	IhcXJtqJldH7kaRcUkL/O20kABLdPMFV5vJ4OIxauLDC1sRebia1ciolJck9hs2cm0+/Vdke+b/
	9E5A3UhAsHh79ytqQ99QpIpoPDG9CPIobKPe0ylwFyprRUb8Uqeq6xg==
X-Received: by 2002:a05:600c:8b12:b0:490:2238:4021 with SMTP id 5b1f17b1804b1-490a29079a0mr2311715e9.8.1780068131479;
        Fri, 29 May 2026 08:22:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8b12:b0:490:2238:4021 with SMTP id 5b1f17b1804b1-490a29079a0mr2311035e9.8.1780068130983;
        Fri, 29 May 2026 08:22:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34b47eesm4805302f8f.9.2026.05.29.08.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:22:10 -0700 (PDT)
Date: Fri, 29 May 2026 11:22:05 -0400
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
Subject: [PATCH v9 01/37] mm: mempolicy: fix interleave index calculation
Message-ID: <56ada5b2073a7e307e03fcb3f5327d0cf3dbeb8a.1780067977.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UPd64Q2jYnTkpaCrAtCckexQho2UhdjAr6RUU1XDyME_1780068132
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

