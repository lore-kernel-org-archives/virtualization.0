Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803F3D0AB
	for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f6NUO39H"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d32c5ce32eso1015925ad.0
        for <virtualization@lists.linux.dev>; Tue, 19 Dec 2023 13:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703023083; x=1703627883; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDzQhgIqDjX+fytpqITZ57HizgWrk/Gmzq6GoIsVzBc=;
        b=f6NUO39HRamVs7OS/lPBzmO4J35uwYflnSwEkrPNLEximYPbXiJ8n1Efy4dzeg7Jv1
         ISlxVFrwXhFjC7CRmS6KmatAQAd3SSIlMeI8cULFtZPTvkp6qi38B2V2JyJVOGjdPWId
         qO3k80XhopMAflPo782V4kjXgGRy8bKNbqP9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703023083; x=1703627883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDzQhgIqDjX+fytpqITZ57HizgWrk/Gmzq6GoIsVzBc=;
        b=L6bh/teknr4fxBUtffVJFXbBFH78k/KqVYzOXF38r2lM86ZOCGnELzMD+LnU9KqSw6
         9f8hh4kitp7WZTbP+ma8jSdVru1ESdr64w7fs3Xg3XCkpZQhmFsjwOk26gjrIzmRVSOY
         L+j/7EwQtxBQSwTEOvHoCt8DWLxIp6bfmTczT/OONvWLE/6QchCPhpF7G3X93YGFKgop
         9ALy5nMjSNKKMP6Z1NMyp0UFyRvGsUidbbte6bh1k03V1/MSXn+pTnvWCU7VFikggrpX
         bEUGqBuy1i+GVeJSBR7WOlRCvzTNWdxt8Wyp8zeaFi574lDXHFBCz31EBxhtuOyevAYQ
         e/ng==
X-Gm-Message-State: AOJu0YwABJQ4zBpRD8J4cBs7+S9rG8FWY9Gyq7OblSHa9g7aPovR9Rht
	yJnzrgwNYG73Nvt4BH74UQffUSiV1zh2
X-Google-Smtp-Source: AGHT+IFpkieRnYX2krB3iy+D6iZ6NtVOA9WZs25SYlO/ihVa0FtxrjypCE07V0g+ajh6EVSVdLwAvQ==
X-Received: by 2002:a17:903:1107:b0:1d3:bceb:ba62 with SMTP id n7-20020a170903110700b001d3bcebba62mr2007657plh.45.1703023083132;
        Tue, 19 Dec 2023 13:58:03 -0800 (PST)
Received: from amakhalov-build-vm.eng.vmware.com ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id v1-20020a170902e8c100b001d3aa7604c5sm5356476plg.0.2023.12.19.13.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:58:02 -0800 (PST)
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
Subject: [PATCH v3 0/6] VMware hypercalls enhancements
Date: Tue, 19 Dec 2023 13:57:45 -0800
Message-Id: <20231219215751.9445-1-alexey.makhalov@broadcom.com>
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

Alexey Makhalov (6):
  x86/vmware: Move common macros to vmware.h
  x86/vmware: Introduce vmware_hypercall API
  ptp/vmware: Use vmware_hypercall API
  input/vmmouse: Use vmware_hypercall API
  drm/vmwgfx: Use vmware_hypercall API
  x86/vmware: Add TDX hypercall support

 arch/x86/include/asm/vmware.h             | 338 ++++++++++++++++++++--
 arch/x86/kernel/cpu/vmware.c              | 116 +++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c       | 173 ++++-------
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_arm64.h | 197 +++++++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h   | 185 ------------
 drivers/input/mouse/vmmouse.c             |  76 ++---
 drivers/ptp/ptp_vmw.c                     |  12 +-
 7 files changed, 577 insertions(+), 520 deletions(-)

-- 
2.39.0

