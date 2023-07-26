Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DD9C001DC
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 19:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B319E41E53;
	Wed, 26 Jul 2023 19:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B319E41E53
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FwhY0I1w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgN26yPEZAjM; Wed, 26 Jul 2023 19:26:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B5EFF41E52;
	Wed, 26 Jul 2023 19:26:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5EFF41E52
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FF17C0072;
	Wed, 26 Jul 2023 19:26:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A7B9C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:26:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D45541E53
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:26:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D45541E53
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKs7OIqruRSp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:26:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 163C641E52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 19:26:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 163C641E52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690399571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QkdPaek5f1FanK35487dKzMjIw8QbmtgDnYh28e2FyU=;
 b=FwhY0I1wTYTefUSEnsOfpEy8kwZEaS6ENx2qXa7U2CiJr2pUj7Pob6B2WO9PcXtFnOCNfX
 3SZJkQ0XGq/aZu+SpP0wDRUV70fAeAhJfnYPoI8+TeH56hhfWGnGfxwLSRfgWGuHFT2zfe
 lXMVObNg5WJ5WKjlKaPnpj51wv7f7RE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-26oqi3PqMzOJwrJsgIJmfQ-1; Wed, 26 Jul 2023 15:26:10 -0400
X-MC-Unique: 26oqi3PqMzOJwrJsgIJmfQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-992e6840901so10068866b.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 12:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690399569; x=1691004369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QkdPaek5f1FanK35487dKzMjIw8QbmtgDnYh28e2FyU=;
 b=M22xuNh9F4Fw+a9yoj/5wWq9u3M5naUvwt2tyvuJsiben0IA3Xe9FVaBB0KjSSwTs1
 M50sIRvVhOniCb7eyasJFIyeB/5opnuaDhS2MBvESmNjZ6i76vVFoX5lDYztH+cz4vyb
 s6Lf9IlZ/Ns/eg2P/dMv1ls+FRyS2gA7VXTIJpF3CSXSnuw6B61M4nMRDVKMMoVz/3Ce
 QmGT1Ev8pcBDbhWzeW4ouckwSiCWRIdhX9Be4RHoGnqxiVK39JMDdBSODcrByauIOmgm
 8hWbF08wY6YKYUr8AbGCCe6sLA8nDxEUIf9lQ7aU3Nr5L60Rs1+2Hf3fd4wRdUAk4lLL
 IJRg==
X-Gm-Message-State: ABy/qLbTOKdQ5H9vILPWZ4+3tVIx3h1i/i1hQKxnKAXDfJI31u/J+iqk
 2+2ZtyPMqe/Osr6c3a9a4cWEO29yzis2pT+brJiEynl6YDoL9KxngnD1zAxX4V3IKKBAT4wHWmu
 x/BxNNbfPjoZ/23OsoqknUE1pUX3o2CxGcsuyg+029g==
X-Received: by 2002:a17:906:7a1a:b0:98f:8481:24b3 with SMTP id
 d26-20020a1709067a1a00b0098f848124b3mr10142ejo.37.1690399569534; 
 Wed, 26 Jul 2023 12:26:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF1DJIMjJPX08OnwgjVJDKrkbXm/nIe3Nj2diSzSRP5PXQM82cX2dmpXgUNgZAmCrFVe02K0w==
X-Received: by 2002:a17:906:7a1a:b0:98f:8481:24b3 with SMTP id
 d26-20020a1709067a1a00b0098f848124b3mr10130ejo.37.1690399569230; 
 Wed, 26 Jul 2023 12:26:09 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 se10-20020a170906ce4a00b0098dfec235ccsm9894085ejb.47.2023.07.26.12.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 12:26:06 -0700 (PDT)
Date: Wed, 26 Jul 2023 15:26:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Message-ID: <20230726152258-mutt-send-email-mst@kernel.org>
References: <20230726190744.14143-1-dtatulea@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230726190744.14143-1-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Saeed Mahameed <saeedm@nvidia.com>
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

On Wed, Jul 26, 2023 at 10:07:38PM +0300, Dragos Tatulea wrote:
> The ndev was accessed on shutdown without a check if it actually exists.
> This triggered the crash pasted below. This patch simply adds a check
> before using ndev.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000300
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP
>  CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.5.0-rc2_for_upstream_min_debug_2023_07_17_15_05 #1
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
>  RSP: 0018:ffff8881003bfdc0 EFLAGS: 00010286
>  RAX: ffff888103befba0 RBX: ffff888109d28008 RCX: 0000000000000017
>  RDX: 0000000000000001 RSI: 0000000000000212 RDI: ffff888109d28000
>  RBP: 0000000000000000 R08: 0000000d3a3a3882 R09: 0000000000000001
>  R10: 0000000000000000 R11: 0000000000000000 R12: ffff888109d28000
>  R13: ffff888109d28080 R14: 00000000fee1dead R15: 0000000000000000
>  FS:  00007f4969e0be40(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000000000000300 CR3: 00000001051cd006 CR4: 0000000000370eb0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   ? __die+0x20/0x60
>   ? page_fault_oops+0x14c/0x3c0
>   ? exc_page_fault+0x75/0x140
>   ? asm_exc_page_fault+0x22/0x30
>   ? mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
>   device_shutdown+0x13e/0x1e0
>   kernel_restart+0x36/0x90
>   __do_sys_reboot+0x141/0x210
>   ? vfs_writev+0xcd/0x140
>   ? handle_mm_fault+0x161/0x260
>   ? do_writev+0x6b/0x110
>   do_syscall_64+0x3d/0x90
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  RIP: 0033:0x7f496990fb56
>  RSP: 002b:00007fffc7bdde88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
>  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f496990fb56
>  RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
>  RBP: 00007fffc7bde1d0 R08: 0000000000000000 R09: 0000000000000000
>  R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
>  R13: 00007fffc7bddf10 R14: 0000000000000000 R15: 00007fffc7bde2b8
>   </TASK>
>  CR2: 0000000000000300
>  ---[ end trace 0000000000000000 ]---
> 
> Fixes: bc9a2b3e686e ("vdpa/mlx5: Support interrupt bypassing")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9138ef2fb2c8..e2e7ebd71798 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3556,7 +3556,8 @@ static void mlx5v_shutdown(struct auxiliary_device *auxdev)
>  	mgtdev = auxiliary_get_drvdata(auxdev);
>  	ndev = mgtdev->ndev;
>  
> -	free_irqs(ndev);
> +	if (ndev)
> +		free_irqs(ndev);
>  }
>  

something I don't get:
irqs are allocated in mlx5_vdpa_dev_add
why are they not freed in mlx5_vdpa_dev_del?

this is what's creating all this mess.



>  static const struct auxiliary_device_id mlx5v_id_table[] = {
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
