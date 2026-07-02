Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8D2E8B98
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961484; cv=none; b=aci0hQnwekMAmobEJG5JrcwF1Qv3XRQclwQ0DFu6d3cz4CfJ/2yGFFDJlk4CV16FqLGThVVkXgowpBTViZc7N5vSEKnKts4IKIGtR3K8TLaQJleoH4khSjsxneGc4IsBu6pXY8vg/KFWF7e6SSa/Cd2rpLtd+c3JFII89eiCqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961484; c=relaxed/simple;
	bh=4mAyagYKmXF63DO7I6tOknQc8yAJ27/s74p+Y2TYhos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XKIXkFz09aiNwvjIgRwwIbIIrdLKuVRPj0expGihe+TDr1lcIqJLn5EZeia7NFNYtL21VmlBifs4qyyrlEjtHRg+xEObKM06tYtfD+xFM2gumfcAJbFfogxgE1k66sQgt9ke1RK1Mj0U2XOPrXjYfTpe1yasqLVS1YGxlq/itcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Ggt7QimD; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Ggt7QimD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782961461;
	bh=D6iKxQwpYX1CYUDos2L4T19GiKd6RNEZZH33fFdceRY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Ggt7QimD7MqVFNzo6i9B9IjKpCAIkZQ1nDMf1A2cbt/H3Zqh+sTQmHaLj2bB+Ryrr
	 16duHjXTq8vPSuZwAt7p4weqSg8HOQqkgblxlzoZbYZ4+tR3f/rBiAoDVsjt+6W8iZ
	 apEpk59I88OG2rgXbE1QNQQAiTVZGUtWWw4pdjmo=
X-QQ-mid: esmtpgz15t1782961443tdb4a3dbb
X-QQ-Originating-IP: AhSFWYBn7RhulvOPAwokzx0F4iuD/ZfRtjBypUA7FUg=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Jul 2026 11:04:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11236963476737238909
EX-QQ-RecipientCnt: 12
From: Yichong Chen <chenyichong@uniontech.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	akpm@linux-foundation.org
Cc: sj@kernel.org,
	rppt@kernel.org,
	ljs@kernel.org,
	pabeni@redhat.com,
	chenyichong@uniontech.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tools: Fix tools/virtio test build
Date: Thu,  2 Jul 2026 11:03:56 +0800
Message-Id: <20260702030358.308155-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NFNrK8KlcSCRmB86nJJTTHp9MaGV6g5gW+DqnYf9X+kKirSXcHH+Qoes
	ZSmWpZBr9Y9EgI1a6b+APbWA4l11elrUHfLKtxjf2iJqoVfHgSB/ozhP4aIcaOj7tXCyfl1
	itioOAg41vgxQGOGcZ/6WmU7gxEGC5eIqhtD/yq4iipV9nD1kDRYVRvsiE0GJ2q/H6cfdpn
	jiZOgscuaQGZuaKuskdf4ez1DHy/Hkt2OTMBSdv6+/qIVrmq9jvKIKG0HP00RA0IZn2imry
	QC4Vdot9lkpyojBYpz0vt5GfeHFAwMEzyJCfpgWBYsWSJ7GyeUp2sTPvOrjkZsp2lJ+WD5p
	vAFGlbY1jJBj4p7Ys9SyEo1/Ky2DaIkDofMBt0amOsASHj9G8Lgx4Tt+tZ+x+4uNDME9r1J
	4Y9T2dPRykp/H3A2iyf9eeCHlYbiWMebgIe6N+mWT/dRWw3IhcmRRZY3J/8jTo3nBMT/Kux
	ZZkpwOWhRqCuhKO6ZBf9hvE0wjNa/aVSf/NuEqMpQkR7R+NNxnOqKN3wz5nRpKHi3ZbFlrO
	ieAk8VYmumCrKq8N8HFEfERXG+M5v3NJxj35EIrOGNHWUt8n69YqIClgb0rezzCjAjKTYnv
	kSQWW1ssx64CXtXtFuhfra0E4qpxR0TT6YrPkJ+2bWTYMf830E3laF2gDZS3bwGco6V+Al7
	bmWragZl5XROqqzWA0GYiNviLVrFlwMXukc/iUB1IpPC6HeNrRgvK5qWYxootqbTTGxIoT5
	VXlO+Zq9SopbrhS/A6NhyNUdl0koZ9sxkn4gda0c2ALaJIhgVOXU2qNdFbk1n+AA5q70Vl9
	goMBfLfn0khkxMcZMf8Nv30HuYXYXojW3l+aAjAFK+qkzLjXGD9rYKlyDOalyJdcFysuYeI
	QAIr7VYVX/+6yiZfxstnFXq28k7fxT9V2UfIJcODLWjklT27CWcldPP+SY7tatHwcHC6RgO
	/slBVBUt+vHH42BT73Hf7g/ObJKWe32CvvdCubjyLUYPgxeokZfpK9lQ/dIUviEtQZZNsdv
	hbTe2mP1x9ZHsSgi6hokUq5aMmCF52W+hwkQIL/65VIJs4MRec
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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

Changes in v3:
- Move the stdint.h include inside the overflow.h include guard, as SJ
  suggested.
- Add Tested-by from SJ Park to patch 1.

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

 tools/include/linux/overflow.h       |  2 +
 tools/virtio/asm/percpu_types.h      |  7 +++
 tools/virtio/linux/completion.h      |  9 ++++
 tools/virtio/linux/device.h          |  1 +
 tools/virtio/linux/dma-mapping.h     |  1 +
 tools/virtio/linux/mod_devicetable.h | 14 +++++
 tools/virtio/linux/virtio_features.h | 79 ++++++++++++++++++++++++++++
 7 files changed, 113 insertions(+)
 create mode 100644 tools/virtio/asm/percpu_types.h
 create mode 100644 tools/virtio/linux/completion.h
 create mode 100644 tools/virtio/linux/mod_devicetable.h
 create mode 100644 tools/virtio/linux/virtio_features.h

-- 
2.51.0

