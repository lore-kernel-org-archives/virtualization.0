Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD73630AC
	for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 22:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781475074; cv=none; b=KjqeEmYa2LbH2txKqblikgrsWNNT9U7MEu0ckJnV+JDSEfROD5BgYYF/gs/6Ufx0tI5KTHI7A8Psbqukxs9H+KR9+1BWnJm9AXZRQ0uCe3YMDjVnJx7WhkIhr6w+WFgXhL01sMal4i3DCqZZmc78n1CMiVaWbLAJK+5RACLYX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781475074; c=relaxed/simple;
	bh=hE/GwITzWqmR5j8vKUYu/blprB3J68CeQ2HJTSCWWqg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tb2/66E0VWJSCcl+YNY6yN4ArYoHhZ/sRnZkbCmuJUXw4tBMk6ueZX9isDPWY1XizVG1ATOQOJUbVgerg//rD3wj4x3TO5Pl65PHwUPDbvlzD6RglJ3zJLaSb857XasNt9hgs4cRlI2rxkx8drw5Z0ngeF28ZSv9880nE9Q5obU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiQvQRTW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiQvQRTW"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9157b895c57so254370085a.3
        for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 15:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781475072; x=1782079872; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R0fm5IGhbrTxjTMbe9Tb6/j2Qy3h+4JiFaVAf5b1n8g=;
        b=MiQvQRTWxbmeixYY7tDiFIaTuOHqZx9oBtAdGt9rq9x/8c3i1facaH9ooOriC1UcW2
         MRZYRN4+V6q+I24hk05xhB5qEFuj0FMRxbdVrW03to/EbPa+HS9BdRcNQWlakgXSjd8I
         VAaeEKadrpsP8MbzHp7U6T2Dv3z5gjTCkKhs/0sBx9MUckcNMVXcdOX5lTjYhJmjPelm
         qXi0Eo/pg0ANo6XIQIZ+WklsQFb44A37B/Y0NQbgxXZFU/A7dvTMo29VHrZoMnrN9qH1
         nLlBAbpCDH8PVQpf6LL9ji5dckVjSwOlnwkm/URi6gGwUTa3/kHRmNP7accYkpgYBjbV
         meQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781475072; x=1782079872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0fm5IGhbrTxjTMbe9Tb6/j2Qy3h+4JiFaVAf5b1n8g=;
        b=jN/AFYJn2GDRgKJQB1uVY6fW35pnzKahDdvylfkkcof/68+ZSq5iygboYwbGddcEwE
         lLhJtcQWjicQjxGkA7h+rSKzDsJ5XBdQmNjLvjAIjqpg4BsyZsm4HD4dQKPFBV0MVx8H
         5cdN6IJcqdikJgljsYG0BgGzrPbexnUk/liL3q+SVT0mIkKO5cGKrCSkqXTAc0szHGaA
         8VhieLgYJNEKqTpDpdN5ba0mc+Oh3t1T7Tiiit3EYYxJdohtMRVM41AwaSX3juQBytoa
         4DmzEwNh7mf0c9MizPzI1VEic3xmrF2BmGSRQzXuqAL/u5bCAIItvLZv1p+G0xFU71s7
         1liw==
X-Forwarded-Encrypted: i=1; AFNElJ+kOQhe4G+62Wez9d98B95l7ZdncezK7vOYLPL/Iz1DnQ/d+owH3R+5F/ejSIIAHhav9DwyQUHzlEd+I5KjCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbSSvXrStw11E1m1a5wf10flTh7Yx6j6s8DI9HZ7WUbIhBxYu0
	n7J4fSlaQJEGnMzT+CN1oYi7MSytk1G45NZmQ0yGAmnaSTFvsZ/8DKw/
X-Gm-Gg: Acq92OGzpIJlL7o9D7dBb6D4MoZOEPbpiUv7k+aAjg9qMQu1/K6XpesCZk8etFEc5Wp
	XPb5PpdSkVbTXoR8JWrAwoc+4urbGtUReIoJxziHtuC02cTr8SsLckfFjs/5Uz3AH3Sps+kTSYp
	Xj0x+GceoMguTtSxxwNBpue9WA1zvRSDxrSJ0EokKIC1cB+N/b4XykcRX/sA+j/KdD2c+obCYI2
	Uvn7NVBlEl+6bI7na/aV5NwDFkdzDcJLsJAkQ+nS7r6EnAd0z/fkgJJfdkeQ3uqUMptZmQ4YoR7
	p7SJIyCwBhpkXClkL5ZWqdt23YiFOIqCaWmpFKGpHumAAQDsckEohLBLBDJPz/gzY5PYczbrEhg
	1LMfgsg1Nz/ewI+XI1TwCHfpIfw8M4ibM88gc01VO6cTN6TzKBgqCjnjqd4Kv9e/3oF1ji0bRNN
	jELeXE8b+0p7fH47TvUlEifLkPcySGUoFty665hIndZXb8cfnEaRm9lr1XSPgIoNEBYL/rdQVTY
	g==
