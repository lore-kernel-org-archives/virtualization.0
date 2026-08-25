Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712145DF6B
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666430; cv=none; b=KqPDWkaNDqdkoYimOpKkFlFR6LiKuO4S1wnr0ycdDOx/LBv0c8+sPw1wjwYqlVC1Y8skPQeqQGzXH5fKUg7hUvwsWcFlrf3qouUTg6J97lwxXvpdEZoCRjy/tNr1CIErG+nhGgXvfQ0Mzonj5UATZwHt6cj+DQY9M2nFM9QYDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666430; c=relaxed/simple;
	bh=sD1cAFAKvP+d8gejacszG0EtL0SC9GGCjzjRCiN6J0w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eGd+4O/kD0UmOhAiMg1KXZ/GTg/p+2A4mudg6xf6wJgh9xMh5W15NQSIl+A9Yau0NjLRN1OhUJbEiXlX6DqTbAyhICKo6poGskRwOnlmhLnIUlmwsBn4P0GsUfKAug9B5MSW+kJ8BoFfOKDUVQbcXa+Qj2yvQn8RMduEAj7xO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f1.google.com with SMTP id 5614622812f47-4960b753d6fso1667622b6e.0
        for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666427; x=1788271227;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EqRUtVMVRwFbVYmErHWZFOx3NYYWPtQjCN46zf6/snY=;
        b=pXmP1ew2vBVWdgyd+ccLRwRjBTLy8m0mLv2yctL4r7w9l68H+Krj2iXADc3Lgf3J+q
         IKsQS9xVAtDot6ZiJSMwgB5UQ8vt9yi78CddjUDn0pYHAD49Z+zZQ5WDdeeDTHRz7GTC
         Z9qO8PlBApjyzIW9DnrFP03d1pVEZERxQoy/RWeWAVHwErrjdlbnJyi4B7LAgKdf2Cj+
         mGcOjnnPyu2I0PHW6FoTZDq+w038gjJsNFVV6Go6EYHxl2kvT8q5mY9FnDjc8JoqyZT8
         hC+VADqTBzm0Lhz2g8huFr+CiyGVen1xeQGdIl5aw5T3wny6HuzKO92fXN6poylPIgt0
         EXmA==
X-Forwarded-Encrypted: i=1; AHgh+RrGLUtEFlQGRdBO+uaV2YwAqLUOhokMMMz2ypR/HgPtdfDyKXLagnD52QZGf71ame0XbICYceL+9lvGv5a2fg==@lists.linux.dev
X-Gm-Message-State: AFuF++kOx6L9BfxIzRoS4vHd/mZkz1Kt17ZsFy7j8Iz3p2TwI8Ngn67g
	RGX1x1533RMs3CMmz2OoOUez8njIkVonJqTXt6e012L3zDevK+NJohfUOWP/qKwlHAb0eGrNcXb
	KBzbAK7P8c02WXeY/voENYkJxdyqpNf2txdoSNJFsgPaysCpPFV3GguaZJyE=
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b8c:b0:497:e0bc:afe2 with SMTP id
 5614622812f47-4b2ef25cff4mr37722051b6e.4.1787666427386; Tue, 25 Aug 2026
 07:00:27 -0700 (PDT)
Date: Tue, 25 Aug 2026 07:00:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8d9ffb.91706f20.ef82.000e.GAE@google.com>
Subject: [syzbot] [dri?] [virt?] upstream test error: WARNING in drm_mode_config_validate
From: syzbot <syzbot+5caf8faef4fa32603577@syzkaller.appspotmail.com>
To: airlied@redhat.com, dmitry.osipenko@collabora.com, 
	dri-devel@lists.freedesktop.org, gurchetansingh@chromium.org, 
	kraxel@redhat.com, linux-kernel@vger.kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, olvaffe@gmail.com, 
	simona@ffwll.ch, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66498c75b4f8 Merge tag 'dmaengine-7.3-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149d6625580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=780bb9a5c10069a1
dashboard link: https://syzkaller.appspot.com/bug?extid=5caf8faef4fa32603577
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-66498c75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4708be72b898/vmlinux-66498c75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5cfcadeec97/bzImage-66498c75.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5caf8faef4fa32603577@syzkaller.appspotmail.com

