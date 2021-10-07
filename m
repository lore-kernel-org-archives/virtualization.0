Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD3CC433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 13:13:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1E961074
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 13:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C1E961074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 388F340A36;
	Thu,  7 Oct 2021 13:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SSQcKxlUXCmD; Thu,  7 Oct 2021 13:13:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6356740A34;
	Thu,  7 Oct 2021 13:13:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2905CC000F;
	Thu,  7 Oct 2021 13:13:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56ECCC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 13:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3779860F87
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 13:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 79ei4s9_Wlcx
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 13:13:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4BA9607BB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 13:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633612385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqM+38+1666otMDxUxP23EDEsopNR9XAHWL2lQ2kgfc=;
 b=UrC2bmeYA/YnPDqL30xWPAJvj6DMmCCOlN//EJlXerQadzzqWpF/2XZkjLj3sKVQZruR4c
 oc8vaiCPXvahgRL5kKc1nNwcItCyEHSrNiorq479JlLE62GOJLIfas0Aal7bXtEOZQq3AG
 x/t/582JXNYkz6v2CQdNop7IifMBnP8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-L8eYW3soO8qOrcoq4SjtsA-1; Thu, 07 Oct 2021 09:11:11 -0400
X-MC-Unique: L8eYW3soO8qOrcoq4SjtsA-1
Received: by mail-ed1-f69.google.com with SMTP id
 p13-20020a056402044d00b003db3256e4f2so5892353edw.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Oct 2021 06:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eqM+38+1666otMDxUxP23EDEsopNR9XAHWL2lQ2kgfc=;
 b=niwqeudSiDMz71viKKQk0sTQELvkdH2r0R901vNwT/cjk9QQUSrl8kSum+42+5WmDB
 OMDJaQxsinCCiD6OjV/9nGZhlFa9wTWUf5aQgqc9LbluYI8bpybNIko2u5eb00EqChR8
 QdM50/1EZprL24gsr+hcjBTR7GPN/++ywJHW9Z5uI3RuIy0rJvyzw2SmnbLgotfAYeDC
 H3TQOmIlTeTo1cIRXITWjpeUM7QkDjEUXmcWGXo2wQp7deeAhXZMBoJ5ArKciM3gqwC0
 2LHZlgP0hiTx0iU1wxE8XPeyCI1G4jQht8ZcahAl3BnZ8HK4+G+pI042n2+mnV8yx7tV
 yvzg==
X-Gm-Message-State: AOAM5333uXwnA0GleJRjA8tVtfBO7WpbqsLXMB77p9sGLO25BPz/K99c
 Tav7Tc+8PkQMXJZzUnEFNnksK5ABpMRlDqcsaiXw4tgo1CFhS+0xIDcfb0o64jrysRtPcThV/jK
 kqA48ikySeOPb0s2xRc876HdQmsCekRlUYL3gZkGCOg==
X-Received: by 2002:a50:d844:: with SMTP id v4mr6448390edj.378.1633612267140; 
 Thu, 07 Oct 2021 06:11:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxaz7OxfUIIghs/oRquOlhvCDJwMg/5qNk9fzNgCZqbYrPdU0eKdvWOBedFKMh6YzIgao5ug==
X-Received: by 2002:a50:d844:: with SMTP id v4mr6448015edj.378.1633612263354; 
 Thu, 07 Oct 2021 06:11:03 -0700 (PDT)
Received: from redhat.com ([2.55.132.170])
 by smtp.gmail.com with ESMTPSA id fx4sm10121597ejb.113.2021.10.07.06.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Oct 2021 06:11:02 -0700 (PDT)
Date: Thu, 7 Oct 2021 09:10:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Corentin =?iso-8859-1?Q?No=EBl?= <corentin.noel@collabora.com>
Subject: Re: virtio-net: kernel panic in virtio_net.c
Message-ID: <20211007090601-mutt-send-email-mst@kernel.org>
References: <5edaa2b7c2fe4abd0347b8454b2ac032b6694e2c.camel@collabora.com>
MIME-Version: 1.0
In-Reply-To: <5edaa2b7c2fe4abd0347b8454b2ac032b6694e2c.camel@collabora.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: regressions@lists.linux.dev, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>
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

On Thu, Oct 07, 2021 at 02:04:22PM +0200, Corentin No=EBl wrote:
> I've been experiencing crashes with 5.14-rc1 and above that do not
> occur with 5.13,
> =

> here is the crash trace:
> =

