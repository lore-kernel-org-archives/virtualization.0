Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44B3C8713
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490183; cv=none; b=KFqbBeaOy8ocLuz6xiYchYviF/0bm4gm0R+fE9Goc9mzxEGL7KZ48rKOoGEHluT91MvMSY0upuHMWumGYfsoNoQAH0lNBgY8nEo2G0lDPaHxUXvg7vrQKxrvOBlQXw4rUXOY6n/Pm1XVeEkkS+phMakWi4WlymxikH5Z7skOhDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490183; c=relaxed/simple;
	bh=m8forpKa92wSEANoV2LwX8iYn506Fg/3SPdqojZoxqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GaoHkz7cVbREpbg/3ThtgMuVmwgZ86eiqTJ/EFzofhYm+K1bu8AGBahOtDYlvodTT7xoPtpRvHbBPz1TRNEBxbei/eQAC5txgm5oaCgAwkmgnXVjFxcsSWUh5Lp6t4/1UhOWzlYqWAAuOj6absYdQk4cJ3OvHR1GU7Zo8E46Bp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TigRNlZV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TigRNlZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awVRqRC+b/AmjARdxVJbu/50IYPO1xelbVaktsnFd6g=;
	b=TigRNlZVTUEberAVfum34/untJVJXpKAkeMkbPfFUZRCzqwNzw9nZa+MQIbgWawWyporFm
	CKB+GwPBvWyEqCOkcsG/0w2X7D968Td0L3jFVDKq5XQovYLpdJqArsXiAuMxZQ1L2zBThV
	GJJz6msNhXTAb+xigJoFs2/4cSi1n8k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-rVGpoumoONij0dLBwJCzyw-1; Mon, 11 May 2026 05:02:59 -0400
X-MC-Unique: rVGpoumoONij0dLBwJCzyw-1
X-Mimecast-MFC-AGG-ID: rVGpoumoONij0dLBwJCzyw_1778490178
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4470d6d2a4fso4375565f8f.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490178; x=1779094978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awVRqRC+b/AmjARdxVJbu/50IYPO1xelbVaktsnFd6g=;
        b=QIEokOSGB4zuC52sPFHFXl/WgDZP+GInpzzgVFCPjiuYVF7RbAE21WCsl+zFCsMZmH
         AeXKInSpNf5y50WmQna/U4z0uy3qqjzfqwYwD4oUinVCg5K2WUtAs7BjnlC93I+w66oY
         mP9x42b1QqXiRQKv7EyoEyGOoOOFFWjPqoXYVIujD2QRhkDcGTciwj1fPKpsnJyJTefM
         3WKj2iZhS7kARRaLNeso/Tzp6/4kCGzwg2kXr/X0qgkdmkCSvodVm32aBdvq43SQFF2S
         KD0lP+xYklzL/+jDf5DJAlBqItQlxbmUePYp6Sn5+i45EdXV2OFkMerRb0P9UBI4ZXB4
         lm9w==
X-Forwarded-Encrypted: i=1; AFNElJ/jWV8IAqrSUPODcAb+fSmgLsteqOLbzwgci3HEQ+grOiX43VMlJBRAjyuYYY5rEzV3kkJKAK/pXDaa5s+JTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWFFYKLRn2H6m8eIkcv0PVpUmQOQrg1nyGhE0WbgC2mwAfq4em
	Cf6vADoRvgp3S2TkNjgm1dqjSDbfabnQp0vo0sLTPK2/YhHc7Oknu/7Sj4+uv7qA42qtQ6vWi0G
	v5EKfdaZZqwQyztZ3MMn4nSdoohT8Fr+bps1qwc8i9wp4iO6/jrWOSd/fEa+MWEYBhR4T
X-Gm-Gg: Acq92OEUI+J6Ycl+TP6cQawJZyIFSTY5DqhoYQjJZF3E5GsaDOcM5sBInDhbBJ+RRie
	+zwNMQb7dB9+/Xuih6U5B+UgFNK7WIBZGUCyilnBZR6EGMFcN2Jce4EKEeNxQoITgAF91Axq/az
	qyE+s6K243awdtGvkh/lg07tPDB1gigHq7+nHD1sfiUYKuFCoQD2AmdWERmU9Ny/uxQZRCWRldQ
	fk7UuJBVEwDlThCZ4QOEEw6IGoK+1uXzlXkpWQ7iSm55X6Ky35R/wuAvYJY2q9fWYELFP+2Tr3n
	LWKYJ+q2qki1UQ1Vyt5V+dDPX1mPgpptX3gGX34XNkoq7/zzJNzPkOOPYV/HEByngIutdB4ttSr
	MUd1ameiSiV2orU/g4skMzYS2z3hOOBtyuQgezMV8
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48e51e196f9mr374461085e9.8.1778490177784;
        Mon, 11 May 2026 02:02:57 -0700 (PDT)
X-Received: by 2002:a05:600c:8115:b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-48e51e196f9mr374460235e9.8.1778490177155;
        Mon, 11 May 2026 02:02:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db10684sm60460435e9.26.2026.05.11.02.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:02:56 -0700 (PDT)
Date: Mon, 11 May 2026 05:02:51 -0400
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
Subject: [PATCH resend v6 12/30] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <20ce2bd8227c0149fb205d293b47348c3ef49974.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: VSaYgN_WbKXJ5pVMxs4tyuSmYSTCyRbFS5Ellt0yVkA_1778490178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Now that vma_alloc_folio aligns the address internally, drop the
redundant HPAGE_PMD_MASK alignment at the callsite.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 970e077019b7..d689e6491ddb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1337,7 +1337,7 @@ static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
 	const int order = HPAGE_PMD_ORDER;
 	struct folio *folio;
 
-	folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK);
+	folio = vma_alloc_folio(gfp, order, vma, addr);
 
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
-- 
MST

