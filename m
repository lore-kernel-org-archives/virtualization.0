Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D952EA473
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828117; cv=none; b=r+uPjgsRdiDPN+809aMJ0HyOVkb6tYsVt9tenrWxGXRlACJqJNOzvV+igTNitEswumkAojmryzuY3liLRFLJXeyhRNnrDxFUbaMEW51VLvrmSrnxvkbjF38ML4TtdnGYS2Q1lBYbVfR72DW8ZxGzakKQlTmanQcm0XinNV4v/iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828117; c=relaxed/simple;
	bh=WDgni6z1ajqIGM0PP7karFQjqBzAlobqYxuPAPjFXd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KObDtg0/Y+IF8t0a3NJft+BU94eY+s1YCzl1akVvXH5wBwHHLHXssYsUGgh5aq954zua+QvWdxlyQFPTZHlSGdUSHm6kuVLCDi18hUfX6NLvZXtQvaU8b0kUxzQOgt7ANsqWHkbrOBN1RBwB4iFWoyQF1ZP1V+IN2K67o8a/cDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx2FO+rH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx2FO+rH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767828114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEMu0Qq1b2UtZMlo5nERJFqxVgC5aIqVPPAv06mb1Zo=;
	b=Gx2FO+rHMsCiN1LopLBRI+ZFDV2nY5+yr3XiF5labcN44m0XLuuxS9NO3ShMfAuvuObqXJ
	/udyHPYkSbwaiSbHNp6aDMpZSytehD0j3hHTe6n/NCeORH8DiuNOH+Nyaq8cd+8daYk84U
	SbmHXuPhng0OOaJVoelSKHPwHW3SWjg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-OHRi1YvjNt62cjGLmKmnVQ-1; Wed, 07 Jan 2026 18:21:52 -0500
X-MC-Unique: OHRi1YvjNt62cjGLmKmnVQ-1
X-Mimecast-MFC-AGG-ID: OHRi1YvjNt62cjGLmKmnVQ_1767828112
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64b7907dd42so4341858a12.3
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 15:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828111; x=1768432911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEMu0Qq1b2UtZMlo5nERJFqxVgC5aIqVPPAv06mb1Zo=;
        b=ed7xhk+LWFZZFNYupNydw+NgWbsZN19zgcGNh4qY1GClrJkX/d7wh5U/iNPcvBRrZv
         RxrvynBnFlLJyd9H24g4rWUjzWWGQVLSjkkGBbe0xIGoexETiJ88AwuQz4lPZybz2Tpt
         prfUiZan1mFAMuU/HobHcZwfgT1Q203TkjvmfxzgRMN8rK0pi4eM/anr84B1UZDUXYQr
         eMG9hnBlbMnZdZvaeHfHbcKUDdcebg445bCB06v+oz3mooELW3R9eQDKMb5KM629snvX
         7Nqp1xbcsXOoA+EN1l4mDp/9e8R9o7EnsORMyBjNRpWkx1l91zdEQGfvamYb5/un9i0a
         lz8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6fNFUQw/v4SYGO9bywiABSIPii2Re1IZGIaUq6EiwOXtJN4xXbX/sts79jhRZW0x1fB84HGY2lNf1uWKjLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmctHlJfL55lzJSTemkAswbLJsl/TxX2Qpj5dTGTEQ1eM5fqrH
	rkrHBpEtmUVRaXD8KyNplxUG4mc4SRubqBcAfE4nvc2hMXiiRA5NbA5Ck1lVg0ToYXi5/AIA/UW
	/NueDDu6dWFpHM5ze0Hr6dqdyE+Uat0DB0n/U7KYZD1GGAzmSmcLJC04SGiizrnti1PN6tw6Eir
	wHf0L+6WiotVK20BBdEqj/bZygWIyR06/yIGvpkAa2NcM=
X-Gm-Gg: AY/fxX4ycJPuDOlk4q+qhyc2Auc/6MY4wpPjF7rp0uo3nOGpeePpd5M8icpvuZLnTpZ
	QYdh6T2yu7bRP33Xv+Xzt+bvZxLbYhYoFoI6SHAfkRgctmfcz99XJn+JfXD6L6H4dRUFn+ojjSy
	NIEpcv9GL962H/T+wQRxga+VoJOUcpjarZrpfTrVYjYBaTTOpW58asBC1vzlM60KTPQhX5Rp43b
	4RJsvC0hlc0LRr+7o1tQ7ZX
X-Received: by 2002:a17:907:7283:b0:b83:1327:5f88 with SMTP id a640c23a62f3a-b84451da312mr413767666b.16.1767828111396;
        Wed, 07 Jan 2026 15:21:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD2HiWiiOKtaHjnkMA5jfb9slYQAsOHb0yCL8JNi9956UPDfM+jmMd01xk08bIRos1+QfexrfIvByxjmWxKQI=
