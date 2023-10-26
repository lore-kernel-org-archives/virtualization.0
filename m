Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC24C25B48
	for <virtualization@archiver.kernel.org>; Thu, 26 Oct 2023 05:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6715C824BD;
	Thu, 26 Oct 2023 05:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6715C824BD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JgAT0G3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AqfOi0e-_DIm; Thu, 26 Oct 2023 05:26:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DC6118249E;
	Thu, 26 Oct 2023 05:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC6118249E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB71BC0071;
	Thu, 26 Oct 2023 05:26:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FD7CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 05:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D02B41E89
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 05:26:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1D02B41E89
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JgAT0G3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BkPou7zfJb_K
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 05:26:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0E8E41E86
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Oct 2023 05:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E0E8E41E86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698297979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqJae009xBE3KugPekEbv710hZP/gPekJx6jWnYEm18=;
 b=JgAT0G3BB849gntQyo50lTSDuWijcogLeE8jAimsuRdNV32LBZ+88cGs1aib3mP43L/zpE
 iimHtyKfGV8/z2itQxlP5qJNXWu3aKurAZnwUrMymWg+2WXoOy39DSzcsX2bgRrIsJaK5P
 IFWZ0kpwen6DxBw57UKHIq5VuwKO7Z8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-PV_bShr6Nw2qzw95qjR0aA-1; Thu, 26 Oct 2023 01:26:16 -0400
X-MC-Unique: PV_bShr6Nw2qzw95qjR0aA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c50ef18b04so4384731fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 22:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698297975; x=1698902775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqJae009xBE3KugPekEbv710hZP/gPekJx6jWnYEm18=;
 b=WmMbbmi4EWOGuprRV2oW6+C63Of9lHCUIQXOIhFyUdLBAKZqRjr/WKn/Yb6bptcG/j
 6ftOOPbYA2eQRXDDR0DpMcVG9k2002fYJVqFpwSBKvRDTk+/Ee/DChRcax/ILU2T5TeK
 JuVCqe+Z4cxqEE9bXYeb+mAOzNxROahkTggfd31ga9/loUynaC5WAU2a5RojeMKADPef
 CHjRkOb8u13fgn4mDplIVl5Q9Hl0dw8czoOlACmqPEcfqHKU/1df+Y5q4jxL9BsxGFi5
 GMwln/roze7hySboAR3unRe9xorkcIwRbTuvUX00uRI479LcgoKxjGGBT5I5cjcfk+I5
 h7uA==
X-Gm-Message-State: AOJu0YysHgARjxhesjGWv4uqXfj9ah37oLI6Du29Ut3BpZrAz4sFuFH9
 d7aDAltbMtrhsDRiXlbr46bnrJe5Ada4NY3Q/5VwICBUaXnlytt2MzLHaf7ymIyKqX7gUgKpbYl
 IZckPuhzUtOB71r36MmjeUkWso115N1XxiK9NG8V+iQ==
X-Received: by 2002:a2e:7a0b:0:b0:2c5:1075:5ec9 with SMTP id
 v11-20020a2e7a0b000000b002c510755ec9mr10995821ljc.13.1698297975213; 
 Wed, 25 Oct 2023 22:26:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvK8TcWtAa7HeN38eCIs/EyjZjcjRrw4ST8tbuymn5lLBsYCwz56XxpCAwv10LfG1bqXWNzw==
X-Received: by 2002:a2e:7a0b:0:b0:2c5:1075:5ec9 with SMTP id
 v11-20020a2e7a0b000000b002c510755ec9mr10995811ljc.13.1698297974852; 
 Wed, 25 Oct 2023 22:26:14 -0700 (PDT)
Received: from redhat.com ([2.52.26.119]) by smtp.gmail.com with ESMTPSA id
 g11-20020adffc8b000000b0032dc24ae625sm13339764wrr.12.2023.10.25.22.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:26:14 -0700 (PDT)
Date: Thu, 26 Oct 2023 01:26:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vhost-vdpa: fix use-after-free in _compat_vdpa_reset
Message-ID: <20231026012326-mutt-send-email-mst@kernel.org>
References: <1698275594-19204-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1698275594-19204-1-git-send-email-si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org,
 leiyang@redhat.com
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

