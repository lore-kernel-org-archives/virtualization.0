Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14B1A9B27
	for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082816; cv=none; b=ZqHZZmX16Jz5P9+0ztUj1SL0VhT/VqCYfMXdSP6jYuNMnZ1z+Ts2ytmcmeigeX0b78UAkOPcWHbMnxvid9WzU4Z1tmDnV1xHyQxf31sp0YYUKv/XdFqF91+NpxtsqWI6AaRlcTpeFPh4CyB0p/SZfsKfLiR7U6mfIY6QiF0hahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082816; c=relaxed/simple;
	bh=MnNisqc0NqM7r0VRLdYxL9biktVBMmD/OyitwnsNYBQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gDUjPRSKraVFhT4NsJDdKHfpM0DOiwkyZ/hZRD6WtB+qVnA0QkW8YTFgRYreOwrpBtJMo3kG8F+XIu6FW619LK/WYujL3N4u8yphXI0dRYc80ATAN+k5d8ZuKlYRM9t7PXcCKBmqGnCv0DCy9nvD6kjQerfW5T3D/+FzLxyoGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClaXN4Rs; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClaXN4Rs"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso8139609276.2
        for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 08:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738082812; x=1738687612; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7I3FQn+a3IeKpvoyXVLY346phLoqlukuEhizyoucyY=;
        b=ClaXN4Rsfi6FiGkLW7erCQPY3am/IvOPC6xDMNTMngVXgFun+bEH7iuNIyJ5ebYsUY
         5kLqqYpfc4O5NTrwmehn9q9eU1sD4+7JvSvJ0eouUqWo6PCpkhXlR7jOg/g4GAhUj2WD
         53mfXT49OuKQoVxbdZDEK7MU1LAOA+STprgakKAQcuKMIougu5Tt3IATxvRs0mObJcjP
         mty8LrgWDzd21s0i0C0UP/vbfi53rA1SPSmdAIWAxqpFdzMIu1qqqdwRodpoCg6wabTf
         41SoA7wZFHbt9sJ4bfqcEG3s4Gcrk4GJzDVRxUKrs7XTIbcUx4BjmiFmDZo8gf1r3atv
         WQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738082812; x=1738687612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7I3FQn+a3IeKpvoyXVLY346phLoqlukuEhizyoucyY=;
        b=kLohZVfh1dhgyhd0HKvI7ff/HPAGfo7ioGl6H+ytoGRiEeNMKDmfEfcIzaSRsT35r8
         8mVNwOF5VRxlQVPNJv2ay4KD8Gh01IZlDrpr74eKT7KZnmwvrhkIumkyFYzUH/LB6pOr
         GXT8rPpyHjX2alk5Aw9Mp755fpUupcezM3gbBuFxk1zH6F57eXrD/46ekCTJWmWTwtwW
         QWnq0N252Wl1e0f2nx524XUQ8qUA+N5h+hNhrcX8FvtA96/f7+XXtPIVZAGExs+Z2b1D
         /oeToW/sq/RkEpaUR44otI+R6vH1/spsBUBmSs3MS4EP2+BUnZJqraj7Iyq6IxqJGOAt
         Y/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMNl0qj/bGim6ssB3Ck6b8LiN8Z3TNr5c43v7IhFVi1wu4LU1haadktsUqqJbnepQoyjr3q+7hugXxTfS2Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzosCojyhAjIMW3eLsSGKY73YK8YpaRnlmNVFJ0ArYTuHF6Jb8D
	XlG0KJlVtH9AHzVbv+06dIoMLWX3/XziBSygCrTFYhUEM6NM9rLb
X-Gm-Gg: ASbGnctN+2p8LusIboW6+ivvocjgJoCKfN8ZQMCmpJDLyQ1uA9eca+wHC5g4CZm15LU
	ltaTNcBEXUeAWKy4jWrkmQv0/qah5CI71czdZubTsLoruQ8k2y2WTO/scR/WI8r8sFw4pYngtGP
	Vh0DGh0g1f+jcIX0AXwOrFhu2I+t6D1x3e15ez+tdgeZKBITsHHRE+Paiq7rp/4ADI4YWqFuM06
	ZIo8M3R0sqEVQWvUMR6ujIxtdvsvOgkyW20r9yY2Q7a0yHlANRdQtk9qaZw3Oq5UjFA5HNM26Ry
	M0REgzsL4ztC0NY6w8FrR5cu480YeiSCGpWDD07beZyXmA4H6JI=
