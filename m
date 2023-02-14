Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD73CC61DA4
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 06:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EC8D4064C;
	Tue, 14 Feb 2023 06:24:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3EC8D4064C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ToOQRfXq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ycnppruf1XFJ; Tue, 14 Feb 2023 06:24:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A4DF1402D0;
	Tue, 14 Feb 2023 06:24:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4DF1402D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A993C0032;
	Tue, 14 Feb 2023 06:24:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E615C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:24:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 010276103E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:24:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 010276103E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ToOQRfXq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCiBuU5enNtJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:24:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3066360E22
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3066360E22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676355880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PfyXZkWxj/kVv+Py1JHPkitVm0URdtTanKQSxq2Xcgs=;
 b=ToOQRfXqQGig+cqNA+CXKKwoMdvAKDe0r91DwHbAUhSbnirDtzn/zXBwIV+wSSFgy0nT2f
 /f/P4McgtPkCtrcwmGgNGlnr1x79h14ohSeZ0NgqraiOavN+QQYynrdMNerwk3SyYDYgzw
 Lz+D43i/JifkDkjjZaXNncsI/bBFNwk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-203-49YJTPDNNk6-6_A6D3CO7Q-1; Tue, 14 Feb 2023 01:24:38 -0500
X-MC-Unique: 49YJTPDNNk6-6_A6D3CO7Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 t21-20020a056808159500b0037865c70f06so2930102oiw.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 22:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PfyXZkWxj/kVv+Py1JHPkitVm0URdtTanKQSxq2Xcgs=;
 b=Jy2KSqk/yOAWSM20OmGk7LK0uOJKHaoA4TSsGcqL+hU9AubJsRndw5MXiSSPmfEGxE
 QqZuhV3QwURFvbP7H4GSFfOsF0cGYNHIqj1NEBwD8vA1NwOHS9a7C4s6PKJds9cq+HqO
 qJ97D83M18W14ZKJx88y3LM8LIJ0Ozi5070ARZDWiXgkij4Bso3SiGki4J4u7R1F2e2m
 h7AILn13w0HlwUPtxqaehPyYS6QgJR+iqqGXrrbe5mmR9cHl+4Q8C93HC7WQ2M49cT9z
 U0tjhR0adsOynPzIDAAGXDMrhpxxBQ5KM7OPQ6qS34jGlC+tm9PSTxCdx1q2TiqcdujO
 RSfw==
X-Gm-Message-State: AO0yUKX4OPlIvTvQd5kKQrAyQOavKRrRArs9w7FN3Ob+O7Ts4AD2nMzV
 raJG9+ZEwV2D16/2iiGS/8sM6TQrm5AO0WD8QSyEqUpDWjML2cNXD7+NsWUXXiw9G1N/BGcnRzP
 JBbEHUmVu1IdBApHZc28GTETFdJRdSUMRaTORZ4B0/slrqvYydA8nxVPVKQ==
X-Received: by 2002:aca:705:0:b0:363:a978:6d41 with SMTP id
 5-20020aca0705000000b00363a9786d41mr50913oih.280.1676355877782; 
 Mon, 13 Feb 2023 22:24:37 -0800 (PST)
X-Google-Smtp-Source: AK7set85wFwfR2MaBWsTGoOEALdVnhI+98ejjvCKJTzuzpGs9tFx7mVZvQJOj+zj4jc+5ZMBWy/tlBWhNN9fVFxOdxo=
X-Received: by 2002:aca:705:0:b0:363:a978:6d41 with SMTP id
 5-20020aca0705000000b00363a9786d41mr50909oih.280.1676355877530; Mon, 13 Feb
 2023 22:24:37 -0800 (PST)
MIME-Version: 1.0
References: <20230214061743.114257-1-lulu@redhat.com>
In-Reply-To: <20230214061743.114257-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Feb 2023 14:24:26 +0800
Message-ID: <CACGkMEtFbxRqJZiho+kxZqziTXLFm5ySfubdAKJf-+eE-wprvw@mail.gmail.com>
Subject: Re: [PATCH] vp_vdpa: fix the crash in hot unplug with vp_vdpa
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

On Tue, Feb 14, 2023 at 2:17 PM Cindy Lu <lulu@redhat.com> wrote:
>
> While unplugging the vp_vdpa device, the kernel will crash
> The root cause is the function vp_modern_get_status() called following the
> vp_modern_remove().

