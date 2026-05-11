Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC7226863
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490280; cv=none; b=ooDiTxFGFkwhnefJD7Qm08gP417qFUfhQ0tX40vpRURBqdHpMXmskqgJLKiLCFv2/BTlbAhrT7+Ab0oH4s7/LFDgLuihRF9k9gNJLsN9+STzs/nrxD4umPSIpyp5dahmOidC2BjR4qOjuo2SPWtYy2Qj3Ch6/I8UDVFUm2kIzV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490280; c=relaxed/simple;
	bh=mQqx6N7f4HKujpbDEae/MRGG23U+Ado82zzAxmBrUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AV9xupBM8NgazIjxvo6773Ir3QL/q7vZMbpJX7bA7WU/h5k0tQ9+PMGfTi/33gKEa3UtqNP6p00x8QtebYA5kQUx4INF4HYTKhA8MgncAcnHRCFMqoIFyinCRE6XSX19vcJtNB0K91fvhhCVcyWneUHo1UNWhAbvQbRkLR9ffys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWRpB6Y1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWRpB6Y1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpBn8Jg+yemSfT/rKcYB8AJ8VmedmgkSc9fIviOsi3s=;
	b=JWRpB6Y1iNJZBs1DU9803CdrSxmOolpU45qCeCG1mix08n8lggM7/XqY8AsldGCiRZB1tB
	AaE3lQiCGl420ro/r9PlyW9QA5NNy6dlIA4/yzvwBid66gACttuTXHLrkQIAady/2k1KZ2
	JJ3v8XBarISE0JDfy8SJCTzlh5NtyBc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-dFnqWL5OPGSOa93DWTG4xQ-1; Mon, 11 May 2026 05:04:37 -0400
X-MC-Unique: dFnqWL5OPGSOa93DWTG4xQ-1
X-Mimecast-MFC-AGG-ID: dFnqWL5OPGSOa93DWTG4xQ_1778490276
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso31845115e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:04:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490276; x=1779095076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpBn8Jg+yemSfT/rKcYB8AJ8VmedmgkSc9fIviOsi3s=;
        b=QipadSPBzynxlzxZ1HK7NJl7SCCTcf0ngQIs7KOW3vLNtaRSf4TCERNnViyp5Wzpk8
         Ojd01LP553lmeTLIldg4guP2s/cOENXIQC0T8SM0QrSTngxGeChQpn/m2zCeYyz2Mrpm
         aZAHZBybk9xf3/cyAqyktKpuToIZSUygp5XL9fpA7D5LxHSeO9u72mnh3UkLkBtC9EKM
         Dekjw2vtmk3vI0se2oDNYknA42dR0R8By9PdNwhUtZ0Ljfud2NUA+jijc1DIpFpou3rP
         DU6wnngevzuYsKJXGkzcZ0+zFvSpxZEsvuQTADM8m1xUFxzScNZ2eoV9Tvt6bZN3vwaJ
         BSzg==
X-Forwarded-Encrypted: i=1; AFNElJ8wR199UDPCe/5MNWMqRC/Y+jkC5DTP2prDQNfYbxUxejzIb02aqCV5NXtclFGtOYsXYkmBQ2I4sAs0vENZ7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVo1SQsu3QOHn09VMqnfdKcaVGF8BAYxyUZQO8c598yJmCQnHU
	OqbltLUu8VUneKFfBD4pPNNJf/avDmvMWNEdAwIE1cdCdCd4UyDQXvQuR3EjjNaZtbJYU2kXil2
	CxlY1G95BNxaCZtOjTPEsv4Y3u0XWBDWIrxgjy+y3ONGklv5TcF4F0TfHjbQeKr+7RmlL
X-Gm-Gg: Acq92OFerM2DvusBPJEbmmptgasQftC3G8yPlPKu8jl/NEnxNh91IKXK0obxx26iyuv
	wFk9eKO5bxTLPdcx3twII9Qtd2cKrfg0kPDmUHYMme36OchZIeDVCUdsoqRVmTgo2MEE/pkiOsS
	S7T/JRezWbjeqqfTMjGZuOKklDbeXzB/hWhgGPy3IRM/g/yFpq51FE02HvInN/koIByfvevbsiZ
	rb4Gb3GeETnJSAJk5t7cSsSA2ANNO79qkGWlvspZbaT0ec5YlL5A8ki/n4qP4PYPQXSnJxf6LNE
	59uKr5+QAjXwY0UanX2LAKbqQjt6wIVjyRWZ2BcgmCcsnH5Qdccguv/uRb8EEfm54QB1bVaM8W5
	1TS0KZlLyXJh0P+qCedLynf93d9N4oBLjagMZg0rl
X-Received: by 2002:a05:600c:3b0f:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-48e51f4cdd8mr372760825e9.22.1778490275700;
        Mon, 11 May 2026 02:04:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0f:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-48e51f4cdd8mr372759815e9.22.1778490275037;
        Mon, 11 May 2026 02:04:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e80ca2666sm91683315e9.10.2026.05.11.02.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:04:34 -0700 (PDT)
Date: Mon, 11 May 2026 05:04:30 -0400
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
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH resend v6 30/30] mm: balloon: use put_page_zeroed for zeroed
 balloon pages
Message-ID: <446baed638f945982fc205a5354611bd24b2672f.1778489843.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: vVyrPoW9BU7qChW1jzB5xjIbVfEAzr6cEpEQbYsaq_c_1778490276
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