X-Received: by 2002:a17:907:7283:b0:b83:1327:5f88 with SMTP id
 a640c23a62f3a-b84451da312mr413764266b.16.1767828110879; Wed, 07 Jan 2026
 15:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aU6lCL_vrF93lpYa@bywater>
 <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
 <aV6sHofXnZuu84OV@bywater> <aV7lplXiOehmw2iR@bywater>
In-Reply-To: <aV7lplXiOehmw2iR@bywater>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Thu, 8 Jan 2026 00:21:38 +0100
X-Gm-Features: AQt7F2rnDbeOG2B9RyToqXJ0D-JbOha2ohKkCienNCk3aXaGyHr76CrPxJpoqUk
Message-ID: <CAHYGQ0yQ=20eFJN-_=_+uqyk=nRyotQLgf01B-Rb8NVk9N4DpQ@mail.gmail.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
To: Francesco Valla <francesco@valla.it>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Harald Mommer <harald.mommer@oss.qualcomm.com>, 
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org, 
	virtualization@lists.linux.dev, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dikAzjLjOcRWLmkAH46T_HHZceX1ObjB2hxC3UYmHFM_1767828112
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:01=E2=80=AFAM Francesco Valla <francesco@valla.it=
> wrote:
>
> On Wed, Jan 07, 2026 at 07:55:26PM +0100, Francesco Valla wrote:
> > Hi Matias,
> >
> > On Wed, Jan 07, 2026 at 05:14:25PM +0100, Matias Ezequiel Vara Larsen w=
rote:
> > > On Fri, Dec 26, 2025 at 4:09=E2=80=AFPM Francesco Valla <francesco@va=
lla.it> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> > > > > While stress testing this, I noticed that flooding the virtio-can
> > > > > interface with packets leads to an hang of the interface itself.
> > > > > I am seeing this issuing, at host side:
> > > > >
> > > > >       while true; do cansend can0 123#00; done
> > > > >
> > > > > with:
> > > > >
> > > > >  - QEMU: the tip of the master branch plus [2]
> > > > >  - vhost-device: the tip of the main branch
> > > > >
> > > > > and the following QEMU invocation:
> > > > >
> > > > > qemu-system-x86_64 -serial mon:stdio \
> > > > >     -m 2G -smp 2 \
> > > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > > >     -append "loglevel=3D7 console=3DttyS0" \
> > > > >     -machine memory-backend=3Dpc.ram \
> > > > >     -object memory-backend-file,id=3Dpc.ram,size=3D2G,mem-path=3D=
/tmp/pc.ram,share=3Don \
> > > > >     -chardev socket,id=3Dcan0,path=3D/tmp/sock-can0 \
> > > > >     -device vhost-user-can-pci,chardev=3Dcan0
> > > > >
> > > > >
> > > > > Restarting the interface (i.e.: ip link set down and the up) does=
 not
