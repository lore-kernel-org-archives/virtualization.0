Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658E3074B1
	for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776034251; cv=none; b=b0ynTK/fInDi66kJZAcJnKqRRFswPkIKFnjBdAzUSji95iMAkWkxfzkFmGSm6TBVo8hJM6bjW4/QVKxg8mUugdxegYS7VxrwHL7uN7bOUAu/vtQ9oU3schROrcmj3HQQ56/XJk4scGYJiZgRcqWSM2Xz7r2SHEn8kZrDiIQ0K70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776034251; c=relaxed/simple;
	bh=1Xi6QJj55uFprY3+j41AxpGhuS0+qcgoEfdSGDN0Als=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pz+NnXdT8eMtARqg3RJVXjUW5ykoqNhw/zFVxQ1arSff0IW9sa8xU68dwzze1i4xY3B5O+Sncv/xP3RwlX6efw+blF4e+rEGHmGPrFqp49QokpkhO+qsD/1xNwbSgG5XdK0SUuUUITG+HGubXi/+gBFGyYLpc41WzLraomrQgz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkzMMe1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkzMMe1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776034245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gWKRsIFuB+Hs22ZUHt8b4Lo3W4KNzkmERVB6NJaMrU4=;
	b=dkzMMe1AnBzhYkbq3aB+RawjIKRCscWy9oqegzEqTheQsJkG2U7le3wQ4GHtkznM9Lmoga
	fUr9w2QFsDxNsNMyBJNz8WXtQZf34F8NanpUHcDR4Wcg9NChIeFX0XqnjDTT0AtLAKbL5Y
	egANBNmMBYMZcyBBV2bhQvhH0OM59ac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-E6_SFKNqPjaM9eaiCSeTaA-1; Sun, 12 Apr 2026 18:50:44 -0400
X-MC-Unique: E6_SFKNqPjaM9eaiCSeTaA-1
X-Mimecast-MFC-AGG-ID: E6_SFKNqPjaM9eaiCSeTaA_1776034243
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7a5b9678so79822f8f.2
        for <virtualization@lists.linux.dev>; Sun, 12 Apr 2026 15:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776034243; x=1776639043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWKRsIFuB+Hs22ZUHt8b4Lo3W4KNzkmERVB6NJaMrU4=;
        b=h+UjXi75KKWJK9TCPratLBmuyANWYZ5rSMB5S4rkR3XudHYivKa5RcKYmHpg8/ODgI
         Wn+6T7zrlhQAsKK/kAMfg2iyljCsJj7X4Aq0ZZuWr0EmILGe11XhKCkZi6+YiC2ncATq
         Li0RWPugYk4yneUKqkcZoqLgf1+2xbMIh3pFGhskvi4eOJe26YdfxBwpBm2fVrUos4rG
         Ko75a5WTRDCOycF6c2QqFQIyF0rsOBcnP0joRdkqPIqz9ldNQsZ/WV6lkd+kSferUHZs
         1znaVYQV8KeyDSZg2WOkD9Maw3mdo3PLDHPyl2hpE4E1tep8A7OTORfiNmDCM7fuhwAV
         TBDA==
X-Forwarded-Encrypted: i=1; AFNElJ8j24m03eZKCTmAMbA9/XEAnfeGJAQNQwBqPw7XKBxWsyJ675d0aSSPv5NYJ4c6KmrCj9BsBjXPW2q2PqfjGA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpXW5tpPggZPVlyxSNeXTvXADzORbtYXtbRCflzB5rioGX7rbF
	bKYVhPqR1gKn58e3koUGKRCqMza8j1kwhusar1Md87RBDGUyEL8VAkhKrP3GO9JxYCyvOLGtiMW
	wFc07UjqCMsauTk8jtdeYR0OiNgK8ApsH8QTGHCRRrW/vQxHCvPW+Wv8eMW6hUAuq+tN5
