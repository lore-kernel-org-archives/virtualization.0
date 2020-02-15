From: Juerg Haefliger <juergh@gmail.com>
Subject: arm64 kernel crash in bochs_get_edid_block() with QEMU '-device VGA'
Date: Sat, 15 Feb 2020 13:11:45 +0100
Message-ID: <CADLDEKugE-Y9rMumiCDJDW_FvGcBaQd3fBv80YeSS0=udnkMAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, kraxel@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The QEMU default edid=off results in a kernel crash [1] on arm64 due
to commit [2]. To reproduce:

$ ARCH=arm64 make defconfig
$ ./scripts/config -e DRM -e DRM_BOCHS
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make olddefconfig Image
$ qemu-system-aarch64 -M virt -cpu cortex-a57 -device VGA -device
virtio-serial-pci -kernel arch/arm64/boot/Image -append
"console=ttyAMA0"

Using '-device VGA,edid=on' instead works just fine.

$ qemu-system-aarch64 -version
QEMU emulator version 4.0.0 (Debian 1:4.0+dfsg-0ubuntu9.2)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

...Juerg

[1]
[    0.740886] Internal error: synchronous external abort: 96000010
[#1] PREEMPT SMP
[    0.741120] Modules linked in:
[    0.741435] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.19.0-rc6-01554-g7118072afbf2 #48
[    0.741605] Hardware name: linux,dummy-virt (DT)
[    0.741817] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    0.741945] pc : bochs_get_edid_block+0x20/0x48
[    0.742052] lr : drm_do_get_edid+0x64/0x318
[    0.742148] sp : ffff00000805ba00
[    0.742239] x29: ffff00000805ba00 x28: 0000000000000000
[    0.742381] x27: 0000000000000000 x26: ffff0000092404dc
[    0.742504] x25: ffff80003c0a4590 x24: ffff80003c218680
[    0.742625] x23: ffff80003c0a496c x22: ffff80003c0a4000
[    0.742745] x21: ffff000008653db0 x20: 0000000000000001
[    0.742865] x19: ffff80003c2a3c00 x18: 0000000000000400
[    0.742986] x17: 0000000000000000 x16: 0000000000000000
[    0.743106] x15: 0000000000000400 x14: 0000000000000400
[    0.743226] x13: 0000000000000374 x12: 0000000000000028
[    0.743345] x11: 0000000000000040 x10: ffff80003c0b3ab0
[    0.743482] x9 : 0000000000000000 x8 : ffff80003c538a40
[    0.743605] x7 : 0000000000800004 x6 : 0000000000000000
[    0.743726] x5 : 0000000000000080 x4 : ffff80003c2a3c00
[    0.743846] x3 : 0000000000000080 x2 : 0000000000000000
[    0.743966] x1 : ffff0000097fd000 x0 : ffff80003c0a4000
[    0.744131] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    0.744339] Call trace:
[    0.744709]  bochs_get_edid_block+0x20/0x48
[    0.744816]  bochs_hw_load_edid+0x34/0x58
[    0.744917]  bochs_kms_init+0x15c/0x1e0
[    0.745006]  bochs_load+0x84/0xc8
[    0.745086]  drm_dev_register+0x140/0x1d0
[    0.745178]  drm_get_pci_dev+0x9c/0x160
[    0.745266]  bochs_pci_probe+0x70/0x98
[    0.745354]  local_pci_probe+0x3c/0xb0
[    0.745441]  pci_device_probe+0x188/0x1a0
[    0.745532]  really_probe+0x1ec/0x280
[    0.745616]  driver_probe_device+0x54/0xe8
[    0.745709]  __driver_attach+0xe4/0xe8
[    0.745811]  bus_for_each_dev+0x70/0xb8
[    0.745897]  driver_attach+0x20/0x28
[    0.745978]  bus_add_driver+0x1a0/0x210
[    0.746063]  driver_register+0x60/0x110
[    0.746151]  __pci_register_driver+0x40/0x48
[    0.746246]  bochs_init+0x28/0x38
[    0.746325]  do_one_initcall+0x54/0x154
[    0.746413]  kernel_init_freeable+0x18c/0x228
[    0.746511]  kernel_init+0x10/0x100
[    0.746592]  ret_from_fork+0x10/0x18
[    0.746834] Code: cb020024 b4000123 f9400001 8b020021 (08dffc21)
[    0.747380] ---[ end trace 4353104b0caf319a ]---
[    0.747791] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    0.747791]
[    0.748046] SMP: stopping secondary CPUs
[    0.748338] Kernel Offset: disabled
[    0.748598] CPU features: 0x0,21806082
[    0.748707] Memory Limit: none
[    0.748871] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b
[    0.748871]  ]---

[2] 01f23459cf93 ("drm/bochs: add edid support.")
