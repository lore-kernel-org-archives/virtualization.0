Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B423278E63;
	Fri, 11 Apr 2025 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744368874; cv=none; b=YEd8Ksk19KifI0FLHt57jaZlnyhqhLS0+bvmLgnBd0KXahvORherCcRzY975qYefG0pRv59/ESnQKEM1nO/zzE4hSRnDPIW206CwX1jMEBRy8+xWQ8Mnazog/Iv9fMkHwOOTQ+mD+hTmEfPiF9/GvelggTcB5RDBOoDYMWSTNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744368874; c=relaxed/simple;
	bh=ivxH0h28h54uT++OFPn2fGmx8H36zuQIX9TAA6mwKOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApnJgWHmYeycjU6qLx/FH/UEIvWibiniRPbpteWqCjalP8Idh/8ZFeyGGui1J6nJBohYVJ6LJg2cFQdRLNecsnrDDooS2fE/oZ7gboqkGU2zCEUsWOc8STMw3fLSKZJygpZNAmTE7PgO++1A/TXWHmtMScg40ixzXaSUxV4uCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=p4feHx0p; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="p4feHx0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1744368814;
	bh=X0ufIEoNyj3oR0IYewqEF9lLAz1QUMF0bHnORwk+1hQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=p4feHx0p+uyXjRmm0Fh1YM+W6uyVeqlOpxoVLDyQqqL1K0cO+qYKtns3HG2AkZHGw
	 Lh+XRX5pm6Yz9A06BoVGe+h2zZsJsCMEI0WxP3Ty/SiUQVlm0FSjaKjVRPkm6TndWR
	 FF/mJXOj0j7PAYTQTh1mQwJ2TIBNWEFTyzrq9kDM=
X-QQ-mid: izesmtp89t1744368797te5117757
X-QQ-Originating-IP: IPlCEmE7xzZ8ozIOcwucNJTzsElxK9Oh578T97Ar7i4=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Apr 2025 18:53:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3300532361145628569
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
Date: Fri, 11 Apr 2025 18:52:59 +0800
Message-ID: <E9B8B40E39453E89+20250411105306.89756-1-chenlinxuan@uniontech.com>
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
X-QQ-XMAILINFO: NNy5VkfPTUBBcmzEQL7gJYMkRMwDXd9sA3Ie/+sW28mdx9tjiY7lL0AB
	kZPoqBLUtK51UlG/54tbzRLbvRuwCMIeJfiY0lwSm0Gc8Mhzj5BlxXD1CCpmUfF9OKjfY+P
	bSPgR14rkhpQYINf0+iKjwzjgP/s72xmujqHnJrkrduq+GQZV07AxjQ9V9k3ebnoaOzC093
	yA/xqFl4aZ0leAaSjHYnTmLAM3VD0SBX4HVpk6j+ok33VhmrWCeGwFxUbXlOSpKNnnPFb1D
	2em9GmdU6zCsM0tRnJ2SpqTbDZvAu3Terb5PbQdSd6a4PeUZm1CdcXHuF5GHN5sMCPvto/F
	aUOXsJ+eOiF12eex1OKud28MiFufd3C9axpkwzvUAJMK9Nx9igUN1RMGkoOgJ8dHV24AuKE
	gsB6utdERdV5x0PcM8Ho6LLOaeWldIQcXFi8wo2CpWf8TaQ8fd+4cSj19wan+dSFu0yZQXw
	Pz1Zj2BZySMxIzRknWjWMQvoo3720MjOBWZxVw/YJFo1IU03UHL1Zm6SqxTEBkWnGrwQPPz
	zwJT3e4YcSBEvDj9OqtRB26UKddQyyksB7pBQlUkQGwHYI6v4KrrnwJnSaXiK2VgHY5U+ri
	9meK+XD9PgHlY6iFVYJq22KBIPL9/33fKacaQzd/t/7M+NeT7YZlRf3WPoZmuatbwwW8mHI
	xN0oedUf5Xg8JnENvpTPlZagOzSQQcoi+E1u3fIXpRVMsfdtUgI5T3/RWPzt1v2S0HMILaC
	C9sjOGytZaMk+ZpF1Ln38yiJJ9ANSir8Xvmj2n606kowiy2amaOFr/q6RLA9FNx5eDl1eZ3
	F+cmIficnUh3fJaOAN2i0GZQfgBhSzbuQS1cirp/DiZdsy4PMMvO/82VxW+HQLiOpUzqe8C
	CeA+F+HlWB5o0dHDS41dMXSUBklz4dUuKucv9F7LchFE8YVTf9muwLNGs6/gsZ5r7wEiQJo
	rj8V4LjemM3Vufou5FlFef3yAbMWD/X+HQUdIGJHqaAh1kXY2y8oVi5Pe1MnBbzlAnnwivd
	jdpqnL8lirVP+lzaZqrMsNNsS148NfZFp00c+DcctfI2RLRm+fJ0T3OpzXFv9icQRfsm08Q
	ndHsF5aQpxw
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

