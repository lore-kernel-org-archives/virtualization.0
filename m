Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601522D7DEA
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806853; cv=none; b=XE/0DILaxajX4p8CTExerIZ0+J9QOFSYBtchr66TfQtU8VKL7dIrdVTP6ef/REmSZR56s2z65cr1TTMTBtcag5cCuIQPINrlNi+bj4JFFFV0t3XLt09Thf6CeTjbyYuOYojE5beC50R5q8c9qOXVSUxjM+Sv9v5KJI08XIWFAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806853; c=relaxed/simple;
	bh=s79Oeg502W4xdw3NRVnr9AKhHVyvkgzn8FY1ksnzdKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=T8Q6a2j6m5DynHbqpvPso/eMwf9+Ri1z5aZiC8OodxrKGCMkqWqb2Ox8EDFQfmlm+MQA9tXXucRj9T3+riC+qmE718qZx4y5wyVu4v5oc+00bnXCyEtmBKfMEttvbvPOZ9JnSQs1TgmPMgDulHcCzt7xk9bz/TWG73UKh8PWkwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YjT7EvFr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjT7EvFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9Znt0atqEjtEUkbTSfKRsvBJ9rEcbnqI7Kn1XkJSrA=;
	b=YjT7EvFrJT5scdeM5Zhxs1Qk/Cqch+J+8hIxWxlHb7nVNU02myxpnBeJveCAmU84L9yDad
	vtsRlwxqXN6zx8RcnWcVFKhynJbqTs2VIm3xSpDL2hddvTFVyKK/czblWXG8Igw2XVihhk
	Fb0YTZpxr5lzYg/3oduk7oOlhbYva1I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-Fg1-Ld5lNYG7PxBUaAwbnw-1; Thu, 21 Aug 2025 16:07:28 -0400
X-MC-Unique: Fg1-Ld5lNYG7PxBUaAwbnw-1
X-Mimecast-MFC-AGG-ID: Fg1-Ld5lNYG7PxBUaAwbnw_1755806847
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0cb0aaso10735275e9.3
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806847; x=1756411647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9Znt0atqEjtEUkbTSfKRsvBJ9rEcbnqI7Kn1XkJSrA=;
        b=lxm4dUymQf2raizh72oawvDiwu87pab7zSi8ixmil6mNPIWeaPuXv7uM2zcx1OMd33
         4hU7DCuZn4DUQhcLhYt5ETywZRIkfXiwoggoOXm+CIN26psYBieJOl6rbGJZM73Qf1mL
         tuGqKP+iD++pNNfAww12Cu0ssKHAEA+m65Y7NMPneSNXoYAatkl8TYbBlfGXvk74wbS3
         PTr6g7XIIOL3xExPoYbU4I+UDngIFtteDydZmrdwbDA6VmyHmjMT3Y4Wz/sGkvr/PRH0
         +L0tUR8dq1vDD4PhsvoRr7Seb7oPVZaMhD6JyZO67APVc/gNOKeek91tOrKbEVVDKPkv
         481Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkEEL9JD/lyswptPC6nm8DVPx+xCrXPJEkUWLYLJIvDBeyapXdvdLzKx4QjEmn7UutvYoqEfhhK4NqXfAnaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhmkwLMrOVV5RaAa/h7TdSZdeTrMg4qla2zLTdxs+oRgGoWWdm
	6SCx4Xy7JXprbVnMYqG78SC/YH8WT4oZui0qOei8MvlGAunwVGqkv8R518VFH/bVOtwYdyYMBT/
	YvJWSWuf6hGjTi2BLCjyM+OXKlpIJVWFxzRlyG2PtYPL+aELr9pjc9AmB4JXNcMV2IqDW
X-Gm-Gg: ASbGncv57JvmkCYmC+cxdyw7GmWpt+uV2KxJEmwb8xKGI21RLu4Iz9VQzEf6vuTS1Gc
	n75FjKmSyHs77Ra68HPllcDPDKTAwa30JnHucYP/TU4SKVOcPOl+u/ZDS5cbqtB4jKlcXrDc3Oy
	blHrVPf17o6FCgRyaQuxof3OvqqrEy77zATWEEOt07FBJ9+fFdjo/jusYMHAIoTuK2s7RDvY6uL
	WuBYD6C/NhlQ4kwKC7sENBUH0ad6GfDTRA3VpCC3at6iO7rxMCIE/vcvPpyZEtuv+rcak2pcu0U
	2zi5qE8aAQ8/l1XgS/HYHZQun3fy5gcQ0Gt2nTAg905vGwRnWaJU8vuRvlJdtiJ/AGpxQqGp1c9
	pzMnCwOtVWas+sYF0p8osRw==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr2922255e9.26.1755806847225;
        Thu, 21 Aug 2025 13:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUeapMM5JkcwJNJXC+LM6ICHu4lGUEF2ir46AAuHXhYXAFzTcPIdec/q/lplZD/isU7mGEgg==
X-Received: by 2002:a05:600c:3552:b0:459:dde3:1a33 with SMTP id 5b1f17b1804b1-45b517d26d4mr2921795e9.26.1755806846742;
        Thu, 21 Aug 2025 13:07:26 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50d62991sm9535385e9.0.2025.08.21.13.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:26 -0700 (PDT)
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
Subject: [PATCH RFC 07/35] mm/memremap: reject unreasonable folio/compound page sizes in memremap_pages()
Date: Thu, 21 Aug 2025 22:06:33 +0200
Message-ID: <20250821200701.1329277-8-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: ifeYxp3zXtFXd0yWjRYIcL15PVXbLbw3KCEPGYL5TH8_1755806847
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's reject unreasonable folio sizes early, where we can still fail.
We'll add sanity checks to prepare_compound_head/prepare_compound_page
next.

Is there a way to configure a system such that unreasonable folio sizes
would be possible? It would already be rather questionable.

If so, we'd probably want to bail out earlier, where we can avoid a
WARN and just report a proper error message that indicates where
something went wrong such that we messed up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memremap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memremap.c b/mm/memremap.c
index b0ce0d8254bd8..a2d4bb88f64b6 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -275,6 +275,9 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 
 	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
 		return ERR_PTR(-EINVAL);
+	if (WARN_ONCE(pgmap->vmemmap_shift > MAX_FOLIO_ORDER,
+		      "requested folio size unsupported\n"))
+		return ERR_PTR(-EINVAL);
 
 	switch (pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
-- 
2.50.1

