Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593314D2B8
	for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306232; cv=none; b=IqoMXxqWs9VRGZLfDNUBvZr8cvq0ZZEgyNPQrwomEv7Z2zd9vjFj/xeol3vPkGkm7w34i9DEbWXpbVKd3anayrGaknBHIsGsr8S0pv5LQLMMWymSONRmfGc1QuvdA/ng6m9zwb/e4Hw8x+OOYcUuhOT9cgiEauRxfXm5+oIf0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306232; c=relaxed/simple;
	bh=CrA2LbZw2fj1oZQlxW6cbBwREuI1pwVFNKXdbbVw6aE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hiW+yzXqJvxzevGpuJZ3e0ufSEXwzal4DKeTSKyqq9QIUczPfuHFZWcNxH8n1vwwNkqpBY2rgfARG+s44JsDD4vXV5AI4rwD80lDmGlttqtDo3ThOC/MQ2V5DoORdGlctS5ZNgXjaCfczbhJdH/MFTS3e2mnwRrpcRdrxNsQJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fBqWjfVH; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fBqWjfVH"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b2a6e99be8so6851086d6.2
        for <virtualization@lists.linux.dev>; Thu, 13 Jun 2024 12:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718306230; x=1718911030; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqRZVCpbYo2jtcU4VLLPgUkKEV8z0zarA1K4gBzGSZs=;
        b=fBqWjfVHQF0gACVegWOzirAF9Uvo5ydPEdO06OP/33fod0kuwyj4EcnB3IV16SyOyG
         1LZjKXlUPCFyj3GnMjlafuwB7Z6tJurgIXRzbzKOAVm7Q5q5LE+0b0xT6xyrVEGhUSH6
         5USBygT9n4fQlUTPoIeiIdACZx0z1iLrDSPSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718306230; x=1718911030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqRZVCpbYo2jtcU4VLLPgUkKEV8z0zarA1K4gBzGSZs=;
        b=d90sKXVaKK2KV8VClfpx9xg+HKBkKK4Ce7muRYByfCC5PZrWN7M21Y4Hl2zksZGnnH
         t4+OSQ46Yb0kLRrKi1Cojlxug7w357KwOHpRjSZTf4bf1s+xdrrpBP5s1id2AWc32lrW
         SB5jTRBkeNMu8zQVD4n+0dcmQLjrqbO+ZiUqlurskDAhjAYVx47F1PIYlW+qMOsoJoXl
         nMys1rOq03Ocy1biqYyC53yGfc0vw5c9L8pHY8wAVGLvL4liC3Tp8HJpK+P7qTjzocgA
         wHvohL4zVv/kFcgEs1WloA37YgXJAmt/7pOtuB3Xj18TJX+C0Ii2FQHnEhnLt1OAJEKi
         1Ujw==
X-Forwarded-Encrypted: i=1; AJvYcCUKjsjEbWPXCg92CQDkhEw7uJ7YL3tNE9+wm1Acu4QRfESFyazsPh8/68yT3fqb0S9VDrJKFpF0U6DTu4HM3I51XwDfGGI+fVIi8zCZHjM=
X-Gm-Message-State: AOJu0YyxMNJcopLazc4LjIR/9JKGILrr1BDwrQ6jTwDsTAorSStxFGIA
	9JxVDlc06N8sbqN4POQvu+RgUxZg6pQRged4fO5LJcX3Qq+2bJHS1Fga9Tv6qg==
X-Google-Smtp-Source: AGHT+IFjEHPK4k0l7eyVsilK8yUQTNHgIqYDnv7SJ1An/1VqFCPEcRK7LH9vCsjmYZUTW3mQYOd55w==
X-Received: by 2002:a0c:f882:0:b0:6b0:839e:ba6b with SMTP id 6a1803df08f44-6b2afd5f040mr5356876d6.43.1718306229909;
        Thu, 13 Jun 2024 12:17:09 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb47f6sm9714106d6.82.2024.06.13.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 12:17:09 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	richardcochran@gmail.com,
	linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	zackr@vmware.com,
	linux-graphics-maintainer@vmware.com,
	pv-drivers@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>
Subject: [PATCH v11 0/8] VMware hypercalls enhancements
Date: Thu, 13 Jun 2024 12:16:42 -0700
Message-Id: <20240613191650.9913-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMware hypercalls invocations were all spread out across the kernel
implementing same ABI as in-place asm-inline. With encrypted memory
and confidential computing it became harder to maintain every changes
in these hypercall implementations.

