Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A539F162;
	Tue, 14 Jul 2026 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997990; cv=none; b=CV3y8IRdoBqvBaOKUt29B+fajPlFyC5F9yAgNBVwVCPTPnK6LIYMvfgXR1HywOgXPfqp2LBy6OpNmxslNJoARkMh3NOfAoeBzZ7y8n8A9BpcdSMEM84umj5Hrdy+XdAtTN7qjFk32+eNnhk4h4BXceM2IIOjDsYCUeLxOSUkJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997990; c=relaxed/simple;
	bh=2K3ajQ15zH38JWsYo+FvqmXUoWUdxRJAvpxnUTGtKwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXOeGLZ8xwFrcuYyvjVzwk2ckt1CopK3gbxjEMdZ/0hErhzEJfN9wqqxrbrSm5PDyeZay9FZ9SllLUltVayUgRm2sBcDm0neyDwar7r1AdhWladgHAqyEpBvOhKfRcC7is69s9SiqeHuP9zWDm8NDwxtVbYUgVvqYCrT9r/IftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AbQz6HeG; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AbQz6HeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZK
	E6YYRIZA3GzyNC9F73oW9MvrKfvLzHeAXLbcx6GTw=; b=AbQz6HeGWKEgDL9R20
	V55pPv3c3KlBTdKpeGTxsqHbm/DOQ3nIWvCgfETEl/QAX8zanpamUgoHtaPAoeUo
	D5e7aUWOm0oe3mrHa91JingC9+zpkkINLCbjafjI8mi3NVL6+0zfzA14SaChDd81
	F9/tEMpI2F7p68k1rMTye5gZQ=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3b_8CplVqBxNXJA--.48351S2;
	Tue, 14 Jul 2026 10:59:22 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH v1 0/2] iommu/virtio: Harden event handling
Date: Tue, 14 Jul 2026 10:59:12 +0800
Message-ID: <20260714025914.193580-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b_8CplVqBxNXJA--.48351S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF43CFyfXr1UCrykJrykGrg_yoWxtFg_uF
	ykK34kWr4DZFWYyayj9FyxJF93GayUWr95urZ0vrWfAr1fZw15WFykJr1rXFyxWrn7XFZ8
	Kws8uw48Zw1fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbQVyDUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8wqbJGpVpgoX0wAA3R

From: Xiong Weimin <xiongweimin@kylinos.cn>

Hi,

This follow-up series hardens virtio-iommu event handling.

It is based on the probe error handling fixes sent earlier:

  [PATCH v1 0/2] iommu/virtio: Fix probe error handling
  Message-ID: <20260714024949.190014-1-15927021679@163.com>

The first patch makes sure vq->vdev->priv is initialized before
virtqueues can invoke callbacks. The second patch rejects short event
buffers before reading the event contents.

Xiong Weimin (2):
  iommu/virtio: Set driver data before enabling virtqueues
  iommu/virtio: Reject short event buffers

 drivers/iommu/virtio-iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0

