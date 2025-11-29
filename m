Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486A22F386
	for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406897; cv=none; b=JLEP6pgGYeJuw58R1lbhcd2Tu6Glx9pgLB5KF8vSWbsFOb8ycYsaqHeUxVnJq/bX1QSNp36Uiv2/h+Nt6Q6moLUFarx2dOIAf+/bjUkY95cHexB9yIBV1se8/fZr9w/I54301TO16/w0yugrKm/fAR8tN6Cu3kJJjqzARC2gAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406897; c=relaxed/simple;
	bh=udx+3WBqGc/iZ7as5xnrvfqI/p1WkcIHAta6MoMWPi4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gi3TTHXT5h+R501oGPO1PleZMTWhGVYW3bPjlek/LCWvtTu2Bfyvm0Vo2FMLGqt0le5iNaDhn7G2sE7oJhk1FeO51lsHYyxz2hxqdJZuP8ExOF0r7eNSjHuM7oapO/forQH8l+TOKksGpJUuQl9C2+BfEWK/5DuLcOZkARzGG0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMzu9w7Y; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMzu9w7Y"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3434700be69so3595724a91.1
        for <virtualization@lists.linux.dev>; Sat, 29 Nov 2025 01:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406895; x=1765011695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmb+ZHVry5p28b7GMkq+CDhLkRiYxaAasQNxk151Gb4=;
        b=eMzu9w7YhiNUOGW2+D9JlpGlfaeU1qODSV2VJE64HcWPXEU+DMlpD5upTnHsEZAyJL
         /LuzpfLqRgF3t/vO+IPdfxTQ96MmA51A5l/fgXBCASGksc4JvTwfFuwoGVu1aiQmYUHW
         KB0S3PUkPMqAUjU7NiImWDE8ADY5U2+lhHKL0Q8blvukWYhDSearr4Tc5VHdf++DYrMw
         07mZeYLjIZjrn18wLNcyOAknXZ1roBTF9J2u0ewu9j41PqG+glxkMyMF0mBXWc/hUgih
         1CJrpnaa70n43c2uKypgyfIYlGhAgE5XbMTKQdsjZFMFWi+KJmQ7WLCyQS8P1zZeYCGZ
         A60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406895; x=1765011695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmb+ZHVry5p28b7GMkq+CDhLkRiYxaAasQNxk151Gb4=;
        b=HptYT+n51KF68tYGYxE67AGwoZ0Bfty60pQQ01As3/RhWCJRuMNmMhuKJxDa5q1scq
         WIK5bU2SEOk/MmnV+6M7uRplWVBMImqELsdsQFPzlpfzoqXJI/A3yjyzdc59xBOn3DXD
         vxhOxMfcgunVhxmiP+Mc6qhC9ZHNgf0fmtu3k6znTzUnIc6tEW7x68D6KZQ6dMVicvnT
         DFY5l0TN4QlQnJ+brZxNSXNyIBqttJ52S7mIxHXipO0FhRIRPpvurO6kqFoqVmexjDvr
         UuibZqnw9CTCN2PzEXK8MauKRlzE+G9WaaIY/RBqscw61iP+OoBqdGYW95AJvbLXBKQt
         ZlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7tR/9WEqJd0yvIImqfBHacgXwnAFE+3eMyIeL9y2jD7k7C+GYZV9cQU1fznLztv5OMhBMzGk+eJBEikJOkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBAoYC+7lkCYAklfn/eySkeiqZxZUJqUlG0oXs4DKyNf0IfqgX
	m9uiByuKzxUY/5JbzFPuC6M2eBHiZ0CmEjXWA5Lnhhz1O+kny1g8C8j8
X-Gm-Gg: ASbGnctdi8bQDb693cyG7xxpEcRfHxragQz0PxwvJyvDDN9mBa4lJPl3nwXhcbzvHI2
	ejJ4bIAGCM0aXPNAaEFdPoofADozrjD0Z1alMbA2QRasqL/RRwBpm5p6a4D1AgHQtv4Cu6mtwC0
	Vz/33Iv7f5X2uOIejc0jNozLpY2u8/Bjz7Ig/yDvi/1bv/lxc+05C7M+qmONiD2yXtEmr5sapdQ
	GzJnb+0xegQVPH7yWzA7fNryyYQS36c/+cHR1d+H33BFjlbbdCtJDknkVQyOIrRROTXwz8Wa4b2
	UJ5tWSlHXVNGezkkkP1MyyavC4BhKviI4xPtasjNZn+3iKMc0AFpwcinEQ2SBHQKYx75SSqZSzN
	hsgIrH+ZjgiXM4fnbH7aRUKmImFu027rSaAmPscZSZ7aJNISWOeYWsVVEM5jYq1K/szi2ISl5pC
	CHXBQxQ4VcGTc9uAMZDgvUoXX1+A==
X-Google-Smtp-Source: AGHT+IE+fzqDQu1/Vmc8yqQsUeHiqyOOoex9+WFx6oQ8MiOIB4Rr8lIb32V7wQkpFMTkrQakUPAF2A==
X-Received: by 2002:a05:7022:ba9:b0:11a:49bd:be28 with SMTP id a92af1059eb24-11cb3ec36cdmr14203629c88.4.1764406895410;
        Sat, 29 Nov 2025 01:01:35 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:35 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 0/9] Fix bio chain related issues
Date: Sat, 29 Nov 2025 17:01:13 +0800
Message-Id: <20251129090122.2457896-1-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Hi all,

While investigating another problem [mentioned in v1], we identified
some buggy code in the bio chain handling logic. This series addresses
those issues and performs related code cleanup.

Patches 1-3 fix incorrect usage of bio_chain_endio().
Patches 4-9 clean up repetitive code patterns in bio chain handling.

v3:
- Remove the dead code in bio_chain_endio and drop patch 1 in v2 
- Refined the __bio_chain_endio changes with minor modifications (was
  patch 02 in v2).
- Dropped cleanup patches 06 and 12 from v2 due to an incorrect 'prev'
  and 'new' order.

v2:
- Added fix for bcache.
- Added BUG_ON() in bio_chain_endio().
- Enhanced commit messages for each patch
https://lore.kernel.org/all/20251128083219.2332407-1-zhangshida@kylinos.cn/

v1:
https://lore.kernel.org/all/20251121081748.1443507-1-zhangshida@kylinos.cn/

Shida Zhang (9):
  md: bcache: fix improper use of bi_end_io
  block: prohibit calls to bio_chain_endio
  block: prevent race condition on bi_status in __bio_chain_endio
  block: export bio_chain_and_submit
  xfs: Replace the repetitive bio chaining code patterns
  block: Replace the repetitive bio chaining code patterns
  fs/ntfs3: Replace the repetitive bio chaining code patterns
  zram: Replace the repetitive bio chaining code patterns
  nvdimm: Replace the repetitive bio chaining code patterns

 block/bio.c                   | 12 +++++++++---
 drivers/block/zram/zram_drv.c |  3 +--
 drivers/md/bcache/request.c   |  6 +++---
 drivers/nvdimm/nd_virtio.c    |  3 +--
 fs/ntfs3/fsntfs.c             | 12 ++----------
 fs/squashfs/block.c           |  3 +--
 fs/xfs/xfs_bio_io.c           |  3 +--
 fs/xfs/xfs_buf.c              |  3 +--
 fs/xfs/xfs_log.c              |  3 +--
 9 files changed, 20 insertions(+), 28 deletions(-)

-- 
2.34.1

