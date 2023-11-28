Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C9A39AFF
	for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="c32zEHeM"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-77dbdc184fdso16915285a.1
        for <virtualization@lists.linux.dev>; Tue, 28 Nov 2023 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204581; x=1701809381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsBQ1c03W+bPyqjQatoY3AtDcRPwnaylyTF2JWK/6Qg=;
        b=c32zEHeM/mpAwa3CPGOpr+7istNGA5i4zeTkIwRb9gHtQ05RjP8DQD/GQ9KOjksnSg
         HjMMU7Z+Zs6Qg1HWITUQMOEdC00GfzJnoX5wZOlEnj+jhhnO2n65W2Ko7iQt4pAvO+yX
         AD08WaBIoPmf+vreaaT9w9eyt8HnoIhQwGpn38ooV71ERWCXHwzTlabXIjIfbmQQnogT
         wYeKDpjpCGrZkc9AYMjKValkfMDxOoWgX18Nv/z2t5e568vn7pkUlorXhHXf1ROqSNSF
         zizLUQhZkIcMstWGxhvIVdIWvuuMk4UKq49waN2pqGgRSgVjiLZlPDo+qHdtIK68vo15
         42cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204581; x=1701809381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsBQ1c03W+bPyqjQatoY3AtDcRPwnaylyTF2JWK/6Qg=;
        b=c/dStlEvm4f3mwjj+tq+ePHntcrFgaa1co4RpQWZfpWa75G7jB+ZilL7MDZTs97/2k
         gtWeN4DfzRP2cMsTAq2k66gxrc0p28pf5rw1INK43+b1rVe7oTnbrGYsL8vNrKCyx1oM
         STQ7ozpKCyk/TYqaapmhwGLchhoXAMIOpv6amKi5RLkFiAlvONXjpBK4krxKfVgft9cv
         zue3pOqI00PrXh0cVPP3WdYuBzvQ3mt9KYKsC7u9P0loK1ULIyZI/WoqMJ4Q5bN0BEoP
         4CayMYL5t3nDp8I9u2lZdNFX6Z04H7ifynFhN3FkkGH2mbfGFI6TMkNQTZii8bWNvGsu
         hgzw==
X-Gm-Message-State: AOJu0YynkwWn07wLzUQRXc41f5spbe23F4qHgT/wkc2U1D1PODD1wYBZ
	9Ok8mCgwRBn+Zk292ezpYWza/A==
X-Google-Smtp-Source: AGHT+IEGKj81OhPPfZGrAMOrKOsHXDo+wy0whZdL8ikR2KmUyXglOYylmfrRjMDC83oWuy4vndr7lg==
X-Received: by 2002:a05:620a:1452:b0:77d:c593:f63c with SMTP id i18-20020a05620a145200b0077dc593f63cmr2543824qkl.24.1701204581121;
        Tue, 28 Nov 2023 12:49:41 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:40 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	alex.williamson@redhat.com,
	alim.akhtar@samsung.com,
	alyssa@rosenzweig.io,
	asahi@lists.linux.dev,
	baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	david@redhat.com,
	dwmw2@infradead.org,
	hannes@cmpxchg.org,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	jasowang@redhat.com,
	jernej.skrabec@gmail.com,
	jgg@ziepe.ca,
	jonathanh@nvidia.com,
	joro@8bytes.org,
	kevin.tian@intel.com,
	krzysztof.kozlowski@linaro.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	lizefan.x@bytedance.com,
	marcan@marcan.st,
	mhiramat@kernel.org,
	mst@redhat.com,
	m.szyprowski@samsung.com,
	netdev@vger.kernel.org,
	pasha.tatashin@soleen.com,
	paulmck@kernel.org,
	rdunlap@infradead.org,
	robin.murphy@arm.com,
	samuel@sholland.org,
	suravee.suthikulpanit@amd.com,
	sven@svenpeter.dev,
	thierry.reding@gmail.com,
	tj@kernel.org,
	tomas.mudrunka@gmail.com,
	vdumpa@nvidia.com,
	virtualization@lists.linux.dev,
	wens@csie.org,
	will@kernel.org,
	yu-cheng.yu@intel.com
Subject: [PATCH 00/16] IOMMU memory observability
Date: Tue, 28 Nov 2023 20:49:22 +0000
Message-ID: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pasha Tatashin <tatashin@google.com>

