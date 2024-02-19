Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CCBA2F
	for <virtualization@lists.linux.dev>; Mon, 19 Feb 2024 05:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319181; cv=none; b=OGfuvaegNC9SpY7mPo0yvshjx0lqeF0vskM0RFKUs8u8HGJAkgydDFHZV+C5JCuPZMiVf1zWed4fAM++4TFojCniXGlposygdElhALDvNscRplsN0EkDuhEsmupTxqUMTCkuKJ7245VVVkyA9fIgJxyW+/iUWRJDSSyeUcevpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319181; c=relaxed/simple;
	bh=WvwQ2bS/E1FygRTqT8AXf//Nr1hu//6FpQI8RMhbTDs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s0RbT5x3epu/rO7ZsKqn8JmBNOtKmpQ2c1Q+kpaExrQM/tA/awtXX2gHfMpH0iucugPFowFowMFkZgNpmiU9lL9b2tDoqyoHMnYs+4SfYYvwj2S+9xrgnAN4CqSc1tzhp1cJd+UPufEL463kYdckoTZrmf4RVh+dZXx0kIGfP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-365026bbf10so37299505ab.3
        for <virtualization@lists.linux.dev>; Sun, 18 Feb 2024 21:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708319179; x=1708923979;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnM1NJuJDctL1cWKTarHVWdjoNgqkYe1G4NkDMu0H3I=;
        b=O9ePC0fVGjKImYeUmPXDLi2Gq3oY/JFTlSvsJ1EqfrMCQbua0A4CYaeJyzeBcEJ1Ge
         qw/y/2vVoG5pG6H6VUFpnxm7/LGw4lnD5lOGGYZ0hnNWaTdnrXUhHoms8SXdEwN6EnZa
         NJy3MzEnKbMA60ddUWlolFOPkGZAwOdrVgLlNEnBaIczu0T0EVO92tLXP6QAIHQmlWus
         siEIHKy96OePo5oOzGr/Et0gG/85iWC3H5oTPqoLTMpr2TBv5MKvFNZwRa7KuDKbVmrI
         /AHFV8YX+UynBqCpRECA/718XuOF6OOQuTd0ihuo90uNbE+kACSC/lAq2x7sx8vm06qZ
         ZfTg==
X-Forwarded-Encrypted: i=1; AJvYcCXAj9dqK4Hvvv1hsiLSRI0KhIqUuteCsuo2aRzBk7PJnRsBx4DbNFfCO1O7uWaAR2jiO74LWuDZf1THIWrG59DvVwWFI0qZyID5zuVZ3nw=
X-Gm-Message-State: AOJu0YxN8UuC9RUrvoJBBB028yprvm6xZqvpITq/RRESv8UUk+DPlU/F
	vvYLG981StgboRi+bFz8ZAnYOqahTXVRnrR+oE8WFxbdkou47FCemSCTydstMasLNkQF6W1sgzU
	fbCHOu9vDaVhsFTZVcvOvc66kNwPc8pgARugDQsal/pfEUmfMti5M8XE=
X-Google-Smtp-Source: AGHT+IF5KTVuir/MADDuTGWWApHfuEACabKJNm6zMKWWLeCKu8rxeipYe0caTIDb+vN+zPf3ooiH2N0AS8wQtnpql90ChNp+qeVm
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0b:b0:365:147b:fb44 with SMTP id
 i11-20020a056e021b0b00b00365147bfb44mr639208ilv.0.1708319178948; Sun, 18 Feb
 2024 21:06:18 -0800 (PST)
Date: Sun, 18 Feb 2024 21:06:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d305050611b50d09@google.com>
Subject: [syzbot] [virtualization?] linux-next boot error: WARNING: refcount
 bug in __free_pages_ok
From: syzbot <syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com>
To: jasowang@redhat.com, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, mst@redhat.com, sfr@canb.auug.org.au, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d37e1e4c52bc Add linux-next specific files for 20240216
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171ca652180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4bc446d42a7d56c0
dashboard link: https://syzkaller.appspot.com/bug?extid=6f3c38e8a6a0297caa5a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/14d0894504b9/disk-d37e1e4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6cda61e084ee/vmlinux-d37e1e4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/720c85283c05/bzImage-d37e1e4c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f3c38e8a6a0297caa5a@syzkaller.appspotmail.com

