Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6DCC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:28:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6D3239E5
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 16:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6D3239E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3B3DB87A5F;
	Thu, 17 Dec 2020 16:28:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQpOt+J3gLDF; Thu, 17 Dec 2020 16:28:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4274887A3E;
	Thu, 17 Dec 2020 16:28:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28FF5C0893;
	Thu, 17 Dec 2020 16:28:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A519C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E4FAC875C1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:28:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dKmSTwNUCnzD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:28:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8BC44875AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1608222411;
 bh=aJhw+NY4u2qqLCXsW8xRiaAfQAzXQyg9VlWkYcC2UWE=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=asPOK6Ks87kt5M4lCZQbjZ+66dQCM40s75b3RbRRHOjQO0J3/gWFSKI1aK5xZF5Us
 kqYSLgbLhn0cb5f0/H0n6+lw91Zq75b94EKQtIiyob6bDT1uhMee9fTF8knP+b2eo0
 q5ZOcHHO7ivTk+3IWzayPbuxMegYatcUU4vAbV+8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1kVf8a3bic-00KTrQ; Thu, 17
 Dec 2020 17:26:50 +0100
Message-ID: <23bc1073395db9ccf55ecca45198375f4d5d6250.camel@gmx.de>
Subject: Re: [bisected] Re: drm, qxl: post 5.11 merge warning+explosion
From: Mike Galbraith <efault@gmx.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, LKML
 <linux-kernel@vger.kernel.org>
Date: Thu, 17 Dec 2020 17:26:49 +0100
In-Reply-To: <6f99d3ca-a7ff-69e9-8ca1-9d016a8d3f48@amd.com>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
 <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
 <1f88b926bedcad0d6e35c7f5b63bbb038c8c6c09.camel@gmx.de>
 <6f99d3ca-a7ff-69e9-8ca1-9d016a8d3f48@amd.com>
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-Provags-ID: V03:K1:tWUdMzCUtqIO6Qrmy+U0bkUiPadM7gU5O5hYttXmoV/4efQNZpE
 9o+sGEdbQkOtweBbQbPwHaJr2WVg4G28TOLU6RHpe20YTUf8YKM8fr9NEJsBldTPDNpZiWh
 flXyIgpWdCIE8ZWeu4a1atMTwWJMe/kNyQ8FfVgKH9Qrx5czxMzIOv4Zm8rp58+fsjgPwGJ
 3TsvYeNqzFw1oLHkJYFWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C7Yxk1vQWCk=:8nR5iNgzCB+H6q1dk+9iEJ
 ujcRcH/utrQv3nXUHgvE19dJGj4L9K2ULZid1T34a+HXWaljDyyEaJYFcfOPRCf+f2lFFN6fd
 LZG3cVQu7C0iRz32ERhUF+wry8vaZ/E9DTl7K+I6xjuE80A+ofJzEApVoe2lJmXOUml9bvyCC
 xx8JS+EYPIXo54x7m96tyVbDw3QvA7JT7XgXxV0Fw4bn7dKBkwRnBPXfzB5NbXG26NmS1FB13
 SXnHP8kiL5OZsWy6TkL8lPSeeYaUXA6RzOzN6PRd0ceJ+mPJASKfTajY5/6Y/rog8qsIbc59E
 2u2yyY/0gSNbEhVXA2rnMSneFvbg+nCNewmHJahj5yggDuwmzGtAvc/5fd0zHuTs9xSjKe5kG
 s69BdmqQrW/hCN5gdJLBnr3iN1wvQwGhECVJeVh1mtwsnf8l54KlzjuaA3Cvd8mVScjwc2LYQ
 A2CVgjWgW6pEmKAyYEfQZRhnCovvNriNkc0Lz29HtoPPzcz9CUKqhFFfXHEGfEuN/yS3vGSui
 CHBR6UZnalBSNISl+d5+2ylh36qFa2ZwcnC615/DWGRD7X29/8zwUe/iUv7CISJ7ixXneS/LY
 jDudd6q/hLy1PKvhclxiEG6pOVmrp2nBq9KyJzTYSpylr+1cYqSGJXnvyqONgIbHsg4I/bMj/
 25V0Tzmbb0SY+bKDwgs4auLTIEP/1hVKcqr45g8oOELmVvE9szJQQcFiwWVE/xEZIYdRjmEE5
 a2MJ8sUivwJj9DFU9tTc5Wx7vLtkvhE+RMk+vEPSQ3ts/GFGw9whN4E5wNe7zgq+uuOX5X+70
 twqFKmUXhwXdFATjO8dBU/l5GU+1lt+3JE9oBcp/cOYb43mSv7xKLri39WFslttAb2cETMBsp
 ER2fyqWdhaXEvDNxCLaQ==
