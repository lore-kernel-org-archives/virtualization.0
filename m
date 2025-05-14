Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0820C47F
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747221352; cv=none; b=W/SyrjQxLtsJhM4oPCb90e6RfzDrivy6GVmydCoZZ/quip0c9PyosdTnaVuDmxz93sCeqxi+yCwu6IkWK2I+MjTooyAji4Fqnq2Au8kV8XCE1CYSP1lEVlXRyQ8SFal07RErGzQlTQfhj/qLwHCEmiahFCZzw/DH6v7q+66pyYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747221352; c=relaxed/simple;
	bh=7jiNQ8On0aJiW3KOJvKsfGYijgcEvhZxGNKiPDfiJY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mU3SHpp//W+YJ2NMIK11wWjaEat9q9bpGmNUEXoiG2gVG0uRI02kBMLvWJeP1U15b3KHFF8QOLJ2mDPZ6b7RCCMC8RPE8Z6GqEF5Y3wLliCtzBcLFvNpFTqnz+mdqdle2Bq7EJyogIDglIfKdG9a+3pz0PhEdgEJ0Ga2CSyvRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6wICQG4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6wICQG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747221349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KIw9tYXSMe4QTBEVyDr0dCSVyNZwb8svaSbHmSTLAC0=;
	b=P6wICQG4c4sudz6CiOVTMUAP7iGfbcWougmbpqXfBOq8Z99ZjzlTjziWT1cLeL3rLCoqe2
	RRI/d8uNlNVwf8A//EFjeKk7NB4qK9CoLu5mErYOc+w841slol8/VcPEpYg2VpjUh6QOQp
	n9tENBxkKywB+6R2j24Gnj73OXqwDck=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-6OXImcHaN4yURAb6RxuVOw-1; Wed, 14 May 2025 07:15:48 -0400
X-MC-Unique: 6OXImcHaN4yURAb6RxuVOw-1
X-Mimecast-MFC-AGG-ID: 6OXImcHaN4yURAb6RxuVOw_1747221347
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-440667e7f92so32485765e9.3
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 04:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747221347; x=1747826147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIw9tYXSMe4QTBEVyDr0dCSVyNZwb8svaSbHmSTLAC0=;
        b=GRmWXHML/qTaFvyAe9XaetOd8RiEhkZk/+Bnmd//eg0PCyuEGwiLhnO55z4hfb5wFb
         ZLDY3OdLVGn+URyE4SQQx68rJylIuM9Jdl8xvVkohNY/oyVMUL0hQEwD2ANFuCx3efS0
         Bo88K1vo5HTQkv8C34BKmE1rgXi9CB8TB1BI1Rd0EqgMRfja7mCRHfG914u2tAFOzMOp
         Xmrj0JCCHKgfckg2pY1hy0QfNm4ZBbl6jA8NZPsLbXnKgVuLVNsWxfRA7E/cVknvNdlE
         vVf6By2ZHt+J0sB/sqEx5bi09vDTWRCpHST0qIv7wgVX5p1XP4GO3CYhGMMlgxjGea2l
         0Z9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZhJph/KSyI0ej0kBDmr7eNvA8nkF3gfWjYeZDBgopMUBHHk3A3xWs1kOgjRrGoKSMOe0aMLWaGBH7iJUEQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/533RA/iImHjeQTkIoNOBN0fEICokvRippm25QMo6/fBd+5BA
	IgTHCM3VcJqLrmruwsFd6q6EHdyjCBgvN6/P2nTpHb/tj6dWS+b5k/4vfbifsyK2TvyzjvNuhuW
	Twm/SwONSK/+1duZWmeiHIbS+iow/yick43HlR019TpuTvavV2FLY7zbDUStN7aFp
X-Gm-Gg: ASbGncvTOYglNIDTqJDUAQkL+NjMYV2Lcq+zZ9Ho+NFiLN1txlVmbDjYP7/MjYQWWfU
	ZIFieb1+1WxfvLWgcNmUFpP77HZiY4k5Njn8Byczoq2Y+SVWZOpfdM2rnrF0yTlLHR8VWCdbKl8
	jW53RAl97sDZyEbjcDATbd60aKox0ZSo6S8s5np07O65AH2Ot8AP0h119ibLRCZmuzqv3Vg7P7X
	qNpgZUs9lOXbxCAa9If2AQAAcSeaqU9yf4jhY0UTjZlXlAy1PEzey3LoKXQ4rh8LZxDj/D4Crfq
	qRPFjdqSBg1TwUcYHAuo+iP4gdyAXpWq3rULbpLZsuaC5b9rbxkyIfZeU3kexVqMbH0NSWKm
X-Received: by 2002:a05:600c:c059:20b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-442f285da04mr13846005e9.2.1747221346881;
        Wed, 14 May 2025 04:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJJIhh7s5g1SAUq6KR34Wmh7l8nWtY6enkkRW9tV0qsQ8PccLlCfYwaJySR3PqJiwxgI3cFA==
X-Received: by 2002:a05:600c:c059:20b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-442f285da04mr13845795e9.2.1747221346462;
        Wed, 14 May 2025 04:15:46 -0700 (PDT)
Received: from localhost (p200300d82f156200d4851bcdd708f5df.dip0.t-ipconnect.de. [2003:d8:2f15:6200:d485:1bcd:d708:f5df])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442f3979275sm26123595e9.34.2025.05.14.04.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 04:15:46 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v1 0/2] mm/memory_hotplug: introduce and use PG_offline_skippable
Date: Wed, 14 May 2025 13:15:42 +0200
Message-ID: <20250514111544.1012399-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r39TFiH0kbS35dQR7DrK7Yu_pmL9brDCxhfIHTPC3EQ_1747221347
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a requirement for making PageOffline pages not have a refcount
in the long future ("frozen"), and for reworking non-folio page migration
in the near future.

I have patches mostly ready to go to handle the latter. For turning all
PageOffline() pages frozen, the non-folio page migration and memory
ballooning drivers will have to be reworked first, to no longer rely on
the refcount of PageOffline pages.

Introduce PG_offline_skippable that only applies to PageOffline() pages --
of course, reusing one of the existing PG_ flags for now -- and convert
virtio-mem to make use of the new way: to allow for skipping PageOffline
pages during memory offlining, treating them as if they would not be
allocated.

Note that the existing mechanism relied on the driver (virtio-mem)
dropping its reference during MEM_GOING_OFFLINE, which is complicated and
not compatible with the concept of frozen pages (no refcount).

Tested with virtio-mem on x86, including  partially hotplugging a memory
block (hotplugging 64MiB with a 128 MiB memory block size), and repeatedly
onlining+offlining the memory block.

Cc: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>

David Hildenbrand (2):
  mm/memory_hotplug: PG_offline_skippable for offlining memory blocks
    with PageOffline pages
  mm/memory_hotplug: remove -EBUSY handling from scan_movable_pages()

 drivers/virtio/virtio_mem.c | 111 +-----------------------------------
 include/linux/page-flags.h  |  29 +++++++---
 mm/memory_hotplug.c         |  22 ++-----
 mm/page_alloc.c             |   8 +--
 mm/page_isolation.c         |  21 +++----
 5 files changed, 40 insertions(+), 151 deletions(-)


base-commit: 2f6baf8dadecc2bec7d6bc931f7e0d58d8443d76
-- 
2.49.0

