Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93F37CD4E
	for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781476185; cv=none; b=IaPqR+UE/SwPThbVnMoaeN+Fy42uW+CPAfAh0FTRH7MZtWL/EtFXYO8etcGHVaz3232b0Nt286JX/bvx0LTN0Ey8oD4TCe1Dlr11arf3wNWJUIVQ6SRJmOgsumlUtLQPayWLhjR3Ltet7CDjlQTWd8ha2xLg9ZDeKPdeID3cXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781476185; c=relaxed/simple;
	bh=1X8oReMlgCFpc10ZxuJOlvI9jtlcFcF0JFPRF2hNY3c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=opdzHm7j3N1wu0JNntLp3NWrdIiikV6h3R6jSe7Px4lwfSsokOa+39wo5nU7b8dx/tvSb/vQI80GFfmn+UnN8qR9Dc7bp7DpFlzLSNu8fEwKmPhWkAY94pmf5BFY4V/cpFYlPgQzwn2WRn4c0bOKmSb1CumsvhOObPGV+k5qDNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdopymVo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdopymVo"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9159951f05aso307352085a.0
        for <virtualization@lists.linux.dev>; Sun, 14 Jun 2026 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781476183; x=1782080983; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zueV11R9evRPUpG6iN/1EBB+3nROiQ9IaTuxXrBXKyY=;
        b=LdopymVo0ESOXLIA2Pg9G//OhCHFtLwMbPE5P13kiOu8uX1s2PQdRsdOx1pu5uibYu
         ESK//9f53J5cSB6HGYE3ytJDXNIdjo6LLc4t4HlFwlTntBnI/7nhrf5ES2wUM/gw+yVy
         vhYjJzmPnhV0zHua6XaT4m+ITqFXdtvLJTqvn6gyBtGQIkN7G2ZF61QFZ7HyLRCvIAdK
         DK1+5u9779eKEX7u/PWeflDO7K0B4H94VjAdLf9pYIdo96LvyCWdYnkK9YvvGx8ZHNSl
         jBI0nVovdHqmm33U8Al6sflDJ8tVLVSCQ92WVkjyLrjgn6A+vG0kRVFs1yorUOXNBQeP
         qczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781476183; x=1782080983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zueV11R9evRPUpG6iN/1EBB+3nROiQ9IaTuxXrBXKyY=;
        b=SvfzVK4wOODlyGBnML8PBhsdqiy8pDRzP+UUQrZD2qdVVYk2fWPki9wBxd1LirlR3k
         52I18zyC4ouWhg/2XZr246kOdaMmE5g9TYRVHee1jsPtJLUTgjBzOvyOtoJZ24to+wnM
         mt+Tw2UHoJWmWnlNkR0528O0woYnfsnD8093VqyjZEbdRfD88s/Bm6sVN3RZJkZl1lJA
         PGIW11j2+2Bjb/w5OAMW6CI8hcwLZJhdqSY9BxjujHd05bh1mAytxEquM/GX3HPdu6xh
         KsnoIbH8pCSW7vtk633SSMvMEeyfT/bsvTfOOvsDXfPOKYMO96Yxr5XoY9DOxGmQnwZ0
         FD/g==
X-Forwarded-Encrypted: i=1; AFNElJ+Qzte3HRDOBDTjKxz3oJVcK5vtV+334e42LmGvFBAg+vsSTA+hglpTmLTTo61SRKalUKExz2Fxnaq1asvCVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzabIFMAiP7gk/MnQx9mY+O5LnJBIRrIvESDdxT4JXYdCGEMLSU
	QGX7HmQj1JStBpsix/f9vPYJj/3T3l8buo8GHJQb6FuCEHydZgTXifUU
X-Gm-Gg: Acq92OFhBdrf64uzkKRYX39TmRKhywiWpbDgY6Uog4tRvrRfMKDYQotvTnMEadCe/RO
	GWizBAIqt1/jatr6RFPcVegLK7w7IoAOa81sEn/bhNO4wNreQzNHYCPTMN81QUT9OK6jeN4VwPl
	N2+js63oJkL8QJqeivYqhel1zr4CM7dQh1wgeiushwIgpa8NszOPpvoiYaVvQlRlgqFd89/z0de
	SkdeFTJKwXVv4UYGVTMKQk5tuRL3mV1jy0L3OimcNU2RiJYL2H2V8tzBKO1mMS1vm44g/SYm40P
	KL3gJjJ1+Pqdle7CstjU9p5ec5Jq/xjvPLDFGZ+eysQAdEK/OhRCp/GazNeTSTgruAIobjXuDBu
	CeALxO1PLLfwRLoDAp2pgPvZdUOE5y+yzw7ACxa+Gyg7Y6THWhUCy7J+oVn6GIYQzyA/2f6jaLg
	Gm9Rg4cL2Wmea8E6xlG2JXqqGLOHSUupmFGekN/T+cCuPR2QZlKSSdVRYmHMmYANM3EN0PkqElG
	A==
