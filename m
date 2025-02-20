Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C921DF735
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066530; cv=none; b=nQwB7nObOvcbm5YMSt0ezL6iuKHprjmA39TCYySBfbopXdssFUZbN/0UnKiJYWtKtX9nZSb/oJnmkkzNDP+PUGsAhRs9Mrhcv9PcFTON0+z7D1Vc+WWVuuvkw9fpPExCWW4AJWWPcg0Jm5sAZh8dbVKQECUuQDjecxc1kEtnJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066530; c=relaxed/simple;
	bh=53tauEdjLcf73B3pwYhNERVmOlwbsXNx9Ee8gIApv6k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Bh/G6HwX06iTBTbtxPrXWLYS7Gs0QzaRhpMTQ2t1l4sF9r612ukbMIa6GzW+f1CMJp/S6s+FRqJpxGb47EWdQvJsG6cagTm1hcg800b9c2sn5XoQbCJ4OOIKz6/TtCCUa3r03caOJpaOik21bjVH4K1N+EatJ67qEMvfZ/hrGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HoFHJGDP; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HoFHJGDP"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-520a473d2adso702366e0c.2
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740066527; x=1740671327; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0kNTVauSGc2zR4k8+pxUQLsX9rwcagptJ7nZmG2jxGM=;
        b=HoFHJGDP63brjnt5ak56hmyB5XTgserEOAX1yPRiyOBQ686IBEm+SF5RCpBiyohDxt
         hlkmzO8K0zSGbUtJB3sXiYgpgEJNnUWAaqtxmzlyyppnvE1UjWa3no7uPDZyxGc6gZ2K
         bbxoVACjdt9Hi/k4StbWTKtXlcaNAOM6bkSiNYDpn4yaLvHE6zFweJE14o+PsWh6wl+G
         xqN35AA0wtjjfDKLV1kxxOZ8k3ElmeCtvPpu45PxfWL/FAQHFD+FXcP/XnF5gbTHICRc
         /RScCwlwz/hnMUm9wbgrOoKFcf2xikZh67XFmlcBJpGzUlQaMyHqCl/+OKck725R92ma
         QsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066527; x=1740671327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kNTVauSGc2zR4k8+pxUQLsX9rwcagptJ7nZmG2jxGM=;
        b=WERvArZAVVwWLYnF4wE+DYQa0sr22VTtN1PKRNvTQDgo7V2L5C1uP2SNVweGGJEK65
         hGvKFJvuVZq3TfhRuwb1zOQJKUp4nfv9C0/vXSDlEYNUvKItgIG89CFRUBGc9DyKDOaV
         q/uP3cIEbTsMOv59kc+q9WO2FqTy114l8uoiRV1NOv0FchFXLtICuIiFNL3sotaC0Ty3
         XFW6PIP4/2/LOdBevofMIpSqsxAtifvHZuhMIEaLj+rximBGms9UTsdOwBsNGkBAdZyw
         ccrEyJOvou0ScT78/TR3WFAzJpHu8mvVF0XIvFscchBzQLui8x/hbT3gRxUzlhV4bFAe
         O0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfWi3K3Dn1mpV1L1fF2bmO8wr29zJ4srcYOnaJTxKTuYWci5XtzVssk1/aNsxguCEl6ryBnf8tUy71e/DeJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrcstUGREk5GrFADFUfQFyyUUa9cnyOPg31TqwIol+lZqQn6HW
	7gXkqt11/VDEYmrK0EKeXaZFfFWYY94hWn4Qjqr7HkTXLv33uVqK1zs/Rcb06Ze+ZnFNJP3lC9V
	7vKSj0Kt1ziePizanKjJAkEmN8ZwwZlZHAoKIxzKBMHm10y5Wers=
X-Gm-Gg: ASbGncuVtrlO2akcRrU83fcAulWszRPmCO0pO0CvougxYW9tPTkCZblWHN81t40I24y
	Ii8FvzkZVjTDXlYBm9LvuVgY7BL+1HgbTVI6H8r/3/sRu9SAT95MHqRQCJRnqEGKn0A48/heHOw
	ZJgbFOEUbf3oBvrmQ8JJM+SQan7AYjKw==
X-Google-Smtp-Source: AGHT+IEwmpxxEaiubcw0N4JOEqOJ14erBSMQ4JqoNyqcu3j1CWEwZqfNHODEoFMofSgcUK31Tr+rctyek8WT3I++Xz0=
X-Received: by 2002:a05:6122:1991:b0:520:5185:1c71 with SMTP id
 71dfb90a1353d-521c460d26amr5277317e0c.7.1740066527244; Thu, 20 Feb 2025
 07:48:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Feb 2025 21:18:35 +0530
X-Gm-Features: AWEUYZmPJR3wb3fOQX3VXObLIUoSshhT_zRLLhyqkLdecchUxWtM1bp2XulyYps
Message-ID: <CA+G9fYvpx2Hb5eNvTomTpwy0Ent8fX0QHt3eHEVBygy75k9mxA@mail.gmail.com>
Subject: next-20250219: arm, arm64 kernel panic handle_fasteoi_irq
To: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mm <linux-mm@kvack.org>, 
	linux-block <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	virtualization@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Regression on qemu-arm64 boot failed due to kernel panic with the
