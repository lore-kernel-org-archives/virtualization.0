Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93D15B57D
	for <virtualization@lists.linux.dev>; Mon,  6 May 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715032416; cv=none; b=VDQ/sOXLrliclSBFnKIalBf7VQFGCPj9NJy5+xP9zUzP2YWX12H8YG4ePd2JC+O2p3YLE/zguFcNO/+XN4GanpqEBb5q8IzPCkPV0O8f9oc9H8iS2gt1gVuL+ZlZBvNPW9QgaN49IR4CL/guuLGQU5TvZX1q+bUG8yh/v4kNUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715032416; c=relaxed/simple;
	bh=2O+wP4vBQozHsluR1vc78YidgtjsHnoZsO3a7SO9cjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2VFOtLZZ5+MIFQpcxhTVH7ITRtLaX7jyi0vz0GEHirf6wYeY26U0dNkQ2I5sV5MOrggID9judijtqzO8wPgTpU3AHvYXyhZF+VpmQb49FqWNOnumDHFDWnwFgTTHgdEhHnM6UhfLw5vtPAZJw+jGMOEq4YeOaYfOS1R91wxHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CKothR3Z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CKothR3Z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso16753025ad.0
        for <virtualization@lists.linux.dev>; Mon, 06 May 2024 14:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715032414; x=1715637214; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYUTFxlPB4t5BYAahm504Iew6H7+QkCuTotTXWPeyzI=;
        b=CKothR3ZTQ2fFtmFpRBVeBMdjKARUqdt0sIY8ZOukbZCN7qvA7SmxMSiJWlyr8pXh0
         fiBnhCcexnq6eHcnvtLOKZf+78smhPiRU0FRpzckjPVnSc4Q22SvaOdmUDr4c2356OMD
         J6/O74tno7g7yoB3bXlx2lJoIgK47HTvr0UQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715032414; x=1715637214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYUTFxlPB4t5BYAahm504Iew6H7+QkCuTotTXWPeyzI=;
        b=IKUEudeY5bzir1jc5QykhO/eOvXGqphBmVMUfhzOJZ5Usa8nNuyHkHlzrgUTmw7/kM
         S3rthb7R1I6Agk4TCUrtwEhrpMojt823uv39L/Wfxf7dk+ZGqjWUbr+36dG8rNvd+BaV
         sz+mbZX2ioW1GjOJn5yNuv0TyVwS40x1QmyKCwBbOX90wQTrrw9usu8NyIcVyliq/yki
         PAuujoIkKkj+osgTUCfZTd/H0y/bXxz+5HHkokSpOV+pgvRa5Iz+gWqK3tPabOwKWYLw
         ToXfqguqFT/uvrxYBV5HVFxfCRmD5/0ee6KPtHWBCddVF4aGCuwZazaiGKgMIVMnEYv3
         K0vw==
X-Forwarded-Encrypted: i=1; AJvYcCUGrhCzo1FGm0cQQ/5cD1P0IfzNG8GMrxccIKckXik4U7UthXwPiJbo1ULYyWIJbQPIaxTQVXEecNRxQKMkWwSpkqzRbz4iOPSIDrr2XJ0=
X-Gm-Message-State: AOJu0Yxhq6M+8dReKBg6E2aLfoGbhOA/MLoSpoTS+FJg9+hwGBNa9YSl
	3iJ6N1Rh34p4igG+Xl0ofwMy6rSy8GXepY4vk4t08hCEuEjz8d8Dp/xkGti/Mg==
X-Google-Smtp-Source: AGHT+IHL5cRDZJngyMmvBrgy59n1mJBgkULgJqoOpSace5UDEB2m1G8X4xIxLf9cVYD04RkFRqN71A==
X-Received: by 2002:a17:902:6bcc:b0:1e4:200e:9c2b with SMTP id m12-20020a1709026bcc00b001e4200e9c2bmr10847177plt.21.1715032414110;
        Mon, 06 May 2024 14:53:34 -0700 (PDT)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902f54800b001ed6868e257sm5664008plf.123.2024.05.06.14.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:53:33 -0700 (PDT)
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
Subject: [PATCH v9 0/8] VMware hypercalls enhancements
Date: Mon,  6 May 2024 14:52:57 -0700
Message-Id: <20240506215305.30756-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
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

Second patch introduces the vmware_hypercall low and high bandwidth
families of functions, with little enhancements there.
Sixth patch adds tdx hypercall support

arm64 implementation of vmware_hypercalls is in drivers/gpu/drm/
vmwgfx/vmwgfx_msg_arm64.h and going to be moved to arch/arm64 with
a separate patchset with the introduction of VMware Linux guest
support for arm64.

No functional changes in drivers/input/mouse/vmmouse.c and
drivers/ptp/ptp_vmw.c

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
  x86/vmware: Move common macros to vmware.h
  x86/vmware: Correct macro names
  x86/vmware: Introduce VMware hypercall API
  ptp/vmware: Use VMware hypercall API
  input/vmmouse: Use VMware hypercall API
  drm/vmwgfx: Use VMware hypercall API
  x86/vmware: Undefine VMWARE_HYPERCALL
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 331 +++++++++++++++++++---
 arch/x86/kernel/cpu/vmware.c              | 144 +++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 197 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 593 insertions(+), 525 deletions(-)

-- 
2.39.0