IOMMU subsystem may contain state that is in gigabytes. Majority of that
state is iommu page tables. Yet, there is currently, no way to observe
how much memory is actually used by the iommu subsystem.

This patch series solves this problem by adding both observability to
all pages that are allocated by IOMMU, and also accountability, so
admins can limit the amount if via cgroups.

The system-wide observability is using /proc/meminfo:
SecPageTables:    438176 kB

Contains IOMMU and KVM memory.

Per-node observability:
/sys/devices/system/node/nodeN/meminfo
Node N SecPageTables:    422204 kB

Contains IOMMU and KVM memory memory in the given NUMA node.

Per-node IOMMU only observability:
/sys/devices/system/node/nodeN/vmstat
nr_iommu_pages 105555

Contains number of pages IOMMU allocated in the given node.

Accountability: using sec_pagetables cgroup-v2 memory.stat entry.

With the change, iova_stress[1] stops as limit is reached:

# ./iova_stress
iova space:     0T      free memory:   497G
iova space:     1T      free memory:   495G
iova space:     2T      free memory:   493G
iova space:     3T      free memory:   491G

stops as limit is reached.

This series encorporates suggestions that came from the discussion
at LPC [2].

[1] https://github.com/soleen/iova_stress
[2] https://lpc.events/event/17/contributions/1466

Pasha Tatashin (16):
  iommu/vt-d: add wrapper functions for page allocations
  iommu/amd: use page allocation function provided by iommu-pages.h
  iommu/io-pgtable-arm: use page allocation function provided by
    iommu-pages.h
  iommu/io-pgtable-dart: use page allocation function provided by
    iommu-pages.h
  iommu/io-pgtable-arm-v7s: use page allocation function provided by
    iommu-pages.h
  iommu/dma: use page allocation function provided by iommu-pages.h
  iommu/exynos: use page allocation function provided by iommu-pages.h
  iommu/fsl: use page allocation function provided by iommu-pages.h
  iommu/iommufd: use page allocation function provided by iommu-pages.h
  iommu/rockchip: use page allocation function provided by iommu-pages.h
  iommu/sun50i: use page allocation function provided by iommu-pages.h
  iommu/tegra-smmu: use page allocation function provided by
    iommu-pages.h
  iommu: observability of the IOMMU allocations
  iommu: account IOMMU allocated memory
  vhost-vdpa: account iommu allocations
  vfio: account iommu allocations

 Documentation/admin-guide/cgroup-v2.rst |   2 +-
 Documentation/filesystems/proc.rst      |   4 +-
 drivers/iommu/amd/amd_iommu.h           |   8 -
 drivers/iommu/amd/init.c                |  91 +++++-----
 drivers/iommu/amd/io_pgtable.c          |  13 +-
 drivers/iommu/amd/io_pgtable_v2.c       |  20 +-
 drivers/iommu/amd/iommu.c               |  13 +-
 drivers/iommu/dma-iommu.c               |   8 +-
 drivers/iommu/exynos-iommu.c            |  14 +-
 drivers/iommu/fsl_pamu.c                |   5 +-
 drivers/iommu/intel/dmar.c              |  10 +-
 drivers/iommu/intel/iommu.c             |  47 ++---
 drivers/iommu/intel/iommu.h             |   2 -
 drivers/iommu/intel/irq_remapping.c     |  10 +-
 drivers/iommu/intel/pasid.c             |  12 +-
 drivers/iommu/intel/svm.c               |   7 +-
 drivers/iommu/io-pgtable-arm-v7s.c      |   9 +-
 drivers/iommu/io-pgtable-arm.c          |   7 +-
 drivers/iommu/io-pgtable-dart.c         |  37 ++--
 drivers/iommu/iommu-pages.h             | 231 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iova_bitmap.c     |   6 +-
 drivers/iommu/rockchip-iommu.c          |  14 +-
 drivers/iommu/sun50i-iommu.c            |   7 +-
 drivers/iommu/tegra-smmu.c              |  18 +-
 drivers/vfio/vfio_iommu_type1.c         |   8 +-
 drivers/vhost/vdpa.c                    |   3 +-
 include/linux/mmzone.h                  |   5 +-
 mm/vmstat.c                             |   3 +
 28 files changed, 415 insertions(+), 199 deletions(-)
 create mode 100644 drivers/iommu/iommu-pages.h

-- 
2.43.0.rc2.451.g8631bc7472-goog

