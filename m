Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964583BF66C
	for <virtualization@lists.linux.dev>; Wed, 20 May 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315654; cv=none; b=BReQOiRqv7H4+1QY8Ki2wL05xYVPFhXIp0r+dDSoLchoOdMe5vo1GixQT4HX1BNd7AYMolyZRSNFJPnUE9Wq2JXhwTzfz/4nQKXjlWTGunEhlQxHv7J62zCbewb+n91wMRCR3Nz7h6MC1Bv6o7Dio/POD4zl5KG2HeALLOSmP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315654; c=relaxed/simple;
	bh=zfTSssqCCnno4sdUyiW/sc4lt3FSQTZh1jfv0HEfTik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iEJpgIgqaghiSz4SH1A3qQ4kXuvW8UrGeiI4JjFNCgphSFPmTLsly9Po4Bd5PodXD6FVLV5eIDNg2KHskTtOY1Umgn2o1ByS8xUO9C8QLTXoYyyFU9bvJrbNYpAJs+7xnLYKapkrEJRyCXcrWU64zcP7HUi0RKqOhCRPViuMbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfOkdqOW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfOkdqOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779315652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3RnCcviTYcs0bJrQCPa7/Ta1tOKxh1kkpoqwRDnBft0=;
	b=RfOkdqOW78OKWBvrK7xGnQDOD/p97XFbmwVitA2wATN1GUxKW96GtX0nxattzWWNH66+qG
	w0yFCkO2KZREHxFkb9BuYVCipcT5N1mYNtfjD2XJTUcRaDL3Qk/mB3GwkuWTGK9mpGfVkX
	g04srEDpHY5mg4VCwLJMaUYyAvCOOiE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-yEoAf_iMNVuz4XHTKL1hMw-1; Wed, 20 May 2026 18:20:50 -0400
X-MC-Unique: yEoAf_iMNVuz4XHTKL1hMw-1
X-Mimecast-MFC-AGG-ID: yEoAf_iMNVuz4XHTKL1hMw_1779315649
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3940fc93c77so23255791fa.0
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 15:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779315649; x=1779920449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RnCcviTYcs0bJrQCPa7/Ta1tOKxh1kkpoqwRDnBft0=;
        b=ezeCraKzzoECo9j/IbttObkLVrWdgYkqT9JbYFqSSpYybDwiBMLRKD95biL1TvV7at
         LPPS08PEngQ3m4OTlNpUd+Lw2+SyyEpU+H+sHl4iKIi8UC0v5XTFK3HE0rBewHI4C7oA
         69ISTlfr2QMA/KSU6mfCJT1ttVCsvXFdIId+PxLLiSN0kKavEFBt+/dYFbfXDOisxkxO
         F/mhAkYOOFfgKByYhfRgZdvtDAp+Wf9Nneg3dB1NaIsAp1q+mvWG2KT9q7LQeSVWS2IO
         yit9U5z0vh7FV1mY6NDaEYav5QWGcS2blsOB/WtMT5apfHQoQ9CpU+1j1nducHvNPvyF
         0kYg==
X-Forwarded-Encrypted: i=1; AFNElJ/rolRXmCk0YYTsqKKwORGD6exMM8Ntvn0680mf2yBR6XHhb90U4vVcEiChZzg5cD2Ot7FfahJLz4c0OhOUyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8qr32i6JJfLWCNWo1ZNiWIt1uv2VPghq0srnX9nR4QX2EFLV2
	K6tpv4/u3mRB8SSP9PBeBMgauxWapWVYiXNKu1oU6OKrJ5RT6ATWcC8cGLkt/FU4y9Gm/I+GQmz
	Y2zr6/IItvxlaLb5hCXWz6Sem/0VyDFVDmLaOJnDE86qap2TJ88A/A+Q28eBh0Ef8CPyQ
X-Gm-Gg: Acq92OELqe0TsT3KCAn1OAO2NjdEYNrGociPcDJyjrs+Wvhx5aXIVAduvut4PLaiSSi
	sNhmsSm4Ir2tFSB45pBj9/GZeZruaeG0kBnCsMd2NWUasCA0VsPOOlEm8j1OsMxP78Iaoauxryb
	0vod/gVwVXLhZtS06hUN6Yg6m+NTtN6fD+IgRaEWmbVCKj1mUDpEPOMoVlLkpaFlBnPE3R6OnP3
	0qTjfsnL/vfBVo0wII0UzR0TUVY3X5CitAv1zlqQLZii+ygHzK0ssA2jok3z/2IGh73ViyxMgoX
	yM44ksaTApiPFz8sqCLsNVFQVCMnEx//Gg6ETmg2iQDgb+RNqB6UONnTqbY95GCmgvYEc2/+WH1
	fURhMaqfWl3Bel6hS+UDcsNK0f9jwWStrO7WlZ2p5KzY=
X-Received: by 2002:a2e:a593:0:b0:38e:98b0:3a7e with SMTP id 38308e7fff4ca-395ca5b175bmr844531fa.22.1779315649043;
        Wed, 20 May 2026 15:20:49 -0700 (PDT)
X-Received: by 2002:a2e:a593:0:b0:38e:98b0:3a7e with SMTP id 38308e7fff4ca-395ca5b175bmr844081fa.22.1779315648437;
        Wed, 20 May 2026 15:20:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882cf497sm34824461fa.16.2026.05.20.15.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 15:20:46 -0700 (PDT)
Date: Wed, 20 May 2026 18:20:40 -0400
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
Subject: [PATCH v8 05/37] mm: hugetlb: remove dead alloc_hugetlb_folio stub
Message-ID: <5756eedfaae9e7b69a00da30428ab099f3941d26.1779315441.git.mst@redhat.com>
References: <cover.1779315441.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1779315441.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jTemNceUUkOzijZdKDzcGeI7oUQW0HMivw9MA1pD_S0_1779315649
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove the !CONFIG_HUGETLB_PAGE stub for alloc_hugetlb_folio().

The stub is dead code: all callers are in mm/hugetlb.c
(CONFIG_HUGETLB_PAGE) or fs/hugetlbfs/inode.c (CONFIG_HUGETLBFS),
and CONFIG_HUGETLB_PAGE is def_bool HUGETLBFS with nothing
selecting it independently.

The stub is also broken: it returns NULL, but all callers check
IS_ERR(folio), so a NULL return would not be caught and would
crash on the subsequent folio dereference.

Remove it now since follow-up patches change the signature of
alloc_hugetlb_folio and would otherwise need to update the
broken stub too.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/hugetlb.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 93418625d3c5..f016bc2e8936 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1129,13 +1129,6 @@ static inline void wait_for_freed_hugetlb_folios(void)
 {
 }
 
-static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
-					   unsigned long addr,
-					   bool cow_from_owner)
-{
-	return NULL;
-}
-
 static inline struct folio *
 alloc_hugetlb_folio_reserve(struct hstate *h, int preferred_nid,
 			    nodemask_t *nmask, gfp_t gfp_mask)
-- 
MST

