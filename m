Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3CF3C872B
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619971; cv=none; b=KQ7o7eGQ5XC+O9bZ2yiUjzuqGW56uWdagkyg2iqXanpffMp/NAyZVgAL/1WuqFeuf5+zMA1HfNaCRiHtcW5ZAv7NXnVbsKaVODxHqw2KZzNn2Ybk5E8c8HcE45i+ouCV4IMJK0Ub4PgtzUFUMqAPH+ltUrJxxOjBpIdZ1rVs6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619971; c=relaxed/simple;
	bh=B4v7SD6SJ84KapLgBy+iXreANiiaF75HE81bu1RBt3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xm9CoqUKBJ4+XYzxV9CjAzKkaKaSByl3D3ToOuwvqMbXrq7ifZBs7/jPG6gAPraE/zPoUaRGYSJUXt0mzgU4SWmJEtgK3tbru/p23FbJtfVfj6RBx7NM1Tp8n/IcYjDFAgBO2aDnrA2ZmAswnEXlVnYMW1BdzUu5UB98rsWJey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5H4umyj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5H4umyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778619969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
	b=H5H4umyjHg5UUbJrjiX9S7Toi0g6jZpJGcAxnZGvVTDEQh5/rjYFqI2t3XPTMsx7N8TPn9
	9YO3wf/IfjnDi6JdXtH1aZ+BJXicREE/DlniAfptbUw6X0++0FJ0jHTJaRatOJXdAKLNbr
	wdESVTYAkvf72AUe/VAOS0e/huAy7BQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-u-rbBFR_PQWykBnVooCztQ-1; Tue, 12 May 2026 17:06:06 -0400
X-MC-Unique: u-rbBFR_PQWykBnVooCztQ-1
X-Mimecast-MFC-AGG-ID: u-rbBFR_PQWykBnVooCztQ_1778619965
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44ffa15dc8cso3782026f8f.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619965; x=1779224765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpAQ9O1oMgUNlo5ukg9OEno1SM1k+70VK2/jH7/8vVM=;
        b=AKtSK7JVUlxmwiR/i6o5IXTLg7K/9DLYEE4nrRp9gGwC4qonOlYnFg3Jks6NukjpUh
         hkk7mb2asp6psfcPcWS+vB2O9jEtf/hWUulYyITbyzG4OS/xzYr5bJI/Mvbasx35ikgS
         XALKD+VQeTf2LFeWmG+YvahRqiyadPaVj/IaLTqA/DE0FT1WFCRt0U5vQEb3Z9IdJhYz
         mdtu+TzzBJT6JaYC2Uu9I77ASeNWib85ctlt3zfOmdq38ID+ApQY2q9r4/lC9tGC5GiV
         eYV7ck45JJuwrnRWs9tZC/aXLKK9Mm+DS9UFWM8LQZC2sRteDenvWcmFBaNQ4JvAPsaQ
         fTvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QOgLWbB0w8rrBUtxPui3Bnij8vOdR+t7yne0i+OyFhAli0PBXpaG2269PPJHMb96yV5U/m1pA/5vK88Kqbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKaEqTJZ89pIJk+/2wHVvSHOMzGy3TG2hYjHPXEao6wFoYp/Qh
	CIv06qCe5x32u3mrjnae+K9m4qzwOuNsdFVqIKi+6HLG/P2tQhQ98JCEtJsHMsEgVvucz/ac4dU
	Mi070MxLsOlouTW5xu690nDz4p9LSfqUiryRnIazxKOx4h1AsYqnF3iS19S77rcGFKP7G
X-Gm-Gg: Acq92OG6JKfQLxvIfVrin0Lp4mTPrjyF82+RYY+d7twqoibyTAroowvCmm1MqPY9LwA
	yB7N7Yiffww0p03iq9hTOl0c3SLlXUVw3KE+ARxU+F+LOJZ9naM4pNLmFNBhojLrLJmnTF2++YO
	zZA0bHpQljY7XQ4f19VRTYYs0E48hz2wj97UPPRjO0jaeYOqWHC4HPSZKsG5iVZlFxK2WwxDgcx
	5g7rlHn6y7IQdUsNt5LiwVU3r/8WDnR+2RCcStEBeHNbNcx6Utb/hWOY+gquBa8ywRSGx3gEhHF
	WvdYZnlrPdGzj+AxAyiXz4CCn/nfYUQ/fxE33zCz4Qjy+9DzG/YMcNgS+b3vHnTHCq2GFHmJwQ1
	ZYaBu4jGvjvvXkdyfh6OfurZWaBy7dhq6byNhJTln
X-Received: by 2002:a5d:64e3:0:b0:449:9aee:4573 with SMTP id ffacd0b85a97d-45c584a91cfmr556781f8f.18.1778619964949;
        Tue, 12 May 2026 14:06:04 -0700 (PDT)
X-Received: by 2002:a5d:64e3:0:b0:449:9aee:4573 with SMTP id ffacd0b85a97d-45c584a91cfmr556737f8f.18.1778619964519;
        Tue, 12 May 2026 14:06:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b00fsm38840020f8f.11.2026.05.12.14.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:06:04 -0700 (PDT)
Date: Tue, 12 May 2026 17:05:59 -0400
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
Subject: [PATCH v7 10/31] mm: use __GFP_ZERO in vma_alloc_zeroed_movable_folio
Message-ID: <bc48239f8f4eb21cf2f9f6e6533c68daaaa2a01e.1778616612.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: V-JrxXmOjzRxIrizhJYlopRWczeh1XS2xwlX9ml8Jgc_1778619965
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

