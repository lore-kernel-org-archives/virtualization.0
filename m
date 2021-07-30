Return-Path: <SRS0=ej4m=MW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DEAR_SOMETHING,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81DEC4338F
	for <virtualization@archiver.kernel.org>; Fri, 30 Jul 2021 11:43:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 624FF60232
	for <virtualization@archiver.kernel.org>; Fri, 30 Jul 2021 11:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 624FF60232
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F3F040104;
	Fri, 30 Jul 2021 11:43:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U_Xa9cm53W7w; Fri, 30 Jul 2021 11:42:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3D979400E4;
	Fri, 30 Jul 2021 11:42:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0237EC001A;
	Fri, 30 Jul 2021 11:42:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76958C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 11:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66B356069C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 11:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pXIiyWOOzHtM
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 11:42:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47AB060619
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 11:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627645374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aCLtm9dFHn+w/SB2693+ZgZ2eFgaS9vHe74MS+otrP0=;
 b=AEEuoqJURvixSAf8obOBWd0uNxjcx9bXqz1v/KG+Ha6aVYw0Ki3X+mkDvqcgrOna6BPFIy
 22/qxyyh5ELA1yAKEb32XGr3RDMJMMSZASG5zO8Ht1AdjX34oFV81Bt0VztYndNxcKteV/
 gUPn6fu+HWXZhawTtd+io39yJUE67g0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-SPl08tOrNgSDQpoRoHRseg-1; Fri, 30 Jul 2021 07:42:53 -0400
X-MC-Unique: SPl08tOrNgSDQpoRoHRseg-1
Received: by mail-ej1-f69.google.com with SMTP id
 x5-20020a1709064bc5b02905305454f5d1so2992807ejv.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 04:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aCLtm9dFHn+w/SB2693+ZgZ2eFgaS9vHe74MS+otrP0=;
 b=Fs1F4VoxPFbWRXgWzWsnX2RXysMMlPnwynC8sSDolfgL7zM+KoAs60SUBTWdupXIUS
 dNlUx2M9u+cq9nVLF8IBw+L/vGV7ypiqgo6nnZ7QBa8SpXfojbM/JfKHZUTmCQeMZYDO
 6Ouea+3GSRadL5x5LEicfhBFJpvzgedOWQMQech/Zgde0Jl3owolSCZ109P0cP8JOLRT
 V0kTlJgRZmzasoaHrtWF73Itgs9fBnmxhEd9p/E5jruMjWPMxlL+f+fAewvAedJbWgyX
 J1t86iItebYM7DYmG/bP6GxQodKsg1ErRCCxhot1tW6RXUSDtcWBt3G8xkxzo6dxJpoJ
 WmIg==
X-Gm-Message-State: AOAM532ltVyh3Xiag/RR8Ag5f9g/f6yJmjX9YqSP83aI1JsqrEoGpBCN
 8HS9GEPThQ9Si/CspqdT7ioRXKD/47NP3fAhIN3aG1uivgUX3E8WPiZwn53qfIEBCtNkTTT1NsD
 yUJUgjF8xbgykTvlybi0LMJLYUIURdXI7i6qOdDT8Cg==
X-Received: by 2002:a17:906:170e:: with SMTP id
 c14mr2099518eje.40.1627645370366; 
 Fri, 30 Jul 2021 04:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLMex01yosXP2wcgUw3UaUEOh1RjmU459A47bxcVoWsy5QaUxlIHWfCdcjeeCPj1w80hxeYA==
X-Received: by 2002:a17:906:170e:: with SMTP id
 c14mr2099508eje.40.1627645370200; 
 Fri, 30 Jul 2021 04:42:50 -0700 (PDT)
Received: from redhat.com ([2.55.154.10])
 by smtp.gmail.com with ESMTPSA id r15sm574960edw.46.2021.07.30.04.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 04:42:48 -0700 (PDT)