On Wed, Oct 25, 2023 at 04:13:14PM -0700, Si-Wei Liu wrote:
> When the vhost-vdpa device is being closed, vhost_vdpa_cleanup() doesn't
> clean up the vqs pointer after free. This could lead to use-after-tree
> when _compat_vdpa_reset() tries to access the vqs that are freed already.
> Fix is to set vqs pointer to NULL at the end of vhost_vdpa_cleanup()
> after getting freed, which is guarded by atomic opened state.
> 
>   BUG: unable to handle page fault for address: 00000001005b4af4
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 16a80a067 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 4 PID: 40387 Comm: qemu-kvm Not tainted 6.6.0-rc7+ #3
>   Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.8.2 09/14/2022
>   RIP: 0010:_compat_vdpa_reset.isra.0+0x27/0xb0 [vhost_vdpa]
>   Code: 90 90 90 0f 1f 44 00 00 41 55 4c 8d ae 08 03 00 00 41 54 55 48
>   89 f5 53 4c 8b a6 00 03 00 00 48 85 ff 74 49 48 8b 07 4c 89 ef <48> 8b
>   80 88 45 00 00 48 c1 e8 08 48 83 f0 01 89 c3 e8 73 5e 9b dc
>   RSP: 0018:ff73a85762073ba0 EFLAGS: 00010286
>   RAX: 00000001005b056c RBX: ff32b13ca6994c68 RCX: 0000000000000002
>   RDX: 0000000000000001 RSI: ff32b13c07559000 RDI: ff32b13c07559308
>   RBP: ff32b13c07559000 R08: 0000000000000000 R09: ff32b12ca497c0f0
>   R10: ff73a85762073c58 R11: 0000000c106f9de3 R12: ff32b12c95b1d050
>   R13: ff32b13c07559308 R14: ff32b12d0ddc5100 R15: 0000000000008002
>   FS:  00007fec5b8cbf80(0000) GS:ff32b13bbfc80000(0000)
>   knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00000001005b4af4 CR3: 000000015644a003 CR4: 0000000000773ee0
>   PKRU: 55555554
>   Call Trace:
>    <TASK>
>    ? __die+0x20/0x70
>    ? page_fault_oops+0x76/0x170
>    ? exc_page_fault+0x65/0x150
>    ? asm_exc_page_fault+0x22/0x30
>    ? _compat_vdpa_reset.isra.0+0x27/0xb0 [vhost_vdpa]
>    vhost_vdpa_open+0x57/0x280 [vhost_vdpa]
>    ? __pfx_chrdev_open+0x10/0x10
>    chrdev_open+0xc6/0x260
>    ? __pfx_chrdev_open+0x10/0x10
>    do_dentry_open+0x16e/0x530
>    do_open+0x21c/0x400
>    path_openat+0x111/0x290
>    do_filp_open+0xb2/0x160
>    ? __check_object_size.part.0+0x5e/0x140
>    do_sys_openat2+0x96/0xd0
>    __x64_sys_openat+0x53/0xa0
>    do_syscall_64+0x59/0x90
>    ? syscall_exit_to_user_mode+0x22/0x40
>    ? do_syscall_64+0x69/0x90
>    ? syscall_exit_to_user_mode+0x22/0x40
>    ? do_syscall_64+0x69/0x90
>    ? do_syscall_64+0x69/0x90
>    ? syscall_exit_to_user_mode+0x22/0x40
>    ? do_syscall_64+0x69/0x90
>    ? exc_page_fault+0x65/0x150
>    entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> Fixes: 10cbf8dfaf93 ("vhost-vdpa: clean iotlb map during reset for older userspace")
> Fixes: ac7e98c73c05 ("vhost-vdpa: fix NULL pointer deref in _compat_vdpa_reset")

So these two are all in next correct?

I really do not like it how 10cbf8dfaf936e3ef1f5d7fdc6e9dada268ba6bb
introduced a regression and then apparently we keep fixing things up?

Can I squash these 3 commits?


> Reported-by: Lei Yang <leiyang@redhat.com>
> Closes: https://lore.kernel.org/all/CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com/
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vhost/vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 9a2343c45df0..30df5c58db73 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1355,6 +1355,7 @@ static void vhost_vdpa_cleanup(struct vhost_vdpa *v)
>  	vhost_vdpa_free_domain(v);
>  	vhost_dev_cleanup(&v->vdev);
>  	kfree(v->vdev.vqs);
> +	v->vdev.vqs = NULL;
>  }
>  
>  static int vhost_vdpa_open(struct inode *inode, struct file *filep)
> -- 
> 2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
