Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D14964E
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049315; cv=none; b=WoX8TAPcagc2lzgk9Y2sNxMZXr8Y83It2aSpn6oCQawnQLLIMFNAyfYgXYVce76H9O24vH56lcP4NIy9uLmT4YVfkjWno/DXeBzpgFGRbN39BWy4ktnVdM+81CejuMIaBIe6XrUCyX5Br7x4cj2H6vp4q47W6VpJV2mUbNSRYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049315; c=relaxed/simple;
	bh=K7emvDdPnxid5SAyFTESF/lQg364GGuWtvnljTHbOh4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=uKEQwfMexu3Vh7OR6SfmnuMWKzsqrMPay/NElsQzaWAb28ODr9Kgbsym7MBgScxOpkaO7ci8Ve52v0WFXORrSOl+6LUmN40cefZVm34tAqWncViIFF7lBCjB1F2v3vLhQtG7eXSZ5QcpkGv1JCVe228flq5vRzyVEQn/xPxbN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iHniarjS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iHniarjS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c97aceb6e4so64919a91.2
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720049313; x=1720654113; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwsbtQMOS4k6+Oss7Cpgl4Cpjs6vMsFQ0jCc9Uz8oAs=;
        b=iHniarjSNeBQAw1ut/Y+g/s2DILA3gFdMoXk9lvjPQHwgcOYwMnN9Rs8RLMJ19L8Tj
         g+pqGWq4jQ7cfb7hd9rmm/5xvZxiN9xBKTUl3q32KChgluC8ejKi+d8N16b1OE0QN1Rn
         Y2CeeQQzfmmSdE7OezQ7Qqu/TNptJmTlb6BoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720049313; x=1720654113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwsbtQMOS4k6+Oss7Cpgl4Cpjs6vMsFQ0jCc9Uz8oAs=;
        b=my0sKAhdAkGFATOemlAyXVqxx9BBMZXqgS14EghWtXgMnO6Aq6qtrkvk8DNkff5Wxw
         MnwozTaS41Ao4nxwFNc29G5Qxok7t+l4lEFrUsLM00T0T7in5fMxHa4TwuDeW/JPHYXd
         AEC181Xa+4VBhj6BtEv7MpXAnUQrrajj0CGdngoE2AgGwxlaWQP/LdoVi9M2TWjt6a7Y
         K78D76m85lmCLZbgxgYTpyHjowhPMLCPqc/BjWeu0ZiECFWF3NFGCiaFHBmIDDLA8CpL
         48z9v8LJ56ljsPscWOIVkaIcT1e4MFFt9asCg7jJvGr86jpaBR8i0E1X0NlyGPRyH1Ap
         j9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUcOY6OYj/nyFlq9W8PURxPVsOF+5buRRUdAyqcWihMWxQ6Ew3616PluVk+gbN/N9jEZbn0gVwkFp457a5SUsXj2kdjb9Prk5zFwrxycNc=
X-Gm-Message-State: AOJu0YxO9M4yY6wYBDVTu/QeQXB8gVbjFNlThcj7fpLxIXvji2LSACQI
	29k8ewM59krheIAKo1RlxxPnCfkloxxt/bk/eNCZpZLswcHI70xC+2Z1S+tToQ==
X-Google-Smtp-Source: AGHT+IFDXbgaXSaqqMX6UdrgdU2QN/tX+qwOwKdsBmygBlfpugT7eTTkgzvnHrtjv7YtX8LnCJTHNQ==
X-Received: by 2002:a17:90a:d142:b0:2c8:431e:4105 with SMTP id 98e67ed59e1d1-2c93d7215c1mr11055885a91.26.1720049313293;
        Wed, 03 Jul 2024 16:28:33 -0700 (PDT)
Received: from ubuntu.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a946fb2sm83793a91.3.2024.07.03.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 16:28:33 -0700 (PDT)
From: Tim Merrifield <tim.merrifield@broadcom.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>,
	Tim Merrifield <tim.merrifield@broadcom.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kai Huang <kai.huang@intel.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <kees@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev,
	alex.james@broadcom.com,
	doug.covelli@broadcom.com,
	jeffrey.sheldon@broadcom.com
Subject: [PATCH 0/2] Support userspace hypercalls for TDX
Date: Wed,  3 Jul 2024 23:35:59 +0000
Message-Id: <cover.1720046911.git.tim.merrifield@broadcom.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMCALL and VMMCALL instructions are used by x86 guests to request services
from the host VMM. Both VMCALL and VMMCALL are not restricted to CPL 0.
This allows userspace software like open-vm-tools to communicate directly
with the VMM.

In the context of confidential VMs, direct communication with the host may
violate the security model. Existing binaries that make use of hypercalls
and are not hardened against malicious hypervisors can become a possible
attack surface. For this reason, user-level VMCALLs are not currently
forwarded to the host on TDX VMs. This breaks any user-level software that
use these instructions.

But if user-level software is aware of the risks and has been hardened to
address any known violations of the security model, then it seems
reasonable to allow hypercalls from this process to proceed.

This patchset introduces a new x86 process control flag to address this
concern. By setting the TIF_COCO_USER_HCALL thread information flag, the
process opts in to user-level hypercalls. When TDX is enabled, the VMCALL
will #VE and control will be transferred to a hypervisor-specific
hypercall handler (similar to how things work today for SEV with
sev_es_hcall_prepare/sev_es_hcall_finish). The flag has no effect on
non-TDX VMs. Other confidential computing technologies could use this flag
to provide limited access to user-level hypercalls.

Tim Merrifield (2):
  x86/tdx: Add prctl to allow userlevel TDX hypercalls
  x86/vmware: VMware support for TDX userspace hypercalls

 arch/x86/coco/tdx/tdx.c            | 18 +++++++++++
 arch/x86/include/asm/thread_info.h |  2 ++
 arch/x86/include/asm/x86_init.h    |  1 +
 arch/x86/include/uapi/asm/prctl.h  |  3 ++
 arch/x86/kernel/cpu/vmware.c       | 51 +++++++++++++++++++++++-------
 arch/x86/kernel/process.c          | 20 ++++++++++++
 6 files changed, 84 insertions(+), 11 deletions(-)

-- 
2.40.1

