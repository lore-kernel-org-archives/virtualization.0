Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE31F4E4C30
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618163; cv=none; b=L+XbFv3uZiWW5gWiUqukBe1xA7datg4flbZmTjnTZitEO8+eCWNrIZGYKGnsXq4tvx+3/xLSIsuzfsEJtQJgMXN3x6PiOgJdIjRhIsnU3FdEEs+ZmjidxX0E/s/Lf5E6m+uGk6gqYABlTlHI1WXJl+lQUaGLhnt4+KxZom8UrmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618163; c=relaxed/simple;
	bh=qHuvSTbzKTQ99mPQxhPgubTCtOl/pceEwTRUqIC9LiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nk0ZDRHMU9bq/MoukI2cFvFlNFFmEwpSKz+G9rrozD4HlE9Toqo7kIQWJz6PAodH8KbHhBcU+WQBVhcDoNx9iu87QwU2Z5P4EzzEJAc5tmczRG97qH5jA9Lq0MLvOEZ3n0NoFN8h6ZiV0F9oigYhR53T9Yl2ps2HBNz950uXWWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dNJgy69p; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dNJgy69p"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-86aecf49833so55158b3a.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618161; x=1791222961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KmmJxySPwG38CbqK+KUDBFApZhpWarF4JpRDp51PqIc=;
        b=sj9QP5fuMKLJZsExhBGs/Qap13vD0ZYvkJY5S/pVKO2X1XgqPxAR6fzQs0BhtGZ++r
         V2dreAQ0qVktv9e4Xiura/LynLBCRnQ8JUm8M6LVv+3nANxFR6+h+YQv2bucMcI5zXOV
         +TPcEqUo2JJvobvtEspsQrnp7UffmpiCGr6l9/GUYAC32JW3HjZzvKBZgX8uU73oHnLj
         pr5GBqInFrtuoN4ziJ021fdDLYQQ8OQAW91d2t7pScTO0IhcI09r262JQOOJc7U11TwT
         e8bAu6jS5nvjmTq+qu4UXWoIYJo95sJH0lVNKMiU0HalQw6vySH2aKgeuMMAa78YZFjT
         +92Q==
X-Forwarded-Encrypted: i=1; AKwUvBySabR+B4s6vk3mwZeXVMRuVbG7xt0+zqCCE9Lv4NHPc99j5B1EiSPeKhaEjxgTcM3BEhIqjppVM4hFVozejA==@lists.linux.dev
X-Gm-Message-State: AFuF++nT1UYKcpZaVrKEyuAt3/G24ys08roUMAqHLWpaLOdagoNj/tVF
	K1pg0P54+EkP3vuoySjZB5dGrynsXt7YxeQe+k9t2PwafTDz/wN5TjoH8zpn15je09bEcKOBGX6
	jcdpEqemXR0UyEOAUTbYMbKHdLPJ8FnLgRoxOrKY/qvXv4WzYAaFRbebYvTIt8rxZD3psHfZvjo
	JwS83dct2UzAYgC6Gp4k9B/pfrCQ3Ql3yHf/pQO7PQ1I1JwgVuRtFGvEtoBEWjbaLKHikP/s6e1
	zWPrI6Lrpxit60cRXw=
X-Gm-Gg: AYBFou0cT3SfxEgOjXtg7ZkdJxSAFGtBQXnLCR8agbVkxB52yP2zOCUaB+PKrWwqILa
	rILDZAEj84wPnSa5iJ5oBSgkJaOLx8ac/dAJ/UMTbmpyucon9SmDa7ZR3S8xG4t2huMmjKqRAPa
	mk0DRNgoGOd7okqLslEH++dM/JKcgnzXwZ7G1cmklh7xvIu1Du0MuL3tOQT+GqFaPgPx4tFnjKl
	1M3UCFLkpB7E5Lq9UATdFFkmAYR66ZV+aPpFOygTeVJjE4HhTC2jREbZl0vP1EbAg7AIwv40GbL
	Ll9EF+dVuNgwVwbMlXBZL44MkqL4Am/M9IlkeakfeX/MG8mfHreS1mpu27AyhgjqvwJWnmDV7+o
	z7mDiXb7V4tJsFK5C1xP7kMLr0T2jr0VfPt3cOVc6nCnr43TCDXRE/4x5ekUZxjXl3ZidnFpjaq
	SFaayItcQG1Dy37Ct0F/BLQdiMdhKubTrsdzw=