X-Received: by 2002:a05:620a:1b89:b0:915:96e4:e49a with SMTP id af79cd13be357-917ee4d9386mr1308363485a.1.1781475072427;
        Sun, 14 Jun 2026 15:11:12 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb91:14e1:4204:4d87:aacf:f5f1:c2dd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f06835sm896347285a.14.2026.06.14.15.11.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 15:11:12 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [BUG] KASAN: slab-use-after-free in mutex_lock from vduse
Date: Sun, 14 Jun 2026 18:11:10 -0400
Message-ID: <178144969601.60470.3373689816332131174@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in mutex_lock from vduse

I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/947d604f1b5d86d8b7a3c7a4000455ad

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  111.459938][ T8370] BUG: KASAN: slab-use-after-free in mutex_lock (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:4456 kernel/locking/mutex.c:161 kernel/locking/mutex.c:318)
[  111.460790][ T8370] Write of size 8 at addr ffff88811bb7a028 by task vduse_open_dest/8370
[  111.461901][ T8370]
[  111.462229][ T8370] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  111.462233][ T8370] Call Trace:
[  111.462238][ T8370]  <TASK>
[  111.462240][ T8370]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  111.462249][ T8370]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  111.462265][ T8370]  kasan_report (mm/kasan/report.c:595)
[  111.462285][ T8370]  kasan_check_range (mm/kasan/generic.c:? mm/kasan/generic.c:200)
[  111.462290][ T8370]  mutex_lock (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:4456 kernel/locking/mutex.c:161 kernel/locking/mutex.c:318)
[  111.462311][ T8370]  vduse_dev_open (drivers/vdpa/vdpa_user/vduse_dev.c:1663)
[  111.462327][ T8370]  chrdev_open (fs/char_dev.c:411)
[  111.462347][ T8370]  do_dentry_open (fs/open.c:947)
[  111.462356][ T8370]  vfs_open (fs/open.c:1079)
[  111.462361][ T8370]  path_openat (fs/namei.c:4699 fs/namei.c:4858)
[  111.462384][ T8370]  do_file_open (fs/namei.c:4887)
[  111.462436][ T8370]  do_sys_openat2 (fs/open.c:1364)
[  111.462462][ T8370]  __x64_sys_openat (fs/open.c:1370 fs/open.c:1386 fs/open.c:1381 fs/open.c:1381)
[  111.462479][ T8370]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  111.462486][ T8370]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  111.462492][ T8370] RIP: 0033:0x7facc56097e4
[  111.462497][ T8370] Code: 84 00 00 00 00 00 44 89 54 24 0c e8 36 f5 ff ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 f5 ff ff 8b 44
[  111.462502][ T8370] RSP: 002b:00007facc2418e70 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
[  111.462509][ T8370] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007facc56097e4
[  111.462512][ T8370] RDX: 0000000000080002 RSI: 00007ffe00ff5eb0 RDI: 00000000ffffff9c
[  111.462515][ T8370] RBP: 00007ffe00ff5eb0 R08: 0000000000000000 R09: 00007facc2419700
[  111.462518][ T8370] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000080002
[  111.462520][ T8370] R13: 00007ffe00ff5ccf R14: 00007facc2418fc0 R15: 0000000000802000
[  111.462526][ T8370]  </TASK>
[  111.462528][ T8370]
[  111.465710][ T8370] Freed by task 8361 on cpu 1 at 111.442076s:
[  111.465718][ T8370]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  111.467048][ T8370]  kasan_save_free_info (mm/kasan/generic.c:584)
[  111.467993][ T8370]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  111.469000][ T8370]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[  111.469887][ T8370]  vduse_ioctl (drivers/vdpa/vdpa_user/vduse_dev.c:1866 drivers/vdpa/vdpa_user/vduse_dev.c:1908 drivers/vdpa/vdpa_user/vduse_dev.c:2208)
[  111.470848][ T8370]  __se_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:597 fs/ioctl.c:583)
[  111.471775][ T8370]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  111.472940][ T8370]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  111.473875][ T8370]
[  111.475022][ T8370] The buggy address belongs to the object at ffff88811bb7a000
[  111.475022][ T8370]  which belongs to the cache kmalloc-512 of size 512
[  111.475948][ T8370] The buggy address is located 40 bytes inside of
[  111.475948][ T8370]  freed 512-byte region [ffff88811bb7a000, ffff88811bb7a200)
[  111.476936][ T8370]


Best,
Shuangpeng
