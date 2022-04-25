Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E0CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Apr 2022 14:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CC87408BA;
	Mon, 25 Apr 2022 14:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id weIA0l0afeuc; Mon, 25 Apr 2022 14:48:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 938F4408B3;
	Mon, 25 Apr 2022 14:48:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C49DC0032;
	Mon, 25 Apr 2022 14:48:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8DA1C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C6314408B3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kpCgDtJL9xl2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:48:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A6CF1408BA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 14:48:06 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3450EB8180F;
 Mon, 25 Apr 2022 14:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24F6C385A7;
 Mon, 25 Apr 2022 14:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650898083;
 bh=ww5pXTnymTyko+JhDt/z+sYzyuvKFpPMDqKA6sywXRM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oI3h28Wc5sKb8BlpRXgCiExH+YOd9S2re+XAD+p7/QMsMZRNn+xCfQ/hk8uQOVsag
 OY8/yPDJYe9ie7+n4BBybRg0Ro+JKXuNmSZefFKDzhKYSBqeGaBZw1agmrcKGk11cs
 xrLGy4K8XkDS988aeCd+l0ZaFJwzRgDTP3VyNucU=
Date: Mon, 25 Apr 2022 16:48:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shile Zhang <shile.zhang@linux.alibaba.com>
Subject: Re: [PATCH v2] drm/cirrus: fix a NULL vs IS_ERR() checks
Message-ID: <Yma0oHqbznOilrCS@kroah.com>
References: <20220425141043.214024-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220425141043.214024-1-shile.zhang@linux.alibaba.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 virtualization@lists.linux-foundation.org
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

On Mon, Apr 25, 2022 at 10:10:43PM +0800, Shile Zhang wrote:
> The function drm_gem_shmem_vmap can returns error pointers as well,
> which could cause following kernel crash:
> 
> BUG: unable to handle page fault for address: fffffffffffffffc
> PGD 1426a12067 P4D 1426a12067 PUD 1426a14067 PMD 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 12 PID: 3598532 Comm: stress-ng Kdump: loaded Not tainted 5.10.50.x86_64 #1
> ...
> RIP: 0010:memcpy_toio+0x23/0x50
> Code: 00 00 00 00 0f 1f 00 0f 1f 44 00 00 48 85 d2 74 28 40 f6 c7 01 75 2b 48 83 fa 01 76 06 40 f6 c7 02 75 17 48 89 d1 48 c1 e9 02 <f3> a5 f6 c2 02 74 02 66 a5 f6 c2 01 74 01 a4 c3 66 a5 48 83 ea 02
> RSP: 0018:ffffafbf8a203c68 EFLAGS: 00010216
> RAX: 0000000000000000 RBX: fffffffffffffffc RCX: 0000000000000200
> RDX: 0000000000000800 RSI: fffffffffffffffc RDI: ffffafbf82000000
> RBP: ffffafbf82000000 R08: 0000000000000002 R09: 0000000000000000
> R10: 00000000000002b5 R11: 0000000000000000 R12: 0000000000000800
> R13: ffff8a6801099300 R14: 0000000000000001 R15: 0000000000000300
> FS:  00007f4a6bc5f740(0000) GS:ffff8a8641900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffffc CR3: 00000016d3874001 CR4: 00000000003606e0
> Call Trace:
>  drm_fb_memcpy_dstclip+0x5e/0x80 [drm_kms_helper]
>  cirrus_fb_blit_rect.isra.0+0xb7/0xe0 [cirrus]
>  cirrus_pipe_update+0x9f/0xa8 [cirrus]
>  drm_atomic_helper_commit_planes+0xb8/0x220 [drm_kms_helper]
>  drm_atomic_helper_commit_tail+0x42/0x80 [drm_kms_helper]
>  commit_tail+0xce/0x130 [drm_kms_helper]
>  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
>  drm_client_modeset_commit_atomic+0x1c4/0x200 [drm]
>  drm_client_modeset_commit_locked+0x53/0x80 [drm]
>  drm_client_modeset_commit+0x24/0x40 [drm]
>  drm_fbdev_client_restore+0x48/0x85 [drm_kms_helper]
>  drm_client_dev_restore+0x64/0xb0 [drm]
>  drm_release+0xf2/0x110 [drm]
>  __fput+0x96/0x240
>  task_work_run+0x5c/0x90
>  exit_to_user_mode_loop+0xce/0xd0
>  exit_to_user_mode_prepare+0x6a/0x70
>  syscall_exit_to_user_mode+0x12/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f4a6bd82c2b
> 
> Fixes: ab3e023b1b4c9 ("drm/cirrus: rewrite and modernize driver.")
> 
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>

No blank line between those please.

And you need to really really really document why this can not use a
commit that is currently upstream.  And what commit upstream did solve
this and how.  Otherwise we can not take this change, sorry.

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
