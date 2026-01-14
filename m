Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C26337111
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 23:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768434661; cv=none; b=Q1auLi9HjiiR8mOU/iK0EVlSxmzL6Jpei67ckVg5MH55d7ZWbLFwfgqndxy9k/tRmlxUn/dV8NSiakc1eCCwQDJDNmE368tsza2UMPaeRuq8clxjUhA8Z+xsPmdy9So1O22rQvNQ0pwDtOsDsl25mjf6GoZOhc6VoDWJpc5h+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768434661; c=relaxed/simple;
	bh=PsXVKNSP2IV5lNxkAtsT/bNWk13Co+2vRu/D64cg554=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWc4BmiAxlswvJAF3Ap8GophXARmZnLzJhDNF/8qbKJXgkUiJVvDAS63eMaxp3yZF6xEEXYsQaAJ77+MGrk39EYH0hBiKTEobUcsA31YGXng8n2aGVHkmd2/WwThm9p3eOdA/8cb3UgFgIdB9dNI6xPIQ0qSY15ILBan6qPDDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=L13/Ntbu; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="L13/Ntbu"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8804f1bd6a7so2395416d6.2
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 15:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768434657; x=1769039457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjrrFW0XqdppZNNWqIznZXzloYpv+TypGhEeLOQrMhw=;
        b=L13/NtbuTZXFJjtMsE32EvGfUMsKfw/nTCBrfsZLKl2YN3A9UPHFhBn5creVn/x+nY
         g1c5UEeerXGqsH7dZDNhr5M7p0jWFNxK0KVrda2PRs4as5O8360CEA/92Bs8DZ6zAkxY
         +rG9SVJoVwXPCyS+ysw7ZWAmSzVDXwxy731HuAkhwjXihKrCxJwmMF9jOwIlxbaFNPV0
         xTgjXQik8vpmWej/027zQguFMVNP+ioBS8Tam2Ir69XLHE5fUKUYDoVs/MveSkABgRFA
         DWlwym+kvw2H6tWuLAR80Hzc8meuSDKqwuSxEJiawgq38A8Kl1VviW7wJ6W/o8NXDiQD
         2sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768434657; x=1769039457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjrrFW0XqdppZNNWqIznZXzloYpv+TypGhEeLOQrMhw=;
        b=JO7Rz+N7Jw0a6J3mA9gGGMvyjokR7hxXPKhGYD9MHmDQqTcq4oWVyXOPg/8fmxrX6H
         USjHlt7no047CM82el4gYYENingZxbwKj1cIvVcgOs2iEjz+j6hEyW5JIvMIWhFI5kQc
         w7mypIdpdk6Q6NmR/sOjW9q4KEYNJMR4RoMZu7m8RckV7hRl1Vnlp5Oqpea/0Ei5q8zu
         zOEdbuAP9eBn5Lhl2xYdI4eUO07pk2fptXqb3LYzAKsAzlE9R/GJlqpD/Oe51fcR8tSR
         LyVBwGntpGB+DYm+T/EBXb/ce/On96R9VmP//AUEv6I75aQ1oo1C+dEFL2JzHUSudcRj
         qb2A==
X-Forwarded-Encrypted: i=1; AJvYcCUiVgJ1ENsdYZs2N06JI1bnR2osGe5WP86AfWj1cT/b1GcnWaZCkbTw83MHx4eGiId4t65sj9fxUSYmm4Ur/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQtS20sRIw+gdWa9WsQ/Rvb+mDoAFeRqEokZBXLs9rQVX/lOHB
	RHUTa5k1HgKHlCTspBnEbcSUxkoxDI5KMrLTc5qQr9A/rkFCIfknyB1HpoZ8iy1uvIXqizL+SLW
	ETRCPdH4=
