Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174281898FB
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782699744; cv=none; b=cIH3RY+5kltDbBkBTG+4UJZrPX4HcjuTC6Ej8DeMSIX3Q2I+uavPZ2bnF/bV/R1EbSOCXdtpb5DbqJQpB8w2arrvj8Q+b5x5AoHNpaBdMbX16BlEUXKF5FVUjpq/GHG6R7eMvztix/MYC77CoQPywKArgq8j/s3XVWFzRNGh0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782699744; c=relaxed/simple;
	bh=3nkxDCu3UWu0wCVNaP1nNFi02fuWoYl6qmhyYv99x+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hzyl+TpYZ0VB5gebTTUzBowkAgdnRrcPKzo7Eqly2LlEgMvsXDDzXxtm7QnkpOy1z6Uw0E+8zT9VQxR8ZqgXqt8YgAGqoperWGydb4mRsIosYGGVBOEjnEPkOqL8uY8IjisUigkC+D3ZDCAw1Q1EiA83fAzP+rt6nJxaj2HxUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=mRUUQp9A; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="mRUUQp9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782699707;
	bh=l/YS4S6iKk/bSfxSJQPof1byBXInLsH54l4IQ70u1TA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=mRUUQp9AWKlV7QDdp2v7QH5QB4opmMi0CCmxaeWvSzbJWb9t8IBT/FLgwubbaS0pO
	 V2+yZxArS18SjQ5wPhLjiFfKfnCNLLpjrlkuk92jjNLx/spWplHc/hCkaWPgN8sA0n
	 5bRblZeaPjKn2v/mNTKFQjMahTX2devIvGy1ky7Q=
X-QQ-mid: esmtpsz17t1782699688t46c759ad
X-QQ-Originating-IP: Og7r9kw/BTYZZ9MyeMXtFncBesq+0ozWL9ugq02yIvU=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Jun 2026 10:21:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11053355749960370675
EX-QQ-RecipientCnt: 11
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: akpm@linux-foundation.org,
	rppt@kernel.org,
	ljs@kernel.org,
	pabeni@redhat.com,
	chenyichong@uniontech.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 0/2] tools: Fix tools/virtio test build
Date: Mon, 29 Jun 2026 10:21:22 +0800
Message-Id: <20260629022124.131894-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NvnyAkFVlrEw4EPZn6G9vkzrJrZDrgWcNuNYO5NBv/tujiZ3svFg0NlK
	t1NlTCcsC6yai39DxIXDRJOxbA3EEI6B+Tm6GehMq7i0XItXYu1JNC4F++ZcGV+w+tZkhDi
	m02yDCSKbitL+j7SVlwrIM0S2QcNcDQ554C5ewAAej6P+tOmPYNT+p3Fq2UrAZodB1RUS06
	x3wQx+VCTZvBObe6MvntkPA1KbApt+Xy0ASrZre5Ckt4RdB2G6PlTd4RIQi/QBkRlFgt5ZD
	0EfNOofZRLKcvcoNGFkIEqYoZHewARcxDWDAz+c+fxiawCDqBZHYXq0J1IXddoddQOad30H
	31U/zDefZByo1NKeZCYPJ9F2X4n4OV9+HjttpcIRF15z5oYNZc7jXEjE5iFDebcYPzfzVei
	LXiF+AXzuZ0793KRp331pO8goMxRDVtZ2oXnxSXHG7domqdzA8jLP/SpQhp1nSSPo9vHyl8
	6BkwW/CfeH4D4CZE852pZFKerznH8B8e/gOBRVLEzJdebdtqVIDuqYB9ve1Y4kqTFvU3deT
	V/uViIG0mi4DEeCdC0Ap72gtvXp94EOfLv2ZBoe5k/lhcWfOcjrqCO0rirAYRfo3oLBnSiP
	epr6OUYzXUvZxBvLdar82d/ll5qtOHResTgLbT8nRtAF4yOKjZvK6sUGEzAqN7G6uzKOnJW
	G7Pcj9f903XCrFxwyp8yX6Pbkvypsev4S8Jlo3bkaZ9qv2Or5hw39hCC2vd5S6fR3I7ub0D
	IK6YQZNz6NgYzilGChPDTJhdS/OsyEUbiCQzMOi7PPuKWxWKjeDwByQEiQXrjLPbUITE1i5
	cFMzp8IOxp7WubfwOE4n+SVdWPbJyxuX8EcQWczJeiy3XHnq0dSIjbGfyr3+2I+O9z7yhxM
	mIECC7kJhoRFP+6XZjyJp5i0t5QMtBqwkZZ2s2rORh/Kuc7eDAkOFUEurpw/rWbs04Rg7Wj
	31BP0vbQn/UStR24hvKgFkkk456upyHZKzvc79VLRIBI2h2wcJ428vliXPQoqtUjZhTER9a
	beDCvvug+r9qClKXq6F9CzKGsnTBqfuE+81OnyYQ==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Hi,

This series fixes build failures hit by:

  make -C tools/virtio test

It is based on linux-next commit:

  commit 3d5670d672ae ("Add linux-next specific files for 20260626")

Patch 1 adds tools/virtio compatibility definitions needed by current
virtio headers when building the tools/virtio tests. Patch 2 makes
tools/include/linux/overflow.h include stdint.h for SIZE_MAX, which is
used by its size helper functions.

With the series applied, make -C tools/virtio test builds virtio_test,
vringh_test and vhost_net_test successfully.

Tested on x86_64 and arm64 with:

  make -C tools/virtio clean
  make -C tools/virtio test

Changes in v2:
- Rebase and retest on linux-next.
- Add the missing asm/percpu_types.h compat header reported by Eugenio.
- Keep the tools/virtio compat definitions aligned with current
  virtio_features.h helpers.
- Drop the slab.h kmalloc_obj/kmalloc_objs change because linux-next
  already defines them in tools/virtio/linux/kernel.h.

Yichong Chen (2):
  tools/virtio: Add missing compat definitions for vhost_net_test
  tools/include: Include stdint.h for SIZE_MAX in overflow.h

 tools/include/linux/overflow.h       |  1 +
 tools/virtio/asm/percpu_types.h      |  7 +++
 tools/virtio/linux/completion.h      |  9 ++++
 tools/virtio/linux/device.h          |  1 +
 tools/virtio/linux/dma-mapping.h     |  1 +
 tools/virtio/linux/mod_devicetable.h | 14 +++++
 tools/virtio/linux/virtio_features.h | 79 ++++++++++++++++++++++++++++
 7 files changed, 112 insertions(+)
 create mode 100644 tools/virtio/asm/percpu_types.h
 create mode 100644 tools/virtio/linux/completion.h
 create mode 100644 tools/virtio/linux/mod_devicetable.h
 create mode 100644 tools/virtio/linux/virtio_features.h

-- 
2.51.0

