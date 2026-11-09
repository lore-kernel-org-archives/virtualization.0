Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794203274;
	b=Oco0E5c9oW8kEyWIn66jULxNMKMjv/2ARFYwqzhzBpk/o/9C5uJCU3Rh//zV9YlKcj/A
	 112A/6AYgIeCjAbxcU5its0tzYQ4FrEz9xukZpHEy5FF9z3nAVKo6AsxmsZkuEGTNHebq
	 lSGuekVIPR7vVGst9e7GHKpxorUGDuDDfJjIXoD5Jt7ZreV7x26vcEAwXjwAcR2Y2ZoxV
	 sOg6Z/GdY7I1MErRJFWAfSJWN+Twm/jJLkQFGkAVQVE03S6LifRI/0iz9W0U1AvAakRWm
	 yuUivqiJDjjsxRuoFtAGsjJASZAdhtfwb61RzGfAUeJCel7gGFnmp5lMKPdPsdkLViw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794203274;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=h/7KHZgrDOM2tA+GxXk56HAD/IPswfxy6WrliIOncNc=;
	b=V4to1VulEATmcrL0IAQnUKDvyJWbdO9nmuY5GYlVt9bhCcc2QB9FHQcUnuoBIdvoNnwn
	 5Kzpsy1TwI2xoF+F7OuUPz48xO8jBAKxhlM2iQPQjaAAsfUvihNjD0Z0abIByuyQCnCGU
	 G37hODDJQWnCNpqkcVBizncc7dDBk/MkOEqrNIG1+b15xDVuHiHzHzbP1nnTHeyWPs1Pe
	 oOtEB6yPISRnVYZrGKA28Z+oFhA250CwM8SfxzZja9TBPap/QWbJQPQo8Opum3ERlwzkE
	 w4ey5/p9qbAxDZBzpFS8VzNdWv6INNZrWQuouWNO6exFFdKkCViCBkM4rT5gmM5yr8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JsbJwMxp;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A8A606A323
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40A8A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=JsbJwMxp
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdd4dafdce9so151833a12.2
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794203274; x=1794808074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h/7KHZgrDOM2tA+GxXk56HAD/IPswfxy6WrliIOncNc=;
        b=aBD00SR+tPcphGoT48sUjdYvB2B49Nn93eMtGZPd7iJ5ih5qgAqPy0Q0pZrFj0GCe2
         8EVNJbFmDINsqHQ4Ct40zBOMtHLP5YPmQz6dxZYNrdtwkP/fBadwmK8cAIkaZBYn3jED
         zqsAUQsYt4QgwXPnb4N2WiTEucLzkh/AIZsYuiSv/Wus+EdEUBdlnAwv0chxASwlqgeh
         VDz074ENNgYRyqTUmT42Fe8Co2VEX0ClostCIijEi8p/Joeq+fTJ59IIV+cICqKQDbIf
         SdjHODUeJiah4N5oXobHrMgYZyFf9m1DgewuZ8XtUP7TBD2wac4+21CT7lfJjDNcZgmF
         ehaw==
X-Forwarded-Encrypted: i=1; AL+hErGSjUCwWi09UO04umLlX3m4tw4YHcB3UEE/U/uEdk0IRLGZPFMXm+VaUOwjkUDPr4qenhtoqRUbKQhFzf/Znw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/iDRg9CCY75BBCFUTYBRxpgGSwVeRu8RL9+d8vo09HnyNHcx5e
	ehIRakHLJ7+InjqWA/4x+c6ID5wvLWu5TrTPeAeSkbasrocZbkIi5KYpaNqOuTLeH3O01rf3ui3
	rdISbrYl513CM5cPPmlU10YAW4oFjVaQtiMS6+0PLq+ywUKvg/Ap1xL+xrmXjLpe/P7mDF8ozQV
	5hRa03jK4jwCeSSiJx4xlj25G+BnPQZg/CwtfrA7SaLYzUJrF0AX3fhHPBLmwxdo7sagJ8LJYy1
	/b4578ocH+V1uUpnfw=
X-Gm-Gg: AYBFou0XT6YMLgBI//kiNrXgSgT7cBDLLd81TRAjAlMceqVnlPKIgFxAy98dKDhA6FY
	J2H3KvUeIrqUyZToaRNr1PkcWsvKJyu9fwEtlis1TuWSSaNeBDN2AWLRIfJ6bKGE9O99xE3eNC2
	dsR2jELZfCcYtTfWPlI22lomUu+ctJY9e5kMTa+AeRKTG1phdhiMRT6g8EPAGVZ/z48GTHu4FgS
	AW16w8fQ9cxyjSmd71cXz1gizjhuuGlga3BDBCRMZjYPDH3WYL782gG9H0ZJAZxHoWHJHgarcJg
	CmvKJ569KjRgpJrl0A57voRxdPFI2MOPU93dgIY/vjR5C89tTx4o7tD+ScXEpQG3+M9ftbMjpyN
	OxtwAxvkw0ycDNZrwEGZ0B5hv5lR4HIt/lFnVIn+53ddP4nLHyDHO/x0wKZi3iCe4KYlekx/mca
	BLKsY56kUulozRETkBa3RBsnbRs7jS6bWa
