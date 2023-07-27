Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC19C001DC
	for <virtualization@archiver.kernel.org>; Thu, 27 Jul 2023 16:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91AD48140B;
	Thu, 27 Jul 2023 16:28:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91AD48140B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zw6z5W1n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imkVgrIwkeaN; Thu, 27 Jul 2023 16:28:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D56B882EF1;
	Thu, 27 Jul 2023 16:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D56B882EF1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D510C0072;
	Thu, 27 Jul 2023 16:28:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 196B1C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 16:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D432260AC2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 16:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D432260AC2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zw6z5W1n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c1vXh4V0Bkg3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 16:28:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0DAB60A93
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 16:28:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0DAB60A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690475322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toVBVAz1OxBBYx0VbDRCYiafp7ZNjBpmo+lGlr0R1k8=;
 b=Zw6z5W1nRg3QruyZDvBIe+FhKROTr58frW06ZmnwsNU5AW0TjDGapESyU0gPOOR3NmbCh8
 4q1KSx1e1uTgqstzxrSorO4j8Th7nHOz51MnxJdAa7m+2owuDz1Jr/lU8K9duiBNaPAQZW
 Q9TyC6F0CE2s+8fvtCd5X7+Sp4StHIc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-0dnQeF7nOOOgVs9XIhHN_Q-1; Thu, 27 Jul 2023 12:28:41 -0400
X-MC-Unique: 0dnQeF7nOOOgVs9XIhHN_Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bc8f1290eso67773366b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 09:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690475320; x=1691080120;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=toVBVAz1OxBBYx0VbDRCYiafp7ZNjBpmo+lGlr0R1k8=;
 b=QyHXdk97Yi66ztUR0FTOPcWLBl0y2OOldyLA9VR6rdKBu/KyrXTynb3x9WUS9/b1iq
 lA6vPZCmQW1PGg73+kOzSQgQfGj8r/Uup6AMUsVijZKEEzt7qwujpEOyZEyK0Ss80sj6
 4jAPc7La5xGy5UVVCIqICFUOwYNLJuvqJQ3FFjuHCPGAKYiCVmgJSfPCgSiy27nz1qjz
 7elmJytC32RyzahR0wTL7Edck81Ua1VVZzsFjWaZK48PvNY4TIOX+TmmUKoro5MXkOeA
 b4fGWa9YtmdjTzDrrpEgh9A/vL1doEWHQV5QV4UrXaiW7GEfu1QKbhmNddyKBv9pCcFL
 yw2A==
X-Gm-Message-State: ABy/qLbTJfC/A2+OLUP9bm/Tb7M4SA6f1SvBberFyfVUiaBCeh6fYIES
 jT9T8L6u8ak0kg8XegRWGhUIomaGSR/SQ4ybFtO7nMi2LTrvjiLam7iwwA6+OtslOOp+Q/3wvVw
 YjgB8F0IAXeiFnujmbq4QyQOjnUoKhkvwmcYIav2QrA==
X-Received: by 2002:a17:906:32cb:b0:993:f4cd:34b3 with SMTP id
 k11-20020a17090632cb00b00993f4cd34b3mr2293544ejk.43.1690475320095; 
 Thu, 27 Jul 2023 09:28:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF3YtxPETqtKUOx9JfM+KLOVBhceIZLv/6TmR6aB0iePf58cstzHPz933BmmCnfiJO30ff4Wg==
X-Received: by 2002:a17:906:32cb:b0:993:f4cd:34b3 with SMTP id
 k11-20020a17090632cb00b00993f4cd34b3mr2293528ejk.43.1690475319784; 
 Thu, 27 Jul 2023 09:28:39 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 lz7-20020a170906fb0700b0099b6b8a0d04sm955404ejb.157.2023.07.27.09.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 09:28:39 -0700 (PDT)
Date: Thu, 27 Jul 2023 12:28:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Message-ID: <20230727122633-mutt-send-email-mst@kernel.org>
References: <20230726190744.14143-1-dtatulea@nvidia.com>
 <20230726152258-mutt-send-email-mst@kernel.org>
 <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
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

On Thu, Jul 27, 2023 at 04:02:16PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-07-26 at 15:26 -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 26, 2023 at 10:07:38PM +0300, Dragos Tatulea wrote:
> > > The ndev was accessed on shutdown without a check if it actually exis=
ts.
> > > This triggered the crash pasted below. This patch simply adds a check
> > > before using ndev.
> > > =

