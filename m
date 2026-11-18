Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981720;
	b=BLB4aziTswr5ofT+K5PzIiPjJx9iQZ43rzR0bmrBDDHx15MuWgQuXKDYouJk/kNVJLnu
	 E/uZ55yZJ3/Y/gbUHPkwiFwOUxp2s/bU0W0WBN8LVAXNxZZtGFIkUgLGfAmIWTkK1hM2n
	 WR+gpOlKXi9SqLva0/BAUnrm5uJ6Nxsy9eJqWCM1887TYGwgg1aK7Tfhgb4HqRhYlg6UE
	 KVtMigkb2fIeoqBVTjJ5VlNToW1RXTzIHWjrNd5L3qraqE9IKCENabZQBffWMlaS2osVs
	 C4D+tPzQddAHEFEX4G/D4KIHnoIsUWoxps1j9MwFtaVKWXKqYQj+dUkMUBDoejoqYDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981720;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=AxEJOEfcnyLje8ZmMvx2AZyT7iZftuKYAFChF/A8Hek=;
	b=peFceIFptIvV5JNyAz1EVRLaLOav7xXt2jF7mKtjZRN3dUV6otu67ueOmhEKSt4/iR4+
	 CIuabCTTavKdcwwsFt/kINtqh7U1WVnnVIfhKfH9y+0mMM3zjz0KKe2fOMo0s7/bRpLKa
	 MuP1xp41gp5ItOqswyAuJZefLPXtcMgv89PTlqzMge87o/eMbQMQ9ZtNoT4w37q3cX5sX
	 cpZwss5+VTNnTptZ+hTrRHZ3JY24/egSowX6FQRPdtnkRbRuwJtaUoLbCi/OHVsY0BO8A
	 NgtpYZdLdahIhC/La/Naw3Qr5yMQN+ApDK2pLdD8h3PjvG1GIfx8UlykqCs9HpyKfZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="ci/9ZE/8";
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891EE606A31C
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 06:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 891EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=ci/9ZE/8
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cddc597d062so378751a12.3
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794981719; x=1795586519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AxEJOEfcnyLje8ZmMvx2AZyT7iZftuKYAFChF/A8Hek=;
        b=WynsDdBhJhPQXdNZqOmmmXdjFY8myiLfM480zOa/JmXE211CJwxeawrnYKMKY/uvMj
         aJXP5kiT4x25G25lC9q/WruwYwyvViDJPLK41Cfic9EJHLAM02/uZNtZiAeKmvmP/x9S
         lFBc2SY8e3BftWNANtCEMm9CPgU343pvjSfSwscrba1d1M57kbl1EyUye2l+QGZJDS06
         qd5jilogWA8/0QKD/4EBK59DbZYT1aWuiiMbdphJcqdkUwvtM6SEAIknO8iVapHoQOuu
         dZDGsKTcY8XCOOTt/BZ3wjzEnZbbcRtd+8j3Yo6WdJ073oKsjksZJtlAVtKcFOirjPIs
         gt4g==
X-Forwarded-Encrypted: i=1; AL+hErHhn67PGK7xQ5p0A2VaH2hdZfmGCIu9lozjb6mQDRXO9hkWHkCmAdI9qNIy574mxmikJ+paTSpd/sEV0Yph5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z9eqezI8ayjOyLvQlRUGYHjfUEQTznF9EcceEwCPsg2RsXX7ytG
	peMWDC0hUMjtgB2Cm5bisWFBwa2y+NTWjM6PYooxTqC5qb3FNN7nT+6e5/zoWpIuvZcWewzIj9F
	3m6YYTgOmp2rv12BwZltGkrdchaXk/QJzsU0Nh4zv/ZDEj+mFB+3DuHJRyyUQPVWt24NO2a9eh3
	/oCrIE5wFcc7Kjhj9/WPIaJ5N6O8v74ay5BBYzZfYGsKzZgE9X6PARCQvDSOcUACuPbQAO6pv9D
	8niwQDdQmY5T4ZAEpw=