Cc: Dave Airlie <airlied@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 2020-12-17 at 17:24 +0100, Christian K=F6nig wrote:
> Hi Mike,
>
> what exactly is the warning from qxl you are seeing?

[    1.815561] WARNING: CPU: 7 PID: 355 at drivers/gpu/drm/ttm/ttm_pool.c:3=
65 ttm_pool_alloc+0x41b/0x540 [ttm]
[    1.815561] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_g=
eneric(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E) =
drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sy=
simgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pci(E)=
 rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_r=
ing(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) dm_mult=
ipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(=
E) autofs4(E)
[    1.815589] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G            E   =
  5.10.0.g489e9fe-master #26
[    1.815590] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[    1.815614] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
[    1.815621] RIP: 0010:ttm_pool_alloc+0x41b/0x540 [ttm]
[    1.815623] Code: fc ff ff 89 ea 48 8d 04 d5 00 00 00 00 48 29 d0 48 8d =
3c c5 00 1c 40 a0 e9 d7 fc ff ff 85 c0 0f 89 2f fc ff ff e9 28 fc ff ff <0f=
> 0b e9 35 fc ff ff 89 e9 49 8b 7d 00 b8 00 10 00 00 48 d3 e0 45
[    1.815623] RSP: 0018:ffff888105d3b818 EFLAGS: 00010246
[    1.815625] RAX: 0000000000000000 RBX: ffff888106978800 RCX: 00000000000=
00000
[    1.815626] RDX: ffff888105d3bc68 RSI: 0000000000000001 RDI: ffff8881062=
38820
[    1.815626] RBP: ffff888106238758 R08: ffffc90000296000 R09: 80000000000=
0016b
[    1.815627] R10: 0000000000000001 R11: ffffc90000296000 R12: 00000000000=
00000
[    1.815628] R13: ffff888106238820 R14: 0000000000000000 R15: ffff8881069=
78800
[    1.815628] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS:=
0000000000000000
[    1.815632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.815633] CR2: 00007eff52a0d5b8 CR3: 0000000002010003 CR4: 00000000001=
706e0
[    1.815633] Call Trace:
[    1.815644]  ttm_tt_populate+0xb1/0xc0 [ttm]
[    1.815647]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
[    1.815652]  qxl_bo_move+0x230/0x2f0 [qxl]
[    1.815655]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
[    1.815657]  ttm_bo_evict+0x124/0x250 [ttm]
[    1.815693]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
[    1.815696]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
[    1.815698]  ttm_bo_mem_space+0x261/0x270 [ttm]
[    1.815702]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
[    1.815705]  ttm_bo_validate+0x117/0x150 [ttm]
[    1.815756]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
[    1.815772]  qxl_bo_create+0x134/0x1d0 [qxl]
[    1.815775]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
[    1.815791]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
[    1.815794]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
[    1.815797]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
[    1.815815]  ? _cond_resched+0x15/0x40
[    1.815819]  ? ww_mutex_lock_interruptible+0x12/0x60
[    1.815822]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
[    1.815841]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
[    1.815853]  process_one_work+0x1f5/0x3c0
[    1.815866]  ? process_one_work+0x3c0/0x3c0
[    1.815867]  worker_thread+0x2d/0x3d0
[    1.815868]  ? process_one_work+0x3c0/0x3c0
[    1.815872]  kthread+0x117/0x130
[    1.815876]  ? kthread_park+0x90/0x90
[    1.815880]  ret_from_fork+0x1f/0x30
[    1.815886] ---[ end trace 51e464c1e89a1728 ]---
[    1.815894] BUG: kernel NULL pointer dereference, address: 0000000000000=
230
[    1.815895] #PF: supervisor read access in kernel mode
[    1.815895] #PF: error_code(0x0000) - not-present page
[    1.815896] PGD 0 P4D 0
[    1.815898] Oops: 0000 [#1] SMP NOPTI
[    1.815900] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G        W   E   =
  5.10.0.g489e9fe-master #26
[    1.815901] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[    1.815916] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
[    1.815921] RIP: 0010:dma_map_page_attrs+0xf/0x1c0
[    1.815922] Code: 1f 17 5b 01 48 85 c0 75 e3 31 c0 c3 66 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 41 55 41 54 55 53 48 83 ec 08 <48=
> 8b 87 30 02 00 00 48 85 c0 48 0f 44 05 e7 16 5b 01 41 83 f8 02
[    1.815923] RSP: 0018:ffff888105d3b7e8 EFLAGS: 00010296
[    1.815924] RAX: 0000000000001000 RBX: 0000000000000001 RCX: 00000000000=
01000
[    1.815924] RDX: 0000000000000000 RSI: ffffea0004171e40 RDI: 00000000000=
00000
[    1.815925] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[    1.815925] R10: ffffea0004171e40 R11: ffffc90000296000 R12: 00000000000=
00001
[    1.815926] R13: ffff888106238820 R14: ffff888105d07100 R15: ffff8881069=
78800
[    1.815926] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS:=
0000000000000000
[    1.815928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.815929] CR2: 0000000000000230 CR3: 0000000002010003 CR4: 00000000001=
706e0
[    1.815929] Call Trace:
[    1.815937]  ttm_pool_alloc+0x448/0x540 [ttm]
[    1.815940]  ttm_tt_populate+0xb1/0xc0 [ttm]
[    1.815942]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
[    1.815945]  qxl_bo_move+0x230/0x2f0 [qxl]
[    1.815947]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
[    1.815949]  ttm_bo_evict+0x124/0x250 [ttm]
[    1.815982]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
[    1.815984]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
[    1.815988]  ttm_bo_mem_space+0x261/0x270 [ttm]
[    1.890133]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
[    1.890138]  ttm_bo_validate+0x117/0x150 [ttm]
[    1.891740]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
[    1.891744]  qxl_bo_create+0x134/0x1d0 [qxl]
[    1.893398]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
[    1.893400]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
[    1.893402]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
[    1.893405]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
[    1.896515]  ? _cond_resched+0x15/0x40
[    1.896517]  ? ww_mutex_lock_interruptible+0x12/0x60
[    1.896520]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
[    1.896533]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
[    1.896537]  process_one_work+0x1f5/0x3c0
[    1.900535]  ? process_one_work+0x3c0/0x3c0
[    1.900536]  worker_thread+0x2d/0x3d0
[    1.900538]  ? process_one_work+0x3c0/0x3c0
[    1.902704]  kthread+0x117/0x130
[    1.902706]  ? kthread_park+0x90/0x90
[    1.902709]  ret_from_fork+0x1f/0x30
[    1.902711] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_g=
eneric(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E) =
drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sy=
simgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pci(E)=
 rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_r=
ing(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) dm_mult=
ipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(=
E) autofs4(E)
[    1.904797] Dumping ftrace buffer:
[    1.911038]    (ftrace buffer empty)
[    1.911041] CR2: 0000000000000230



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
