Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B9AC0018C
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 13:36:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CCC23105
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 13:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CCC23105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C59C4860C2;
	Wed, 16 Dec 2020 13:36:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2zMaLrssoazj; Wed, 16 Dec 2020 13:36:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A9B5386078;
	Wed, 16 Dec 2020 13:36:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91125C0893;
	Wed, 16 Dec 2020 13:36:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAFABC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 13:36:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9A5AB86D5A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 13:36:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZQhIb4Hi1ZFR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 13:36:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 93AE586BA1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 13:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1608125692;
 bh=Y5cSGlcz9H0Epy95u+UpY+ZK0gB2fp8cK0Y49Gykg9s=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=hR50mV33Ky8Mwu09MXOZMga3NSCtp/j6lew5seMAVj9RaHCDwAydOw+3TUAbDWQvm
 C6Q8sBR4UYJcg8hNGhbI+gmxniZfLUMFAS3V8sUf+1PtfF0Bdt2iCVAdB4sOPTq3Bh
 m6mA3O+098XYzA3SnQRjdQZrro1bcXe+PyNfGp04=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp9i-1kbL2O1mFY-00YBHx; Wed, 16
 Dec 2020 14:34:52 +0100
Message-ID: <a1b925758cbc5517d4ff6df3cf2a9b6614fd5535.camel@gmx.de>
Subject: Re: drm, qxl: post 5.11 merge warning+explosion
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Date: Wed, 16 Dec 2020 14:34:50 +0100
In-Reply-To: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
References: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
X-Provags-ID: V03:K1:jWYZqCW86A4c8LMBbjQgWrWo3x7+tZNWUtYGB+mM8WxPEMeGNXY
 ndW5QYvnYoeqVhDiH+iOLRE7rwWMvx7bXQJOxLHIKappQ7hsHCgK3p7YlGkSHLlKV33H2Ha
 7w+Z2wkOTk/Uc1wAlMxsbgsrd9l0K+2scTDTrrogZhgBMdPn20AABzMnpcfxhxRZRNDwJOY
 jfirre7eJOcbkxTVutV9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bwKbGnpCsN8=:646fIADR4KusJvWUo1HfjN
 zibleDQdkvYHb2aKClbYMgxmz5RFPF/8LqAxuUl0MdUQZ+9kVVZbsbx50EViXvmWXQyebt/Z7
 S9ilE1HPUG5LlVwaOzbGDO7H+hK34ycfP0JilQxq9h93/RUDA607D/aUXwMY9vI/Bf606cKpZ
 KMkvd+iE4tfynAZOMdtl532cKR5L7m/LF/cK4zwHRIwvUbTwH1AF9xaiSJ+NrjpZApHeq6CWC
 SD1wK82j+HuHwj4eZbj6opVhWHYYopwQl2/DLHAWPuZ1ABGryTeVy0n2fFKl5ScSHUiUfLv7f
 6A5ceGsHuJIIofiA9AHOu7MYNk++AB1qEw6ZeE11kfaSIAEjNxVhwhMw1tJm66Q4ZcOraIVJi
 67rnoVU5Hd4sRjKTh1nfKZFoIuVpo7EBlYV3I0MuBA6EW1wC4eTEu45bG3FWCpLkYf1lE2V22
 KdrW9zwWaCdn5S6x4/qHYa4hbw/9srpViAVqtckHVL1ZphugeIPEKTTIRr33t3hkVE5tkP8lp
 ohHihT/4UgbUXjAaFLcry9N7FmZVV4/FsQIkCROXO/8XkG+5Z5zmoNf+TgrtX7pHyzq7FJuOW
 WdPT1Pa1L7AxwfB4a23Ecw48dhDAzzoxYKibYSeAVP0l4xBiWcWssF+8YBC+/RaUyMtlt6PQw
 NZQFKAJmtVscilHXLeYLdHS4QdYQ4cwH/ltF8SlnNYDhF77wrbcbPVXmJdXaiKn+gjcVNpxoS
 C13rh8UfETZfSKwk5ykN+2+Wolfbi2Th0mjktArLVVXMKudU0gTPRU66ypGygDFFgb1sn+QXR
 JQrjbHkESpmHFsAYXV6cFs0ASJtbYcad8kGeMdV02uBpSFg1ZzSsn7vCr9YwPTghcFdGKOTvI
 sn2ArxJG+ugLTt21Il3g==
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

<adds virt list>