X-Received: by 2002:a05:620a:198f:b0:915:a6ca:f12a with SMTP id af79cd13be357-9161bfa0f5dmr1931069485a.54.1781476182609;
        Sun, 14 Jun 2026 15:29:42 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb91:14e1:4204:4d87:aacf:f5f1:c2dd])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fd1sm901343785a.11.2026.06.14.15.29.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 15:29:42 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [BUG] KASAN: slab-use-after-free in port_fops_splice_write
Date: Sun, 14 Jun 2026 18:29:40 -0400
Message-ID: <178144969601.60470.8845755287570316901@gmail.com>
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

KASAN: slab-use-after-free in port_fops_splice_write

I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/d21a9a20a05cd840b99ea90101888879

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   78.120298][ T8329] BUG: KASAN: slab-use-after-free in port_fops_splice_write (drivers/char/virtio_console.c:922)
[   78.121417][ T8329] Read of size 8 at addr ffff8881158d7020 by task virtconsole_spl/8329
[   78.122247][ T8329]
[   78.122502][ T8329] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   78.122505][ T8329] Call Trace:
[   78.122508][ T8329]  <TASK>
[   78.122510][ T8329]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   78.123695][ T8329]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   78.123714][ T8329]  kasan_report (mm/kasan/report.c:595)
[   78.123722][ T8329]  port_fops_splice_write (drivers/char/virtio_console.c:922)
[   78.123754][ T8329]  do_splice (fs/splice.c:936 fs/splice.c:1349)
[   78.123773][ T8329]  __se_sys_splice (fs/splice.c:1431 fs/splice.c:1634 fs/splice.c:1616)
[   78.123782][ T8329]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   78.123795][ T8329]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   78.123799][ T8329] RIP: 0033:0x7f875ebb2f29
[   78.123805][ T8329] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
[   78.123808][ T8329] RSP: 002b:00007ffdd2abad88 EFLAGS: 00000206 ORIG_RAX: 0000000000000113
[   78.123815][ T8329] RAX: ffffffffffffffda RBX: 00007f875eabb6c0 RCX: 00007f875ebb2f29
[   78.123818][ T8329] RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000004
[   78.123819][ T8329] RBP: 00007ffdd2abbdb0 R08: 0000000000001000 R09: 0000000000000000
[   78.123822][ T8329] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
[   78.123823][ T8329] R13: 00007ffdd2abbdd7 R14: 0000000000000000 R15: 0000000000000000
[   78.123828][ T8329]  </TASK>
[   78.123830][ T8329]
[   78.144834][ T8329] Freed by task 8329 on cpu 1 at 78.116533s:
[   78.145445][ T8329]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   78.145926][ T8329]  kasan_save_free_info (mm/kasan/generic.c:584)
[   78.146445][ T8329]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   78.146936][ T8329]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[   78.147342][ T8329]  vp_del_vqs (drivers/virtio/virtio_pci_common.c:259 drivers/virtio/virtio_pci_common.c:285)
[   78.147779][ T8329]  remove_vqs (drivers/char/virtio_console.c:1895)
[   78.148226][ T8329]  virtcons_remove (drivers/char/virtio_console.c:1939)
[   78.148717][ T8329]  virtio_dev_remove (drivers/virtio/virtio.c:375)
[   78.149220][ T8329]  device_release_driver_internal (drivers/base/dd.c:619 drivers/base/dd.c:1352 drivers/base/dd.c:1375)
[   78.149821][ T8329]  unbind_store (drivers/base/bus.c:244)
[   78.150261][ T8329]  kernfs_fop_write_iter (fs/kernfs/file.c:352)
[   78.150762][ T8329]  vfs_write (fs/read_write.c:595 fs/read_write.c:688)
[   78.151167][ T8329]  ksys_write (fs/read_write.c:740)
[   78.151579][ T8329]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   78.152019][ T8329]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   78.152581][ T8329]
[   78.152811][ T8329] The buggy address belongs to the object at ffff8881158d7000
[   78.152811][ T8329]  which belongs to the cache kmalloc-256 of size 256
[   78.154115][ T8329] The buggy address is located 32 bytes inside of
[   78.154115][ T8329]  freed 256-byte region [ffff8881158d7000, ffff8881158d7100)
[   78.155397][ T8329]


Best,
Shuangpeng