following boot errors.

Boot regression: arm, arm64 kernel panic handle_fasteoi_irq

Started noticing from next-20250219.
Good: next-20250218
Bad: next-20250219

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


Boot log:
---------
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.14.0-rc3-next-20250219
(tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 13.3.0-12) 13.3.0,
GNU ld (GNU Binutils for Debian) 2.43.90.20250127) #1 SMP PREEMPT
@1739943628
[    0.000000] KASLR enabled
[    0.000000] random: crng init done
[    0.000000] Machine model: linux,dummy-virt
<trim>
<6>[    3.812053] loop: module loaded
<6>[    3.814219] virtio_blk virtio0: 2/0/0 default/read/poll queues
<5>[    3.831704] virtio_blk virtio0: [vda] 5345376 512-byte logical
blocks (2.74 GB/2.55 GiB)
<1>[    3.852043] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
<1>[    3.852124] Mem abort info:
<1>[    3.852141]   ESR =3D 0x000000008600002b
<1>[    3.852200]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
<1>[    3.852229]   SET =3D 0, FnV =3D 0
<1>[    3.852249]   EA =3D 0, S1PTW =3D 0
<1>[    3.852273]   FSC =3D 0x2b: level -1 translation fault
<1>[    3.852335] [0000000000000000] user address but active_mm is swapper
<0>[    3.852610] Internal error: Oops: 000000008600002b [#1] PREEMPT SMP
<4>[    3.857169] Modules linked in:
<4>[    3.858810] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.14.0-rc3-next-20250219 #1
<4>[    3.859808] Hardware name: linux,dummy-virt (DT)
<4>[    3.860409] pstate: 824028c9 (Nzcv daIF +PAN -UAO +TCO -DIT
-SSBS BTYPE=3D-c)
<4>[    3.861239] pc : 0x0
<4>[ 3.862440] lr : cond_unmask_eoi_irq (kernel/irq/chip.c:676)
<4>[    3.863382] sp : ffff80008000bf70
<4>[    3.863709] x29: ffff80008000bf70 x28: ffff73e3c02e0000 x27:
0000000000001000
<4>[    3.864549] x26: ffff73e3c0544000 x25: 0000000000000040 x24:
ffff80008002b458
<4>[    3.865425] x23: 0000000061400009 x22: ffff73e3c098ce30 x21:
ffff73e3c098d4ac
<4>[    3.866218] x20: ffff73e3c098d430 x19: ffff73e3c098d400 x18:
00000000ffffffff
<4>[    3.867099] x17: ffffdbf12bdaf000 x16: ffff800080008000 x15:
ffff800081000000
<4>[    3.867863] x14: 0000000000000040 x13: 0000000000000000 x12:
ffffffcf4f041ec0
<4>[    3.868612] x11: 0000000000000040 x10: ffff73e3c001d230 x9 :
ffff97f2d115aeb0
<4>[    3.869259] x8 : ffffffffffffffc0 x7 : 6395bf3371f0dbee x6 :
ffff73e3ff4d9ba0
<4>[    3.870107] x5 : 0000000000000000 x4 : 0000000000000026 x3 :
0000000000000000
<4>[    3.870812] x2 : ffff73e3c098d400 x1 : 0000000000000000 x0 :
ffff73e3c098d430
<4>[    3.871938] Call trace:
<4>[    3.872496]  0x0 (P)
<4>[ 3.873023] handle_fasteoi_irq (kernel/irq/chip.c:727)
<4>[ 3.873647] handle_irq_desc (kernel/irq/irqdesc.c:715)
<4>[ 3.874062] generic_handle_domain_irq (kernel/irq/irqdesc.c:771)
<4>[ 3.874521] gic_handle_irq (drivers/irqchip/irq-gic.c:344 (discriminator=
 1))
<4>[ 3.875043] call_on_irq_stack (arch/arm64/kernel/entry.S:897)
<4>[ 3.875400] do_interrupt_handler (arch/arm64/kernel/entry-common.c:310)
<4>[ 3.875906] el1_interrupt (arch/arm64/kernel/entry-common.c:561
arch/arm64/kernel/entry-common.c:575)
<4>[ 3.876244] el1h_64_irq_handler (arch/arm64/kernel/entry-common.c:581)
<4>[ 3.876690] el1h_64_irq (arch/arm64/kernel/entry.S:596)
<4>[ 3.877270] __blk_flush_plug (block/blk-core.c:1225) (P)
<4>[ 3.877637] __submit_bio (block/blk-core.c:1241 (discriminator 1)
block/blk-core.c:1237 (discriminator 1) block/blk-core.c:642
(discriminator 1))
<4>[ 3.878180] submit_bio_noacct_nocheck (include/linux/bio.h:576
block/blk-core.c:716 block/blk-core.c:744)
<4>[ 3.878712] submit_bio_noacct (block/blk-core.c:875)
<4>[ 3.879175] submit_bio (block/blk-core.c:910)
<4>[ 3.879442] submit_bh_wbc (fs/buffer.c:2809)
<4>[ 3.880010] block_read_full_folio (fs/buffer.c:2442 (discriminator 1))
<4>[ 3.880454] blkdev_read_folio (block/fops.c:468)
<4>[ 3.880914] filemap_read_folio (mm/filemap.c:2399)
<4>[ 3.881400] do_read_cache_folio (mm/filemap.c:3969)
<4>[ 3.881933] read_cache_folio (mm/filemap.c:4003)
<4>[ 3.882325] read_part_sector (block/partitions/core.c:723 (discriminator=
 1))
<4>[ 3.882730] read_lba (block/partitions/efi.c:248)
<4>[ 3.883009] efi_partition (block/partitions/efi.c:177
(discriminator 1) block/partitions/efi.c:604 (discriminator 1)
block/partitions/efi.c:720 (discriminator 1))
<4>[ 3.883384] bdev_disk_changed (block/partitions/core.c:142
block/partitions/core.c:589 block/partitions/core.c:693)
<4>[ 3.884038] blkdev_get_whole (block/bdev.c:706)
<4>[ 3.884467] bdev_open (block/bdev.c:915)
<4>[ 3.884736] bdev_file_open_by_dev (block/bdev.c:1018 block/bdev.c:992)
<4>[ 3.885367] disk_scan_partitions (block/genhd.c:376 (discriminator 1))
<4>[ 3.885988] add_disk_fwnode (block/genhd.c:526)
<4>[ 3.886377] device_add_disk (block/genhd.c:587)
<4>[ 3.886707] virtblk_probe (drivers/block/virtio_blk.c:1535)
<4>[ 3.887022] virtio_dev_probe (drivers/virtio/virtio.c:341)
<4>[ 3.887438] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
<4>[ 3.888073] __driver_probe_device (drivers/base/dd.c:800)
<4>[ 3.888474] driver_probe_device (drivers/base/dd.c:830)
<4>[ 3.888908] __driver_attach (drivers/base/dd.c:1217)
<4>[ 3.889499] bus_for_each_dev (drivers/base/bus.c:370)
<4>[ 3.889936] driver_attach (drivers/base/dd.c:1235)
<4>[ 3.890312] bus_add_driver (drivers/base/bus.c:678)
<4>[ 3.890708] driver_register (drivers/base/driver.c:249)
<4>[ 3.891060] __register_virtio_driver (drivers/virtio/virtio.c:416)
<4>[ 3.891547] virtio_blk_init (drivers/block/virtio_blk.c:1695)
<4>[ 3.891971] do_one_initcall (init/main.c:1257)
<4>[ 3.892273] kernel_init_freeable (init/main.c:1318 (discriminator
1) init/main.c:1335 (discriminator 1) init/main.c:1354 (discriminator
1) init/main.c:1567 (discriminator 1))
<4>[ 3.892596] kernel_init (init/main.c:1461)
<4>[ 3.892888] ret_from_fork (arch/arm64/kernel/entry.S:863)
<0>[ 3.894314] Code: io_uring LICENSES Makefile security io_uring
LICENSES Makefile security io_uring LICENSES Makefile security
io_uring LICENSES Makefile security (????????)
All code
=3D=3D=3D=3D=3D=3D=3D=3D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<4>[    3.895583] ---[ end trace 0000000000000000 ]---
<0>[    3.897170] Kernel panic - not syncing: Oops: Fatal exception in inte=
rrupt
<2>[    3.898084] SMP: stopping secondary CPUs
<0>[    3.900403] Kernel Offset: 0x17f251000000 from 0xffff800080000000
<0>[    3.901020] PHYS_OFFSET: 0xfff08c1d40000000
<0>[    3.901448] CPU features: 0x000,000000d0,60bef2f8,cb7e7f3f
<0>[    3.902230] Memory Limit: none
<0>[    3.902988] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---

## Source
* Kernel version: 6.14.0-rc3-next-20250219
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
* Git sha: 8936cec5cb6e27649b86fabf383d7ce4113bba49
* Git describe: next-20250219
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250219/

## Build
* Test log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next=
-20250219/testrun/27353387/suite/log-parser-test/test/panic-multiline-kerne=
l-panic-not-syncing-oops-fatal-exception-in-interrupt-af3884c4b4033494570cf=
11ed10a8af71223ab1cfcf7a208e5376192d5e4085c/log
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250219/te=
strun/27353544/suite/log-parser-test/test/panic-multiline-kernel-panic-not-=
syncing-oops-fatal-exception-in-interrupt-af3884c4b4033494570cf11ed10a8af71=
223ab1cfcf7a208e5376192d5e4085c/history/
* Test details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250219/te=
strun/27354020/suite/log-parser-test/tests/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2tFMKFT6i1JOAPACynnh=
wzW2duf/config
* Architecures: arm64
* Toolchain version: gcc-13


--
Linaro LKFT
https://lkft.linaro.org