X-Received: by 2002:a05:6a00:37c6:b0:871:a6f5:693a with SMTP id d2e1a72fcca58-8856114326amr34913b3a.11.1790618160941;
        Mon, 28 Sep 2026 10:56:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-880c5a65432sm4799472b3a.5.2026.09.28.10.56.00
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:56:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3425098ae4bso139818eec.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 10:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790618159; x=1791222959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmmJxySPwG38CbqK+KUDBFApZhpWarF4JpRDp51PqIc=;
        b=dNJgy69pYSt6IL2or/q5RfjS9jRCq3rzTRLvJAEc+KwOG0BhmBu5rpBGnxcZhyTsks
         hpsCBzIfyZobDoyZ1iVVAsvsySc8hrFxh4qMEkFhS8If5ohaeZOdzh1fssf3g0p3Ir58
         duACGJT1Z+wyUpvZ+CJxSXrg7yrZ9iysqF9FI=
X-Forwarded-Encrypted: i=1; AKwUvByojCWoJQ2VZwYUjUUpi39R3IANE8cq5Fq/+7B5Gjp4Fv94PhOoYEULQYyHcVGthzemcojP0UtM3MFxBHxhSw==@lists.linux.dev
X-Received: by 2002:a05:7022:ff49:b0:13c:e1e2:fc86 with SMTP id a92af1059eb24-14b2d993e47mr201604c88.4.1790618159204;
        Mon, 28 Sep 2026 10:55:59 -0700 (PDT)
X-Received: by 2002:a05:7022:ff49:b0:13c:e1e2:fc86 with SMTP id a92af1059eb24-14b2d993e47mr201547c88.4.1790618158548;
        Mon, 28 Sep 2026 10:55:58 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3421dbb2971sm26076069eec.10.2026.09.28.10.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:55:57 -0700 (PDT)
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
	Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH v2 0/6] panic, x86/vmware: Preserve crash logs before kdump
Date: Mon, 28 Sep 2026 13:55:34 -0400
Message-ID: <cover.1790014793.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

A VMware guest may have no persistent storage or working userspace after
a crash. Preserve its newest kernel log tail in the host's vmware.log
before entering kdump, without enabling every panic notifier by default.

Following Petr's suggestion, add one generic panic_pre_kdump_list with
VMware as its first client. A set-once helper covers panic() and direct
crash-kexec entry. Fatal oopses can reach kdump without calling panic(),
so patch 2 adds that call after capturing the original registers under
the existing kexec lock. The late panic call follows sys_info() and
precedes the kmsg dumpers.

Patch 3 adds Guilherme's suggested escape hatch for debugging kdump
failures involving early callbacks. With panic_pre_kdump_postpone set,
the list runs before kdump only when crash_kexec_post_notifiers is also
set. This can omit hypervisor crash handling as well as diagnostics.
The late panic call remains eligible. This policy is a separate patch;
I can omit patch 3 if it is not wanted.

The logger preallocates an 8 KiB buffer and bounds its register-based
RPC transfer and retries. Michael suggested increasing the buffer
because 4 KiB can omit useful stack-trace context. Ordinary guests
enable logging by default; encrypted guests must opt in. Use
bool/proc_dobool for the sysctl as Joel requested. The potentially
terminating REPORTGUESTCRASH event remains a separate late dumper,
suppressed whenever a crash image is loaded. The v1 assignment to
crash_kexec_post_notifiers is dropped.

Tested on VMware Workstation and ESXi with ordinary guests, and on
ESXi with SEV-SNP and TDX guests.

v1:
https://lore.kernel.org/r/cover.1788414671.git.zack.rusin@broadcom.com

Zack Rusin (6):
  panic: Add a notifier chain for pre-kdump callbacks
  crash: Notify pre-kdump callbacks before switching kernels
  panic: Allow postponing pre-kdump notifiers
  x86/vmware: Add a bounded pre-kdump log sender
  x86/vmware: Add the vmware_record_panic_msg sysctl
  x86/vmware: Report guest crashes after kmsg dumpers

 .../admin-guide/kernel-parameters.txt         |  14 +
 Documentation/admin-guide/sysctl/kernel.rst   |  20 ++
 arch/x86/include/asm/vmware.h                 |   2 +
 arch/x86/kernel/cpu/vmware.c                  | 250 ++++++++++++++++++
 include/linux/panic_notifier.h                |   4 +
 kernel/crash_core.c                           |   3 +
 kernel/panic.c                                |  28 ++
 7 files changed, 321 insertions(+)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