> > > =A0BUG: kernel NULL pointer dereference, address: 0000000000000300
> > > =A0#PF: supervisor read access in kernel mode
> > > =A0#PF: error_code(0x0000) - not-present page
> > > =A0PGD 0 P4D 0
> > > =A0Oops: 0000 [#1] SMP
> > > =A0CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.5.0-
> > > rc2_for_upstream_min_debug_2023_07_17_15_05 #1
> > > =A0Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.=
0-0-
> > > gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > =A0RIP: 0010:mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > > =A0RSP: 0018:ffff8881003bfdc0 EFLAGS: 00010286
> > > =A0RAX: ffff888103befba0 RBX: ffff888109d28008 RCX: 0000000000000017
> > > =A0RDX: 0000000000000001 RSI: 0000000000000212 RDI: ffff888109d28000
> > > =A0RBP: 0000000000000000 R08: 0000000d3a3a3882 R09: 0000000000000001
> > > =A0R10: 0000000000000000 R11: 0000000000000000 R12: ffff888109d28000
> > > =A0R13: ffff888109d28080 R14: 00000000fee1dead R15: 0000000000000000
> > > =A0FS:=A0 00007f4969e0be40(0000) GS:ffff88852c800000(0000)
> > > knlGS:0000000000000000
> > > =A0CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > =A0CR2: 0000000000000300 CR3: 00000001051cd006 CR4: 0000000000370eb0
> > > =A0DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > =A0DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > =A0Call Trace:
> > > =A0 <TASK>
> > > =A0 ? __die+0x20/0x60
> > > =A0 ? page_fault_oops+0x14c/0x3c0
> > > =A0 ? exc_page_fault+0x75/0x140
> > > =A0 ? asm_exc_page_fault+0x22/0x30
> > > =A0 ? mlx5v_shutdown+0xe/0x50 [mlx5_vdpa]
> > > =A0 device_shutdown+0x13e/0x1e0
> > > =A0 kernel_restart+0x36/0x90
> > > =A0 __do_sys_reboot+0x141/0x210
> > > =A0 ? vfs_writev+0xcd/0x140
> > > =A0 ? handle_mm_fault+0x161/0x260
> > > =A0 ? do_writev+0x6b/0x110
> > > =A0 do_syscall_64+0x3d/0x90
> > > =A0 entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > =A0RIP: 0033:0x7f496990fb56
> > > =A0RSP: 002b:00007fffc7bdde88 EFLAGS: 00000206 ORIG_RAX: 000000000000=
00a9
> > > =A0RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f496990fb56
> > > =A0RDX: 0000000001234567 RSI: 0000000028121969 RDI: fffffffffee1dead
> > > =A0RBP: 00007fffc7bde1d0 R08: 0000000000000000 R09: 0000000000000000
> > > =A0R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> > > =A0R13: 00007fffc7bddf10 R14: 0000000000000000 R15: 00007fffc7bde2b8
> > > =A0 </TASK>
> > > =A0CR2: 0000000000000300
> > > =A0---[ end trace 0000000000000000 ]---
> > > =

> > > Fixes: bc9a2b3e686e ("vdpa/mlx5: Support interrupt bypassing")
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > ---
> > > =A0drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 ++-
> > > =A01 file changed, 2 insertions(+), 1 deletion(-)
> > > =

> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 9138ef2fb2c8..e2e7ebd71798 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -3556,7 +3556,8 @@ static void mlx5v_shutdown(struct auxiliary_dev=
ice
> > > *auxdev)
> > > =A0=A0=A0=A0=A0=A0=A0=A0mgtdev =3D auxiliary_get_drvdata(auxdev);
> > > =A0=A0=A0=A0=A0=A0=A0=A0ndev =3D mgtdev->ndev;
> > > =A0
> > > -=A0=A0=A0=A0=A0=A0=A0free_irqs(ndev);
> > > +=A0=A0=A0=A0=A0=A0=A0if (ndev)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0free_irqs(ndev);
> > > =A0}
> > > =A0
> > =

> > something I don't get:
> > irqs are allocated in mlx5_vdpa_dev_add
> > why are they not freed in mlx5_vdpa_dev_del?
> > =

> That is a good point. I will try to find out. I also don't get why free_i=
rq is
> called in the vdpa dev .free op instead of mlx5_vdpa_dev_del. Maybe I can=
 change
> that in a different refactoring.

as it is I have no idea whether e.g. ndev can change
between these two call sites. that would make the check
pointless.

> > this is what's creating all this mess.
> > =

> > =

> Not quite: mlx5_vdpa_dev_del (which is a .dev_del of for struct
> vdpa_mgmtdev_ops) doesn't get called on shutdown. At least that's what I =
see. Or
> am I missing something?

and why do we care whether irqs are freed on shutdown?

> > > =A0static const struct auxiliary_device_id mlx5v_id_table[] =3D {
> > > -- =

> > > 2.41.0
> > =

> =


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
