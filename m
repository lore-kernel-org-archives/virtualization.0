Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224923BD62E
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489663; cv=none; b=XnGQpK/N0zHew83NYFaFfkvyjt69p1ZseyfdArHXWpTNquIByZglYy/IIT17B5IZOYjAZ7e0lnt810zrhCPMivsXMJEM4K660zk6vTe2oqCVicCpvsZhjcL18Sa59DFtuub98CaXu80dqROLFJSDVjg74oefhiMOPVMci8bu9q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489663; c=relaxed/simple;
	bh=m8forpKa92wSEANoV2LwX8iYn506Fg/3SPdqojZoxqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lu2GfmgxbzRBqEsuiUusMWiPq/Z5mcR6wNj97tBkdx0KQ3BpLpQ6h+9gV5nwYUbQ2qUIaTXiUJJAWUJpBfSQGFTeFMx+y41QweCXzb9KhWKu27wNe1XrviSO+9nDGTEsKULmCYrY7Q5PiexVru7X1MLFZ2ug0LnATorce49map4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtdUdYKY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtdUdYKY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778489661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awVRqRC+b/AmjARdxVJbu/50IYPO1xelbVaktsnFd6g=;
	b=gtdUdYKYnmNlUl2V8J1DiA+lKEExLVDkrNXcV8NZLs0oV81z3l3weOMGNvs/EDg5hwADU0
	99ol54AJj3Qk4pdUwBC/Ui0JTwFC+kvr/eOnFBnE1ODR4JJIg96d+Kl+ynAJoHZegl2hUP
	nO3r7fAojo9FLDmZohXHTyV2DtbeJoc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-nB9W27KqOkK6BfYtUsigaA-1; Mon, 11 May 2026 04:54:20 -0400
X-MC-Unique: nB9W27KqOkK6BfYtUsigaA-1
X-Mimecast-MFC-AGG-ID: nB9W27KqOkK6BfYtUsigaA_1778489659
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d103e46c3so2456152f8f.3
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 01:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489659; x=1779094459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awVRqRC+b/AmjARdxVJbu/50IYPO1xelbVaktsnFd6g=;
        b=isZBZCyMFqJB/yKJd4IqgtrnZB3dNsGtdEOp1d+WCj9swWKTFoQ3WWCgIHloFNHP3J
         TkLe/kQimcAaSp09Z8J9gnbQ472WDV+K42rks1BgrxPD1AEtTSQHZJD4bWc60ot4qZz8
         uYG8g4/9t5cBD1ybx8HUAcW1it/UtBXkhBZc3g7vz8On01C2Wgr4gmo2wFIzqYkjplav
         Rb2b+vVKmcFnVSp+BN+npO+jtMkLqRUSHz1CNmCDmYVYCH7R9gM4kmiqf07KK/fYfp1c
         OKEfoc8RRmpg7ApHHfm63nHCL/IrhVFZYKRr9+ZROLCjijXyqwQY7ofLsMKpUGt0Dapx
         p0Ug==
X-Forwarded-Encrypted: i=1; AFNElJ/1vaNOx1ywwJkfXZCjOeW/sghsUV+oc0+cWw/bmqI09WqXKtKsJDuudBxBNi39aLi9ysqMoK1StwegmMo9sQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKAgS2YgiM9BYaAQkr8EjObTKsMoDVdTG3l5xo2D2ZGMPcR3Ot
	X45lhfCDKayaLg+eyRyTvgTQGj264BHHo81zfqKrdqECE2XPVy8m2VQd5Uj9Jnq5p9l98UFrTLL
	ywcPQxYqaDPU0gxm1afxifyVa8byMJHR7r59svY44Xttl+SXvzQgQW9ZRFIIRq3ynGfiG
X-Gm-Gg: Acq92OHiOzOMnH7Bbva0cfIFrWcUwNsPhFI5LCS1x4qegzSvz4Xh70vMHFbRjZSe9lB
	AJ2L60bj2MdbfSDNbb4x7DSofOgZDY4NVA9oPL0JRtkuRxi6jOk9Avkmnow6KBdaMmdvnd25GBR
	XlzBH/Twjs9fbJW7PFy9/8IMh66gfrSyeZHQ7pX7qm/mwPy6MnE5PH4ze0o9Sn6+Ajhd5hkFc+a
	qmQj+VkawrwabBStO04q44MtyclzA0PJWWA29t9ld532fmGQz3kqHzDbTwn2ZHXHK4YNWgkK5mW
	C3ZEG2GsnKVztYJm4qGiLjvt0b7ErBNXo6Izd7OYY0Tn2CyGD4mbM9dT9lBIMjhR6HMckzAq584
	Iqg8ynSVm258RXH3YqRj6LoERG1RIGI5XQ3QXvBiO
X-Received: by 2002:a05:600c:3e0c:b0:489:fec9:a17e with SMTP id 5b1f17b1804b1-48e6768514dmr232537365e9.12.1778489658602;
        Mon, 11 May 2026 01:54:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0c:b0:489:fec9:a17e with SMTP id 5b1f17b1804b1-48e6768514dmr232536465e9.12.1778489657983;
        Mon, 11 May 2026 01:54:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6fff9c91sm181688305e9.1.2026.05.11.01.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:17 -0700 (PDT)
Date: Mon, 11 May 2026 04:54:12 -0400
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
Subject: [PATCH v6 12/30] mm: vma_alloc_anon_folio_pmd: pass raw fault
 address to vma_alloc_folio
Message-ID: <20ce2bd8227c0149fb205d293b47348c3ef49974.1778488966.git.mst@redhat.com>
References: <cover.1778488966.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778488966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fJ1oSYhIX4RsxL6m7U6BM8awmO-ofDMrVPYONncBrFU_1778489659
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

