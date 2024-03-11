Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A04AEC0
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173860; cv=none; b=D3VrgKjfgM0cetPN9PSLIuamf0QAlbneui9hv7nIPRUSpWb05pE5J3VnlgNpb3krj/w5XArQBSBS/bBvIKpucPfWb3wlDb1u9lWds1M/aYYSZ7TY8OfMjIPYFi8rk2p6fRPO4DJZsOCIavLqhMykqhoTBqt19qRXjT/7/SzML5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173860; c=relaxed/simple;
	bh=dZ0oYtFBE/0c+pXjkBPcJJBxvUJ6uPY7Lm71TuKqwyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NsHPv7axLH250wHba+DfoHQLoGgtgzwZyLnooAltrbzzL9u2wVEEXgW6PMb1ICF10X2XDUIIxQQ/XcBBczkrfHCnYLN4ZrgBg83eHgqfVJgxg/jYxCcoPpWTQ4wt2V9AIR6cOSRrR2zv/y6c5UmWLjbgEGuiHKAI0shHjnVcAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrRVYYMa; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrRVYYMa"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70F7E60A39
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRhz5SGB11j3
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Mar 2024 16:17:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 07C4060909
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07C4060909
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QrRVYYMa
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 07C4060909
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 16:17:34 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4131b1f8c91so21100925e9.3
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Mar 2024 09:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173852; x=1710778652; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhgroYwDHirsSK6NEpHEOPOQNxUnb5y1s4Aku7Fobs0=;
        b=QrRVYYMa8zvxDIkMadjR0LqTcwRWJGVX2jasBGRaCVn5t3dQ2kSUjocFOIt9hkNV2A
         xHEZ4PEo+a5yVs7pCm7zR6RAP3hJV7Hqe4cQE2ku5ZXBenS7PMN4vVXUEpsJVaCZP46I
         MP0Q51eC32EehDAAfEi+XcM/MQ9ZQorENDtRAoWgN1vJPFxSs4xhJYCmT7tcbdk5XloM
         93vVmsYMyHIBIXu5Md5WITo6AY62yprXkkR5br0FKxwZZsE8HR2EXenr8vocZFrjxs5f
         xW+unRVXZKAg3YyBpNFjp1LlrX5uQtEiHGfmyZ1lPS9N5L4/ZCxLgHVLLODUwRIGET9I
         02cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173852; x=1710778652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhgroYwDHirsSK6NEpHEOPOQNxUnb5y1s4Aku7Fobs0=;
        b=he8NFShGe9TvcB7jI7LouiTml/jGkeic37EcrnplL1eu3K1tvA/6phoRXmHJMS994F
         s/0jtJihiBgNOuBguxNP+YXiYqsduLQFkzR9/QeBaxnWSBMIFCbgedHhzCQnxVy/O8VR
         fXYz77dSrND2lkJdaw+M+A5LRGZaReuxL/cmltrcLE8M9WyB98RfIdXxQ1S9nrkr46UG
         by7jTWCx8KTb9TunkE8ijsqEvaRTDjRNJeIICSAAgoJoRoR2ERf1qKXrDyz7KWs4lbN8
         fNECkNbUcVk9jb1PV1hRiBmmgx8zJpY5xyT79/QfWDGfhBU5ubGNy5A9Fyhb3T3k4/p2
         mXVg==
X-Forwarded-Encrypted: i=1; AJvYcCVMBFz1/bwv5853ac79syKQ7QUVJ8rGGRVzPqt2KzxpNGWPw1Bln375hDFEKLaF3I08B6qq4AaMkhPkWG6qJMw9Pe00WaWUk99uUULg83b0DA7DeBFUa1+XeA==
X-Gm-Message-State: AOJu0YxKU5S32mdul+m9UugikXXe6uvJyKqu3wVUe1JZwAjW4Oj9Rh0t
	hJaIDlVqAe06k7gln+3vQeTXDSW9sGQpumoQOifNDAAmVwCIhw5V
X-Google-Smtp-Source: AGHT+IFOXZkK2STurIgXVxbzpgve2av/2k7r2YA7lYoWxFHnDOWhnUJF1kkXWaz1HUNUDRTofP3laA==
X-Received: by 2002:a05:600c:5011:b0:413:2bcf:de2c with SMTP id n17-20020a05600c501100b004132bcfde2cmr1743625wmr.9.1710173852290;
        Mon, 11 Mar 2024 09:17:32 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:31 -0700 (PDT)
From: Vasant Karasulli <vsntk18@gmail.com>
To: x86@kernel.org
Cc: joro@8bytes.org,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v4 0/9] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Date: Mon, 11 Mar 2024 17:17:18 +0100
Message-Id: <20240311161727.14916-1-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasant Karasulli <vkarasulli@suse.de>

Hi,

here are changes to enable kexec/kdump in SEV-ES guests. The biggest
problem for supporting kexec/kdump under SEV-ES is to find a way to
hand the non-boot CPUs (APs) from one kernel to another.

