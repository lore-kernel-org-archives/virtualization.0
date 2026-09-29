Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD33D9DBF
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654589; cv=none; b=ATuqvxNNlt+ynUGEhvyBxj7oxoVEN+LWuDRTVUIoXUc/NhITEkOOLZywA9dyY1a7JfLPAR71uiGyiLC5NjmsVy6U6o28ydOG2xJa+I3Uxu0KXv1Dx+odLJsN/37T+bPwHDN2IbOoNcgHsVE9CaQ4ps/Y4qmfvH3QZbTSECMMZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654589; c=relaxed/simple;
	bh=ofjMK+frBLaew2v4NwVs3dlVJMs1NzYJl7FaeQqAgHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAdoOSpVKzuYxC0kPbuw9t2Zs0dZOXihhxhWLk2z6FtyUHM2furWggC3m7KYyp8H/jiU/QBSLpFN207wNhiKiDAtSseUDEQRp3P+hOJVIYO+Zt10xSwCI5kzJctDOhDPqcQI6R8c1FYs+yBEn6Mak85infAB8NMXfsJbEkT/3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CP/Ja7yq; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CP/Ja7yq"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5c82d057971so1777078e0c.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654586; x=1791259386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JYFksTwPL6Xygy3lz6bjz5WbJ+cVLM8U0ms6Q5xLHTI=;
        b=OZPJLR44CrwLkWrWWuFwaaDh/30csFU3w8uB+MfxkxNPdQt1Ftu2gpyaOBOJm/+M/D
         ksOKrsSfrQI80RNT1aRI+NVotDL6982IUCYHCrMl5tzEteckjctlzNnfFaQi7AjbJBE0
         LDKuOOKYMd8PkKzXBJGmorZDM9RvEBPSEqlctDdbQlYSxHldlUd/soM2DfsHM1KG8wbB
         6TIMI5xL/0HPs4UxkE7cbLoj/JTa6e4AplC+ZMtt4Uod4edkor/UfMLlIV808yTGBRXd
         diRxb6DOKmDY7ICSjcxoCQ6z/LVW+vcoBYxYJS4izBosGp0EiAo2ocfX33s5ptrYPTkT
         /Q7A==
X-Forwarded-Encrypted: i=1; AKwUvBy96FBOEC6fhjIhqbWNo8mjUnNml5m00RDp8wAzzBV1U/v8974CbYa189jgZnBXs2Q++/aI8Mc+hBNlwBPi0w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKLmMsPN9Fo6KC2Fcsp2xnqFAbKLwTdEQo2MeByk0/1K6DxO2sQ
	RM8DhoWC1PMEWNuxSbj3oO7WDU1bEKUa2HART74pxKy8ce6TBx1VA6Ize1SRts0F03iKgJlu2SB
	QB50+GUoj9jsCxEeU6fZTLcTAVOI9kOlNmkqGlqFGxy7NKkMrdvb0M3NoaKLvK/d/5t8qfmLTiC
	vyU+VVL6HREQovMOZtaIGN0+/Qd5FlXuLm3yyrPGyV7cpOrBfeWDFMX5WOk+QnhOuy5Fk+yQPmj
	mUnvsEBoCEfZjVw7EE=
X-Gm-Gg: AYBFou1m1xBTlHMhqPakflQfLUaJJXa4ELSfaC+nfYWQmq+s9Nitt2s7b9EXvU1sOZU
	wiXHKSQ1ofw/pniVpCwp2MK/16AnCRH2Mk4FchJMkLCdSz0VmJ5EE+jUf19dKrCDx6Dp8v/ToXo
	GtPMqcrDPhe/w0Op74648KWbgoPB0N2QH+zj80w9bxHj95DqKxg/eCAZlXCfe3WfzO5lmClO03M
	FDPANWc6eA9t/AOKV91VMVV1/CMxb5h8xdXLOgBcBFYZWGctKdBmyTRCo2O+kuT33n/pbRtaino
	X9we4IunSMF+NP/ZiwMF6juq/nKIvT0E4zd/S73E0TXq/yawnlvhtZOwNk5cznWbR5PEG7E0pDl
	t9TQTKgbbD1OMD5f2h1FS2grrjiLLUR5wRFgcqFVJarz7XHYdijcHLxxx9gNo8bO+msMEG2vmV0
	wpVluO9w1g/YEGm0Q2MXhWym/v0CR2OlAFqaA=
