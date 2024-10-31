Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B314D6E1
	for <virtualization@lists.linux.dev>; Thu, 31 Oct 2024 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360786; cv=none; b=VpTAdWG4WWDZTIhsC62J3Ju3YjFJ1p8mD8pusx+iwkjCvEOBfc4SSInWNATGsHfKE9zl3thP1qIiFAHDtAoDQw17H7DnN3uqW07v2+I80BJpSmbiphqbJxXbogvKhPZyZbSSJUCnJvleSmV8aURVslyhYM5+7sQW6W97MzCKGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360786; c=relaxed/simple;
	bh=LO8Ci0ae9Y8Y0UdUGzx5luX8NEoGnj562SvJpkzsmdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3GnuVYzSHwl+8rybdLv7VkC6wlsHDPh3gVrWMogba8iqVA1tWVS65NN6BqxrvrFdg0oaZVyvH6ckzG3Z8ZxsvAWiTrzfJyvmUlYaV8AQYcu6IIGtr8aa6UFHGOJ5WYWGFQlGf5q8gjSLaHR/iWs+sx/ON5+kCvCildAHeXYvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IfMtY89E; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IfMtY89E"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730360780; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HcJhglacALWuErvFcSYaoS/PumrISEPMTBp9tpEVtaY=;
	b=IfMtY89EdttRY0iD36c+oTWNhJKn3WwS2MpHxv5LlV0t1gleIwp0h7mZCdnz+fkNip6NSMT0BEtPGD/kN2fAlTgQ7tkprB5PyNzMUMf2O2AgCezu7iwyFyodBgpGjW1ZFgBu7fXXJwDBV6NpwUF32F4jHRhO76YabVH4hSpumag=
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0WIHa4Ov_1730360778 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Oct 2024 15:46:19 +0800
From: 'Guanjun' <guanjun@linux.alibaba.com>
To: corbet@lwn.net,
	axboe@kernel.dk,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu,
	tglx@linutronix.de,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	bp@alien8.de,
	xiongwei.song@windriver.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Cc: guanjun@linux.alibaba.com
Subject: [PATCH RFC v1 0/2] Support for limiting the number of managed interrupts on every node per allocation.
Date: Thu, 31 Oct 2024 15:46:16 +0800
Message-ID: <20241031074618.3585491-1-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanjun <guanjun@linux.alibaba.com>

We found that in scenarios with a large number of devices on the system,
for example, 256 NVMe block devices, each with 2 I/O queues, about a few
dozen of interrupts cannot be allocated, and get the error code -ENOSPC.
The reason for this issue is that the io queue interrupts are set to managed
interrupts (i.e., affinity is managed by the kernel), which leads to a
excessive number of the IRQ matrix bits being reserved.

This patch series support for limiting the number of managed interrupt
per allocation to address this issue.

Thanks,
Guanjun


Guanjun (2):
  genirq/affinity: add support for limiting managed interrupts
  genirq/cpuhotplug: Handle managed IRQs when the last CPU hotplug out
    in the affinity

 .../admin-guide/kernel-parameters.txt         | 12 ++++
 block/blk-mq-cpumap.c                         |  2 +-
 drivers/virtio/virtio_vdpa.c                  |  2 +-
 fs/fuse/virtio_fs.c                           |  2 +-
 include/linux/group_cpus.h                    |  2 +-
 include/linux/irq.h                           |  2 +
 kernel/cpu.c                                  |  2 +-
 kernel/irq/affinity.c                         | 11 ++--
 kernel/irq/cpuhotplug.c                       | 51 +++++++++++++++++
 lib/group_cpus.c                              | 55 ++++++++++++++++++-
 10 files changed, 130 insertions(+), 11 deletions(-)

-- 
2.43.5