On Wed, 2020-12-16 at 03:41 +0100, Mike Galbraith wrote:
> Little kvm works fine with nomodeset, so will be busy for a while
> bisecting two other problems that popped up here this cycle. (hohum)
>
> [    1.815561] WARNING: CPU: 7 PID: 355 at drivers/gpu/drm/ttm/ttm_pool.c:365 ttm_pool_alloc+0x41b/0x540 [ttm]
> [    1.815561] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_generic(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pci(E) rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_ring(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) autofs4(E)
> [    1.815589] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G            E     5.10.0.g489e9fe-master #26
> [    1.815590] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [    1.815614] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [    1.815621] RIP: 0010:ttm_pool_alloc+0x41b/0x540 [ttm]
> [    1.815623] Code: fc ff ff 89 ea 48 8d 04 d5 00 00 00 00 48 29 d0 48 8d 3c c5 00 1c 40 a0 e9 d7 fc ff ff 85 c0 0f 89 2f fc ff ff e9 28 fc ff ff <0f> 0b e9 35 fc ff ff 89 e9 49 8b 7d 00 b8 00 10 00 00 48 d3 e0 45
> [    1.815623] RSP: 0018:ffff888105d3b818 EFLAGS: 00010246
> [    1.815625] RAX: 0000000000000000 RBX: ffff888106978800 RCX: 0000000000000000
> [    1.815626] RDX: ffff888105d3bc68 RSI: 0000000000000001 RDI: ffff888106238820
> [    1.815626] RBP: ffff888106238758 R08: ffffc90000296000 R09: 800000000000016b
> [    1.815627] R10: 0000000000000001 R11: ffffc90000296000 R12: 0000000000000000
> [    1.815628] R13: ffff888106238820 R14: 0000000000000000 R15: ffff888106978800
> [    1.815628] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS:0000000000000000
> [    1.815632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.815633] CR2: 00007eff52a0d5b8 CR3: 0000000002010003 CR4: 00000000001706e0
> [    1.815633] Call Trace:
> [    1.815644]  ttm_tt_populate+0xb1/0xc0 [ttm]
> [    1.815647]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
> [    1.815652]  qxl_bo_move+0x230/0x2f0 [qxl]
> [    1.815655]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
> [    1.815657]  ttm_bo_evict+0x124/0x250 [ttm]
> [    1.815693]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
> [    1.815696]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
> [    1.815698]  ttm_bo_mem_space+0x261/0x270 [ttm]
> [    1.815702]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
> [    1.815705]  ttm_bo_validate+0x117/0x150 [ttm]
> [    1.815756]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
> [    1.815772]  qxl_bo_create+0x134/0x1d0 [qxl]
> [    1.815775]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
> [    1.815791]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
> [    1.815794]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
> [    1.815797]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
> [    1.815815]  ? _cond_resched+0x15/0x40
> [    1.815819]  ? ww_mutex_lock_interruptible+0x12/0x60
> [    1.815822]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
> [    1.815841]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
> [    1.815853]  process_one_work+0x1f5/0x3c0
> [    1.815866]  ? process_one_work+0x3c0/0x3c0
> [    1.815867]  worker_thread+0x2d/0x3d0
> [    1.815868]  ? process_one_work+0x3c0/0x3c0
> [    1.815872]  kthread+0x117/0x130
> [    1.815876]  ? kthread_park+0x90/0x90
> [    1.815880]  ret_from_fork+0x1f/0x30
> [    1.815886] ---[ end trace 51e464c1e89a1728 ]---
> [    1.815894] BUG: kernel NULL pointer dereference, address: 0000000000000230
> [    1.815895] #PF: supervisor read access in kernel mode
> [    1.815895] #PF: error_code(0x0000) - not-present page
> [    1.815896] PGD 0 P4D 0
> [    1.815898] Oops: 0000 [#1] SMP NOPTI
> [    1.815900] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G        W   E     5.10.0.g489e9fe-master #26
> [    1.815901] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [    1.815916] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
> [    1.815921] RIP: 0010:dma_map_page_attrs+0xf/0x1c0
> [    1.815922] Code: 1f 17 5b 01 48 85 c0 75 e3 31 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 41 55 41 54 55 53 48 83 ec 08 <48> 8b 87 30 02 00 00 48 85 c0 48 0f 44 05 e7 16 5b 01 41 83 f8 02
> [    1.815923] RSP: 0018:ffff888105d3b7e8 EFLAGS: 00010296
> [    1.815924] RAX: 0000000000001000 RBX: 0000000000000001 RCX: 0000000000001000
> [    1.815924] RDX: 0000000000000000 RSI: ffffea0004171e40 RDI: 0000000000000000
> [    1.815925] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [    1.815925] R10: ffffea0004171e40 R11: ffffc90000296000 R12: 0000000000000001
> [    1.815926] R13: ffff888106238820 R14: ffff888105d07100 R15: ffff888106978800
> [    1.815926] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS:0000000000000000
> [    1.815928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.815929] CR2: 0000000000000230 CR3: 0000000002010003 CR4: 00000000001706e0
> [    1.815929] Call Trace:
> [    1.815937]  ttm_pool_alloc+0x448/0x540 [ttm]
> [    1.815940]  ttm_tt_populate+0xb1/0xc0 [ttm]
> [    1.815942]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
> [    1.815945]  qxl_bo_move+0x230/0x2f0 [qxl]
> [    1.815947]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
> [    1.815949]  ttm_bo_evict+0x124/0x250 [ttm]
> [    1.815982]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
> [    1.815984]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
> [    1.815988]  ttm_bo_mem_space+0x261/0x270 [ttm]
> [    1.890133]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
> [    1.890138]  ttm_bo_validate+0x117/0x150 [ttm]
> [    1.891740]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
> [    1.891744]  qxl_bo_create+0x134/0x1d0 [qxl]
> [    1.893398]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
> [    1.893400]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
> [    1.893402]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
> [    1.893405]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
> [    1.896515]  ? _cond_resched+0x15/0x40
> [    1.896517]  ? ww_mutex_lock_interruptible+0x12/0x60
> [    1.896520]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
> [    1.896533]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
> [    1.896537]  process_one_work+0x1f5/0x3c0
> [    1.900535]  ? process_one_work+0x3c0/0x3c0
> [    1.900536]  worker_thread+0x2d/0x3d0
> [    1.900538]  ? process_one_work+0x3c0/0x3c0
> [    1.902704]  kthread+0x117/0x130
> [    1.902706]  ? kthread_park+0x90/0x90
> [    1.902709]  ret_from_fork+0x1f/0x30
> [    1.902711] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_generic(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E) sysimgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pci(E) rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) virtio_ring(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) scsi_mod(E) autofs4(E)
> [    1.904797] Dumping ftrace buffer:
> [    1.911038]    (ftrace buffer empty)
> [    1.911041] CR2: 0000000000000230
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