> > > > > fix the situation.
> > > > >
> > > > > I'll try to do some more testing during the next days.
> > > >
> > > > After a deep dive, I _think_ the problem actually lies in vhost-dev=
ice,
> > > > since it is not there (or al least, it seems so) using an alternati=
ve
> > > > implementation that uses the qemu socketcan support [0] (implementa=
tion
> > > > which builds on top of the work done by Harald and Mikhail):
> > > >
> > > > qemu-system-x86_64 -serial mon:stdio \
> > > >     -m 2G -smp 2 -enable-kvm \
> > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > >     -append "loglevel=3D7 console=3DttyS0" \
> > > >     -object can-bus,id=3Dcanbus0 -object can-host-socketcan,id=3Dca=
nhost0,if=3Dvcan0,canbus=3Dcanbus0 \
> > > >     -device virtio-can-pci,canbus=3Dcanbus0
> > > >
> > > > Unfortunately, my Rust knoweledge is not sufficient to understand t=
he
> > > > vhost-device implementation [1]; the issue seems to be related to t=
he
> > > > host->guest vring becoming empty and not refilling anymore.
> > > >
> > >
> > > Can you try with
> > > https://github.com/MatiasVara/vhost-device/commits/fix-for-923/?
> >
> > I'll stress test it during the night, but this seems to fix it. Before
> > it was reproducible in a consistent manner after mere seconds, while i
> > now in a bunch of runs I never reproduced it.
> >
> > I also agree with your analysis on the commit.
> >
>
> Quick update, unfortunately not good: the RX issue is solved, but now I
> have a different one: if I send a single message either from the guset
> or the host (e.g.: cansend can0 111#00) I get:
>
> [   16.496923] irq 11: nobody cared (try booting with the "irqpoll" optio=
n)
> [   16.511875] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-00=
002-gded0a4b9da5a #29 PREEMPT(voluntary)
> [   16.511883] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> [   16.511887] Call Trace:
> [   16.511933]  <IRQ>
> [   16.511938]  dump_stack_lvl+0x4d/0x70
> [   16.511973]  __report_bad_irq+0x30/0xb7
> [   16.511986]  note_interrupt.cold+0x28/0x66
> [   16.511988]  handle_irq_event+0x6d/0x70
> [   16.512004]  handle_fasteoi_irq+0xd5/0x1f0
> [   16.512011]  __common_interrupt+0x3f/0xd0
> [   16.512023]  ? tick_nohz_irq_exit+0x2e/0x60
> [   16.512035]  common_interrupt+0x3b/0x90
> [   16.512057]  asm_common_interrupt+0x26/0x40
> [   16.512073] RIP: 0010:handle_softirqs+0x6d/0x270
> [   16.512081] Code: 02 00 01 00 00 89 5c 24 14 48 89 6c 24 08 c7 44 24 1=
0 0a 00 00 00 89 7c 24 04 31 c0 65 66 89 05 01 ce 3e 02 fb bb ff ff ff ff <=
49> c7 c2 c0 80 a0 a2 44 89 ed 41 0f bc dd 83 c3 01 74 76 8d 43 ff
> [   16.512082] RSP: 0018:ffffb22480003f98 EFLAGS: 00000246
> [   16.512086] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 000000000=
0000838
> [   16.512087] RDX: 0000000000000000 RSI: ffffffffa2a0e940 RDI: 000000000=
0000000
> [   16.512088] RBP: 00000000fffbac3e R08: 0000000000000001 R09: 000000000=
0000000
> [   16.512088] R10: ffffa2d57da249d0 R11: ffffb22480003ff8 R12: 000000000=
0000000
> [   16.512091] R13: 0000000000000082 R14: 0000000000000000 R15: 000000000=
0000000
> [   16.512097]  irq_exit_rcu+0x89/0xb0
> [   16.512099]  sysvec_apic_timer_interrupt+0x6b/0x80
> [   16.512103]  </IRQ>
> [   16.512104]  <TASK>
> [   16.512104]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   16.512105] RIP: 0010:pv_native_safe_halt+0xf/0x20
> [   16.512107] Code: 2c 81 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 9=
0 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 05 cf 18 00 fb f4 <=
c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
> [   16.512109] RSP: 0018:ffffffffa2a03e80 EFLAGS: 00000212
> [   16.512110] RAX: ffffa2d5da523000 RBX: ffffffffa2a0e940 RCX: 000000000=
0000838
> [   16.512111] RDX: 4000000000000000 RSI: 0000000000000087 RDI: 000000000=
00a722c
> [   16.512111] RBP: 0000000000000000 R08: 00000000000a722c R09: ffffa2d57=
da249d0
> [   16.512112] R10: ffffa2d57da1bac0 R11: 0000000000000001 R12: 000000000=
0000000
> [   16.512112] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0014770
> [   16.512113]  default_idle+0x9/0x10
> [   16.512117]  default_idle_call+0x2a/0xf0
> [   16.512119]  do_idle+0x1cb/0x230
> [   16.512129]  cpu_startup_entry+0x24/0x30
> [   16.512130]  rest_init+0xbc/0xc0
> [   16.512133]  start_kernel+0x6d7/0x6e0
> [   16.512164]  x86_64_start_reservations+0x24/0x30
> [   16.512172]  x86_64_start_kernel+0xc8/0xd0
> [   16.512173]  common_startup_64+0x13e/0x148
> [   16.512181]  </TASK>
> [   16.512181] handlers:
> [   16.513166] [<00000000b61218c7>] vp_interrupt
> [   16.515096] Disabling IRQ #11
>
> with IRQ#11 being:
>
> # cat /proc/interrupts
>            CPU0       CPU1
>  11:     102218          0  IO-APIC  11-fasteoi   virtio0
>
>
> This cannot be reproduced with the old version of vhost-device. I think
> it is due to the removal of the req_rx_buf variable and associated
> logic: a vq kick is now being performed at every cycle of the event
> loop, even if no processing happened. At guest side, this results in a
> IRQ not cared for.
>

Thanks Francesco! right, I made a mistake. process_rx_queue() is only
invoking signal_used_queue() when req_rx_buf is true, i.e., the device
has actually added something to the used ring. I'll fix that.

Matias