X-Gm-Gg: AZFdTZdi/k3VtcT1J+FtO2K2ImTAQTFB81O/M5I9JVifgQ6QdpDhDAyUld9wrBollSF
	++kMIG1hdQ5tmwWlCmuF8BYcYpWcUKPJ0poJ/kUURks/Nx/34tv/RkrdF9tHanYe6Ovk7XInew0
	lHq2SgnYsKpUjiJf0GQYBpdEdbDR1GlOjw5IBmxoK5ZL/buhGPDHF7N1/espZ0W52l8eLg6bubD
	pD5ykBDSfgsBHr4yFDshK4u2owS78bAe6RMjoTcc65ugO2KFp0QHq18wsAswXm6fq49BO8H3/qY
	nuxZnLzpHHxjKCbRuAXerZqj/Jko3gT7juVXoa9BV9VuXWAUf36zk3q581F0tJ/j1TSZkfRxTsE
	pIf9h4yn4AaSisP+Nu4/LOhx65/58/HcLqjcbSHHkr/q5l4ELHx03OCQWY/npbveXyNyMPxuKJ5
	A+9k/YzCaIehVf9BgknAePifPJzEdcbILOqbA=
X-Received: by 2002:a17:90b:39a3:b0:3b0:d0c5:c10e with SMTP id 98e67ed59e1d1-3b3d07a2448mr1661745a91.17.1794981718514;
        Tue, 17 Nov 2026 22:01:58 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3abf029a5sm3554849a91.5.2026.11.17.22.01.57
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:01:58 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-54af6c38092so7715311cf.0
        for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 22:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794981717; x=1795586517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AxEJOEfcnyLje8ZmMvx2AZyT7iZftuKYAFChF/A8Hek=;
        b=ci/9ZE/8oUy0DnGALCTZx18M2qkIbySBizESJIfi3g0apXf5K34poXS71kcfmPea2v
         h+1k2mICI0s3t4DWoOGT9AuO6+rC2OrdTWyNNQMI1kHymfoyYsdKwpFQ3ki62lpoDScw
         yvhEEuLmy3k7PmLeiPe5sHfZzkcFR6q/jcros=
X-Forwarded-Encrypted: i=1; AL+hErHW0F36JRR/T+h9+I+GkOoI8t2+xk5+fKkDT/STV9vd62C8tko5u+qqDTjDJNZkaY5VOpUcdDm9VC/NqxF5YQ==@lists.linux.dev
X-Received: by 2002:ac8:6f0b:0:b0:54a:755d:6fcc with SMTP id d75a77b69052e-55d5a2c46b1mr26201511cf.4.1794981716703;
        Tue, 17 Nov 2026 22:01:56 -0800 (PST)
X-Received: by 2002:ac8:6f0b:0:b0:54a:755d:6fcc with SMTP id d75a77b69052e-55d5a2c46b1mr26201071cf.4.1794981716159;
        Tue, 17 Nov 2026 22:01:56 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d58ff0065sm14886841cf.5.2026.11.17.22.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:01:55 -0800 (PST)
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
Subject: [PATCH v4 0/4] panic, x86/vmware: Preserve crash logs before kdump
Date: Wed, 18 Nov 2026 01:01:47 -0500
Message-ID: <cover.1794980455.git.zack.rusin@broadcom.com>
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

Changes since v3:
- Call the platform list before taking the kexec lock in __crash_kexec(),
  so a callback that panics on a direct crash_kexec() can still enter
  kdump (reported by Sashiko).
- Rebase onto v7.4-rc3.

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

v3:
https://lore.kernel.org/r/cover.1794201807.git.zack.rusin@broadcom.com
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
 kernel/crash_core.c                           |   8 +
 kernel/panic.c                                |  51 ++++
 7 files changed, 346 insertions(+)


base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