qnx6: QNX6 filesystem 1.0.0 registered.
fuse: init (API version 7.45)
orangefs_debugfs_init: called with debug mask: :none: :0:
orangefs_init: module version upstream loaded
JFS: nTxBlock = 6145, nTxLock = 49167
SGI XFS with ACLs, security attributes, realtime, scrub, repair, quota, no debug enabled
9p: Installing v9fs 9p2000 file system support
NILFS version 2 loaded
befs: version: 0.9.3
ocfs2: Registered cluster interface o2cb
ocfs2: Registered cluster interface user
OCFS2 User DLM kernel interface loaded
gfs2: GFS2 installed
ceph: loaded (mds proto 32)
NET: Registered PF_ALG protocol family
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 239)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
raid6: skipped pq benchmark and selected avx512x4
ACPI: \_SB_.GSIE: Enabled at IRQ 20
pcieport 0000:00:04.0: PME: Signaling with IRQ 25
pcieport 0000:00:04.0: AER: enabled with IRQ 26
input: Power Button as /devices/platform/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
ACPI: \_SB_.GSIF: Enabled at IRQ 21
ACPI: \_SB_.GSIH: Enabled at IRQ 23
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Non-volatile memory driver v1.3
usbcore: registered new interface driver xillyusb
ACPI: bus type drm_connector registered
[drm] Initialized vgem 1.0.0 for vgem on minor 0
usbcore: registered new interface driver udl
[drm] pci: virtio-vga detected at 0000:00:01.0
virtio-pci 0000:00:01.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
[drm] features: -virgl +edid -resource_blob -host_visible
[drm] features: -context_init -blob_alignment
[drm] number of scanouts: 1
[drm] number of cap sets: 0
------------[ cut here ]------------
[PLANE:36:plane-1] pixel format with alpha exposed but blend mode not setup
WARNING: drivers/gpu/drm/drm_mode_config.c:873 at validate_blend_mode_for_alpha_formats drivers/gpu/drm/drm_mode_config.c:872 [inline], CPU#0: swapper/0/1
WARNING: drivers/gpu/drm/drm_mode_config.c:873 at drm_mode_config_validate+0x1c6a/0x1e60 drivers/gpu/drm/drm_mode_config.c:938, CPU#0: swapper/0/1
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:validate_blend_mode_for_alpha_formats drivers/gpu/drm/drm_mode_config.c:872 [inline]
RIP: 0010:drm_mode_config_validate+0x1cab/0x1e60 drivers/gpu/drm/drm_mode_config.c:938
Code: 0f 85 ae 00 00 00 4d 8d 77 10 8b 6d 00 4c 89 f0 48 c1 e8 03 80 3c 18 00 74 08 4c 89 f7 e8 3d a7 a3 fc 49 8b 16 4c 89 ef 89 ee <67> 48 0f b9 3a eb 05 e8 49 56 32 fc 49 bd 00 00 00 00 00 fc ff df
RSP: 0000:ffffc900001af450 EFLAGS: 00010246
RAX: 1ffff11000022e08 RBX: dffffc0000000000 RCX: ffff88801ceb0000
RDX: ffff88801f5c7900 RSI: 0000000000000024 RDI: ffffffff9085b000
RBP: 0000000000000024 R08: ffffffff8ec2b347 R09: 1ffffffff1d85668
R10: dffffc0000000000 R11: fffffbfff1d85669 R12: dffffc0000000000
R13: ffffffff9085b000 R14: ffff888000117040 R15: ffff888000117030
FS:  0000000000000000(0000) GS:ffff88808c2e6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88801af19000 CR3: 000000000eb46000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 drm_dev_register+0x7c/0xd80 drivers/gpu/drm/drm_drv.c:1077
 virtio_gpu_probe+0x1cb/0x290 drivers/gpu/drm/virtio/virtgpu_drv.c:107
 virtio_dev_probe+0xdf6/0x10c0 drivers/virtio/virtio.c:347
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __driver_attach+0x339/0x600 drivers/base/dd.c:1292
 bus_for_each_dev+0x23b/0x2c0 drivers/base/bus.c:383
 bus_add_driver+0x345/0x670 drivers/base/bus.c:763
 driver_register+0x23a/0x320 drivers/base/driver.c:174
 virtio_gpu_driver_init+0x96/0x110 drivers/gpu/drm/virtio/virtgpu_drv.c:298
 do_one_initcall+0x250/0x870 init/main.c:1353
 do_initcall_level+0x10a/0x1a0 init/main.c:1415
 do_initcalls+0x59/0xa0 init/main.c:1431
 kernel_init_freeable+0x29d/0x3e0 init/main.c:1666
 kernel_init+0x22/0x1d0 init/main.c:1556
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f 85 ae 00 00 00    	jne    0xb4
   6:	4d 8d 77 10          	lea    0x10(%r15),%r14
   a:	8b 6d 00             	mov    0x0(%rbp),%ebp
   d:	4c 89 f0             	mov    %r14,%rax
  10:	48 c1 e8 03          	shr    $0x3,%rax
  14:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  18:	74 08                	je     0x22
  1a:	4c 89 f7             	mov    %r14,%rdi
  1d:	e8 3d a7 a3 fc       	call   0xfca3a75f
  22:	49 8b 16             	mov    (%r14),%rdx
  25:	4c 89 ef             	mov    %r13,%rdi
  28:	89 ee                	mov    %ebp,%esi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 05                	jmp    0x36
  31:	e8 49 56 32 fc       	call   0xfc32567f
  36:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  3d:	fc ff df


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