Intention of this patchset is to introduce arch independent VMware
hypercall API layer other subsystems such as device drivers can call
to, while hiding architecture specific implementation behind.

First patch introduces the vmware_hypercall low and high bandwidth
families of functions, with little enhancements there. And the last
patch adds tdx hypercall support

arm64 implementation of vmware_hypercalls is in drivers/gpu/drm/
vmwgfx/vmwgfx_msg_arm64.h and going to be moved to arch/arm64 with
a separate patchset with the introduction of VMware Linux guest
support for arm64.

No functional changes in drivers/input/mouse/vmmouse.c and
drivers/ptp/ptp_vmw.c

v10->v11 changes:
- Redesign VMware hypercall asm inline. Move slow path to a separate function
  keeping asm inline alternative small a simple. Suggested by Borislav Petkov.
- Use existing _ASM_BP instead of introduction of VMW_BP_REG as was suggested
  by Uros Bizjak.
- Patch 6: add "Fixes" tag as was suggested by Markus Elfring. 

v9->v10 changes:
- Restructure the patchset as was suggested by Borislav Petkov to
  introduce vmware_hypercalls API first, then move callers to use this
  API, and then remove the old mechanism.  
- Reduce alternative portion of VMWARE_HYPERCALL by moving common code
  outside of alternative block. Suggested by Borislav Petkov.
- Use u32 instead of uint32_t in vmware_hypercall API and across vmware.c
  as was suggested by Simon Horman.
- Remove previous Reviewed-by and Acked-by.
- Fix typos in comments and commit descriptions.
- No major changes in patches 2,3,4,8 compare to v9.

v8->v9 change:
First patch "x86/vmware: Move common macros to vmware.h" was split on 2 pieces:
  "x86/vmware: Move common macros to vmware.h" - just code movement, and
  "x86/vmware: Correct macro names" - macro renaming.

v7->v8 no functional changes. Updated authors and reviewers emails to
@broadcom.com

v6->v7 changes (only in patch 7):
- Addressed comments from H. Peter Anvin:
  1. Removed vmware_tdx_hypercall_args(), moved args handling inside
     vmware_tdx_hypercall().
  2. Added pr_warn_once() for !hypervisor_is_type(X86_HYPER_VMWARE) case.
- Added ack by Dave Hansen.

v5->v6 change:
- Added ack by Kirill A. Shutemov in patch 7. 

v4->v5 changes:
  [patch 2]:
- Fixed the problem reported by Simon Horman where build fails after
  patch 2 application. Do not undefine VMWARE_HYPERCALL for now, and
  update vmwgfx, vmmouse and ptp_vmw code for new VMWARE_HYPERCALL macro.
- Introduce new patch 6 to undefine VMWARE_HYPERCALL, which is safe to do
  after patches 3 to 5.
- [patch 7 (former patch 6)]: Add missing r15 (CPL) initialization.

v3->v4 changes: (no functional changes in patches 1-5)
  [patch 2]:
- Added the comment with VMware hypercall ABI description.
  [patch 6]:
- vmware_tdx_hypercall_args remove in6/out6 arguments as excessive.
- vmware_tdx_hypercall return ULONG_MAX on error to mimic bad hypercall
  command error from the hypervisor.
- Replaced pr_warn by pr_warn_once as pointed by Kirill Shutemov.
- Fixed the warning reported by Intel's kernel test robot.
- Added the comment describing VMware TDX hypercall ABI.

v2->v3 changes: (no functional changes in patches 1-5)
- Improved commit message in patches 1, 2 and 5 as was suggested by
  Borislav Petkov.
- To address Dave Hansen's concern, patch 6 was reorganized to avoid
  exporting bare __tdx_hypercall and to make exported vmware_tdx_hypercall
  VMWare guest specific.

v1->v2 changes (no functional changes):
- Improved commit message in patches 2 and 5.
- Added Reviewed-by for all patches.
- Added Ack from Dmitry Torokhov in patch 4. No fixes regarding reported
  by Simon Horman gcc error in this patch.

Alexey Makhalov (8):
  x86/vmware: Introduce VMware hypercall API
  ptp/vmware: Use VMware hypercall API
  input/vmmouse: Use VMware hypercall API
  drm/vmwgfx: Use VMware hypercall API
  x86/vmware: Use VMware hypercall API
  x86/vmware: Correct macro names
  x86/vmware: Remove legacy VMWARE_HYPERCALL* macros
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 336 +++++++++++++++++++---
 arch/x86/kernel/cpu/vmware.c              | 212 ++++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 196 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 654 insertions(+), 536 deletions(-)

-- 
2.39.4

