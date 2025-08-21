Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D931354B
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806864; cv=none; b=JxpZ+iIx1TRBqiaP/IzT6ylgHJt6ycEmwR9aXFe0f6iAcuDhc5vXjbQLlhleAukeuo1/1HPdgzj//NJXlDthJpndiL4GLkajqrXdKamiXGh029D4xLJEJjsSCp0hm9OzcFskDTUXTZQrXulUPHOOmdQuscPK2DCwSyEhc6DOsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806864; c=relaxed/simple;
	bh=XmsSbVhT3dGsaRmtyroJ024d7WMqPWbEWQJfIPHhOJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=bYe0L8Mmm7ozRzX02xDwG9Uv+b8kJbpo5cvVL5tzOUyax0H5WOGQDdM8B3XQ2TzHNdLw2JoflTgWi8kxu4mc4XlkeFqQ3lrnT3Hc8JlXCG1N0BQETvZpfLBllXxSELj/ceuVZvV/KWatc2JsnS/H3fIueUZcQSlZzIvRulLgUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e9xXcRIA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9xXcRIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
	b=e9xXcRIAYwhSGs1JA+qKbx7lSD6GgGofF8d4PIU00Et9Aqu50Ag20HYpeE8ret2AcJP5SN
	n0gsnZzZJsYbOoxobXeuG4aAf2YAqJj9rMFJ8m+BQPZ+C2DEKlkmv6HZkPiBbRrSs8pNq5
	3fruU1+uaLB1iPOL0TqujwdbiPOYpyA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-mtTmqHw-PpWJ_4TZhnTpaQ-1; Thu, 21 Aug 2025 16:07:39 -0400
X-MC-Unique: mtTmqHw-PpWJ_4TZhnTpaQ-1
X-Mimecast-MFC-AGG-ID: mtTmqHw-PpWJ_4TZhnTpaQ_1755806858
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a256a20fcso8251745e9.2
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 13:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806858; x=1756411658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ4Uu4zoWyKmYQrq0i4l3HgKr6VpAHaNUVdQgPTsBAE=;
        b=qDKsVYTja9BF+5WJm3XB/ETCbeD3EdKUTH6FNXkUbSbsWrHqFO1BFy52hk5qz440An
         EFRALSRHN+Wf5TNajxj0PUX1rgmf+evbPIY/+sH0cxQdJcmCA6yexRzg0944O+q4sGq6
         pMF71cSWWJYQUBwkFJmo5xKljS5szrMsXqjzRQqWU6b1uFjTmRuavaEv7zyu6HVRaMbV
         /EMMut01T/vZP3JyHdUKBNlumQsAjcw/6lpD9aPqGaT67/PzMSy7HjHJVrgngZmp4rs3
         XxzpBZlR2yWwn304v8b2PmSYlJt6MEPJHUobjWBfqHyb2IH27yiBu3oMEVSgFUkrFBis
         0D3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMEXLBXVTO1RL/fGKvdy07AKGwF6jyK2gi5S5knUpd27OdSW8IwDMQcnsSOWp+HtYJa74ZaYA6krt1zDu4tQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrSxYv/T9SRCIsJeJlTNsVwre8dSbA8Jao2IiNfgRq+qIOiWyX
	DevjH8k8XWnYgvLio3siSjFv2bkJophzz9jQ947w3ApjbCCMhfqPZ6bP0GJoK7coboNzk0gSfqB
	grKTmO8UzcJh5bU3HdIJHYOUlGpSxq/65muYEe56EhcjmBRWLjoHB5xTbb4fSqnfKo8LK
X-Gm-Gg: ASbGncsCDsq+LPbU0uO9+7WBs3ZS7P7FejDDda1RdZ7YhD0+8KzS8bPchst9oq5l0iQ
	g08zlsSonoJTlyLjOaobX/oYjNpevjWiS3amYNNeTWsCoNQGdJ6geZ7+DK4abvWOLfSBgb3vJ2w
	ZIVWd3A4Xzu40VVuC3q1c7t7VU8CgwsjmuXCrgMOXnADGg9HZ08xDbkrwCzER2OFRj+qPlKZGRD
	KVkB9LC23AaigGjyJRaoxUP/ABYduKlj56LQFTrNEpzq6sA7BMiUU1jUyxxkNFV7V8IalAdkyTn
	657C5jqN+7BYZpT9LsCF0m3kMz6FQ7HIcFrQcOJf7TWBznq9XlEBNU0Y6xUbi1elP071csMo8SX
	DJZ0UbjUBWA1STpxk84W0CA==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646545e9.18.1755806857890;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlSU80KqPPviGOLp6CI40u/NjPujjG4FLCG6NoakJIlvY80lRDOTTm20w50mEKFuk0YjVSLQ==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr2646245e9.18.1755806857378;
        Thu, 21 Aug 2025 13:07:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e87858asm18672185e9.3.2025.08.21.13.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:36 -0700 (PDT)
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
Subject: [PATCH RFC 11/35] mm: sanity-check maximum folio size in folio_set_order()
Date: Thu, 21 Aug 2025 22:06:37 +0200
Message-ID: <20250821200701.1329277-12-david@redhat.com>
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
X-Mimecast-MFC-PROC-ID: vH7v7FVXjb9wlvYimOwiTW3jFYUmNHlapZ5EmEMN65k_1755806858
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Let's sanity-check in folio_set_order() whether we would be trying to
create a folio with an order that would make it exceed MAX_FOLIO_ORDER.

This will enable the check whenever a folio/compound page is initialized
through prepare_compound_head() / prepare_compound_page().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc030..946ce97036d67 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -755,6 +755,7 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 {
 	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
 		return;
+	VM_WARN_ON_ONCE(order > MAX_FOLIO_ORDER);
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
 #ifdef NR_PAGES_IN_LARGE_FOLIO
-- 
2.50.1

