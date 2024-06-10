Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912577BAF4
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014888; cv=none; b=VVWYcM57fY+dY9Biu9YFHL73KWTqHsHu4JUOEKNTUp8e8GKDLQRbhfFIjZDPIiVgJCcnS9BwQqCkpki5XVCSNOVRo44+u91dbIJntIwidZvUkgHuh798k40u8XqcL3YcgmKjNjWjAdx7VLSbBlZ5IH27X1zH84RgLeY3j9FFqRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014888; c=relaxed/simple;
	bh=y4nHq92fBK7Hncw18w6FXPEZgY5S+YepShIVlJ1gXTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XDFWlXaYCKXHtK7HAa21gJQsEnQO5AGYG2bWLEZfjd59Z8tRYg+IHyCRb9nRO5Zymtwy0FWJkN1cdFU+gnhvOINhHC8YbpawwsPVpJgK7x/2qzY5xkPt0edCYb3yFtqsz/6Uw/H22fVkGveBSHWTRoeo1BiLi7XRW4pNDgdB7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Okmxtco8; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Okmxtco8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DA4E607D3
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqM7fhHJ9s76 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jun 2024 10:21:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B899E60667
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B899E60667
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Okmxtco8
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B899E60667
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 10:21:25 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a6f177b78dcso121915966b.1
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Jun 2024 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718014883; x=1718619683; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwHIHsN6FOqMaJ0QvL4YUcdXJqzusyELWmCpBOJ4s7U=;
        b=Okmxtco8ikwrTIiNWIS75JGX0lc9IvJpFMDB3JvznjJTIM2YkQM/hGXBe258dTkoNn
         gnT/07XxNV9ajZVB9lgMJF//kfZJK2p6vhpBopXMp7uwsoKAnzPJBtogDZ/qUGW2QTnH
         Fd50ogc5+tO42paHQo0ozlzqxZteA6pBD6k4J93fq4QyIW7fkcaJ0dTPmDuPHWndXGup
         rr1INNScS9a8OGth3ydIQvCz0K+uJpfPlhdOU5iHZY2Tu2pYqAgN72WHUHyfHPSh+Gne
         710fRSc7bes9fpodQjObCDhyfneqrhGnjY7E7mTXJxpyFk0ImY1NEssyi/TMF7gMKWGH
         /1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718014884; x=1718619684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwHIHsN6FOqMaJ0QvL4YUcdXJqzusyELWmCpBOJ4s7U=;
        b=IaJRLMjoa99XHBfodm/bmQIcHukV6nc3eiukLNAbo8yXc4HA/p60mhxLJLVVj+IfCR
         d+achXbzguBiyAm01YitMLh7MKd9gb933zwdlQIkAPYm+Qd/Z0bnYcQENkKnCEvmS/ho
         A7/cIPbPxTgQgO4f5zrnmwCMkBelkFFTbH69XkJbimBxWXLl1OWs8dnC+rXrTbja+ylz
         vT3llyQU2gmNR6ddZlY7k3B93gqUoltzq98vYLFI68c/e5mpzvEaO+Dto/DjJajJEpmR
         MhEmfJN21MPzJVS+3V0NRp2vOwppfGeKRGonMespnZDbtuO4Mfs1AzidRXdW/2fgjq0e
         R0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXVMkvPTm3/PUGgPOUwMl9tyhnTZOFk7/Pta0IxOSOWNoAR+eMP2NvabDqaUJawfhYigOGRsgtFdksoHKh5tcd+IKV1+g5mMl8vxB6Ty9CxQR3qcggDy8lGKA==
X-Gm-Message-State: AOJu0YwIhDG1+2GN1P7EL8QrT9e/dgO+J++hra83xX/iRabmW4ogVTu9
	8miqLkJs9tERj7iN92/kANTucOYlV+wVJKszJfXCpVVPnxEuqkxn
X-Google-Smtp-Source: AGHT+IHYtZnMWrJ0IkdZ+MyDgpngsD09lt7KGhzA4zeGHE5BqNwD2tXuke8ut6t0IoCcbB5ZC+9Wmg==
X-Received: by 2002:a17:906:f198:b0:a6f:e36:aba8 with SMTP id a640c23a62f3a-a6f0e36acd5mr316798066b.33.1718014883287;
        Mon, 10 Jun 2024 03:21:23 -0700 (PDT)
Received: from vasant-suse.fritz.box ([2001:9e8:ab68:af00:6f43:17ee:43bd:e0a9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0d7b35d5sm290887766b.192.2024.06.10.03.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 03:21:22 -0700 (PDT)
From: vsntk18@gmail.com
To: vsntk18@gmail.com
Cc: x86@kernel.org,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com,
	ashish.kalra@amd.com,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	michael.roth@amd.com,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de
Subject: [PATCH v6 00/10] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Date: Mon, 10 Jun 2024 12:21:03 +0200
Message-Id: <20240610102113.20969-1-vsntk18@gmail.com>
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

	https://lore.kernel.org/kvm/20240408074049.7049-1-vsntk18@gmail.com/

Please review.

Thanks,
   Vasant

Changes v5->v6:
        - Rebased to v6.10-rc3 kernel
   
Changes v4->v5:
        - Rebased to v6.9-rc2 kernel
	- Applied review comments by Tom Lendacky
	  - Exclude the AP jump table related code for SEV-SNP guests

Changes v3->v4:
        - Rebased to v6.8 kernel
	- Applied review comments by Sean Christopherson
	- Combined sev_es_setup_ap_jump_table() and sev_setup_ap_jump_table()
          into a single function which makes caching jump table address
          unnecessary
        - annotated struct sev_ap_jump_table_header with __packed attribute
	- added code to set up real mode data segment at boot time instead of
          hardcoding the value.

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

Vasant Karasulli (1):
  x86/sev: Exclude AP jump table related code for SEV-SNP guests

 arch/x86/boot/compressed/sev.c          |  45 +-
 arch/x86/include/asm/insn-eval.h        |   1 +
 arch/x86/include/asm/realmode.h         |   5 +
 arch/x86/include/asm/sev-ap-jumptable.h |  30 +
 arch/x86/include/asm/sev.h              |   7 +
 arch/x86/kernel/machine_kexec_64.c      |  12 +
 arch/x86/kernel/process.c               |   8 +
 arch/x86/kernel/sev-shared.c            | 234 +++++-
 arch/x86/kernel/sev.c                   | 376 +++++-----
 arch/x86/lib/insn-eval-shared.c         | 921 ++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c                | 911 +----------------------
 arch/x86/realmode/Makefile              |   9 +-
 arch/x86/realmode/init.c                |   5 +-
 arch/x86/realmode/rm/Makefile           |  11 +-
 arch/x86/realmode/rm/header.S           |   3 +
 arch/x86/realmode/rm/sev.S              |  85 +++
 arch/x86/realmode/rmpiggy.S             |   6 +
 arch/x86/realmode/sev/Makefile          |  33 +
 arch/x86/realmode/sev/ap_jump_table.S   | 131 ++++
 arch/x86/realmode/sev/ap_jump_table.lds |  24 +
 20 files changed, 1711 insertions(+), 1146 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-ap-jumptable.h
 create mode 100644 arch/x86/lib/insn-eval-shared.c
 create mode 100644 arch/x86/realmode/rm/sev.S
 create mode 100644 arch/x86/realmode/sev/Makefile
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.S
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.lds


base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.34.1