X-Gm-Gg: AeBDiet46/MKHXaaSDQcQwWeMS4ZYZ8kq5NH6zd6CbtrM/6NO+azbXhNXwvHJeJGdct
	PUnR5w7gmpNrVYSjjbHqN9IgDZr3Di5YIQUO7wBWu2UWtrY5sDnp2/LynrX84nL/lPUhcb0xIW+
	U5BR2oE7UeoGMlRvQVztLDhxT+ewOad8WXWFPkyX5JVR6nvX+rccOalJ5Geq14ElkY7HnNSiKqo
	1zhsF6ld+egVWhud6sOzPKVFdHehUNboE+8VtTiG7NMtzvk4HMOW28uP5gnrL9V+9VmMQIvvdVw
	Fole8BMEpkpFT/UjmhWjgKYeVTosqbwBaH7TEU7wQGX/aDugV0fTXqM1qgDyvvfav0HSSbeE5Qc
	vU/tr5us0BqEAmYCqbN/y/NHSHNd3zvGlC279noNwOXE=
X-Received: by 2002:a5d:5f53:0:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-43d642711ffmr16823629f8f.18.1776034243230;
        Sun, 12 Apr 2026 15:50:43 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-43d642711ffmr16823615f8f.18.1776034242809;
        Sun, 12 Apr 2026 15:50:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec295sm27487393f8f.14.2026.04.12.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:50:42 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:50:40 -0400
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
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 1/9] mm: page_alloc: propagate PageReported flag across
 buddy splits
Message-ID: <a74ad3652d9bd68c78fbb5360fa7adfd0606689f.1776033771.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 6Fv1nPB5TgIhonjJPmIaYOv3pXDXIrX7YbUPyZs4gTU_1776034243
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a reported free page is split via expand() to satisfy a
smaller allocation, the sub-pages placed back on the free lists
lose the PageReported flag.  This means they will be unnecessarily
re-reported to the hypervisor in the next reporting cycle, wasting
work.

Propagate the PageReported flag to sub-pages during expand() so
that they are recognized as already-reported.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
 mm/page_alloc.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d4b6f1a554e..edbb1edf463d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1730,7 +1730,7 @@ struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
  * -- nyc
  */
 static inline unsigned int expand(struct zone *zone, struct page *page, int low,
-				  int high, int migratetype)
+				  int high, int migratetype, bool reported)
 {
 	unsigned int size = 1 << high;
 	unsigned int nr_added = 0;
@@ -1752,6 +1752,15 @@ static inline unsigned int expand(struct zone *zone, struct page *page, int low,
 		__add_to_free_list(&page[size], zone, high, migratetype, false);
 		set_buddy_order(&page[size], high);
 		nr_added += size;
+
+		/*
+		 * The parent page has been reported to the host.  The
+		 * sub-pages are part of the same reported block, so mark
+		 * them reported too.  This avoids re-reporting pages that
+		 * the host already knows about.
+		 */
+		if (reported)
+			__SetPageReported(&page[size]);
 	}
 
 	return nr_added;
@@ -1762,9 +1771,10 @@ static __always_inline void page_del_and_expand(struct zone *zone,
 						int high, int migratetype)
 {
 	int nr_pages = 1 << high;
+	bool was_reported = page_reported(page);
 
 	__del_page_from_free_list(page, zone, high, migratetype);
-	nr_pages -= expand(zone, page, low, high, migratetype);
+	nr_pages -= expand(zone, page, low, high, migratetype, was_reported);
 	account_freepages(zone, -nr_pages, migratetype);
 }
 
@@ -2322,7 +2332,8 @@ try_to_claim_block(struct zone *zone, struct page *page,
 
 		del_page_from_free_list(page, zone, current_order, block_type);
 		change_pageblock_range(page, current_order, start_type);
-		nr_added = expand(zone, page, order, current_order, start_type);
+		nr_added = expand(zone, page, order, current_order, start_type,
+				  false);
 		account_freepages(zone, nr_added, start_type);
 		return page;
 	}
-- 
MST