Without SEV-ES the first kernel parks the CPUs in a HLT loop until
they get reset by the kexec'ed kernel via an INIT-SIPI-SIPI sequence.
For virtual machines the CPU reset is emulated by the hypervisor,
which sets the vCPU registers back to reset state.

This does not work under SEV-ES, because the hypervisor has no access
to the vCPU registers and can't make modifications to them. So an
SEV-ES guest needs to reset the vCPU itself and park it using the
AP-reset-hold protocol. Upon wakeup the guest needs to jump to
real-mode and to the reset-vector configured in the AP-Jump-Table.

The code to do this is the main part of this patch-set. It works by
placing code on the AP Jump-Table page itself to park the vCPU and for
jumping to the reset vector upon wakeup. The code on the AP Jump Table
runs in 16-bit protected mode with segment base set to the beginning
of the page. The AP Jump-Table is usually not within the first 1MB of
memory, so the code can't run in real-mode.

The AP Jump-Table is the best place to put the parking code, because
the memory is owned, but read-only by the firmware and writeable by
the OS. Only the first 4 bytes are used for the reset-vector, leaving
the rest of the page for code/data/stack to park a vCPU. The code
can't be in kernel memory because by the time the vCPU wakes up the
memory will be owned by the new kernel, which might have overwritten it
already.

The other patches add initial GHCB Version 2 protocol support, because
kexec/kdump need the MSR-based (without a GHCB) AP-reset-hold VMGEXIT,
which is a GHCB protocol version 2 feature.

The kexec'ed kernel is also entered via the decompressor and needs
MMIO support there, so this patch-set also adds MMIO #VC support to
the decompressor and support for handling CLFLUSH instructions.

Finally there is also code to disable kexec/kdump support at runtime
when the environment does not support it (e.g. no GHCB protocol
version 2 support or AP Jump Table over 4GB).

The diffstat looks big, but most of it is moving code for MMIO #VC
support around to make it available to the decompressor.

The previous version of this patch-set can be found here:

	https://lore.kernel.org/lkml/20220127101044.13803-1-joro@8bytes.org/

Please review.

Thanks,
   Vasant

Changes v3->v4:
        - Rebased to v6.8 kernel
	- Applied review comments by Sean Christopherson
	- Combined sev_es_setup_ap_jump_table() and sev_setup_ap_jump_table()
          into a single function which makes caching jump table address
          unnecessary
        - annotated struct sev_ap_jump_table_header with __packed attribute
	- added code to set up real mode data segment at boot time instead of
          hardcoding the value.

Changes v2->v3:

	- Rebased to v5.17-rc1
	- Applied most review comments by Boris
	- Use the name 'AP jump table' consistently
	- Make kexec-disabling for unsupported guests x86-specific
	- Cleanup and consolidate patches to detect GHCB v2 protocol
	  support

Joerg Roedel (9):
  x86/kexec/64: Disable kexec when SEV-ES is active
  x86/sev: Save and print negotiated GHCB protocol version
  x86/sev: Set GHCB data structure version
  x86/sev: Setup code to park APs in the AP Jump Table
  x86/sev: Park APs on AP Jump Table with GHCB protocol version 2
  x86/sev: Use AP Jump Table blob to stop CPU
  x86/sev: Add MMIO handling support to boot/compressed/ code
  x86/sev: Handle CLFLUSH MMIO events
  x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob

 arch/x86/boot/compressed/sev.c          |  45 +-
 arch/x86/include/asm/insn-eval.h        |   1 +
 arch/x86/include/asm/realmode.h         |   5 +
 arch/x86/include/asm/sev-ap-jumptable.h |  30 +
 arch/x86/include/asm/sev.h              |   7 +
 arch/x86/kernel/machine_kexec_64.c      |  12 +
 arch/x86/kernel/process.c               |   8 +
 arch/x86/kernel/sev-shared.c            | 234 +++++-
 arch/x86/kernel/sev.c                   | 372 +++++-----
 arch/x86/lib/insn-eval-shared.c         | 912 ++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c                | 911 +----------------------
 arch/x86/realmode/Makefile              |   9 +-
 arch/x86/realmode/rm/Makefile           |  11 +-
 arch/x86/realmode/rm/header.S           |   3 +
 arch/x86/realmode/rm/sev.S              |  85 +++
 arch/x86/realmode/rmpiggy.S             |   6 +
 arch/x86/realmode/sev/Makefile          |  33 +
 arch/x86/realmode/sev/ap_jump_table.S   | 131 ++++
 arch/x86/realmode/sev/ap_jump_table.lds |  24 +
 19 files changed, 1695 insertions(+), 1144 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-ap-jumptable.h
 create mode 100644 arch/x86/lib/insn-eval-shared.c
 create mode 100644 arch/x86/realmode/rm/sev.S
 create mode 100644 arch/x86/realmode/sev/Makefile
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.S
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.lds


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
--
2.34.1

