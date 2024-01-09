Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA79EA8
	for <virtualization@lists.linux.dev>; Tue,  9 Jan 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qb2+G5PT"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ce942efda5so1997485a12.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jan 2024 00:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704789661; x=1705394461; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wYpp3OYvmWsAtzJnbqql3qjVLEUjHL49vz1VsGi0Ho=;
        b=Qb2+G5PTu/ezAo+yjB30u5YPluC6s0OtomGjKE+4mO19MHxlE56tnedcn+jggJl7Sx
         0hfkayxRzT+SR7SK56NlQwt0OiDHMYJtrYjCTerSAX3iLzTWck+f1YEnh5W7EJSMmWIp
         HlqHyfU0GUGD7axpbpu5kI9vGNxFYglS09+7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704789661; x=1705394461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wYpp3OYvmWsAtzJnbqql3qjVLEUjHL49vz1VsGi0Ho=;
        b=VaaiZwlSuVqDcMfIGg0/ORw0jk8wTJExXhqVtOc7/qvDnWS/GJ0DVHnp6hHYMlr8OD
         xgbUCYmZ4yuIfY/anZwiQ0KsWwhftxpSKKdx9uM2u1Yui4OKJ0wi2GoD1bQiXBU8zttV
         4CDRi8nFwR5fXVoVIfvD7GKh3TbMN3XeoDS319KMx4Qlmqdlxiy7RKI0Pr//nVz58a4E
         f10IwYt1E9D2x5ZRh6euNdY3JBmk8DsrxAthYOKxXImeqbBHMW8H3yuZgKy+g5287SSU
         YdVyNzwgJwrXVnj20teu1nkQ+hBRHyTRhwYc7lgsSOqP8n0ZdBgVRfSiguTp+i3bfmHa
         FxPA==
X-Gm-Message-State: AOJu0YythVVQmA0VEx4ozSXIjtRGbq7pn8sOx8FiKnzXa2KzY4cjouJ9
	Q8D9NoKFvCJwCd8ovTHU6tuoF8wL0f1T
X-Google-Smtp-Source: AGHT+IGDNGili/eLI8MrSuIhgm8F/yz/d9X4r6v9ZFf88z3SxEXpihXxyC9q87KVaZRg+wy02GCoCA==
X-Received: by 2002:a05:6a20:1446:b0:199:c5b5:8f18 with SMTP id a6-20020a056a20144600b00199c5b58f18mr2129019pzi.14.1704789660801;
        Tue, 09 Jan 2024 00:41:00 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id sf15-20020a17090b51cf00b0028d435cc2cbsm4772293pjb.15.2024.01.09.00.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 00:41:00 -0800 (PST)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
X-Google-Original-From: Alexey Makhalov <amakhalov@vmware.com>
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
	namit@vmware.com,
	timothym@vmware.com,
	akaher@vmware.com,
	jsipek@vmware.com,
	dri-devel@lists.freedesktop.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	horms@kernel.org,
	kirill.shutemov@linux.intel.com
Subject: [PATCH v6 0/7] VMware hypercalls enhancements
Date: Tue,  9 Jan 2024 00:40:45 -0800
Message-Id: <20240109084052.58661-1-amakhalov@vmware.com>
X-Mailer: git-send-email 2.39.0
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

Alexey Makhalov (7):
  x86/vmware: Move common macros to vmware.h
  x86/vmware: Introduce VMware hypercall API
  ptp/vmware: Use VMware hypercall API
  input/vmmouse: Use VMware hypercall API
  drm/vmwgfx: Use VMware hypercall API
  x86/vmware: Undefine VMWARE_HYPERCALL
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 364 ++++++++++++++++++++--
 arch/x86/kernel/cpu/vmware.c              | 117 +++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 197 ++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 -----------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 599 insertions(+), 525 deletions(-)

-- 
2.39.0

