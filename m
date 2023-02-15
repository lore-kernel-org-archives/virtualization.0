Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367D9C05027
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 01:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AA424401CA;
	Wed, 15 Feb 2023 01:46:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA424401CA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K4ym2zpB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eUcJGH8kGj9p; Wed, 15 Feb 2023 01:46:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E1C4B40B79;
	Wed, 15 Feb 2023 01:45:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E1C4B40B79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B382FC0032;
	Wed, 15 Feb 2023 01:45:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 621C4C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 01:45:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 430A0819F6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 01:45:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 430A0819F6
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=K4ym2zpB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pfZ-GBO2Nn11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 01:45:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6171C819ED
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6171C819ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 01:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676425556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z13SvjuRAK6JAGO7hupMx4g/hf9s2/2VYJAPPBUkXPo=;
 b=K4ym2zpBJWUnMf+0wXMsv50817cXGh3P2cWK5R8MfdmMehvzyouxe/DhFcT73tDW05qyvO
 BOIrv32a4sIe5H4/txyB0xOEPY0Ubx78Zy4GoaX3WJq+U2ZQgHDwS+6OA8fObdSmcdqv8N
 BVtU1r8qnnjBIIY0dw0Q71JmnxeT3IQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-18-OzC63Au3OBC8P8-SLLY2VQ-1; Tue, 14 Feb 2023 20:45:52 -0500
X-MC-Unique: OzC63Au3OBC8P8-SLLY2VQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 c9-20020a9d67c9000000b0068d17bf4c93so8620943otn.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 17:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z13SvjuRAK6JAGO7hupMx4g/hf9s2/2VYJAPPBUkXPo=;
 b=vBzpmSRq5dKVvKCIa+m7D2Tr0nvgRMqMgBsXkIhpXT2aUi4dYb4hIMXaJBNot9rsSQ
 88mHjhUDg2jF+J6HeN+qYUIYFwtIB9JyUkFe9+Qsu79TbauDgzrl2a9oldWy5ir4TZPP
 EzBWQE/PoKm1m64oqoy3/KppUwxCJUfpHZK4EIYqPddTV9ziBP01KBk/HuemUJuTF8pb
 OtcUwEto3Z+Mo+aLH0ujAKHY5U4z5OFjAHOWdR4JX1yccgD7jV0LzRigf0QZRiQuyQvF
 DKTz2WYiE8JU2xYFZQfKss9F6dH9bfch4O3qdQ1E52jSZAFe583kMbpHVvNFiPCQ5CIv
 39cA==
X-Gm-Message-State: AO0yUKVDtBI+WRuzsmaePb82EofikhHe0J8VIp3C1cJ1cqLRPjzbuVOz
 oC6+nqdhIdzPjmImyUVrqHSAcPdNkYgbbj+drhxDj8dOefmrj5dmp4d4NXug6GBqwaSgFJCnd38
 J7bQ9RAlF2idaA5Z4htuqN/eVJiZXSum56zGDdMwxCOGg4f9n+IZ+PRQ5xA==
X-Received: by 2002:aca:1119:0:b0:37d:5d77:e444 with SMTP id
 25-20020aca1119000000b0037d5d77e444mr92598oir.35.1676425551297; 
 Tue, 14 Feb 2023 17:45:51 -0800 (PST)
X-Google-Smtp-Source: AK7set9w9gHRXxHk27xEdyGR83Dq4iLC9uil3PZBspRy+TTttuI3bvOJBj1uNqJQezz8luZu/g266O3VxQFOX8woKo8=
X-Received: by 2002:aca:1119:0:b0:37d:5d77:e444 with SMTP id
 25-20020aca1119000000b0037d5d77e444mr92589oir.35.1676425551023; Tue, 14 Feb
 2023 17:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20230214080924.131462-1-lulu@redhat.com>
In-Reply-To: <20230214080924.131462-1-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Feb 2023 09:45:40 +0800
Message-ID: <CACGkMEuidAhBhAD7SsNJ9g6_yH2HKfTC6jr7GvBDu8t=ZQVPpA@mail.gmail.com>
Subject: Re: [PATCH v2] vp_vdpa: fix the crash in hot unplug with vp_vdpa
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

On Tue, Feb 14, 2023 at 4:09 PM Cindy Lu <lulu@redhat.com> wrote:
>
> While unplugging the vp_vdpa device, it triggers a kernel panic
> The root cause is: vdpa_mgmtdev_unregister() will accesses modern
> devices which will cause a use after free.
> So need to change the sequence in vp_vdpa_remove
>
> [  195.003359] BUG: unable to handle page fault for address: ff4e8beb80199014
> [  195.004012] #PF: supervisor read access in kernel mode
> [  195.004486] #PF: error_code(0x0000) - not-present page
> [  195.004960] PGD 100000067 P4D 1001b6067 PUD 1001b7067 PMD 1001b8067 PTE 0
> [  195.005578] Oops: 0000 1 PREEMPT SMP PTI
> [  195.005968] CPU: 13 PID: 164 Comm: kworker/u56:10 Kdump: loaded Not tainted 5.14.0-252.el9.x86_64 #1
> [  195.006792] Hardware name: Red Hat KVM/RHEL, BIOS edk2-20221207gitfff6d81270b5-2.el9 unknown
> [  195.007556] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> [  195.008059] RIP: 0010:ioread8+0x31/0x80
> [  195.008418] Code: 77 28 48 81 ff 00 00 01 00 76 0b 89 fa ec 0f b6 c0 c3 cc cc cc cc 8b 15 ad 72 93 01 b8 ff 00 00 00 85 d2 75 0f c3 cc cc cc cc <8a> 07 0f b6 c0 c3 cc cc cc cc 83 ea 01 48 83 ec 08 48 89 fe 48 c7
> [  195.010104] RSP: 0018:ff4e8beb8067bab8 EFLAGS: 00010292
> [  195.010584] RAX: ffffffffc05834a0 RBX: ffffffffc05843c0 RCX: ff4e8beb8067bae0
> [  195.011233] RDX: ff1bcbd580f88000 RSI: 0000000000000246 RDI: ff4e8beb80199014
> [  195.011881] RBP: ff1bcbd587e39000 R08: ffffffff916fa2d0 R09: ff4e8beb8067ba68
> [  195.012527] R10: 000000000000001c R11: 0000000000000000 R12: ff1bcbd5a3de9120
> [  195.013179] R13: ffffffffc062d000 R14: 0000000000000080 R15: ff1bcbe402bc7805
> [  195.013826] FS:  0000000000000000(0000) GS:ff1bcbe402740000(0000) knlGS:0000000000000000
> [  195.014564] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  195.015093] CR2: ff4e8beb80199014 CR3: 0000000107dea002 CR4: 0000000000771ee0
> [  195.015741] PKRU: 55555554
> [  195.016001] Call Trace:
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
