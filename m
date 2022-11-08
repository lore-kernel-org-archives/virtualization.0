Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B3C433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 16:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4054240331;
	Tue,  8 Nov 2022 16:06:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4054240331
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=Jnq9oeTc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kYBRiceuTNIA; Tue,  8 Nov 2022 16:06:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 70A7040363;
	Tue,  8 Nov 2022 16:06:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70A7040363
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45181C0032;
	Tue,  8 Nov 2022 16:06:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0831FC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 16:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D43EA8130B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 16:06:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D43EA8130B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=Jnq9oeTc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CuO1A9dIqidB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 16:06:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE03F81305
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE03F81305
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 16:06:12 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id a5so23170092edb.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 08:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m2T406pNI28bUQQ3A8W9bWn2Shz/lyjLe+O2Y6ispPQ=;
 b=Jnq9oeTcCH1Tpj98lVXml/65WBw0EfpMCLzrPX5Uv/C9mQrr+UBh6elYHApQKSqTF8
 CIj4E6pjroTzehWmf+7h6B9JvXy8VswPgDWeE+lT9kg0v2zTIf3k4V2BbyKAX0nz7SFT
 XUbUApCo+hcouoOOIuOpVKZyUBu4/O0SIbrt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2T406pNI28bUQQ3A8W9bWn2Shz/lyjLe+O2Y6ispPQ=;
 b=ceqRLg78iLvD3jSSq/3Dt/0C7X0hKwFKLBJfBpydE/2SNmGq3vSsUOHwL9975CBJz7
 +RBuXl0XWDqqL1GLiNdycjiGvC93MYi6iukwaRxWOmusimFLEMZg5NGpw7r/EY0ogI8i
 krD6fkDhMkuhJUkoXumX2PaJD9HQrGrZricfCQFJqpcXLBzLz9UXSCwhK4Wqm5Gp8ySC
 JLqY4qvUs1qQOQSRtkDBBxveuq/sg0xuJUE3AO5/B5N3MyTiDPaRxG6XClusnSrWcrWX
 cJXhsybFSnaLUzU0nuZIAAXRMH1dahQphV/lcTIhpdwATNF8qnURuuKeisP0XEuHG32y
 cNhg==
X-Gm-Message-State: ACrzQf0qJyuj0tedBTP7NjOeDqjedcGm7k5HDQJtNZ87N040H49BPltu
 kD4dV6bQzcHeb/g45riC+KgtPQ==
X-Google-Smtp-Source: AMsMyM6dnVHElWKLyrbfuNXD/0++t2xSFzbDjnTaaTFaY+Hx11m/ofNA5kgjg+irRsB99rFyzo/naA==
X-Received: by 2002:a05:6402:1f84:b0:455:27b8:27aa with SMTP id
 c4-20020a0564021f8400b0045527b827aamr55492446edc.243.1667923570986; 
 Tue, 08 Nov 2022 08:06:10 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 ta19-20020a1709078c1300b0073d796a1043sm4799058ejc.123.2022.11.08.08.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 08:06:10 -0800 (PST)
Date: Tue, 8 Nov 2022 17:06:08 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Wei Li <liwei391@huawei.com>
Subject: Re: [PATCH] drm/qxl: Fix missing free_irq
Message-ID: <Y2p+cFEgvJZMUpoS@phenom.ffwll.local>
References: <20221108151601.1235068-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221108151601.1235068-1-liwei391@huawei.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
Cc: huawei.libin@huawei.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, spice-devel@lists.freedesktop.org,
 David Airlie <airlied@gmail.com>
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

On Tue, Nov 08, 2022 at 11:16:01PM +0800, Wei Li wrote:
> When doing "cat /proc/interrupts" after qxl.ko is unloaded, an oops occurs:
> 
> BUG: unable to handle page fault for address: ffffffffc0274769
> PGD 2a0d067 P4D 2a0d067 PUD 2a0f067 PMD 103f39067 PTE 0
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 6 PID: 246 Comm: cat Not tainted 6.1.0-rc2 #24
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> RIP: 0010:string_nocheck+0x34/0x50
> Code: 66 85 c0 74 3c 83 e8 01 4c 8d 5c 07 01 31 c0 eb 19 49 39 fa 76 03 44 88 07 48 83 c7
> RSP: 0018:ffffc90000893bb8 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffffc90000893c50 RCX: ffff0a00ffffff04
> RDX: ffffffffc0274769 RSI: ffff888102812000 RDI: ffff88810281133e
> RBP: ffff888102812000 R08: ffffffff823fa5e6 R09: 0000000000000007
> R10: ffff888102812000 R11: ffff88820281133d R12: ffffffffc0274769
> R13: ffff0a00ffffff04 R14: 0000000000000cc4 R15: ffffffff823276b4
> FS:  000000000214f8c0(0000) GS:ffff88842fd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffc0274769 CR3: 00000001025c4005 CR4: 0000000000770ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  string+0x46/0x60
>  vsnprintf+0x27a/0x4f0
>  seq_vprintf+0x34/0x50
>  seq_printf+0x53/0x70
>  ? seq_read_iter+0x365/0x450
>  show_interrupts+0x259/0x330
>  seq_read_iter+0x2a3/0x450
>  proc_reg_read_iter+0x47/0x70
>  generic_file_splice_read+0x94/0x160
>  splice_direct_to_actor+0xb0/0x230
>  ? do_splice_direct+0xd0/0xd0
>  do_splice_direct+0x8b/0xd0
>  do_sendfile+0x345/0x4f0
>  __x64_sys_sendfile64+0xa1/0xc0
>  do_syscall_64+0x38/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x4bb0ce
> Code: c3 0f 1f 00 4c 89 d2 4c 89 c6 e9 bd fd ff ff 0f 1f 44 00 00 31 c0 c3 0f 1f 44 00 00
> RSP: 002b:00007ffd99dc3fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> RAX: ffffffffffffffda RBX: 0000000001000000 RCX: 00000000004bb0ce
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000001
> RBP: 0000000000000001 R08: 000000000068f240 R09: 0000000001000000
> R10: 0000000001000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> It seems that qxl doesn't free the interrupt it requests during unload,
> fix this by adding the missing free_irq().
> 
> Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Could we go right ahead and switch over to devm_request_irq? Or does that
not quite do the right thing here?
-Daniel

> ---
>  drivers/gpu/drm/qxl/qxl_kms.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
> index dc3828db1991..d591084824de 100644
> --- a/drivers/gpu/drm/qxl/qxl_kms.c
> +++ b/drivers/gpu/drm/qxl/qxl_kms.c
> @@ -283,6 +283,8 @@ int qxl_device_init(struct qxl_device *qdev,
>  void qxl_device_fini(struct qxl_device *qdev)
>  {
>  	int cur_idx;
> +	struct drm_device *ddev = &qdev->ddev;
> +	struct pci_dev *pdev = to_pci_dev(ddev->dev);
>  
>  	/* check if qxl_device_init() was successful (gc_work is initialized last) */
>  	if (!qdev->gc_work.func)
> @@ -305,6 +307,7 @@ void qxl_device_fini(struct qxl_device *qdev)
>  	wait_event_timeout(qdev->release_event,
>  			   atomic_read(&qdev->release_count) == 0,
>  			   HZ);
> +	free_irq(pdev->irq, ddev);
>  	flush_work(&qdev->gc_work);
>  	qxl_surf_evict(qdev);
>  	qxl_vram_evict(qdev);
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