> [   61.346677] skbuff: skb_over_panic: text:ffffffff881ae2c7 len:3762
> put:3762 head:ffff8a5ec8c22000 data:ffff8a5ec8c22010 tail:0xec2
> end:0xec0 dev:<NULL>
> [   61.369192] kernel BUG at net/core/skbuff.c:111!
> [   61.372840] invalid opcode: 0000 [#1] SMP PTI
> [   61.374892] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.14.0-
> rc1linux-v5.14-rc1-for-mesa-ci.tar.bz2 #1
> [   61.376450] Hardware name: ChromiumOS crosvm, BIOS 0 =

> [   61.377222] RIP: 0010:skb_panic+0x43/0x45
> [   61.377833] Code: 4f 70 50 8b 87 bc 00 00 00 50 8b 87 b8 00 00 00 50
> ff b7 c8 00 00 00 4c 8b 8f c0 00 00 00 48 c7 c7 18 f1 cf 88 e8 6a 43 fb
> ff <0f> 0b 48 8b 14 24 48 c7 c1 20 35 b1 88 e8 ab ff ff ff 48 c7 c6 60
> [   61.380566] RSP: 0018:ffffae258017cce0 EFLAGS: 00010246
> [   61.381267] RAX: 000000000000008b RBX: 0000000000000010 RCX:
> 00000000ffffdfff
> [   61.382246] RDX: 0000000000000000 RSI: 00000000ffffffea RDI:
> 0000000000000000
> [   61.383376] RBP: ffffde6a80230880 R08: ffffffff88f45568 R09:
> 0000000000009ffb
> [   61.384494] R10: 00000000ffffe000 R11: 3fffffffffffffff R12:
> ffff8a5ec7461200
> [   61.385696] R13: ffff8a5ec8c22000 R14: 0000000000000000 R15:
> 0000000000000eb2
> [   61.386825] FS:  0000000000000000(0000) GS:ffff8a5febd40000(0000)
> knlGS:0000000000000000
> [   61.388055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   61.389221] CR2: 000000000148a060 CR3: 000000011ae0e005 CR4:
> 0000000000370ee0
> [   61.390871] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   61.392335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   61.393635] Call Trace:
> [   61.394127]  <IRQ>
> [   61.394488]  skb_put.cold+0x10/0x10
> [   61.395095]  page_to_skb+0xf7/0x410
> [   61.395689]  receive_buf+0x81/0x1660
> [   61.396228]  ? netif_receive_skb_list_internal+0x1ad/0x2b0
> [   61.397180]  ? napi_gro_flush+0x97/0xe0
> [   61.397896]  ? detach_buf_split+0x67/0x120
> [   61.398573]  virtnet_poll+0x2cf/0x420
> [   61.399197]  __napi_poll+0x25/0x150
> [   61.399764]  net_rx_action+0x22f/0x280
> [   61.400394]  __do_softirq+0xba/0x257
> [   61.401012]  irq_exit_rcu+0x8e/0xb0
> [   61.401618]  common_interrupt+0x7b/0xa0
> [   61.402270]  </IRQ>
> [   61.402620]  asm_common_interrupt+0x1e/0x40
> [   61.403302] RIP: 0010:default_idle+0xb/0x10
> [   61.404018] Code: 8b 04 25 00 6d 01 00 f0 80 60 02 df c3 0f ae f0 0f
> ae 38 0f ae f0 eb b9 0f 1f 80 00 00 00 00 eb 07 0f 00 2d df 3e 44 00 fb
> f4 <c3> cc cc cc cc 65 8b 15 31 2f a4 77 89 d2 48 8b 05 d0 a1 0c 01 48
> [   61.407636] RSP: 0018:ffffae258008fef8 EFLAGS: 00000202
> [   61.408394] RAX: ffffffff885ce620 RBX: 0000000000000005 RCX:
> ffff8a5febd56f80
> [   61.409451] RDX: 0000000000c1ec32 RSI: 7ffffff1b7a1e726 RDI:
> ffff8a5febd5dd00
> [   61.410530] RBP: ffff8a5fc01f8000 R08: 0000000000c1ec32 R09:
> 0000000000000000
> [   61.411715] R10: 0000000000000006 R11: 0000000000000002 R12:
> 0000000000000000
> [   61.412984] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [   61.414183]  ? mwait_idle+0x70/0x70
> [   61.414805]  ? mwait_idle+0x70/0x70
> [   61.415592]  default_idle_call+0x2a/0xa0
> [   61.416216]  do_idle+0x1e8/0x250
> [   61.416722]  cpu_startup_entry+0x14/0x20
> [   61.417347]  secondary_startup_64_no_verify+0xc2/0xcb
> [   61.418144] Modules linked in:
> [   61.418622] ---[ end trace 3741c3e580a52bbd ]---
> [   61.419399] RIP: 0010:skb_panic+0x43/0x45
> [   61.420054] Code: 4f 70 50 8b 87 bc 00 00 00 50 8b 87 b8 00 00 00 50
> ff b7 c8 00 00 00 4c 8b 8f c0 00 00 00 48 c7 c7 18 f1 cf 88 e8 6a 43 fb
> ff <0f> 0b 48 8b 14 24 48 c7 c1 20 35 b1 88 e8 ab ff ff ff 48 c7 c6 60
> [   61.422606] RSP: 0018:ffffae258017cce0 EFLAGS: 00010246
> [   61.423865] RAX: 000000000000008b RBX: 0000000000000010 RCX:
> 00000000ffffdfff
> [   61.425031] RDX: 0000000000000000 RSI: 00000000ffffffea RDI:
> 0000000000000000
> [   61.426229] RBP: ffffde6a80230880 R08: ffffffff88f45568 R09:
> 0000000000009ffb
> [   61.427439] R10: 00000000ffffe000 R11: 3fffffffffffffff R12:
> ffff8a5ec7461200
> [   61.428615] R13: ffff8a5ec8c22000 R14: 0000000000000000 R15:
> 0000000000000eb2
> [   61.429799] FS:  0000000000000000(0000) GS:ffff8a5febd40000(0000)
> knlGS:0000000000000000
> [   61.431048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   61.431997] CR2: 000000000148a060 CR3: 000000011ae0e005 CR4:
> 0000000000370ee0
> [   61.433206] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   61.434502] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   61.435799] Kernel panic - not syncing: Fatal exception in interrupt
> [   61.439250] Kernel Offset: 0x6a00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> =

