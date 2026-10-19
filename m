Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9F49B44E
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399396; cv=none; b=ogTwDeoGFNhD4/qMp7ZmhAZnAuQaBKTs5XhbQ5sgsdLaWwqyYcgOpaaCQpZffLe7BnnAajNSv61alijsmGsum2EhEVRO9HpI6TqybA+NTdzsUBvnFkyMO0oRKBBpfI5OPv2fYwLFDV1oEJPWDN+42keulOr2otu7f7bhdpSUd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399396; c=relaxed/simple;
	bh=wXweUhgcBOLBorS8EuIE1GKRjd1xEwrZr0imlei1aiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/TPlOPIHEPnSG//+l5F0l45C4CGUoOXQFt1arbum2LQ+Vb+Uq/rT1T6OSX+LXXNu4cadauKN7pgLk1PU7mqKlrbJBbWeTJQOrtFRvNbupnatf7tgYBpJsKEbJRzDqupOlC2JQ+01CTB69Ed9bJM1s4re0briH/bn6YPMXc/yr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AzdtfAe5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AzdtfAe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ig
	E/kEh0g7gFKv5PAwWV/CKHlROUnBFZYW4mh6vr2N4=; b=AzdtfAe5zCDyzRWfoy
	A8T89jA2HQr8wbyEZdpPqe/doMfmtb9xr4UUbuMykAvVfcCXOEvfuLObr+ILhobp
	Zk9lujS6CP6KKg9YJeEC9+/DkFLfwCNo35LZ4C+rU2LMSgHi93QP73mb3EnU+Q0I
	PChWPOT8P+Ax5fzR8RSis8rNA=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnt9ng19VqcQOlAw--.9091S2;
	Mon, 19 Oct 2026 16:42:10 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	David Rheinsberg <david@readahead.eu>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/6] drm: reject empty TTM range manager sizes
Date: Mon, 19 Oct 2026 16:41:32 +0800
Message-Id: <20261019084138.1821477-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt9ng19VqcQOlAw--.9091S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWkAFWUGFW8GFyfAw4rGrg_yoWkArb_u3
	40vas7Wr1UGrnxXF4Iyr47Ar12ka1UuayDZwnFv3y3Ary3Xr1UX348Gr93Ww18C3Z8KFn0
	krnYqw1YyrnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt9a97UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wM+eGrV1+M2UQAA3G

drm_mm_init() rejects a zero-length allocation range with a BUG check.
Several DRM TTM users can derive a zero page count from device-provided
VRAM metadata and pass it to the range manager.

This series rejects empty ranges at the affected callers and adds a
defensive check in the common range manager. Patches 1 through 4 and
6 validate the individual driver inputs. Patch 5 protects the shared
range-manager API against any remaining zero-page caller.

The series was checked with scripts/checkpatch.pl for every code patch.

Jiale Yao (6):
  drm/vram-helper: reject empty VRAM ranges
  drm/nouveau: reject empty VRAM ranges
  drm/qxl: reject empty TTM memory ranges
  drm/radeon: reject empty VRAM ranges
  drm/ttm: reject empty range manager sizes
  drm/vmwgfx: reject empty VRAM ranges

 drivers/gpu/drm/drm_gem_vram_helper.c   | 3 +++
 drivers/gpu/drm/nouveau/nouveau_ttm.c   | 3 +++
 drivers/gpu/drm/qxl/qxl_ttm.c           | 3 +++
 drivers/gpu/drm/radeon/radeon_ttm.c     | 3 +++
 drivers/gpu/drm/ttm/ttm_range_manager.c | 3 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 4 ++++
 6 files changed, 19 insertions(+)

-- 
2.34.1

