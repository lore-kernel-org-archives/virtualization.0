Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9E33E715C
	for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 10:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.54.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776878; cv=none; b=eyDbQIW4rDV9KquW4N12KurfEgEPp2Prgr6k0mvwmJ5C1hqVLPzN+abhiOVeVAn7hq9Sfz5yg+1a7KunNFzupFVSpo40KrQlJFA00e/z8FNjWLqIUlsoPf2Yd08VhiC8VwzPzowSeq1eFcqJKfWZaXhu4tVkM+TZnNRnQoBCa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776878; c=relaxed/simple;
	bh=hgIZpuS8cGUCKTMAN9HMSdRpBgid9tRVCtuI0rkTdrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dk6k4m4TwS6bCYJ8Pqrafs8dCiA4gaqj54wnjeH+/7asdfm/t/p34y6VQMpQWnPeklZiBnkhXvky6Q3vIn5dfGENwdfIgOwbCXYMhfjU7HaOKD/h4sr9H1eE81zcH0diydi7Rm+TnKc3C9BFKYXGkCUO88MXDcNl3bFtb1WJQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=E/p0TERI; arc=none smtp.client-ip=43.154.54.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="E/p0TERI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781776867;
	bh=nbv5AehayYJiATaaRsgsbqhRFAhJgqQNTtP2yMu2zUE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=E/p0TERIQDaiMXoxgpPHSU7ao+Wwee1cnqA4VyDmtn2+b7GLCIK37+TOqy/wAZheX
	 Fhapl2VeVLdHyp5O+ZYIC4jlhS0MjlDINAaBWQbWb6G4taKv47oaaHCLk2i4E7BKyT
	 18NzR7Buh7qg7NnHzI4Xt2GM4Yd1CWBI5jnQ0Rqw=
X-QQ-mid: zesmtpgz1t1781776626td5735b67
X-QQ-Originating-IP: eGD7SUVg//Znba/GR0ZdWpLalZrNn4wLXiOlIyYzvWg=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 17:56:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9669427810377979883
EX-QQ-RecipientCnt: 10
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	rppt@kernel.org,
	ljs@kernel.org,
	akpm@linux-foundation.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH 0/2] tools: Fix tools/virtio test build
Date: Thu, 18 Jun 2026 17:56:40 +0800
Message-ID: <913D9291164C65D4+20260618095642.510565-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NEooIJKZCRWfD/1L3ZrCi9eDtJxjvr/yLIS1NFfF8pdhL7NqW9LLRl0B
	mdI6y3XBFiUXuCl9eelyJ/07FOkgnvT9p9fcLtuvhuaQZq2x2t+1Q5tIhB024IrL6pv4CY+
	TlEWyJZI3ZynEoMhSebczkLgch8j98Dv0GNlbOdK0y54p15MrDCRANTeeRHcGw3QUdIiMgz
	7gMQsXVpAlhwphnDOvytdDg36vubbeyAzfH1+hXg4avGpGuZScBYFYsB+Nv+uXKFk7B8Amy
	ZjELkwUkB4HzKborQI54nT6lXd41W8fVsncAXJgI2s074PPde9cD3FtsvsuqCZhx1ARRZYs
	a5/nVnYNbuZ3sVNdu+GkIQ+LRWnRKEFmch6ZvSNYQ2apVKb8muLLXwm4V7Wyywl1abKc/au
	Q6nAtX6/8MGbNalOY36zf6H94xP/SkBvkZDtcxF6jH7j3riUawzyFEOq6Bfls3aJO7uBG+t
	6vRxAx9qpBWhcEX50x4sMpc3gqLeSyKypNoA+jC04uU8Cc+xW+EaeKPzPz58r8bv2P8B1mH
	W/PRX9jgEbUyEGt+zrdrZsl/K67PSrdhAe9fZBD5zr/Yo4c/qRot1FnFsNuMTG0TzxKlbuk
	XoWbBy2BEeBxusXUW/2bz5JRZajlA4xzsJ/AWnettRFo9ncey6WFh92b2Yk8UAzqSTNdWmk
	EYF2zBKml+8sPR7t/77iKJrmBD9l0yIqw9jdB2OlcDpCJyRYG/cLZwlCTX7lOOWbragMxTA
	c806v6IsZaeumrFSimaSmdFnSR2DOJ/77qhfQIMJMhiHjNj+Sh/ni5uUfD6+mMakMPhDQIc
	uAmu+K2LyHVo/mutuBmyTW4CIulnuB1GsCwQI+Vh76UCUSBOrBexUy4GJ6Ex9nwbZpDJiMA
	wufo+1sjyaeUQTyK4TlLif82i0OA6zFJ1rEZG/1Yintk8hulWBvY2SNxbntXZSPP4nmP8xe
	HiaWKhHT1Uqgx94qdzNytywmJIByLi1yCaslfyybm96RJ8ihYlz9ytvG++OtygETIBopWGa
	cs25JLV4klzVQ4HHAD
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

This series fixes build failures hit by:

  make -C tools/virtio test

Patch 1 adds tools/virtio compatibility definitions needed by
recent virtio headers when building vhost_net_test.

Patch 2 makes tools/include/linux/overflow.h include stdint.h
for SIZE_MAX, which is used by its size helper functions.

With the series applied, make -C tools/virtio test builds
virtio_test, vringh_test and vhost_net_test successfully.

Yichong Chen (2):
  tools/virtio: Add missing compat definitions for vhost_net_test
  tools/include: Include stdint.h for SIZE_MAX in overflow.h

 tools/include/linux/overflow.h       |  2 +
 tools/virtio/linux/completion.h      |  9 +++++
 tools/virtio/linux/device.h          |  1 +
 tools/virtio/linux/dma-mapping.h     |  1 +
 tools/virtio/linux/mod_devicetable.h | 14 +++++++
 tools/virtio/linux/slab.h            |  4 ++
 tools/virtio/linux/virtio_features.h | 56 ++++++++++++++++++++++++++++
 7 files changed, 87 insertions(+)
 create mode 100644 tools/virtio/linux/completion.h
 create mode 100644 tools/virtio/linux/mod_devicetable.h
 create mode 100644 tools/virtio/linux/virtio_features.h

-- 
2.51.0