> Here is my kernel config: =

> https://gitlab.freedesktop.org/tintou/mesa/-/raw/7cf2be0e1c53d1040ff8a973=
ddeeeb3d93250f8e/.gitlab-ci/container/x86_64.config
> =

> =

> here is the decoded trace:
> =

> [   61.346677] skbuff: skb_over_panic: text:ffffffff881ae2c7 len:3762
> put:3762 head:ffff8a5ec8c22000 data:ffff8a5ec8c22010 tail:0xec2
> end:0xec0 dev:<NULL>
> [   61.369192] kernel BUG at net/core/skbuff.c:111!
> [   61.372840] invalid opcode: 0000 [#1] SMP PTI
> [   61.374892] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.14.0-
> rc1linux-v5.14-rc1-for-mesa-ci.tar.bz2 #1
> [   61.376450] Hardware name: ChromiumOS crosvm, BIOS 0
> [   61.377222] RIP: skb_panic+0x43/0x45 =

> [ 61.377833] Code: 4f 70 50 8b 87 bc 00 00 00 50 8b 87 b8 00 00 00 50
> ff b7 c8 00 00 00 4c 8b 8f c0 00 00 00 48 c7 c7 18 f1 cf 88 e8 6a 43 fb
> ff <0f> 0b 48 8b 14 24 48 c7 c1 20 35 b1 88 e8 ab ff ff ff 48 c7 c6 60
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	4f 70 50             	rex.WRXB jo 0x53
>    3:	8b 87 bc 00 00 00    	mov    0xbc(%rdi),%eax
>    9:	50                   	push   %rax
>    a:	8b 87 b8 00 00 00    	mov    0xb8(%rdi),%eax
>   10:	50                   	push   %rax
>   11:	ff b7 c8 00 00 00    	pushq  0xc8(%rdi)
>   17:	4c 8b 8f c0 00 00 00 	mov    0xc0(%rdi),%r9
>   1e:	48 c7 c7 18 f1 cf 88 	mov    $0xffffffff88cff118,%rdi
>   25:	e8 6a 43 fb ff       	callq  0xfffffffffffb4394
>   2a:*	0f 0b                	ud2    		<-- trapping
> instruction
>   2c:	48 8b 14 24          	mov    (%rsp),%rdx
>   30:	48 c7 c1 20 35 b1 88 	mov    $0xffffffff88b13520,%rcx
>   37:	e8 ab ff ff ff       	callq  0xffffffffffffffe7
>   3c:	48                   	rex.W
>   3d:	c7                   	.byte 0xc7
>   3e:	c6                   	(bad)  =

>   3f:	60                   	(bad)  =

> =

> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	0f 0b                	ud2    =

>    2:	48 8b 14 24          	mov    (%rsp),%rdx
>    6:	48 c7 c1 20 35 b1 88 	mov    $0xffffffff88b13520,%rcx
>    d:	e8 ab ff ff ff       	callq  0xffffffffffffffbd
>   12:	48                   	rex.W
>   13:	c7                   	.byte 0xc7
>   14:	c6                   	(bad)  =

>   15:	60                   	(bad)  =

> [   61.380566] RSP: 0018:ffffae258017cce0 EFLAGS: 00010246
> [   61.381267] RAX: 000000000000008b RBX: 0000000000000010 RCX:
> 00000000ffffdfff
> [   61.382246] RDX: 0000000000000000 RSI: 00000000ffffffea RDI:
> 0000000000000000
> [   61.383376] RBP: ffffde6a80230880 R08: ffffffff88f45568 R09:
> 0000000000009ffb
> [   61.384494] R10: 00000000ffffe000 R11: 3fffffffffffffff R12:
> ffff8a5ec7461200
> [   61.385696] R13: ffff8a5ec8c22000 R14: 0000000000000000 R15:
> 0000000000000eb2
> [   61.386825] FS:  0000000000000000(0000) GS:ffff8a5febd40000(0000)
> knlGS:0000000000000000
> [   61.388055] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   61.389221] CR2: 000000000148a060 CR3: 000000011ae0e005 CR4:
> 0000000000370ee0
> [   61.390871] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   61.392335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   61.393635] Call Trace:
> [   61.394127]  <IRQ>
> [   61.394488] skb_put.cold+0x10/0x10 =