This needs some tweaking, maybe it's better to say
vdpa_mgmtdev_unregister() will access modern devices which will cause
a use after free.

>So need to change the sequence in vp_vdpa_remove
>
> [  195.016001] Call Trace:

Let's paste the full log with the reason for the calltrace (e.g
general protection fault or whatever else).

> [  195.016233]  <TASK>
> [  195.016434]  vp_modern_get_status+0x12/0x20
> [  195.016823]  vp_vdpa_reset+0x1b/0x50 [vp_vdpa]
> [  195.017238]  virtio_vdpa_reset+0x3c/0x48 [virtio_vdpa]
> [  195.017709]  remove_vq_common+0x1f/0x3a0 [virtio_net]
> [  195.018178]  virtnet_remove+0x5d/0x70 [virtio_net]
> [  195.018618]  virtio_dev_remove+0x3d/0x90
> [  195.018986]  device_release_driver_internal+0x1aa/0x230
> [  195.019466]  bus_remove_device+0xd8/0x150
> [  195.019841]  device_del+0x18b/0x3f0
> [  195.020167]  ? kernfs_find_ns+0x35/0xd0
> [  195.020526]  device_unregister+0x13/0x60
> [  195.020894]  unregister_virtio_device+0x11/0x20
> [  195.021311]  device_release_driver_internal+0x1aa/0x230
> [  195.021790]  bus_remove_device+0xd8/0x150
> [  195.022162]  device_del+0x18b/0x3f0
> [  195.022487]  device_unregister+0x13/0x60
> [  195.022852]  ? vdpa_dev_remove+0x30/0x30 [vdpa]
> [  195.023270]  vp_vdpa_dev_del+0x12/0x20 [vp_vdpa]
> [  195.023694]  vdpa_match_remove+0x2b/0x40 [vdpa]
> [  195.024115]  bus_for_each_dev+0x78/0xc0
> [  195.024471]  vdpa_mgmtdev_unregister+0x65/0x80 [vdpa]
> [  195.024937]  vp_vdpa_remove+0x23/0x40 [vp_vdpa]
> [  195.025353]  pci_device_remove+0x36/0xa0
> [  195.025719]  device_release_driver_internal+0x1aa/0x230
> [  195.026201]  pci_stop_bus_device+0x6c/0x90
> [  195.026580]  pci_stop_and_remove_bus_device+0xe/0x20
> [  195.027039]  disable_slot+0x49/0x90
> [  195.027366]  acpiphp_disable_and_eject_slot+0x15/0x90
> [  195.027832]  hotplug_event+0xea/0x210
> [  195.028171]  ? hotplug_event+0x210/0x210
> [  195.028535]  acpiphp_hotplug_notify+0x22/0x80
> [  195.028942]  ? hotplug_event+0x210/0x210
> [  195.029303]  acpi_device_hotplug+0x8a/0x1d0
> [  195.029690]  acpi_hotplug_work_fn+0x1a/0x30
> [  195.030077]  process_one_work+0x1e8/0x3c0
> [  195.030451]  worker_thread+0x50/0x3b0
> [  195.030791]  ? rescuer_thread+0x3a0/0x3a0
> [  195.031165]  kthread+0xd9/0x100
> [  195.031459]  ? kthread_complete_and_exit+0x20/0x20
> [  195.031899]  ret_from_fork+0x22/0x30
> [  195.032233]  </TASK>
>
> Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
> Tested-by: Lei Yang <leiyang@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cindy Lu <lulu@redhat.com>

Other than above,

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 8fe267ca3e76..281287fae89f 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -645,8 +645,8 @@ static void vp_vdpa_remove(struct pci_dev *pdev)
>         struct virtio_pci_modern_device *mdev = NULL;
>
>         mdev = vp_vdpa_mgtdev->mdev;
> -       vp_modern_remove(mdev);
>         vdpa_mgmtdev_unregister(&vp_vdpa_mgtdev->mgtdev);
> +       vp_modern_remove(mdev);
>         kfree(vp_vdpa_mgtdev->mgtdev.id_table);
>         kfree(mdev);
>         kfree(vp_vdpa_mgtdev);
> --
> 2.34.3
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
