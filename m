Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456C2C69A
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562067; cv=none; b=u64zZWpWRPxfdTMJSW5GW9QH36wWxsqbpcESBZUIeNBoECyUcZP7NwUtMjv937QKjoyr3Mbqh674q4rAw925qbp6Rk/N5XVArY8U4bcvEOdthe13Mri0IPdkVE1yZ34vCUN1NL97zkw4J1GLRtpdGJneVUM5PseJo4hXF2ZAkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562067; c=relaxed/simple;
	bh=r8USykEiI0Lq4RkqNUjKL9QxW5JbTK3f11585hiRfLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cXldreBdMApKa19JlPWDI+PcXxyVe8dBIm69US6rZ0paMAns9MKqi+P+/6mwFMKTn8cvrfuwla418hHPMDp/S+LbgLh0mfWQ7ezV/BD2gYM/HS3mXZh13NnG3OqmfwriuYPGN8T52idYZSa+MSUfkG4GQXv8mCARgRrLdX0XwOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYtYtase; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYtYtase"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95BFC4072E
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.849
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e7tlSji7M51l for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Apr 2024 07:41:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com; envelope-from=vsntk18@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C249B40727
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C249B40727
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OYtYtase
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C249B40727
	for <virtualization@lists.linux-foundation.org>; Mon,  8 Apr 2024 07:41:03 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4168a5d75c4so836085e9.0
        for <virtualization@lists.linux-foundation.org>; Mon, 08 Apr 2024 00:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562061; x=1713166861; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmndQeC4PSRnWNm7AgzW2Pg/8QFXLvyF8S9fiEcAmmc=;
        b=OYtYtaseJH289Rs18EwoQPl6cirAzz7qcZGqEIKxSG/vGri27ROiwyrpTmb+PsLggd
         MfpL0eQ3tj9uXsDyj+GENt97fCvmRbfKzQl1m+jmZed6MjT8f1E+6xiGL4e4KoCZi35w
         AbR9UJq1uRDtewiZD4/p/3QR8ciyPocIqfJM/GcSmbAkJ4+uT6xlejxeyG/vM0rSKwv+
         oyk5xvQt6PjDopv83MHO6rWWW2XOUXUcpw7Yqc+KYbWLaOL66t390d1bceYbcDpGhyKW
         Zmuxb0eAlGprWoy4n/PO/8idtyzXZJrjuUKYlb3xQvwOXNshI0fZNcHAKCPBHV9N7WI1
         FN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562061; x=1713166861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmndQeC4PSRnWNm7AgzW2Pg/8QFXLvyF8S9fiEcAmmc=;
        b=Ergg4I80aJXz995mXxksxQS/t7mUcLnqsrzj7YqkoF1AEpQL5FL+rOuH5RXNAfHDmb
         3nVEhUk9iXNXUxu2RmKMk6YHQiRI4HGRb8BwcAqbkQS8lUhMvYPE1oGFamjxxUzIu64e
         EnlH4i2/+m2O7VR/LbsUpjOcKhosti5Y5BuarLGcchoc2tFv/CFUBmH+YngPPmgGEC6/
         iLr4cfd2UTZmng2oncrFcXhjOkAQBcUTgwkKIBojY60zBeqeNAWbLgbq/8Pp5XhLyTND
         8T3dk7ecf0azpEKRCOA2501x0hL+sp92Z0R8h5N0c33MrRrj13zJ+q2DklIeZR1sY0as
         bq+g==
X-Forwarded-Encrypted: i=1; AJvYcCUv/75tsGLc7BPo0+OSS9WbHyAKMMW1f7HNXxOoKl991R4tD06RKJVzWh8YRDa7cdJeKPpCu8fMbbY+vF3HsCbd3iimbg/FJou+UbgkIabJobJ0MwFCAffm6Q==
X-Gm-Message-State: AOJu0YzzQC2T9BnHXc2PNEXnCEXxVuk1iQLw4liA48BQH+4eJAxYmPMc
	Kt43AfcJLCNJhgP6CF28wNGFMzQ1ztMdS1mTg1QFVgoBn+kkpw/K
X-Google-Smtp-Source: AGHT+IGdz9RdrOljvpb36UmEtQIvLkiczH4oBTd6Tq0B5aLflz4xcAB37TEo1bC9FBjYmfIqlDbVYg==
X-Received: by 2002:a05:600c:3845:b0:416:64c0:5d26 with SMTP id s5-20020a05600c384500b0041664c05d26mr2976938wmr.12.1712562061291;
        Mon, 08 Apr 2024 00:41:01 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:00 -0700 (PDT)
From: vsntk18@gmail.com
To: x86@kernel.org
Cc: cfir@google.com,
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
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	vkarasulli@suse.de,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com
Subject: [PATCH v5 00/10] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Date: Mon,  8 Apr 2024 09:40:39 +0200
Message-Id: <20240408074049.7049-1-vsntk18@gmail.com>
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

	https://lore.kernel.org/kvm/20240311161727.14916-1-vsntk18@gmail.com/

Please review.

Thanks,
   Vasant

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


base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
--
2.34.1

