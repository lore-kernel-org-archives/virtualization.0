Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660B37FBEF
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806929; cv=none; b=bUkFestAftRV/g8xxV/KrognY4OQxPRxjnpJ8vOAeTR3q3pkFAxa9x9J4sn3YThD4Sy4+GSnen9syAgJ3W978I+QKc8iFjhGwEWCvF4d2QFKNJj5M8Qqxgd3JFwZJ20k6OoCRgtXzcbz5iSmOrdMY9OfKfjL5Nzrh33EtOO4wD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806929; c=relaxed/simple;
	bh=izYuZWtM9expuJ4aw1W3JEFW5k9djBINp3Pti4HydYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=K53AP79phKYgy3ztUNT48YtZy++2BPWNJSBZpQ0J7e1eMtGYTVJSvbz5ICwM2FeN1tAo0Wa7lf90fPiiyFDFRDV2lajmgivSsHFwrEIYPGBLIlNzAirw+SIRPiKz+ReKn89ZdJN2hl0DVpXQEj3wir1KNuhOplCRCD8jPBL1QI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UonbbPAB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UonbbPAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
	b=UonbbPABs/WAVZJ+kINp2q/lhGgM2bobix8GHDf7b+5l8wT6zS1EEwQKVIipjhp7kANz1G
	6qN0HXc1f3tA5YdI62e4WfebyfFYLgR0INJwDIY+GOce3ZnZNdU9OpuLKm5ORDZ9vPb7NW
	kx5CHPOcDKoq6F21zkgReSDFBMZc1Mw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-DUe4Ss-ROLWFCT9hcBQ4xA-1; Thu, 21 Aug 2025 16:08:44 -0400
X-MC-Unique: DUe4Ss-ROLWFCT9hcBQ4xA-1
X-Mimecast-MFC-AGG-ID: DUe4Ss-ROLWFCT9hcBQ4xA_1755806923
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3c380aa1ac0so519642f8f.0
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806923; x=1756411723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
        b=htzH4kx9r+pTFs3t0uM0FRYDp//7Emlg7Ov8TM7Asn/j82tg7V/at7MJ4LMlOSxIsP
         bhx7PQqd/BL2WVsnkbAPXvy06P4/wex9kWwQD+EP9RKJd1nt6MDk05EGlVrb4Qxtrb31
         acj7Og7U+rB+Mkj2ZlvbXoaS7W3reHbOQDOeqJvrA/cbN+MFQSzD/agmjuzYG/oVW74X
         WP119JtlMS5XqfxUBRuedOAWaoPQrI5lmEfXESl2ONl3pVRLnEdS44forbzJOrFWarZb
         H+cWv0rg76kIcb/ymB+/16FuV5cDLwcZbxDh5fllaaunNq2kZj/zwvwXS16gn76YgFy+
         9qfg==
X-Forwarded-Encrypted: i=1; AJvYcCWvNt5ei/zUIfXJha3FZDQGz2oNql7IEA2Brwldwn/xQvaipg/3I/LmwGhaiXTeFcGaqh+Qmgcqm6SpXmORaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb3wxOur37OejiAz+cIzDJHmQAw/m3pjtO3RV+5VpcpCcezTCa
	L27Nj/ir0EI5AxQ0cMaweYlRvZK6dVRtu8edrov4PI9AhDUAfhoxmlfWL1xS7N9lrayK7RQPPAH
	Wa+X7ZqSjtDkWBVp6yfrrT7Vuuq03pEex5KRDpYZBen/wAd8YEqe33rS+viqFvN4dJsqf
X-Gm-Gg: ASbGnctCRGslSCrhSkl1PRHZDKnRK/+kBwhf/ot29RQ+DyGlUaxXRkReOykPKiUNCA8
	pGMTn6Y50AyHYRLu0lMZFEVtbVFOCRGID4cgOa2Kal4gtLVbWw/62Tgl1kmCmZU7SvnAJDOZDaT
	am1L0QJDYt8WRLO32384YfPSacipATdFb9zBPniBJAdgE1doXj0EH4/EqpclDP3Te4NiLIVx3z2
	U9vYrMd1krsBqABDGzaQXQxlnHYPdSUt5kWP1YDnDUOjIUo8BDzv3YDbBaPFWSCqknEVZF+UD0C
	weVFB9fgQKd6Cx6RxzonRTYf/3ntZuEqsF+rD+H/CtwWcBODji3jHDgbZiwmU2OdBdMqBcNtBbc
	M99c+TG2YHzzrCf25vvM5kg==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204664f8f.33.1755806922941;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnHzRKC08dohUKQD/XdldMc6IWYVddiLtTh8Yidep5vx+5++gzVG23SiimMwYZ+HldR36Zkg==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204645f8f.33.1755806922505;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a587sm10028205e9.18.2025.08.21.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 34/35] block: update comment of "struct bio_vec" regarding nth_page()
Date: Thu, 21 Aug 2025 22:07:00 +0200
Message-ID: <20250821200701.1329277-35-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WTr96UTb_f5TV4IoqTpoMD2DbmDfvndYSpN3p1bkdSY_1755806923
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Ever since commit 858c708d9efb ("block: move the bi_size update out of
__bio_try_merge_page"), page_is_mergeable() no longer exists, and the
logic in bvec_try_merge_page() is now a simple page pointer
comparison.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bvec.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 0a80e1f9aa201..3fc0efa0825b1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -22,11 +22,8 @@ struct page;
  * @bv_len:    Number of bytes in the address range.
  * @bv_offset: Start of the address range relative to the start of @bv_page.
  *
- * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
- *
- *   nth_page(@bv_page, n) == @bv_page + n
- *
- * This holds because page_is_mergeable() checks the above property.
+ * All pages within a bio_vec starting from @bv_page are contiguous and
+ * can simply be iterated (see bvec_advance()).
  */
 struct bio_vec {
 	struct page	*bv_page;
-- 
2.50.1

