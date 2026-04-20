Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3C3A3826
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689466; cv=none; b=K19PmPgsolyTLC9IGajDNiLY6LLjMyMANYIYMKzI6n5CKigOHmRHib6OzOCXHCyY/IhArgq7U3ijSo4lMh/stYU+gAjxHzJOiI5R0LNEqTQdBB5QWs4+tspBcK8kcyUEiLRd9gcwbi0KiLucNJl7RZQHrpqcZdzmBBu7kHfpEIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689466; c=relaxed/simple;
	bh=99DTJv3X+yGf9/H7JcrqKkUagGBqOu5zdakUYlSmk0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ne9L79j/KaAh8loGez+Xg+eW1UUhQ1fWnd3VC9WApEKkI5xKuqDWLSybGyWp0UVrcpf9ok4Qr1+shXHiVpk5xvku0sDnjyIGaSPBUMW66sQzl9Ij/MMJw/dBqE5SZOM4H42vxQQjUtRxD/YhwDb8lcxrYaW3zy4824sAk21ieGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiNQSON/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiNQSON/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776689464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAGKc42yexqH1EWWUAUEJrDKNbSbrVhgetE1tPIVhxk=;
	b=YiNQSON/8g87eryTeEMV5boZNvDQ4wLJJnMCCbXmvA2e7/T8Jz0KnRh6PjKyXgOkwX3aXc
	D6FPwSCxdjcyIXaD42Tqsf83dxV2TUmN51c4mzu8dkg3PP7u2npaqZfDbZIq9gQ+RriQDa
	hEND9dGdjgWJ5o6BLnb5bXnCkwoD8w0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-11wcH5fNPASdxtxkzlvXIw-1; Mon, 20 Apr 2026 08:51:02 -0400
X-MC-Unique: 11wcH5fNPASdxtxkzlvXIw-1
X-Mimecast-MFC-AGG-ID: 11wcH5fNPASdxtxkzlvXIw_1776689462
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488be33b7a6so22254435e9.0
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 05:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776689462; x=1777294262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAGKc42yexqH1EWWUAUEJrDKNbSbrVhgetE1tPIVhxk=;
        b=T2BmE9uI+TVb4oMV3gwDAYZQiewdfp6sSIsXQo3s0DxRIRuyts0r7Qnn6bH5TfMgM8
         r/KAClEl9CDg0JsC6WGjdD8zE+6l4SZX+fk8eCkKsMOyQIl1DL/+lBwR8dFZLPSxlN0C
         fbArWJ9pkMSgHDCN2XXI7o/Qubc16MTpvGeRN7uOjHiuzMV58SSh8pDAIA46QtnQV3r+
         Nfy0artE2eUlPRxVGt7jhJz8y3HfZwtBOni0kiUlabaGokRELAG/qed5LmhDCFGvek4/
         vCTSELa2PprAtVpfx2n3EwvhcKEhPorQMYP2v4JGJ8yzsq9kmZPeeWGEf/il7NOyxaz4
         oFKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7ok1AW7SraPCWNuIHK+Ulc+rbTLPj28J7nVdTDODV11ddU+0UQadnedclpBzORzLx7LaDdHJ+Rf8kmmdTWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw34gfeogL6AsyKTsh6QFG4v9I8vTo8ldrY/g3thOhBUQu2aanx
	Bl7V694BOBsvM4UpY+ihTqmKZ2+7Y8ErIwloE+p2pdAF/LPZWH4MQ5At4bvKMz0ydcExoavG6Nj
	CTLNERdvFdVK3gmhGNGudAhKUX0DOPWPLetAXfjvhVuJjvLq8Th7FhfQ4r0hD4QZV5uYJ
X-Gm-Gg: AeBDiesO1saL2zzk/dtKuGsyI+i/oIKuYJ5vvYwzB/GVL+s7Gg7ZSGJQ2uJueiknW1X
	7BF8qeNIw2GKnjqsQjDTM2fnMkcVcXz6OqDwyQmsu47iB11KxT2axxK6lf4qArjnhoFPJ+Bx19L
	tQsYu/+LtwMqBydPo1P89D3SiQU4ezFc9ZFEEjZWntI9JB7uRxKq55K8ZKjLVcadxVqjJf4t7SE
	diyZt2BS72GZzctYJCOAqJgHH7TwOEgKdxVUNmqyff/jX7NtxXA9gIn56gnmtlBhvuQQwZkktfv
	VEHnc549oLwLDq+dmZ/8RNBKn8u/7j0YYjr4yitDoEeA8wEe3cUBhPwxha99XTXjcUZf/KBLBaB
	VTKSVPzuXE6vDcJ5rfH9528IIJ6CrFFcWVrHyOwA0qyWSBnZ1rWazDQ==
X-Received: by 2002:a05:600c:a00f:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-488fb788924mr200859505e9.23.1776689461546;
        Mon, 20 Apr 2026 05:51:01 -0700 (PDT)
X-Received: by 2002:a05:600c:a00f:b0:486:fe83:8621 with SMTP id 5b1f17b1804b1-488fb788924mr200858775e9.23.1776689460975;
        Mon, 20 Apr 2026 05:51:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb735d3dsm184142605e9.2.2026.04.20.05.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:51:00 -0700 (PDT)
Date: Mon, 20 Apr 2026 08:50:58 -0400
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
	virtualization@lists.linux.dev, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH RFC v2 14/18] mm: memfd: skip zeroing for pre-zeroed hugetlb
 pages
Message-ID: <03405f0008afd371021e98a985490dce7fab6e7d.1776689093.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -ivrleol6oadaaIww9IYT6MYxqkrmXWSuTDYNvfWBF0_1776689462
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the pghint_t output from alloc_hugetlb_folio_reserve() to
skip folio_zero_user() when the page is already zeroed.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 mm/memfd.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index f1c00600e19a..546149897369 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -81,6 +81,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		struct hstate *h = hstate_file(memfd);
 		int err = -ENOMEM;
 		long nr_resv;
+		pghint_t hints;
 
 		gfp_mask = htlb_alloc_mask(h);
 		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
@@ -93,17 +94,12 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		folio = alloc_hugetlb_folio_reserve(h,
 						    numa_node_id(),
 						    NULL,
-						    gfp_mask, NULL);
+						    gfp_mask, &hints);
 		if (folio) {
 			u32 hash;
 
-			/*
-			 * Zero the folio to prevent information leaks to userspace.
-			 * Use folio_zero_user() which is optimized for huge/gigantic
-			 * pages. Pass 0 as addr_hint since this is not a faulting path
-			 *  and we don't have a user virtual address yet.
-			 */
-			folio_zero_user(folio, 0);
+			if (!(hints & PGHINT_ZEROED))
+				folio_zero_user(folio, 0);
 
 			/*
 			 * Mark the folio uptodate before adding to page cache,
-- 
MST

