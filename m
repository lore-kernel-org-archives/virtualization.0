Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EA21A38F9
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 04:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770871892; cv=none; b=Yv9MKFupiey0WmzntekXwO+BFKKrfBHMaVqr8q7GrLkzZCm7FU+DOsGLT6KqEhSsIi/OKigEkpAlA0pST1USuvmwaulR2cWungMTt3Lwj8EJf6em3gChkyYnweLOyj0onzAwAYcm6N732Sr8Ys/Y92AToVbOw49o1jNpz0wuPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770871892; c=relaxed/simple;
	bh=8D94FTU3J7WbTPERy95OWvMbWad1oKdsojUUHZ3Rmak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3cvsPaqhoPU9J2qTinPwunUixJu1VSDN+wHPHO29b69lhq8LjJD4ejDbhhlkQLMOOXHjvMMzmX9PzthgeBjHQwxEZU/B3Qo07ni1MN7d/4zMC6tjFJp+U2wB0ON8S6IX3xNqtmy9JFXGSCm8J6j82I3Fmj7MpS2e2fDBKbRk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzsmUEl8; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzsmUEl8"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba94dbf739so2640692eec.1
        for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 20:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770871889; x=1771476689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qoLkvcAtx2WTrKtSPpoAsMeiJqeenZRH0jOzHw3uF5Y=;
        b=bzsmUEl8JfwXGBftQtLPK72Ft4cY5Qi4JJ+Vk0e/cvjOph1I+qhdlnwUvoFCU30ABt
         cOQTD+6zLDIRxLHIwp94V8VVgEXaNUxFj3cc8DYRYTdPM7HK90TAcEOpQZJY6JCfgUCK
         tZVkp9kka4sn9TNgg5klasuhJnRyp8139cVAPBCv2AwtfgLNlqvTF5Ohxs0tz+nRQ+cQ
         BaFSwrJmORAHWt8RVjHD40PtITb7qKraQpNQeDr9cW8YfQMZYd7J3qZVrpDEqfBE52rc
         RxhhCUQji57wH6XpR0WxC968Jn+srElkhemTJNgqq4AMe+GcHELxmJ6we5g2msN76GrZ
         JVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770871889; x=1771476689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoLkvcAtx2WTrKtSPpoAsMeiJqeenZRH0jOzHw3uF5Y=;
        b=eqKSW+peDTI14uKm5fyCYM6TzM2xOtRAmYjY+nPn9hSbZK3hse2jYBojoOv0dP1xmg
         Bzsnx3zFlTziTiDDAV0JDQbv9HkkJn3iI0LOU5CUCQbnDKPgxBI2au6YrRDEE8eLcaHE
         9AQeAwY1rRyP0jR0jUvuLZRU0Oe2gp0biiXEfOCXkBlyR+fZooH4jF9g7Jc/YiBsOW8R
         CEtwsojW1+I3uDqmmxWjq8G7lVdqcFMzF3cPxyr0ugFmxlosBHGvtn5Xa1GqrDahounN
         dojf0ZqUK6psAu/JnQBIihh8VUJbx5FKD6Jenx9L9q/mRlJSdlQC56anNSUIziEKe1N2
         TUqA==
X-Forwarded-Encrypted: i=1; AJvYcCWgydyxQPJODe/Oyq+QhAKiMY6D9IBs4A/XrQdJEAyrLGtQj9yenN2NHP9IRVSzbneKOE2hPRgKC0sKjMQP5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrlUWUgZK7cDeEVwk06BtFKGWaEQ5ESxCo1Kjn03HeOP2GuNq2
	qjZ8t7wSf69JKnHUmh5ffkXLsx809jwHslaT7ZaNoGRrZkxm6dOZ3fIz
X-Gm-Gg: AZuq6aLe1TkC6KLYASKOLK0dS0njzLd4HiUUluIzgrCrT5MIZAdL+UfGJs3uMcfSp6C
	peXKi6DaqrQPGi4kllj+uY2dR2ooiJkifGNwepcKhq0jeVec41Xej+8cWW+VE7uVxqAj5d0TVhY
	QaaoKIUsb3u195l1wxuzswQ8GI1v3Vl9kJgXQ9ltKHa1ApU1V8vSMxxq4fVyjzAMUEyptP4nDKL
	Qc2vPWgfTdf3kgxiT+Y7gYC+478EVvQpoAlQx/Wzbdvh33tqwZVjkNZ3uS1DeCSz3VC7Jh9vedV
	efcvB+fufLx0uugKIfDUmwiYrAGFDw+xC7kSlaIeDVohz2EVgWM5rGvdUw/i9LE3SVxUR1Uw8bf
	1VCpWeBNc+3e/hZcUoj6us5eqewweS5RESsbXKkMZa+m2SmGMU96bKvH0p93FWODirZN6wBqrUf
	qWKKLIu4UGqZBFmiCAA3XkKoTm8klBpdL6qhVkA+YEjpzKYZyQGw==
X-Received: by 2002:a05:7300:1907:b0:2ba:a3f2:958c with SMTP id 5a478bee46e88-2baac4769bfmr331153eec.0.1770871889305;
        Wed, 11 Feb 2026 20:51:29 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9daa6151sm2878699eec.0.2026.02.11.20.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 20:51:29 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: linux-mm@kvack.org
Cc: apopple@nvidia.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	david@kernel.org,
	eperezma@redhat.com,
	gourry@gourry.net,
	jasowang@redhat.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mst@redhat.com,
	mhocko@suse.com,
	rppt@kernel.org,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	surenb@google.com,
	virtualization@lists.linux.dev,
	vbabka@suse.cz,
	weixugc@google.com,
	xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com,
	yuanchu@google.com,
	ziy@nvidia.com,
	kernel-team@meta.com
Subject: [PATCH 0/2] improve per-node allocation and reclaim visibility
Date: Wed, 11 Feb 2026 20:51:07 -0800
Message-ID: <20260212045109.255391-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We sometimes find ourselves in situations where reclaim kicks in, yet there
is free memory available on the system. One possible explanation is that a
NUMA node under pressure has triggered the reclaim. This NUMA imbalance
scenario could be made easier to diagnose if we had better visibility.

This series aims to provide that visibility by accounting for the cause and
effect of the imbalance. First, the addition of new node stats allows for
tracking of allocations done on a per-policy basis. If a node is under
pressure, these stats can help reveal the cause of how it got there.
Second, the stats associated with reclaim are changed from vm_event_item to
node_stat_item. Having the pgsteal and pgscan counters tracked on a
per-node basis reveals the effect of any pressure, and allows us to quickly
narrow down the affected node(s).

JP Kobryn (2):
  mm/mempolicy: track page allocations per mempolicy
  mm: move pgscan and pgsteal to node stats

 drivers/virtio/virtio_balloon.c |  8 ++++----
 include/linux/mmzone.h          | 21 +++++++++++++++++++
 include/linux/vm_event_item.h   | 12 -----------
 mm/memcontrol.c                 | 36 ++++++++++++++++++---------------
 mm/mempolicy.c                  | 30 +++++++++++++++++++++++++--
 mm/vmscan.c                     | 32 +++++++++++------------------
 mm/vmstat.c                     | 33 +++++++++++++++++++-----------
 7 files changed, 106 insertions(+), 66 deletions(-)

-- 
2.47.3

