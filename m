Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89563309DB1;
	Tue, 14 Jul 2026 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997426; cv=none; b=Om4XYwBYuYyxidlW0PgdLplCBEHKSETIzXUI92RjaPmAUF0FjdusQc6Ri41pzJ6kGgRYs8uzMMb4HGztAu/KY1Mai7tCBFbIYwkVeYpFmHHd2otAxSyqxyGUtUnx4eLxq+8Ja0qypwmP+aZwgMx0TbQ5xqBADB3kcQBRPQQEnrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997426; c=relaxed/simple;
	bh=Kd3qpz1F0ZitOH9vtVLur0nBNRdyvC4QNu73ywl6tJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpQt4rTXAO/FvPVLIikzXueyoooAKnAZz7h4b7BHabKYVxJG0dsFhiloAzOqSSCkg6b+AWx/nblKHHTILRCj5pwDQVjLOgAQ7Z462r2mcEfETOD6HhIA/jqX4KcTPboCTGvr66xd0jStsorihwNDYhiKv0hQLvL+2Klo07uyKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B2QjHij9; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B2QjHij9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ht
	MSV4imJYuPDcE1bahZScTNKqhmRaCGCB4EIz8HALQ=; b=B2QjHij92qVjxyW0ee
	CGJUrxrbuFX7Fsx1GCLwqJs2JI9/jmtwgQbXRum43o46hHoLZwgCXutFtgji+xc3
	XyN1eZkAMV/pnPRXBDWa/RQivBVS4D3nDNeYIWZxdLKe1JyueHeFRlU6w4KZBcsX
	THlkC6pJFQrHsdjeNgJHTVPF4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXNQLNo1VqB9jsJA--.61058S2;
	Tue, 14 Jul 2026 10:49:59 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH v1 0/2] iommu/virtio: Fix probe error handling
Date: Tue, 14 Jul 2026 10:49:47 +0800
Message-ID: <20260714024949.190014-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXNQLNo1VqB9jsJA--.61058S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrGrWrGw4xJry7Gr1fXrWDArb_yoWxWFb_ur
	W0gry8Xw15ZFsYkFW7Zry7Jr93Ka909rW3CFy5Kw4fJr18Xr1DKr93Ary5tryxWw40kFn8
	tFWYvrs3Aw12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8pHq3UUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0RcOlmpVo9dc5QAA3s

From: Xiong Weimin <xiongweimin@kylinos.cn>

Hi,

This small series fixes two probe-time error handling issues in the
virtio-iommu driver.

The first patch avoids dereferencing a device after dropping the
reference returned by bus_find_device(). The second patch propagates
failures from iommu_device_register() and unwinds the resources that
were set up earlier in probe.

Xiong Weimin (2):
  iommu/virtio: Avoid use-after-put in viommu_get_by_fwnode
  iommu/virtio: Handle iommu_device_register() failures

 drivers/iommu/virtio-iommu.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.43.0

