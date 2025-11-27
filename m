Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DC72BF3F4
	for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764213868; cv=none; b=WFKLdYPxPTRvJwAC7+qzaHFIOWjOqj6lK3bIUj5WaRzB9c0Z0MrH7detkd2AHZKhhEAej4XQZ59lwUqpiUgbMycBOW+RALJrjGLOfc0feaqImJa9+4iwirfnZgCKHTRMrcr7ZNAuBapYDzCTe4iNeHcZ4x0GGwqKfkL2y+IeWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764213868; c=relaxed/simple;
	bh=Er4fFy9UobEZFuyAgrViSOHec03jNI9BjfNE+v+uJhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ddgp//dmVJtPZZ2CiQy3gfcg5gEQ2ghfjpVSo3BwsMurrRfRhjRjEiVebknRYfWSG4CuZd16XZyKUT/SryhclWyhavmf87cG4TZ/lh+EpaRtH/JZFR4l9tVcdDFjX1mFPfBQKqO/NNTGuWCpBmbIm3J/HFZX8InswzN9q8TeTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=czBx2aTL; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="czBx2aTL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+o
	VudPXX9VTVrfR70/1tbdjAPXQYgwMC0/hl9sLNw6o=; b=czBx2aTLCbq9MT455Q
	T3dYnppngpC7hCdVjzs/ZdZFLCXYRIH/FxqMaLp9S0w1CtuVHi0rXLJPFTehgp9B
	r4IEAS8IbIhixUmPaDApMatA9RHnixQF5nHFnFWEGVDhwIhfyWCTmYMiPSqa3AJK
	FurshTpo7pow9PxWV4rIH4Ujc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCX4NVfxCdptnYQFg--.3639S2;
	Thu, 27 Nov 2025 11:24:16 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: lange_tang@163.com,
	tanglongjun@kylinos.cn,
	virtualization@lists.linux.dev
Subject: [PATCH v1 0/7] introduce virtnet_mon for monitor virtio_net
Date: Thu, 27 Nov 2025 11:24:00 +0800
Message-Id: <20251127032407.33475-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCX4NVfxCdptnYQFg--.3639S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF48ur45Xr4xGF4ktF1DKFg_yoWkGFX_Kr
	1UXr9Iqan0qayYvFWjvry3XrZ3KayUJFn5XF45Jw1fCw47Jw17AFn7Jr18WFnI9r1UGr43
	JF4FkrZYva1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtT5dDUUUUU==
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbBdgwTLmknu4n7PQAAs9

From: Tang Longjun <tanglongjun@kylinos.cn>

hi,
virtnet_mon is used to monitor the data packets of the virtio_net driver 
and the related parameters of virtqueue, useful for tracking its status 
and troubleshooting faults.

pls review. tks

Best regard.

Tang Longjun (7):
  tools/virtio/virtnet_mon: create misc driver for virtnet_mon
  tools/virtio/virtnet_mon: add kfifo to virtnet_mon
  tools/virtio/virtnet_mon: add kprobe start_xmit
  tools/virtio/virtnet_mon: add kprobe gro_receive_skb
  tools/virtio/virtnet_mon: add kprobe ip_local_deliver
  tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_recv_done
  tools/virtio/virtnet_mon: add README file for virtnet_moin

 tools/virtio/virtnet_mon/Makefile      |   10 +
 tools/virtio/virtnet_mon/README        |   35 +
 tools/virtio/virtnet_mon/virtnet_mon.c | 1048 ++++++++++++++++++++++++
 3 files changed, 1093 insertions(+)
 create mode 100644 tools/virtio/virtnet_mon/Makefile
 create mode 100644 tools/virtio/virtnet_mon/README
 create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c

-- 
2.43.0

