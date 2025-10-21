Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FFC334C1D
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051599; cv=none; b=fhpDYo+432KzeMyi7CDCofSZUfhJZT7a2/INjU5MVVgc4RZu2QDlUz4vixrHt+FbDw1Np15IAdy9DvBDamUk2UR8N0hmPVqA5UiwD+ZbMXnW6PQBzwE9dy6H9egOcXSufEn957DgGb4qnY9fr/kb9gsSumSuCuxbm8o7S+m2PWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051599; c=relaxed/simple;
	bh=u7008y8MgBH/UJlpJQuW7nnTnLv1WM7skWUdVur6z2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lN7kJKehLkJmmfF7MIPjgr4AW0TZn0pVMrq3L+7q2d/0VVhiucJT+uQtukIvVbl1/Z0Lg0DXD6hvrrxaPgwSIfeEmdDEtn45rw2KhFe7h9rHVVuh/Uy3t/rTOkzHReqLzMjsKur6wQ0QrYQZoueDMDIjpVY8ypoHanc/TahgA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMfAk3MI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMfAk3MI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761051597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pex3TSD4VopdNGhgViIupu2qOIUkRM48nNF7NdH4ZpQ=;
	b=AMfAk3MIYnxqlaLB1U1XCRw55DIAKjLVHDCB/BWyfPkKkpo2H1sU2H8oNkL1gWoZBJpYTQ
	p6hOPyRoHdx3uEontp0iuURDY4gVbP2fcgyU/+S/Bqh4iTpO41ddYa3TyU9xojZ2uzE+6F
	vVe2jGHvGqmw5e9uJU+4ke4EFxSuhiE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-OM4dYqb7NmCPoVuH-XOW1A-1; Tue, 21 Oct 2025 08:59:54 -0400
X-MC-Unique: OM4dYqb7NmCPoVuH-XOW1A-1
X-Mimecast-MFC-AGG-ID: OM4dYqb7NmCPoVuH-XOW1A_1761051593
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4721b4f3afbso14058425e9.0
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 05:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051593; x=1761656393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pex3TSD4VopdNGhgViIupu2qOIUkRM48nNF7NdH4ZpQ=;
        b=FyaQ0NBib3nO006DwNcSUKQ2NRDPhoqigiJemA2CM3aya72750kOFsZtIL5l00Lza2
         OPwBzl4ED0vAVbioGfJfAri4UWEbEWYcLJCPXFkbuS59rWvBCsJQNsVKFcI1RSBGQ2Yj
         bsgcR9qEei4qB/G94Bh+QF7cqfU+5WrrIue7hgM6xBttvu2VtoTgHDF/nezrffpWxOGq
         mL7mhWtsBqjjo1We0TlVqBbZFgxDJh2v2DLHb0twgdQXPykCKv87J3NHfmcinivdmG8w
         wALO0DqI2mnOXpqtQ0RmHCd9/evkSbNbDsizvN7QiEbq2T0lo5gc9ylKEUrx5IkHPFkL
         34oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCuyO8Ev621pLAEq30Me+nOIvg4mzN2i9+NV6KPmH0/eHx6AM0+RG+ispuR7AuYEA+tPX/DZaoc2ZXb/6y0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzScONef3gB3ZmxSWQEqSNs9J7mplJQnRcfAvpnOMuw9+ArsWPh
	xuVYQu9ELGNtxZwsmzVvLAWTUP9mphczrRFXjRjz4vNjV2XL9iCqnKH86ccFONSrV5B6vzaFerO
	/Il/j/GLwHAyei7QQRAZCJQB5QY/JkCO97xWj/LINPXcdCebP8lxWo/iaM/ixjF/xEuQa
X-Gm-Gg: ASbGncsjp8LryEzcV+cvLIJf96Ym9fXDEeApsyWuozLzmzr7qDvEVa2QBGjnM/6fvWV
	kxEnLHLcttCahFdIfFgVvylCTGS54IJj2WPEYZMeFyIuOOIxEW7JFFZUCO0C1tzvivsnin3jV4G
	9qzzXav2cbF1hH46YomRTTEZwwlxmwbuSk8bqfnr38tJAwNUJHcrZbVePnklZq8Cc+bCXGXrnQb
	94X3dAg4djURPR+gZGtXJCigwaywPu8VecxZINeMPpVE274baCW4CJuWeScluT1mDkrbMdyxdfv
	WR/e5jCZTWa/eDFRougiLK/Yleq9U4cT6+UjMnvgF3bXaCM5IEqIq9nztg6BvV3j/m1Yjg6/OPl
	NO3tKCdcNMcvd06Gi9stPyG36WM+ZdC2iIP+UTm/wNbAD0+wOEM90S+z0kkAB
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-4711790bf23mr118755975e9.26.1761051592826;
        Tue, 21 Oct 2025 05:59:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA4wZ2YHHfGwBY+P4joTOmyMCpMPrDXxQSxjIfhLQThHNmEp/4Y/9hLtnfofL7CHt5koNYrw==
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-4711790bf23mr118755415e9.26.1761051592292;
        Tue, 21 Oct 2025 05:59:52 -0700 (PDT)
Received: from localhost (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce178sm20202274f8f.46.2025.10.21.05.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 05:59:51 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v1 09/23] mm/balloon_compaction: make balloon_mops static
Date: Tue, 21 Oct 2025 14:59:14 +0200
Message-ID: <20251021125929.377194-10-david@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021125929.377194-1-david@redhat.com>
References: <20251021125929.377194-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NwescEm6qI0nMRh6d9KAMyXkE_j9EIamFt9HSAqd4RU_1761051593
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

There is no need to expose this anymore, so let's just make it static.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 1 -
 mm/balloon_compaction.c            | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index ad594af6ed100..7db66c2c86cdc 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -78,7 +78,6 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 }
 
 #ifdef CONFIG_BALLOON_COMPACTION
-extern const struct movable_operations balloon_mops;
 /*
  * balloon_page_device - get the b_dev_info descriptor for the balloon device
  *			 that enqueues the given page.
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 28ef0cb6b3bbc..c44e0b62203cc 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -286,7 +286,7 @@ static int balloon_page_migrate(struct page *newpage, struct page *page,
 	return 0;
 }
 
-const struct movable_operations balloon_mops = {
+static const struct movable_operations balloon_mops = {
 	.migrate_page = balloon_page_migrate,
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
-- 
2.51.0