X-Received: by 2002:a17:90b:3b84:b0:3ad:d4aa:8559 with SMTP id 98e67ed59e1d1-3b12d2cb981mr2664968a91.17.1794203273508;
        Sun, 08 Nov 2026 21:47:53 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1054a5e2esm5125557a91.0.2026.11.08.21.47.53
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2026 21:47:53 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a71dd190b0so2291847c88.1
        for <virtualization@lists.linux.dev>; Sun, 08 Nov 2026 21:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794203271; x=1794808071; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h/7KHZgrDOM2tA+GxXk56HAD/IPswfxy6WrliIOncNc=;
        b=JsbJwMxp4fT42HCHIbrYO4DxHA3Zbk/PQAvCSkmT1tvlJjAy+lswv19BVAkQXN3l7a
         x6w6oqHUUFah09S1jBvW3qs1kwC++7mXn4fH283kJj/AvxEpY5MP/wPBzrYY2zwIVJ90
         ThbohFQ58LentyI0ZfqRYyX54Ijmg9SawsZgY=
X-Forwarded-Encrypted: i=1; AL+hErGiV2flGLCJLSVeHGvS5zUztpnVPHhmaWoDjNiEXMuXnoiX0am8K+61ljmcPA8UVJinOkYgPUE0jJFpX7QYfQ==@lists.linux.dev
X-Received: by 2002:a05:7022:1407:b0:145:287:ce91 with SMTP id a92af1059eb24-1b39fe87be0mr5170877c88.14.1794203271462;
        Sun, 08 Nov 2026 21:47:51 -0800 (PST)
X-Received: by 2002:a05:7022:1407:b0:145:287:ce91 with SMTP id a92af1059eb24-1b39fe87be0mr5170811c88.14.1794203270668;
        Sun, 08 Nov 2026 21:47:50 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b37314626dsm13745136c88.1.2026.11.08.21.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:47:49 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>
Cc: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bo Gan <bo.gan@broadcom.com>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Maaz Mombasawala <maaz.mombasawala@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v3 0/4] panic, x86/vmware: Preserve crash logs before kdump
Date: Mon,  9 Nov 2026 00:47:36 -0500
Message-ID: <cover.1794201807.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series lets VMware guests copy the end of their kernel log to
the host's vmware.log when they crash, before entering kdump. This
preserves diagnostic information even if the guest cannot save its
own logs or the crash dump fails.

Using the existing panic notifier list for this would require
crash_kexec_post_notifiers=1, which also runs unrelated callbacks
before kdump. Following Petr's suggestion, v3 instead adds a separate
platform panic notifier list for callbacks that need to run early.
It runs before kdump and before stopping the other CPUs. It also
covers fatal oopses that enter kdump without going through panic().
The callbacks run at most once, and the list can be disabled for
debugging with disable_panic_notifiers_platform_list.
crash_kexec_post_notifiers, the existing panic notifiers and the
kmsg dumpers are unchanged.

The VMware log sender is the first user. It uses a preallocated
8 KiB buffer and limits both the transfer size and the number of
retries. Logging is enabled by default in ordinary guests; encrypted
guests must opt in through kernel.vmware_record_panic_msg. The copy
is best-effort: kdump and reboot do not depend on it succeeding.

The separate VMware guest-crash notification, which can cause the
host to terminate the VM, is a kmsg dumper registered late in boot,
so it runs after the built-in log dumpers. It is suppressed while a
crash kernel is loaded.

Changes since v2:
- Replace the pre-kdump list and postponement parameter with the
  platform list and a debugging switch to disable it.
- Run the list in vpanic() before the other CPUs are stopped,
  instead of just before the kmsg dumpers.
- Correct the sysctl documentation heading.
- Rebase onto v7.4-rc1.

Tested on x86-64 guests on VMware Workstation, ESXi (ordinary,
SEV-SNP and TDX) and QEMU/KVM.

Platform list proposal:
https://lore.kernel.org/r/ateYxCu63pRY9EGq@pathway.suse.cz

v2:
https://lore.kernel.org/r/cover.1790014793.git.zack.rusin@broadcom.com
v1:
https://lore.kernel.org/r/cover.1788414671.git.zack.rusin@broadcom.com

Zack Rusin (4):
  panic: Add a platform panic notifier list
  x86/vmware: Add a bounded panic log sender
  x86/vmware: Add the vmware_record_panic_msg sysctl
  x86/vmware: Report guest crashes after kmsg dumpers

 .../admin-guide/kernel-parameters.txt         |  12 +
 Documentation/admin-guide/sysctl/kernel.rst   |  20 ++
 arch/x86/include/asm/vmware.h                 |   2 +
 arch/x86/kernel/cpu/vmware.c                  | 250 ++++++++++++++++++
 include/linux/panic_notifier.h                |   3 +
 kernel/crash_core.c                           |   3 +
 kernel/panic.c                                |  50 ++++
 7 files changed, 340 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