X-Google-Smtp-Source: AGHT+IFvmgf54bypeg06iXMG7R6vW3zKyn1725RIYJUIjUALciExdJNbHjTn7B/5gtx7qirVGTp6aA==
X-Received: by 2002:a05:6902:70c:b0:e58:5a:7694 with SMTP id 3f1490d57ef6-e58005a7945mr26770575276.20.1738082811957;
        Tue, 28 Jan 2025 08:46:51 -0800 (PST)
Received: from localhost (c-73-224-175-84.hsd1.fl.comcast.net. [73.224.175.84])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e583b7697c9sm2098812276.16.2025.01.28.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 08:46:51 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>,
	Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [PATCH v2 00/13] cpumask: cleanup cpumask_next_wrap() implementation and usage
Date: Tue, 28 Jan 2025 11:46:29 -0500
Message-ID: <20250128164646.4009-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumask_next_wrap() is overly complicated, comparing to it's generic
version find_next_bit_wrap(), not mentioning it duplicates the above.
It roots to the times when the function was used in the implementation
of for_each_cpu_wrap() iterator. The function has 2 additional parameters
that were used to catch loop termination condition for the iterator.
(Although, only one is needed.)

Since 4fe49b3b97c262 ("lib/bitmap: introduce for_each_set_bit_wrap()
macro"), for_each_cpu_wrap() is wired to corresponding generic
wrapping bitmap iterator, and additional complexity of
cpumask_next_wrap() is not needed anymore.

All existing users call cpumask_next_wrap() in a manner that makes
it possible to turn it to a straight and simple alias to
find_next_bit_wrap().

This series replaces historical 4-parameter cpumask_next_wrap() with a
thin 2-parameter wrapper around find_next_bit_wrap().

Where it's possible to use for_each_cpu_wrap() iterator, the code is
switched to use it because it's always preferable to use iterators over
open loops.

This series touches various scattered subsystems and To-list for the
whole series is quite a long. To minimize noise, I send cover-letter and
key patches #5 and 6 to every person involved. All other patches are sent
individually to those pointed by scripts/get_maintainers.pl.

I'd like to move the series with my bitmap-for-next branch as a whole.

v1: https://lore.kernel.org/netdev/20241228184949.31582-1-yury.norov@gmail.com/T/
v2:
 - rebase on top of today's origin/master;
 - drop #v1-10: not needed since v6.14 @ Sagi Grinberg;
 - #2, #3: fix picking next unused CPU @ Nick Child;
 - fix typos, cleanup comments @ Bjorn Helgaas, Alexander Gordeev;
 - CC Christoph Hellwig for the whole series.

Yury Norov (13):
  objpool: rework objpool_pop()
  virtio_net: simplify virtnet_set_affinity()
  ibmvnic: simplify ibmvnic_set_queue_affinity()
  powerpc/xmon: simplify xmon_batch_next_cpu()
  cpumask: deprecate cpumask_next_wrap()
  cpumask: re-introduce cpumask_next{,_and}_wrap()
  cpumask: use cpumask_next_wrap() where appropriate
  padata: switch padata_find_next() to using cpumask_next_wrap()
  s390: switch stop_machine_yield() to using cpumask_next_wrap()
  scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
  scsi: lpfc: rework lpfc_next_{online,present}_cpu()
  PCI: hv: Switch hv_compose_multi_msi_req_get_cpu() to using
    cpumask_next_wrap()
  cpumask: drop cpumask_next_wrap_old()

 arch/powerpc/xmon/xmon.c            |  6 +--
 arch/s390/kernel/processor.c        |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.c  | 18 +++++---
 drivers/net/virtio_net.c            | 12 ++---
 drivers/pci/controller/pci-hyperv.c |  3 +-
 drivers/scsi/lpfc/lpfc.h            | 23 +++-------
 drivers/scsi/lpfc/lpfc_init.c       |  2 +-
 include/linux/cpumask.h             | 69 ++++++++++++++++++++---------
 include/linux/objpool.h             |  7 ++-
 kernel/padata.c                     |  2 +-
 lib/cpumask.c                       | 37 +---------------
 11 files changed, 81 insertions(+), 100 deletions(-)

-- 
2.43.0

