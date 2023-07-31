Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E123C001DF
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 09:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C386F60AEC;
	Mon, 31 Jul 2023 09:08:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C386F60AEC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EDuIJXCT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RDrqT54h8xHY; Mon, 31 Jul 2023 09:08:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A2B660A7D;
	Mon, 31 Jul 2023 09:08:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A2B660A7D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEA87C0072;
	Mon, 31 Jul 2023 09:08:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 158EDC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 09:08:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D13D581468
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 09:08:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D13D581468
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EDuIJXCT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 56Ho2Vb5B8qG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 09:08:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9363880B28
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 09:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9363880B28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690794502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JhMHpWsBC5u5G9m5oRJ1ACqYl1UUoNNRgOZgltuXZhY=;
 b=EDuIJXCT6SuHHl1GeGwXt/EVpSA6nNsLkoAS3X6cgXDZVGcmtzFfKAbNSOkuWT4u/5qdvK
 YPqFWk3Uy5eWUdhPHilJNJog6/uqA7hnq1pXOn0TvAPdnxy4bGXYMCrmbF/jDpVsf2zZlO
 rCKVG+psh4v6inbppPkQxGDGEDAqqKs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-CI_9IyLNOGKLDWIoaIYVlg-1; Mon, 31 Jul 2023 05:08:20 -0400
X-MC-Unique: CI_9IyLNOGKLDWIoaIYVlg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bfe6a531bso137463566b.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 02:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690794499; x=1691399299;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JhMHpWsBC5u5G9m5oRJ1ACqYl1UUoNNRgOZgltuXZhY=;
 b=GjDwDSAczDsZw+TEc9UNOt7rT7At8ZYIHR3GcTE4BKf0bBCVPiHncPaJ8w8xlmlx+e
 hB4VXTa1fd/HsGJWFiK0jG3zj7JFMkjMfA4LKZZ0NaVgt3hk8q9AepRY691aH54JzVb8
 qeRC77g/SNy64PjJHYltRnHHRZc6lo8U3IuizJtM3Kyg8sed5VViP6dhYpLl0JdLeofd
 XUj2ZmOucaQW3CAj1dopOylQwaXoJNHjWz9MS8X6J+bfEjNSg7ZpEMZMoPX5d6YbDv77
 5GmoPkYxlIKWomnkcD1eC1k06HI7iHsDmRvNF0UAIQPDk7euGqRKPrqgxF3AFPdD02Yp
 Ne+A==
X-Gm-Message-State: ABy/qLacnVongY/m9Gi6SKnYwVPaI9JLoc6ccFi+g0rzcwZvua7Sqn0Q
 Ung8Wkrky+5JTbHO3G1aux4Gpa/GpwSujG5uEv7MePnniRDHgrEkfsHQS3L9N5ETPgDD27gGIBD
 Ic0UywR7eBNAd4HSMcnBDFClyloPCh/lC3Tj0lMP28Q==
X-Received: by 2002:a17:907:75ce:b0:994:1956:2331 with SMTP id
 jl14-20020a17090775ce00b0099419562331mr6437126ejc.13.1690794499253; 
 Mon, 31 Jul 2023 02:08:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdxt26dJCrujviicMYhQDvqZJu0RkOuDNX32idC8ybN2zSZ8mePWWmO940lBUnRalqQwW5Hw==
X-Received: by 2002:a17:907:75ce:b0:994:1956:2331 with SMTP id
 jl14-20020a17090775ce00b0099419562331mr6437107ejc.13.1690794498857; 
 Mon, 31 Jul 2023 02:08:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e0:3800:a16e:b2a0:7d06:58aa])
 by smtp.gmail.com with ESMTPSA id
 j25-20020a170906255900b0099b4d86fbccsm5960383ejb.141.2023.07.31.02.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 02:08:18 -0700 (PDT)
Date: Mon, 31 Jul 2023 05:08:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Message-ID: <20230731050200-mutt-send-email-mst@kernel.org>
References: <20230726190744.14143-1-dtatulea@nvidia.com>
 <20230726152258-mutt-send-email-mst@kernel.org>
 <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
 <20230727122633-mutt-send-email-mst@kernel.org>
 <b97484f15824c86f5cee4fe673794f17419bcb1b.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <b97484f15824c86f5cee4fe673794f17419bcb1b.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Jul 31, 2023 at 07:15:31AM +0000, Dragos Tatulea wrote:
> On Thu, 2023-07-27 at 12:28 -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 27, 2023 at 04:02:16PM +0000, Dragos Tatulea wrote:
> > > On Wed, 2023-07-26 at 15:26 -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Jul 26, 2023 at 10:07:38PM +0300, Dragos Tatulea wrote:
> > > > > The ndev was accessed on shutdown without a check if it actually =
exists.
> > > > > This triggered the crash pasted below. This patch simply adds a c=
heck
> > > > > before using ndev.
> > > > > =

