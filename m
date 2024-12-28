Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCB2744D
	for <virtualization@lists.linux.dev>; Sat, 28 Dec 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735411797; cv=none; b=RRxSvBXY9vPyO8HOpEO699j6HBBaV9sjv7YkM7/GIQM3ik2XI1K4pQ4J7xIo22d/p/8Z+8AhWsrffjLz4+3CrX3LKXayJoGd0jY5AL1CPAFCjKsOHeUanLLn2Plu8YxRDDXO4B3qVTlpQPSygREdsghb1e7SwN3c92IdIwb0vdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735411797; c=relaxed/simple;
	bh=1yAI3ZDHyUkDV9UQDHx22Hbwp4ZXby1Wc02tN6J1Y4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MWDQj6D4k513gI7QV7oxevADx80E8TWYfHZVFW4vBOngZJsyIZQfDJpPTWnqpgMwKmzDMq+Wp09sa6t0t6FISWTvcG+v9nOdYBMLQs+WhbQprECnt10pPx1Sb+E7XhEqYHNVbMvMokQM0qdRr51uDJGshBIUdt9npar/h5IqwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNhM8/8Y; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNhM8/8Y"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e396c98af22so4237428276.1
        for <virtualization@lists.linux.dev>; Sat, 28 Dec 2024 10:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735411794; x=1736016594; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmPTlVzrMWsZV/0UuabLUVbV1EH4j//h4cVfthapkOk=;
        b=FNhM8/8YC4xmG4ebTrv1AqBKMykRRQ3aeyNqZo3RBtrDijyRk9nb9C3QfXQwp0XyVs
         i+pBMlRVgu4rarGse8XCpk8Dg+JLF/rbGpDcCXjUAV4y1O0UZTbsrwsVRllk+4y0/p9A
         t9LLB6ujFICNCCWSHPQorLLLfMeAKEBeYVKrU+prSRwhV6JwenT5siG28iOJCrU/FpwR
         2GQ2mSo5igsYxWFqEF3c1wVboySO5BceZRdFiZ+WKHT4Uqx8lsQgfOZbtmQwPlk03Tuj
         HpZ/hhPjZv+cIoKWMunScnhwMYlPvEmG+sKNCOIoH0HIUQCLSVw+5WD8f28ct8SWg65k
         nHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735411794; x=1736016594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmPTlVzrMWsZV/0UuabLUVbV1EH4j//h4cVfthapkOk=;
        b=MWn/wIm3Yeiq8a9dISpEXzMhJjrSM0onYVbsf/WBo8EiPFrfSA6YbaiDnG22An5QHV
         JWJUhx561otyVZ97mM3NmGXvNeMfZObbUpgQTpTOlLBUhi6KbM8zCd7TdjNjtMM+PkVg
         jmJSlhg8QYx7wHROBnHh+3fNjAJVITvNPqoXMF4AlN3hzQrdKWxeEImVZWHP6YnLyJGr
         kehWOOCdV0A8ZE+0mTyyFmvbllTtshMmy5UF6+1obdmQLx/AkY//Y8QZDdKfTY2XcieB
         DEqajcVfxh13U2bublDZKbHFaTooyIyJ3YY+zFFYwDQ4XKG5Thnou2e0VxarFj5cKx0U
         R0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUOiqHEALlMBCXn9Fpo+HAq2pB+sfmZMCA23tiDgL7Njrc6qf823rdyZ80Oe4ZnzgWrxSorXzLgjVTBa/vkOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmQXuNxO0shVq+EbiVRHZBox1nijBsR5Ea/MnnO2/N61VYa4v0
	A7iGtcKxDtHXhhXbfEv8ugZO9vQg67sTbHVUAd/NU0B9dP7JYO7G
X-Gm-Gg: ASbGncvDWsqZYButD+6LCFs9KM554YSld/z1ThiX4M4v3GrSPGy8VIt3XvBvhQ4ESgB
	VffSU31pn63iQeM26tcRpQz/bwlaJAA+lx0JO6aVcocDGsyQds8qZ8xqLMyZd8dnAKp9IKNHDjF
	OGE5uRmA+6rnjaJVjObP6UDMi1jNrfqrhTXyYMUtapVyMBOQGyw+nvMYzOkPkR302zBqOIsug7j
	ImODq8Bd7UurDYNY5xTF1ACateSl60ksoqy/v5dR3Bya6Et68zwkNWBo4GxrngCKnGpcUD1AFfb
	QOjvjaDxwrIIwa+p
X-Google-Smtp-Source: AGHT+IEkJJFH0m3oTNAbR0yAINMZTww0cO+zE7+Lf9uNhKvuTxiLtpcDAvH2RV2/PHCyo+AVfgp8KA==
X-Received: by 2002:a05:6902:18c1:b0:e39:8b94:16e6 with SMTP id 3f1490d57ef6-e538c3a2eb7mr19599866276.39.1735411794393;
        Sat, 28 Dec 2024 10:49:54 -0800 (PST)
Received: from localhost (c-24-129-28-254.hsd1.fl.comcast.net. [24.129.28.254])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cbedbe7sm5061343276.4.2024.12.28.10.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2024 10:49:53 -0800 (PST)
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
Subject: [PATCH 00/14] cpumask: cleanup cpumask_next_wrap() implementation and usage
Date: Sat, 28 Dec 2024 10:49:32 -0800
Message-ID: <20241228184949.31582-1-yury.norov@gmail.com>
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

Yury Norov (14):
  objpool: rework objpool_pop()
  virtio_net: simplify virtnet_set_affinity()
  ibmvnic: simplify ibmvnic_set_queue_affinity()
  powerpc/xmon: simplify xmon_batch_next_cpu()
  cpumask: deprecate cpumask_next_wrap()
  cpumask: re-introduce cpumask_next_wrap()
  cpumask: use cpumask_next_wrap() where appropriate
  padata: switch padata_find_next() to using cpumask_next_wrap()
  s390: switch stop_machine_yield() to using cpumask_next_wrap()
  nvme-tcp: switch nvme_tcp_set_queue_io_cpu() to using
    cpumask_next_wrap()
  scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
  scsi: lpfc: rework lpfc_next_{online,present}_cpu()
  PCI: hv: switch hv_compose_multi_msi_req_get_cpu() to using
    cpumask_next_wrap()
  cpumask: drop cpumask_next_wrap_old()

 arch/powerpc/xmon/xmon.c            |  6 +---
 arch/s390/kernel/processor.c        |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.c  | 17 +++++-----
 drivers/net/virtio_net.c            | 12 +++++---
 drivers/nvme/host/tcp.c             |  2 +-
 drivers/pci/controller/pci-hyperv.c |  3 +-
 drivers/scsi/lpfc/lpfc.h            | 23 +++-----------
 drivers/scsi/lpfc/lpfc_init.c       |  2 +-
 include/linux/cpumask.h             | 48 ++++++++++++++++-------------
 include/linux/objpool.h             |  7 ++---
 kernel/padata.c                     |  2 +-
 lib/cpumask.c                       | 37 ++--------------------
 12 files changed, 60 insertions(+), 101 deletions(-)

-- 
2.43.0