X-Gm-Gg: AY/fxX51bFicCwIJkeMTdHqgla+weYxXcROgekkQQiaWnWbrCY8yredzTZJBk/jBjmT
	fLWq+Fu895nMrUVg5vsWRp4f9WcIzyv6E9V3+Z/sy3ao2vBkEjPlQ3YgmIr55PGN5xafvz4Y06Z
	DaIN0IqyuJHcIXPEwMjQvkmwlsIjAvCxXy6IRRrXKZGCSeWLo4XoYyveoBg0rjRgPbcZHE0NzsC
	0JN2QRqqi6cs5ZAukOY5Ovt9eJc5b05f8TjrpZPHGMZEPkZHw2fKH73pQ2dmFiYYd0eUsyZUnLT
	AhVXCM84yLqYaa1vI5JE34CU0uxeyDWHQ2n60niCNLTnvBI96dHNq4Ui54bNyHSSnoXFPBNvQLN
	xEyAyZ6L5krT4CQ4FnbQibe/xtzWWIzXbMzzGCocqIYXw6IWycvNXdLiyPM8DhXW1gfs7Y8SYk/
	sDnsWQhR5P0rBKYUIEcAzpa02zLIerkJgVe769LFJWDE6zhshYAwqCUnv0iM7pxmdIpHccAH9uP
	+g=
X-Received: by 2002:a05:6214:401:b0:890:6603:f258 with SMTP id 6a1803df08f44-89274373da6mr61800136d6.12.1768434657410;
        Wed, 14 Jan 2026 15:50:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890772346f8sm188449106d6.35.2026.01.14.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 15:50:56 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH v2 0/5] add runtime hotplug state control
Date: Wed, 14 Jan 2026 18:50:16 -0500
Message-ID: <20260114235022.3437787-1-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dax kmem driver currently onlines memory automatically during
probe using the system's default online policy but provides no way
to control or query the entire region state at runtime.

This series adds a sysfs interface to control DAX kmem memory
hotplug state, and refactors the memory_hotplug paths to make it
possible for drivers to request an online type at hotplug time.

Problem
=======

Once dax_kmem onlines memory during probe, there's no mechanism in
the dax driver to:

- Query the current state of the memory region
- Offline and hot-remove memory blocks atomically
- Control online type (ZONE_NORMAL vs ZONE_MOVABLE)
- Prevent external interference with driver-managed memory state

This forces users (such as ndctl) to toggle individual memory blocks
prior to unbinding the dax device, and has lead to some race conditions
between competing hotplug policies.

Solution
========

This series introduces a 'hotplug' sysfs attribute for dax_kmem devices
that allows userspace to control and query memory region state:

/sys/bus/dax/devices/daxN.M/hotplug

Supported states:
- "unplug": memory is offline and blocks are not present
- "online": memory is online as normal system RAM
- "online_movable": memory is online in ZONE_MOVABLE

A memory notifier prevents external operations (auto-online policies,
direct sysfs manipulation) from changing memory state, ensuring the
driver maintains consistent state tracking.

Patches
=======

Patches 1-2 prepare mm/memory_hotplug to allow callers to specify an
explicit online type rather than implicitly using the system default.

Patch 3 refactors dax_kmem to extract hotplug/hotremove helpers,
preparing for the sysfs interface.

Patch 4 adds the 'hotplug' sysfs interface for runtime state control.

Patch 5 adds a memory notifier to prevent external state changes and
maintain consistency between the sysfs interface and actual memory
block state.

Gregory Price (5):
  mm/memory_hotplug: pass online_type to online_memory_block() via arg
  mm/memory_hotplug: add 'online_type' argument to
    add_memory_driver_managed
  dax/kmem: extract hotplug/hotremove helper functions
  dax/kmem: add sysfs interface for runtime hotplug state control
  dax/kmem: add memory notifier to block external state changes

 Documentation/ABI/testing/sysfs-bus-dax |  17 +
 drivers/dax/kmem.c                      | 577 ++++++++++++++++++++----
 drivers/virtio/virtio_mem.c             |   3 +-
 include/linux/memory_hotplug.h          |   2 +-
 mm/memory_hotplug.c                     |  35 +-
 5 files changed, 528 insertions(+), 106 deletions(-)

-- 
2.52.0