> > > > > =A0BUG: kernel NULL pointer dereference, address: 0000000000000300
> > > > > =A0#PF: supervisor read access in kernel mode
> > > > > =A0#PF: error_code(0x0000) - not-present page
> > > > > =A0PGD 0 P4D 0
> > > > > =A0Oops: 0000 [#1] SMP
> > > > > =A0CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.5.0-
> > > > > rc2_for_upstream_min_debug_2023_07_17_15_05 #1
> > > > > =A0Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1=
.13.0-0-
> > > > > gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > > =A0RIP: 0010:mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > > > > =A0RSP: 0018:ffff8881003bfdc0 EFLAGS: 00010286
> > > > > =A0RAX: ffff888103befba0 RBX: ffff888109d28008 RCX: 0000000000000=
017
> > > > > =A0RDX: 0000000000000001 RSI: 0000000000000212 RDI: ffff888109d28=
000
> > > > > =A0RBP: 0000000000000000 R08: 0000000d3a3a3882 R09: 0000000000000=
001
> > > > > =A0R10: 0000000000000000 R11: 0000000000000000 R12: ffff888109d28=
000
> > > > > =A0R13: ffff888109d28080 R14: 00000000fee1dead R15: 0000000000000=
000
> > > > > =A0FS:=A0 00007f4969e0be40(0000) GS:ffff88852c800000(0000)
> > > > > knlGS:0000000000000000
> > > > > =A0CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > =A0CR2: 0000000000000300 CR3: 00000001051cd006 CR4: 0000000000370=
eb0
> > > > > =A0DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000=
000
> > > > > =A0DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000=
400
> > > > > =A0Call Trace:
> > > > > =A0 <TASK>
> > > > > =A0 ? __die+0x20/0x60
> > > > > =A0 ? page_fault_oops+0x14c/0x3c0
> > > > > =A0 ? exc_page_fault+0x75/0x140
> > > > > =A0 ? asm_exc_page_fault+0x22/0x30
> > > > > =A0 ? mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > > > > =A0 device_shutdown+0x13e/0x1e0
> > > > > =A0 kernel_restart+0x36/0x90
> > > > > =A0 __do_sys_reboot+0x141/0x210
> > > > > =A0 ? vfs_writev+0xcd/0x140
> > > > > =A0 ? handle_mm_fault+0x161/0x260
> > > > > =A0 ? do_writev+0x6b/0x110
> > > > > =A0 do_syscall_64+0x3d/0x90
> > > > > =A0 entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > > > =A0RIP: 0033:0x7f496990fb56
> > > > > =A0RSP: 002b:00007fffc7bdde88 EFLAGS: 00000206 ORIG_RAX: 00000000=
000000a9
> > > > > =A0RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f496990f=
b56
> > > > > =A0RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1d=
ead
> > > > > =A0RBP: 00007fffc7bde1d0 R08: 0000000000000000 R09: 0000000000000=
000
> > > > > =A0R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000=
000
> > > > > =A0R13: 00007fffc7bddf10 R14: 0000000000000000 R15: 00007fffc7bde=
2b8
> > > > > =A0 </TASK>
> > > > > =A0CR2: 0000000000000300
> > > > > =A0---[ end trace 0000000000000000 ]---
> > > > > =

> > > > > Fixes: bc9a2b3e686e ("vdpa/mlx5: Support interrupt bypassing")
> > > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > > ---
> > > > > =A0drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
> > > > > =A01 file changed, 2 insertions(+), 1 deletion(-)
> > > > > =

> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 9138ef2fb2c8..e2e7ebd71798 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -3556,7 +3556,8 @@ static void mlx5v_shutdown(struct auxiliary=
_device
> > > > > *auxdev)
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0mgtdev =3D auxiliary_get_drvdata(auxdev);
> > > > > =A0=A0=A0=A0=A0=A0=A0=A0ndev =3D mgtdev->ndev;
> > > > > =A0
> > > > > -=A0=A0=A0=A0=A0=A0=A0free_irqs(ndev);
> > > > > +=A0=A0=A0=A0=A0=A0=A0if (ndev)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0free_irqs(ndev);
> > > > > =A0}
> > > > > =A0
> > > > =

> > > > something I don't get:
> > > > irqs are allocated in mlx5_vdpa_dev_add
> > > > why are they not freed in mlx5_vdpa_dev_del?
> > > > =

> > > That is a good point. I will try to find out. I also don't get why fr=
ee_irq
> > > is
> > > called in the vdpa dev .free op instead of mlx5_vdpa_dev_del. Maybe I=
 can
> > > change
> > > that in a different refactoring.
> > =

> > as it is I have no idea whether e.g. ndev can change
> > between these two call sites. that would make the check
> > pointless.
> > =

> > > > this is what's creating all this mess.
> > > > =

> > > > =

> > > Not quite: mlx5_vdpa_dev_del (which is a .dev_del of for struct
> > > vdpa_mgmtdev_ops) doesn't get called on shutdown. At least that's wha=
t I
> > > see. Or
> > > am I missing something?
> > =

> > and why do we care whether irqs are freed on shutdown?
> > =

> Had to ask around a bit to find out the answer: there can be issues with =
kexec
> IRQ allocation on some platforms. It is documented here [0] for mlx5_core.
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/net/ethernet/mellanox/mlx5/core/main.c#n2129
> =

> Thanks,
> Dragos

It's quite weird. =

	 * Some platforms requiring freeing the IRQ's in the shutdown
	 * flow. If they aren't freed they can't be allocated after
	 * kexec. There is no need to cleanup the mlx5_core software
	 * contexts.

but most drivers don't have a shutdown callback how do they work then?
do you know which platforms these are?

I don't really know much about why shutdown callback is even necessary.
I guess this is to detect shutdown and do a faster cleanup than
the slow, graceful removal, just cleaning hardware resources?


-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