> [   61.395095] page_to_skb+0xf7/0x410 =

> [   61.395689] receive_buf+0x81/0x1660 =

> [   61.396228] ? netif_receive_skb_list_internal+0x1ad/0x2b0 =

> [   61.397180] ? napi_gro_flush+0x97/0xe0 =

> [   61.397896] ? detach_buf_split+0x67/0x120 =

> [   61.398573] virtnet_poll+0x2cf/0x420 =

> [   61.399197] __napi_poll+0x25/0x150 =

> [   61.399764] net_rx_action+0x22f/0x280 =

> [   61.400394] __do_softirq+0xba/0x257 =

> [   61.401012] irq_exit_rcu+0x8e/0xb0 =

> [   61.401618] common_interrupt+0x7b/0xa0 =

> [   61.402270]  </IRQ>
> [   61.402620] asm_common_interrupt+0x1e/0x40 =

> [   61.403302] RIP: default_idle+0xb/0x10 =

> [ 61.404018] Code: 8b 04 25 00 6d 01 00 f0 80 60 02 df c3 0f ae f0 0f
> ae 38 0f ae f0 eb b9 0f 1f 80 00 00 00 00 eb 07 0f 00 2d df 3e 44 00 fb
> f4 <c3> cc cc cc cc 65 8b 15 31 2f a4 77 89 d2 48 8b 05 d0 a1 0c 01 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	8b 04 25 00 6d 01 00 	mov    0x16d00,%eax
>    7:	f0 80 60 02 df       	lock andb $0xdf,0x2(%rax)
>    c:	c3                   	retq   =

>    d:	0f ae f0             	mfence =

>   10:	0f ae 38             	clflush (%rax)
>   13:	0f ae f0             	mfence =

>   16:	eb b9                	jmp    0xffffffffffffffd1
>   18:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
>   1f:	eb 07                	jmp    0x28
>   21:	0f 00 2d df 3e 44 00 	verw   0x443edf(%rip)        # 0x443f07
>   28:	fb                   	sti    =

>   29:	f4                   	hlt    =

>   2a:*	c3                   	retq   		<-- trapping
> instruction
>   2b:	cc                   	int3   =

>   2c:	cc                   	int3   =

>   2d:	cc                   	int3   =

>   2e:	cc                   	int3   =

>   2f:	65 8b 15 31 2f a4 77 	mov    %gs:0x77a42f31(%rip),%edx       =

>  # 0x77a42f67
>   36:	89 d2                	mov    %edx,%edx
>   38:	48 8b 05 d0 a1 0c 01 	mov    0x10ca1d0(%rip),%rax        #
> 0x10ca20f
>   3f:	48                   	rex.W
> =

> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	c3                   	retq   =

>    1:	cc                   	int3   =

>    2:	cc                   	int3   =

>    3:	cc                   	int3   =

>    4:	cc                   	int3   =

>    5:	65 8b 15 31 2f a4 77 	mov    %gs:0x77a42f31(%rip),%edx       =

