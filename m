Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B6263F28;
	Wed, 25 Jun 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857559; cv=none; b=baZ6Nl/55HP6ipXsxrumMY7fJpVoSx41aiXv0ctyAvSu9OEOmRwS+xJnMzXSy1xovfQFFR0vQf+/00Lz4W/W5Tv2Gea8+6boXQzjTEJ9WptcYQKGIUcyK4ijLwimpHjWFJ+4budprDJP0dxcyAYmq/tsK1Rh8trgJLIjKF46KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857559; c=relaxed/simple;
	bh=x2+9WyiMKk51YbdrrEHH1emdFd89rPiPsvikAZYGQgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQGWbjE2WUuD9HLw+046AS23jyhq3LN0JaJ2LOP9z5RT+AS4Pe0kILrt+w6ahYctqTL7tKzn/SLi+a9060bOGShJyLOFhT6VS3rNRfY/Yioic3csj35zoitA23GdgNpeC6VnVNO661GFoS7KFPPEySggdxjlg44tLOKTTKwJMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l10zw3Wd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l10zw3Wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CB0C4CEEF;
	Wed, 25 Jun 2025 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750857554;
	bh=x2+9WyiMKk51YbdrrEHH1emdFd89rPiPsvikAZYGQgc=;
	h=From:To:Cc:Subject:Date:From;
	b=l10zw3WdyXEdS9RctXGPVEXxHMOvYtV9GQIdtQEmyQsrO4jkjVzkws3Uvq5/54YKC
	 BWk+L1U7dSr6RPgo1R4HkxtMaD51XQsZVWhcz3kfQaIPgtBG+dHPqgSCNm460cQH3m
	 2hGxhgaSoUU5/cunK9skYGzD0OOpw8n+4wvZBCbCPoNtqZknn8v0E+BKl0w+MyvZYa
	 XMNB3afOwqLGCPStz6Wmqck3EA/fUOYHSMz7BKlUnJa//u0/py1Po/qzjyplclhZcq
	 ZrSyz77b7diqxCv/D8r8QvFup7HF/YiJcjJW6vAfghZqn5Tq1J4odLTaEzz4PJKE6n
	 pcKtlnV78DPoA==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux.dev,
	virtualization@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] dma-mapping: migrate to physical address-based API
Date: Wed, 25 Jun 2025 16:18:57 +0300
Message-ID: <cover.1750854543.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series refactors the DMA mapping to use physical addresses
as the primary interface instead of page+offset parameters. This
change aligns the DMA API with the underlying hardware reality where
DMA operations work with physical addresses, not page structures.

The series consists of 8 patches that progressively convert the DMA
mapping infrastructure from page-based to physical address-based APIs:

The series maintains backward compatibility by keeping the old
page-based API as wrapper functions around the new physical
address-based implementations.

Thanks

Leon Romanovsky (8):
  dma-debug: refactor to use physical addresses for page mapping
  dma-mapping: rename trace_dma_*map_page to trace_dma_*map_phys
  iommu/dma: rename iommu_dma_*map_page to iommu_dma_*map_phys
  dma-mapping: convert dma_direct_*map_page to be phys_addr_t based
  kmsan: convert kmsan_handle_dma to use physical addresses
  dma-mapping: fail early if physical address is mapped through platform
    callback
  dma-mapping: export new dma_*map_phys() interface
  mm/hmm: migrate to physical address-based DMA mapping API

 Documentation/core-api/dma-api.rst |  4 +-
 arch/powerpc/kernel/dma-iommu.c    |  4 +-
 drivers/iommu/dma-iommu.c          | 14 +++----
 drivers/virtio/virtio_ring.c       |  4 +-
 include/linux/dma-map-ops.h        |  8 ++--
 include/linux/dma-mapping.h        | 13 ++++++
 include/linux/iommu-dma.h          |  7 ++--
 include/linux/kmsan.h              | 12 +++---
 include/trace/events/dma.h         |  4 +-
 kernel/dma/debug.c                 | 28 ++++++++-----
 kernel/dma/debug.h                 | 16 ++++---
 kernel/dma/direct.c                |  6 +--
 kernel/dma/direct.h                | 13 +++---
 kernel/dma/mapping.c               | 67 +++++++++++++++++++++---------
 kernel/dma/ops_helpers.c           |  6 +--
 mm/hmm.c                           |  8 ++--
 mm/kmsan/hooks.c                   | 36 ++++++++++++----
 tools/virtio/linux/kmsan.h         |  2 +-
 18 files changed, 159 insertions(+), 93 deletions(-)

-- 
2.49.0