Date: Fri, 30 Jul 2021 07:42:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ivan <ivan@prestigetransportation.com>
Subject: Re: PROBLEM: virtio_net LRO kernel panics
Message-ID: <20210730073029-mutt-send-email-mst@kernel.org>
References: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACFia2dwacaVVYD+1uG=CDGaJqdCOSBvZ5FcXp04caecaWAY3w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Jul 22, 2021 at 06:27:18PM -0500, Ivan wrote:
> Dear Sir,
> 
> I've been plagued with kernel panics recently. The problem is easily
> reproducible on any virtual machine that uses the virtio-net driver
> from stock Linux kernel. Simply isuse this command:
> 
> echo 1 > /proc/sys/net/ipv4/ip_forward
> ...and the kernel panics.
> 
> Is there any way we can possibly fix this?
> 
> kernel: ------------[ cut here ]------------
> kernel: netdevice: eth0: failed to disable LRO!
> kernel: WARNING: CPU: 1 PID: 424 at net/core/dev.c:1768
> dev_disable_lro+0x108/0x150
> kernel: Modules linked in: nls_iso8859_1 nls_cp437 vfat fat usbhid
> atkbd libps2 ahci libahci virtio_net ohci_pci net_failover failover
> i8042 serio lpc_ich mfd_core libata ohci_hcd ehci_pci ehci_hcd usbcore
> rng_core i2c_piix4 i2c_core virtio_pci usb_common
> virtio_pci_modern_dev virtio_ring virtio loop unix
> kernel: CPU: 1 PID: 424 Comm: bash Not tainted 5.13.4-gnu.4-NuMini #1
> kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> kernel: RIP: 0010:dev_disable_lro+0x108/0x150
> kernel: Code: ae 88 74 14 be 25 00 00 00 48 89 df e8 f1 54 ed ff 48 85
> c0 48 0f 44 eb 4c 89 e2 48 89 ee 48 c7 c7 00 c6 ae 88 e8 7a 76 0c 00
> <0f> 0b e9 2d ff ff ff 80 3d e8 70 97 00 00 49 c7 c4 73 bb ae 88 75
> kernel: RSP: 0018:ffffb596c0237d80 EFLAGS: 00010282
> kernel: RAX: 0000000000000000 RBX: ffff9af9c1835000 RCX: ffff9af9fed17538
> kernel: RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9af9fed17530
> kernel: RBP: ffff9af9c1835000 R08: ffffffff88c96ac8 R09: 0000000000004ffb
> kernel: R10: 00000000fffff000 R11: 3fffffffffffffff R12: ffffffff88ac7c3d
> kernel: R13: 0000000000000000 R14: ffffffff88cb2748 R15: ffff9af9c12166c8
> kernel: FS:  00007fd4911b8740(0000) GS:ffff9af9fed00000(0000)
> knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000532008 CR3: 000000000115c000 CR4: 00000000000406e0
> kernel: Call Trace:
> kernel:  devinet_sysctl_forward+0x1ac/0x1e0
> kernel:  proc_sys_call_handler+0x127/0x230
> kernel:  new_sync_write+0x114/0x1a0
> kernel:  vfs_write+0x18c/0x220
> kernel:  ksys_write+0x5a/0xd0
> kernel:  do_syscall_64+0x45/0x80
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
> kernel: RIP: 0033:0x7fd4912b79b3
> kernel: Code: 8b 15 b9 74 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb
> b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05
> <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> kernel: RSP: 002b:00007ffe96fdd858 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> kernel: RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd4912b79b3
> kernel: RDX: 0000000000000002 RSI: 0000000000536810 RDI: 0000000000000001
> kernel: RBP: 0000000000536810 R08: 000000000000000a R09: 0000000000000000
> kernel: R10: 00007fd49134f040 R11: 0000000000000246 R12: 0000000000000002
> kernel: R13: 00007fd4913906c0 R14: 00007fd49138c520 R15: 00007fd49138b920
> kernel: ---[ end trace ee7985b10570603d ]---
> kernel: ------------[ cut here ]------------

So the warning is easy to reproduce.
On qemu/kvm just set ctrl_guest_offloads=off for the device.

The panic does not seem to trigger for me and you did not provide
any data about it.  What happens? Does guest just freeze?

I am guessing the issue is that dev_disable_lro does not report the
return status and inet_forward_change assumes it's successful.  We then
end up with LRO packets in unexpected places.

Cc netdev and a bunch of people who might have a better idea.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
