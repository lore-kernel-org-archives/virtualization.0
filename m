Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41810278E6D;
	Fri, 11 Apr 2025 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368855; cv=none; b=QDrJ0/ZkstUyyGRJjSYNpplvTUf7mD2Rz5/JCyg8v1h7uyrKyawhG7Q5wYXsmYy4/bE1cFZ06WNbarBrBipRlaglRogJB+yL9PE3IuQpLHVxt0wGwD/nZOmMcryUaY4F9K1IXEGeZRvnyMaOsXnS2QVRT18sIcJec2phA0Tns6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368855; c=relaxed/simple;
	bh=ivxH0h28h54uT++OFPn2fGmx8H36zuQIX9TAA6mwKOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p5gvvSpHNE3yuIuUgprHnxSVW2XR2i7mMmx/pOC2K76BWCDBDV8kv1woYWsfijXeXzG2AiP+XEPFwLRoTRCY4TUNpfA4Hy+7VOrSs8i2/KURMPy6lfRpXhGnP0tmAfh6Px+Xx8O8XB2WBBWb7J+/xupHBwY2iaJZCjOTb7kE7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oEDtWs0M; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oEDtWs0M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744368776;
	bh=X0ufIEoNyj3oR0IYewqEF9lLAz1QUMF0bHnORwk+1hQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oEDtWs0MtOtqbQ52t42fAH2CYfpa2sjc/7YB7kmwSWKbRWNH4BcZQrd9TA+4+5NZ2
	 sKAQcidFwdkcNzSb5JHuCHk5pz0WqfXcmx1G8haHtSclHKYen7zausbLoykZ/i9Jqk
	 Tm38rBjPe35TVZtQBMfs8kZQBNVPKu4dDC+t5oRE=
X-QQ-mid: izesmtp88t1744368758t32cfd97f
X-QQ-Originating-IP: tKvnF/gmZ4DIpXdx6u7S98Ombl0e/s4+gqgyAGenmmg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Apr 2025 18:52:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5811992715279106274
EX-QQ-RecipientCnt: 39
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org,
	llvm@lists.linux.dev
Subject: [RFC PATCH 0/7] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
Date: Fri, 11 Apr 2025 18:51:35 +0800
Message-ID: <31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: izesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MtJoEQFRGvIzah4Ke5Vo4KIanFxZCiutX0b6+GqzojqVsHeLpmjJq+0/
	rCj7ZUec/3JjBUW36XLND3xWPhVxvvJ6lz4kH0UFLiJVAxGNUuHNRdOQny7M9Q/9hKYTRpa
	C2YSbQeNvRE4FfLsOpdlHPzB81Ft4O71uQLIImSOaEd/iqcf53UZdGxfJWx6yGYxr8r8eY7
	SmWWRQn4wtyCBYoMKv2dD7zFhW6WzgJNPQUmskMSDfEMzu3eG8c83lNYJrGkdDf+EzEhrv3
	ASu0G2TIiD2rKHxab3WcMxv5Fp14gHBAP5zM+mNWMdt0xMNlX7gc6s906MlnSF++XROGW9V
	zUt+gVnqvTHsTRVQ/HYB1PiJ/p66PTnTEghuR2TV3uaCRpfUVkv+pXmJw1S2f41vP8PPgao
	ishFqaBqT3foLyptn4Q92f+jYcIkS+KcoFH5Q3dGMYzUl4lw5vWnyovkZZWBMrK2VLHpam0
	vA0x97qWEa7CwO3GB3Jl10nsMzByeXT2lykmVP5ax8TXrK6wLvx3CAjr0Ist0gh1A6bzL+B
	ny1xpJtsm5Kd5tpZau+r+SSLohrxPl1v3yBpJQtCoN62s9lZV7ad/iEPeRQKxuOGqLI//hj
	nMJFR/Ngs4Bd2Mlem/dCh0AN2ioLFgn0loX4T+MuJOJXqWk19CQn54mTbDnB71Rt7tnVIqK
	9ryTh1S7dErXIVlg2Uf3Qbhh/XxVfuBJ+2qCDCLbxDxKYHI0/3+SgltiC5eN8Aq/PkeTgDd
	6MXAArCIy20nGWxB21oLXCg+3t8WfsUG421o5VMAYw3Q5FEUp6f451+rc8wPfzCGieiZMf6
	cNChTyHG3jmaZWCPTCa3eiihY+Pqz4l+KzFkr2z8t8lKr8X1xz+/vk0jzOIEJWcEMpq0gpP
	tCGZ4qaWqpJv7IMydJ3Hleuduzdd8EIPHX9F5J5S8ggNk3cR77jGl8D5n+ehiyAyd0bNtoG
	dRXwZS/HP38d0tGn4lS6Xp+clVOG5royvRDrFwH2UtUJbnW38pZf7v/zFczstz8UZDSE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This series introduces a new kernel configuration option NO_AUTO_INLINE,
which can be used to disable the automatic inlining of functions.

This will allow the function tracer to trace more functions
because it only traces functions that the compiler has not inlined.

Previous discussions can be found here:
Link: https://lore.kernel.org/all/20181028130945.23581-3-changbin.du@gmail.com/

Chen Linxuan (2):
  drm/i915/pxp: fix undefined reference to
    `intel_pxp_gsccs_is_ready_for_sessions'
  RDMA/hns: initialize db in update_srq_db()

Winston Wen (5):
  nvme: add __always_inline for nvme_pci_npages_prp
  mm: add __always_inline for page_contains_unaccepted
  vfio/virtio: add __always_inline for virtiovf_get_device_config_size
  tpm: add __always_inline for tpm_is_hwrng_enabled
  lib/Kconfig.debug: introduce CONFIG_NO_AUTO_INLINE

 Makefile                                   |  6 ++++++
 drivers/char/tpm/tpm-chip.c                |  2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_gsccs.h |  8 ++++++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  2 +-
 drivers/nvme/host/pci.c                    |  2 +-
 drivers/vfio/pci/virtio/legacy_io.c        |  2 +-
 lib/Kconfig.debug                          | 15 +++++++++++++++
 mm/page_alloc.c                            |  2 +-
 8 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.48.1

