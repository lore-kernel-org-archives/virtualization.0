Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8901C8603
	for <virtualization@lists.linux.dev>; Tue, 20 May 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759345; cv=none; b=dZmPUDc5xbyXWQOeJHGaE1yOBN8rux1t3lJHJsr5gMpjsBuj8IQtWH24ye0wxBv9KBL7at36wPkZrvyLULKYeH4es8PBnBxH8ZoJRUbx1IwlnTir7sdTuB3D0fIIE60ldhqCBSmJ70KplkItc7L840S7QbL2Ubi2LSNe3Q3OKlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759345; c=relaxed/simple;
	bh=O/zF8BIjJSZZD1bMIMd2l/UU9MCXoY/z3vcgzeUWzss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ENjZqd/KKEpJ+TNINau32WXUouwLuFpTD5mijcvM03FU+4syATzFTjxwOMCgP0WYRb0vNns7HPy/Eq13tp3ZYJXD3M4bRhP1DuyW7b9/vbtoocdsrLpJdAz7lfFpuDC0P9t7CpzGoqHxrF0mOFu+vxv9OnqxIecfudRzbtvnRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2rKUuBg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2rKUuBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747759341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dMmCTr8FV4camAPV2B6Uv6O4Wah81IfL3gtjzE3sMkA=;
	b=h2rKUuBgund69sF5KlRcTACs78XIk7ibnScsIm+jgThKyoy7Cd0eP5I5MOoyZBf/M4ZR44
	80HVQ+qVkQ3GxD3b5m4otngSzjaUCLQBpC0oMRBZgmCCRbPy2dYNbpcjM4wUFlD6bkmF13
	GXwAqzCzpA8zecO5jghWW/wW/8bOx1I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-ayHbooUAOc6pIQgxjxx8ug-1; Tue, 20 May 2025 12:42:19 -0400
X-MC-Unique: ayHbooUAOc6pIQgxjxx8ug-1
X-Mimecast-MFC-AGG-ID: ayHbooUAOc6pIQgxjxx8ug_1747759338
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a3591c42d4so1286922f8f.3
        for <virtualization@lists.linux.dev>; Tue, 20 May 2025 09:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759338; x=1748364138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMmCTr8FV4camAPV2B6Uv6O4Wah81IfL3gtjzE3sMkA=;
        b=GSCfibbHjyjxcyxZ8nPuE+rXv8Eq5lGAhxHZOy+EVuEgCSJulHWA25m2qPTxYmryYz
         OGgHWhD1IwtVOcS02RkSABJv0oHMlHLjEMGzXe33dd9YfwHgqB+6BPbx5U4mho78Cnd9
         a7CTjkFIKWqXpHURKDNVF1RvmvuvvDgwCkbrC0l34dvaI7sHY25SJvpXvix/lkCZBUBq
         JflmKhDaHKMsOd9d4q/ACmy/waQnPYyNI1JOU39M7J6BFb7FhuFY9IHUYqofz/DFxB+0
         /rBE0mmeyKKsn2ctWuHuMBboLzScZZV4UiE5NDlWzvchnSHL+6BrgN0NaapS3sGaQ0QF
         m12A==
X-Forwarded-Encrypted: i=1; AJvYcCWm6JpGcaNXPy2M/Q75zXzmJtAnmC/Ly/sSxpuJmqYbjH8NxeHbYqkBI0aX9Tj9FKXQ+0ZUy5mQ2xKcU5+frQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIETlEMPL7+eEU02dioJ2YB4o3+jp6jKO96DvJByTYPI3vY5ro
	AuJNmoZp/UvE+qj6pzG103M+ZEJeO/3YktjKPaw2J53DLpkKCWVdnb45iDPXJs/SJE9mStl8sIF
	GZM8GNgul5hACuPld6HEGDPZ46PrAWJkC6gLKGGlAw50fFjI3a7y8r64WU8uOGY4UuqLL
X-Gm-Gg: ASbGncsl9Ux4/W5GsyTmZ90cVVU3b4xzrm6Rvm4zNiOO/X2CdwI+9zUMiLg8tfGwl9j
	3Tw+rq4Su7DATS+euzTVntt5psdiyYrH4jw9u009NxAnuuUAtUgAlVO0lPkNcCbU9BqJO5JxfQb
	91XlNaSEpnhjGcFfiwsHD1WdzZsIl4p72lYC9W+PY0FHXTYmRXn+7Y5+eBe2qZS7LawngXCttbY
	TDqpVx08knk2RPeEjIIYUHF5IlVZbkyNnFg2ZpFmZDigC0vGIP8KlE8AugOuuQy9llZwi+XfeEt
	POIQFD240rczNyTrCJGTit2NuNCXq9gv8usM8h6CXhCv3Zii3LFjgSU1lvEv5ewkRJIaHNtw
X-Received: by 2002:a05:6000:2304:b0:3a3:621a:d3c2 with SMTP id ffacd0b85a97d-3a3621ad425mr10859945f8f.58.1747759338427;
        Tue, 20 May 2025 09:42:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF01oyCH30NXY3wu6mQba4pmLtfM7r7ivSDHBlg1KpnoWBCJHpNy44l4OgJZ2MH/4+39rTc7g==
X-Received: by 2002:a05:6000:2304:b0:3a3:621a:d3c2 with SMTP id ffacd0b85a97d-3a3621ad425mr10859915f8f.58.1747759338012;
        Tue, 20 May 2025 09:42:18 -0700 (PDT)
Received: from localhost (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a35ca889e6sm17013724f8f.71.2025.05.20.09.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 09:42:17 -0700 (PDT)
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
Subject: [PATCH v2 0/1] mm/memory_hotplug: introduce and use PG_offline_skippable
Date: Tue, 20 May 2025 18:42:10 +0200
Message-ID: <20250520164216.866543-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R-yXVVBTMOjkdPd1DtNNhFQecwlqXzY7PNrYUVcp5pQ_1747759338
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
onlining+offlining the memory block. Also tested that forced driver
unloading with partially plugged memory blocks keeps working as is.

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

v1 -> v2:
* Handle forced driver unloading of virtio-mem: clear the flag
* Added a comment for a PageOfflineSkippable check
* Added more details to the patch description
* Drop patch #2 ("mm/memory_hotplug: remove -EBUSY handling from
  scan_movable_pages()")

David Hildenbrand (1):
  mm/memory_hotplug: PG_offline_skippable for offlining memory blocks
    with PageOffline pages

 drivers/virtio/virtio_mem.c | 141 ++++++++----------------------------
 include/linux/page-flags.h  |  29 ++++++--
 mm/memory_hotplug.c         |  17 +++--
 mm/page_alloc.c             |   8 +-
 mm/page_isolation.c         |  21 ++----
 5 files changed, 74 insertions(+), 142 deletions(-)

-- 
2.49.0