>  # 0x77a42f3d
>    c:	89 d2                	mov    %edx,%edx
>    e:	48 8b 05 d0 a1 0c 01 	mov    0x10ca1d0(%rip),%rax        #
> 0x10ca1e5
>   15:	48                   	rex.W
> [   61.407636] RSP: 0018:ffffae258008fef8 EFLAGS: 00000202
> [   61.408394] RAX: ffffffff885ce620 RBX: 0000000000000005 RCX:
> ffff8a5febd56f80
> [   61.409451] RDX: 0000000000c1ec32 RSI: 7ffffff1b7a1e726 RDI:
> ffff8a5febd5dd00
> [   61.410530] RBP: ffff8a5fc01f8000 R08: 0000000000c1ec32 R09:
> 0000000000000000
> [   61.411715] R10: 0000000000000006 R11: 0000000000000002 R12:
> 0000000000000000
> [   61.412984] R13: 0000000000000000 R14: 0000000000000000 R15:
> 0000000000000000
> [   61.414183] ? mwait_idle+0x70/0x70 =

> [   61.414805] ? mwait_idle+0x70/0x70 =

> [   61.415592] default_idle_call+0x2a/0xa0 =

> [   61.416216] do_idle+0x1e8/0x250 =

> [   61.416722] cpu_startup_entry+0x14/0x20 =

> [   61.417347] secondary_startup_64_no_verify+0xc2/0xcb =

> [   61.418144] Modules linked in:
> [   61.418622] ---[ end trace 3741c3e580a52bbd ]---
> [   61.419399] RIP: skb_panic+0x43/0x45 =

> [ 61.420054] Code: 4f 70 50 8b 87 bc 00 00 00 50 8b 87 b8 00 00 00 50
> ff b7 c8 00 00 00 4c 8b 8f c0 00 00 00 48 c7 c7 18 f1 cf 88 e8 6a 43 fb
> ff <0f> 0b 48 8b 14 24 48 c7 c1 20 35 b1 88 e8 ab ff ff ff 48 c7 c6 60
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	4f 70 50             	rex.WRXB jo 0x53
>    3:	8b 87 bc 00 00 00    	mov    0xbc(%rdi),%eax
>    9:	50                   	push   %rax
>    a:	8b 87 b8 00 00 00    	mov    0xb8(%rdi),%eax
>   10:	50                   	push   %rax
>   11:	ff b7 c8 00 00 00    	pushq  0xc8(%rdi)
>   17:	4c 8b 8f c0 00 00 00 	mov    0xc0(%rdi),%r9
>   1e:	48 c7 c7 18 f1 cf 88 	mov    $0xffffffff88cff118,%rdi
>   25:	e8 6a 43 fb ff       	callq  0xfffffffffffb4394
>   2a:*	0f 0b                	ud2    		<-- trapping
> instruction
>   2c:	48 8b 14 24          	mov    (%rsp),%rdx
>   30:	48 c7 c1 20 35 b1 88 	mov    $0xffffffff88b13520,%rcx
>   37:	e8 ab ff ff ff       	callq  0xffffffffffffffe7
>   3c:	48                   	rex.W
>   3d:	c7                   	.byte 0xc7
>   3e:	c6                   	(bad)  =

>   3f:	60                   	(bad)  =

> =

> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	0f 0b                	ud2    =

>    2:	48 8b 14 24          	mov    (%rsp),%rdx
>    6:	48 c7 c1 20 35 b1 88 	mov    $0xffffffff88b13520,%rcx
>    d:	e8 ab ff ff ff       	callq  0xffffffffffffffbd
>   12:	48                   	rex.W
>   13:	c7                   	.byte 0xc7
>   14:	c6                   	(bad)  =

>   15:	60                   	(bad)  =

> [   61.422606] RSP: 0018:ffffae258017cce0 EFLAGS: 00010246
> [   61.423865] RAX: 000000000000008b RBX: 0000000000000010 RCX:
> 00000000ffffdfff
> [   61.425031] RDX: 0000000000000000 RSI: 00000000ffffffea RDI:
> 0000000000000000
> [   61.426229] RBP: ffffde6a80230880 R08: ffffffff88f45568 R09:
> 0000000000009ffb
> [   61.427439] R10: 00000000ffffe000 R11: 3fffffffffffffff R12:
> ffff8a5ec7461200
> [   61.428615] R13: ffff8a5ec8c22000 R14: 0000000000000000 R15:
> 0000000000000eb2
> [   61.429799] FS:  0000000000000000(0000) GS:ffff8a5febd40000(0000)
> knlGS:0000000000000000
> =

> Regards,
> Corentin

Don't see anything obvious.. could be a net stack change.
Any chance of a bisect?

-- =

MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
