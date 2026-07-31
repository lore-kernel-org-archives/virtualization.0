Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F333AD9B
	for <virtualization@lists.linux.dev>; Fri, 31 Jul 2026 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488554; cv=none; b=NVdHikaxi7TtqzPFsf0/rRdXfRuEzAm/tii5+JI1UNdt6tM10UQ5hdEz6CZSqh5PUaBtjkWjVAIjKQXjQKR6bcw8H0piw5qx2YlEW62s0pSSiFOPQ39z9j1Z8bhYg+Y3FI65G7rUJTBBYM8CTP8C3AsO5DyiV3TOATpSJlIG/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488554; c=relaxed/simple;
	bh=4avJqCFfzKlWtz9QVtJgbQtiXR9r2VDnhrd/y425vwM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzMeHoUcwFJII51QZ4rYXfaH40MEJdAtzji/0JylThEUVmL/vHDQtXWU9+roYZTELprB3IHhWU2x5YInqGHG8F3XhxRIP54I24GeDFJhjvT4b2mBALDZdAbyIAkfWfqhlDxyGtfDAggFnnjUr7U2oM6nMuwhSiH7VgVqBHZ6B/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yVVqbh4M; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yVVqbh4M"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=343OsLc9Zb9EtU0hf0dFUr0LIjlfXP2W9uRjv/2fxOo=;
	b=yVVqbh4MpJL3fIeQEo+IWdd3zP2JlP9VoLLEf9sboA7Bma5OAPkOu+63qiReMIERku73zSvor
	64PN0ik9p2FLWGyAcER7Imhjh3vUo9Hmnhuc+lI+s2HsJDTe7K3ntkeoZZQY45LGz1Mfxk3Mhq2
	Lp3hCjDmKNcw4Y9R+8Aq5SY=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hBKbJ2mb4zRhVP;
	Fri, 31 Jul 2026 16:53:00 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id 628354058F;
	Fri, 31 Jul 2026 17:02:27 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 31 Jul 2026 17:02:26 +0800
From: Yao Kai <yaokai34@huawei.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<liuyongqiang13@huawei.com>, <jifa@huawei.com>
Subject: [PATCH 0/2] drm/virtio: fix control-buffer leaks on queueing errors
Date: Fri, 31 Jul 2026 17:22:34 +0800
Message-ID: <20260731092236.2262403-1-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemr500006.china.huawei.com (7.185.36.185)

Fix two independent cleanup omissions for control buffers that do not
reach the virtqueue.

Patch 1 fixes the reproduced GEM/VMA leak when fbdev damage work races
with device unplug.

Patch 2 fixes the vmalloc_to_sgt() allocation-failure path, found by
code inspection.

Testing:
- Repeated virtio-gpu unbind/rebind no longer triggers the
  drm_mm_takedown warning.
- Built drivers/gpu/drm/virtio/virtgpu_vq.o with W=1.

Yao Kai (2):
  drm/virtio: release object array when device is unplugged
  drm/virtio: free control buffer when scatterlist allocation fails

 drivers/gpu/drm/virtio/virtgpu_vq.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
-- 
2.43.0