X-Received: by 2002:a05:6122:6d10:b0:5d2:f636:7577 with SMTP id 71dfb90a1353d-5d2f6367964mr59124e0c.9.1790654586339;
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5cde644ef51sm1908275e0c.5.2026.09.28.21.03.04
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34344599f01so1673328eec.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 21:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654584; x=1791259384; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JYFksTwPL6Xygy3lz6bjz5WbJ+cVLM8U0ms6Q5xLHTI=;
        b=CP/Ja7yqLetK/PeEORwtyFK7bgkPz130C4KoFSXcfAwCvg1ijLoM6GPl+Yeupx0o5c
         XVwBhHJI6p0azrDxA8x9AbmXWBmydA5Kb10IddScMvkZs4MltyijvYM2WQ1X1rh5CIUo
         hVMGSRKHU27gdNUnbRLzsL8AhYMH9CqIlwKvQ=
X-Forwarded-Encrypted: i=1; AKwUvBw6nXEIs7/cYPljeLA+t5EqiCSL9y685aRlB8EWTzcTfjgWnkVdEuv9cH0aQKlxSWPmPfpYvVj+yPHSD9rw9g==@lists.linux.dev
X-Received: by 2002:a05:7301:3ab0:b0:33b:e264:474a with SMTP id 5a478bee46e88-34272c5c9c8mr10268589eec.31.1790654583947;
        Mon, 28 Sep 2026 21:03:03 -0700 (PDT)
X-Received: by 2002:a05:7301:3ab0:b0:33b:e264:474a with SMTP id 5a478bee46e88-34272c5c9c8mr10268522eec.31.1790654583107;
        Mon, 28 Sep 2026 21:03:03 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:02 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 0/6] x86/percpu: Share decrypted storage before guest setup
Date: Tue, 29 Sep 2026 00:02:49 -0400
Message-ID: <20260929040256.543767-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware publishes its per-CPU steal-time GPA without first sharing the
storage in encrypted guests. Following Kiryl's review, this series moves
sharing into early per-CPU initialization for both KVM and VMware.
This replaces the VMware fix from Bo Gan and Alexey Makhalov:
https://lore.kernel.org/r/20260309235250.2611115-5-alexey.makhalov@broadcom.com

The common helper uses boot-time page-table allocation and preserves
initial contents on AMD and TDX. Conversion precedes buffer registration
on SMP and UP; failures stop boot. Encrypted guests use the embedded
allocator, warn on percpu_alloc=page, and never fall back to page mode.
There is no driver conversion loop or readiness flag. .bss..decrypted
remains outside this series.

I interpreted the allocator requirement as guest-specific, so both it
and per-CPU conversion use CC_ATTR_GUEST_MEM_ENCRYPT and leave bare-metal
SME behavior unchanged.

Two corrections to v1: its isolation claim missed UP, where ordinary data
could share the decrypted objects' page; patch 1 fixes that separately.
TDX's vmalloc constraint concerns private aliases and adjacent accesses
through load_unaligned_zeropad(), not just GPA lookup. This series removes
the unused declaration macro and adds explicit SMP/UP section boundaries.
I have not carried the v1 Ack onto the revised patches; renewed review
would be appreciated.

Tested on VMware ESXi with SEV-SNP and TDX guests, and on KVM with
SEV and SEV-SNP guests, using SMP and UP kernels.

v1: https://lore.kernel.org/r/cover.1789488039.git.zack.rusin@broadcom.com

Zack Rusin (6):
  percpu: Page-align decrypted data in UP kernels
  percpu: Bound decrypted storage for all x86 encrypted guests
  x86/percpu: Require embedded allocation in encrypted guests
  x86/mm: Provide common early memory decryption
  x86/tdx: Support early sharing of kernel data
  x86/percpu: Share decrypted storage before guest CPU setup

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/x86/coco/sev/core.c                      |  16 ++
 arch/x86/coco/tdx/tdx.c                       |  32 ++++
 arch/x86/hyperv/ivm.c                         |   4 +
 arch/x86/include/asm/mem_encrypt.h            |   9 +-
 arch/x86/include/asm/x86_init.h               |   4 +
 arch/x86/kernel/cpu/vmware.c                  |   2 +-
 arch/x86/kernel/kvm.c                         |  35 -----
 arch/x86/kernel/setup.c                       |   2 +
 arch/x86/kernel/setup_percpu.c                |  14 +-
 arch/x86/mm/mem_encrypt.c                     | 139 ++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c                 |  12 +-
 include/asm-generic/vmlinux.lds.h             |  19 ++-
 include/linux/percpu-defs.h                   |   7 +-
 14 files changed, 247 insertions(+), 51 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

