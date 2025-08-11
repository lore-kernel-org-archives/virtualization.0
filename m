Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F8255E27
	for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923198; cv=none; b=WwZnuI+9xbbBX9+rXxgXVn1XeQWduLz0kirCUNjdBgPsqrTn+kkwdg8P12MSJ4h1rScBB0w0+O5OBUWFfSLdTGUCbHGOkcKlxlN7GXRsJUtawiUffJlmXpISd7TgHnE1uVzOO5qgZ0tuFrB8WJ92RKOB/cam39XJPkbH2m+VHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923198; c=relaxed/simple;
	bh=/ioprKEzI1qcsrbEC6w+eZ9U3l5T/Hu9whZ62ICUdU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hodroU/4cbpJv5k7hLuuazMWUA4FMCeganZfhQVRBOX8nlnExagQIGfW5cq5zpQdTTgvRvpydIwoWUsXpSR7gqXhKy2LqxNXKD/1PymjgwQr3Cf1FDdBoUAGAfUVlMfxX5FkRYEbqkFS8nSW39PNv5SKChpE8kL/LM1mIQXsVZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnU7Krjd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnU7Krjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3jBX4j3yDpmQs2pQdcmkFlIUwpnim2gbOcYS+XAZawI=;
	b=AnU7Krjd+MixZdLvwFFmaxLBf5JwzArGHSRc6EIGK6fYus7gjYYePLSg3lIRpOplQf4Ezm
	CF18YD8UdXAXQG2mo+gjnJ7GZuP/ztHkFXKKpIahJAHKMDpbfmHKOhani2ycaCob6Ggqbq
	cqiBFIW4GkFDr0UvIWD36NdCcsxWti4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-Ob4von-9NwuUOGzuMAtGOw-1; Mon, 11 Aug 2025 10:39:53 -0400
X-MC-Unique: Ob4von-9NwuUOGzuMAtGOw-1
X-Mimecast-MFC-AGG-ID: Ob4von-9NwuUOGzuMAtGOw_1754923192
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e6c564fdso18413805e9.0
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 07:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923192; x=1755527992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jBX4j3yDpmQs2pQdcmkFlIUwpnim2gbOcYS+XAZawI=;
        b=UGW5xO3hNHb/WOD5gpwaKwGT5JM8v2OHKEZewSje0Zpg7yD8X+Yj7SfkcR/MM+Kfsi
         2LIOUF1HstWVCQrRcvB83IkxeS8uDkR1tiSLmD9/6kGvwPGyDzXD61WTvKUHnm19kRgy
         JQ0jsaD52OQF/wtzso2fAXuc/bjILkmIZqLGAUZs+aGOzLgmZ1m0wwIjFxm7YF+LSURh
         uJ55jqyc2VL5nuZ1RX4u2zqA9LfxVUAGEsKDVo2Qp9H6fPC8VBXMbNFUY/WISvwwEYkL
         gMZGU5X9g1RUChALO3R7DxfHqPGBh9KHuRmwm8aqeziGdYsHjZ1zDo+7hW1uPuNyJuXm
         woXg==
X-Forwarded-Encrypted: i=1; AJvYcCWxN4UsARi6brc0gei01aJL5Ph9VHJ5rqBsMFclmbvLE6Z1tJ/Z2j0krIJJVCMlZG+1EvpOJUHY8etY6fSIfg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpWZOIPajZYtEbcXqEAwTnXBZ5rE6KietfZe4xQOtmu0/xVlZJ
	ctJ+LIKGs/3x0J1Y5pCR3gdJ7mFS7cLiyJxIwr+Rk9xMe0yY+/mj4Lo4hnYBf4ub3WD6gQBh/Fy
	9PZI0jDLCEDXG3YR14qsosljDoeT2f2HY5tAoGzfjaEGbPbi2uQm3ipKIWsSwJ3NYMWcz
X-Gm-Gg: ASbGncsyiGz9Ulbfaak/mi52QBEzLSlTRI5vo86OQ8MeKgRMPqr3yuDFw6kSs3R0mug
	8IbPkXzPxZhnXGSbBLZ0tukzwEsHMyfQZTY0wCZHkCTxgaZLLBZg3uIWNdvLRoweqiEuP/bYjZu
	w583e8PnghmFuuiZgHMe0Tp26AqE0sSNH8pDYRZKV1gto6XWbdkXr0y2gCiYf7FST8rzXyBNG27
	uaV3E+jqDZwOzk62+erfgxZfWgiJia2gwHuuqhgmFHu1uCyB2codPkk0AI+doMzrbQJ4bksO+Ja
	K9qIhPcYJeLpo0z+mVnktllCccfeDWU1BxBV742adddeQ1pRO9/I0GTNWsomT2aHCxWIzI8oPkp
	yLvaGF/iZCWJg+R2VtugKIai/
X-Received: by 2002:a05:600c:1c18:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459f4f3e153mr122955005e9.8.1754923192296;
        Mon, 11 Aug 2025 07:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+bcYyrzEHtg5O8YCja39RJfZF3lc/0BwBvrhjiRJgNhfaMkviNPqO5gGtgSpeCPJqwbl5CQ==
X-Received: by 2002:a05:600c:1c18:b0:459:443e:b180 with SMTP id 5b1f17b1804b1-459f4f3e153mr122954665e9.8.1754923191851;
        Mon, 11 Aug 2025 07:39:51 -0700 (PDT)
Received: from localhost (p200300d82f06a600a397de1d2f8bb66f.dip0.t-ipconnect.de. [2003:d8:2f06:a600:a397:de1d:2f8b:b66f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-459e0a24bf1sm280478765e9.1.2025.08.11.07.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 07:39:51 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org,
	linux-btrfs@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Kleikamp <shaggy@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v1 0/2] mm: remove MIGRATEPAGE_*
Date: Mon, 11 Aug 2025 16:39:46 +0200
Message-ID: <20250811143949.1117439-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _wC_RYQhAMIpby_sjWauHYHJVMxii7bonrSicuhKboU_1754923192
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is against mm/mm-new.

This series gets rid of MIGRATEPAGE_UNMAP, to then convert the remaining
MIGRATEPAGE_SUCCESS usage to simply use 0 instead.

Not sure if it makes sense to split the second patch up, a treewide
cleanup felt more reasonable for this simple change in an area where
I don't expect a lot of churn.

Briefly tested with virtio-mem in a VM, making sure that basic
page migration keeps working.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Eugenio Pérez" <eperezma@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>

David Hildenbrand (2):
  mm/migrate: remove MIGRATEPAGE_UNMAP
  treewide: remove MIGRATEPAGE_SUCCESS

 arch/powerpc/platforms/pseries/cmm.c |  2 +-
 drivers/misc/vmw_balloon.c           |  4 +-
 drivers/virtio/virtio_balloon.c      |  2 +-
 fs/aio.c                             |  2 +-
 fs/btrfs/inode.c                     |  4 +-
 fs/hugetlbfs/inode.c                 |  4 +-
 fs/jfs/jfs_metapage.c                |  8 +--
 include/linux/migrate.h              | 11 +---
 mm/migrate.c                         | 80 ++++++++++++++--------------
 mm/migrate_device.c                  |  2 +-
 mm/zsmalloc.c                        |  4 +-
 11 files changed, 56 insertions(+), 67 deletions(-)


base-commit: 53c448023185717d0ed56b5546dc2be405da92ff
-- 
2.50.1