Key type pkcs7_test registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
ACPI: button: Sleep Button [SLPF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
ACPI: \_SB_.LNKC: Enabled at IRQ 11
virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKD: Enabled at IRQ 10
virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
ACPI: \_SB_.LNKB: Enabled at IRQ 10
virtio-pci 0000:00:06.0: virtio_pci: leaving for legacy driver
virtio-pci 0000:00:07.0: virtio_pci: leaving for legacy driver
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
Console: switching to colour frame buffer device 128x48
platform vkms: [drm] fb0: vkmsdrmfb frame buffer device
usbcore: registered new interface driver udl
brd: module loaded
loop: module loaded
zram: Added device: zram0
null_blk: disk nullb0 created
null_blk: module loaded
Guest personality initialized and is inactive
VMCI host device registered (name=vmci, major=10, minor=118)
Initialized host personality
usbcore: registered new interface driver rtsx_usb
usbcore: registered new interface driver viperboard
usbcore: registered new interface driver dln2
usbcore: registered new interface driver pn533_usb
nfcsim 0.2 initialized
usbcore: registered new interface driver port100
usbcore: registered new interface driver nfcmrvl
Loading iSCSI transport class v2.0-870.
virtio_scsi virtio0: 1/0/0 default/read/poll queues
------------[ cut here ]------------
refcount_t: decrement hit 0; leaking memory.
WARNING: CPU: 0 PID: 1 at lib/refcount.c:31 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc4-next-20240216-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:31
Code: b2 00 00 00 e8 b7 94 f0 fc 5b 5d c3 cc cc cc cc e8 ab 94 f0 fc c6 05 c6 16 ce 0a 01 90 48 c7 c7 a0 5a fe 8b e8 67 69 b4 fc 90 <0f> 0b 90 90 eb d9 e8 8b 94 f0 fc c6 05 a3 16 ce 0a 01 90 48 c7 c7
RSP: 0000:ffffc90000066e10 EFLAGS: 00010246
RAX: 15c2c224c9b50400 RBX: ffff888020827d2c RCX: ffff8880162d8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: ffffffff8157b942 R09: fffffbfff1bf95cc
R10: dffffc0000000000 R11: fffffbfff1bf95cc R12: ffffea000502fdc0
R13: ffffea000502fdc8 R14: 1ffffd4000a05fb9 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 __free_pages_ok+0xc42/0xd70 mm/page_alloc.c:1269
 make_alloc_exact+0xc4/0x140 mm/page_alloc.c:4847
 vring_alloc_queue drivers/virtio/virtio_ring.c:319 [inline]
 vring_alloc_queue_split+0x20a/0x600 drivers/virtio/virtio_ring.c:1108
 vring_create_virtqueue_split+0xc6/0x310 drivers/virtio/virtio_ring.c:1158
 vring_create_virtqueue+0xca/0x110 drivers/virtio/virtio_ring.c:2683
 setup_vq+0xe9/0x2d0 drivers/virtio/virtio_pci_legacy.c:131
 vp_setup_vq+0xbf/0x330 drivers/virtio/virtio_pci_common.c:189
 vp_find_vqs_msix+0x8b2/0xc80 drivers/virtio/virtio_pci_common.c:331
 vp_find_vqs+0x4c/0x4e0 drivers/virtio/virtio_pci_common.c:408
 virtio_find_vqs include/linux/virtio_config.h:233 [inline]
 virtscsi_init+0x8db/0xd00 drivers/scsi/virtio_scsi.c:887
 virtscsi_probe+0x3ea/0xf60 drivers/scsi/virtio_scsi.c:945
 virtio_dev_probe+0x991/0xaf0 drivers/virtio/virtio.c:311
 really_probe+0x29e/0xc50 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
 bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
 bus_add_driver+0x347/0x620 drivers/base/bus.c:673
 driver_register+0x23a/0x320 drivers/base/driver.c:246
 virtio_scsi_init+0x65/0xe0 drivers/scsi/virtio_scsi.c:1083
 do_one_initcall+0x238/0x830 init/main.c:1233
 do_initcall_level+0x157/0x210 init/main.c:1295
 do_initcalls+0x3f/0x80 init/main.c:1311
 kernel_init_freeable+0x435/0x5d0 init/main.c:1543
 kernel_init+0x1d/0x2b0 init/main.c:1432
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
