Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5652E7F25
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903715; cv=none; b=kk9T7EJjJx89u602MrPf9L+MnkaHhiLB3ZnqcSwcRs4IRHqZjFMS1TJ1ZdKFnfnd1LVMtOMwL8Ds65xZ5zQPaHrtMhFE619MOJP2ijabVBcsG9eh609ytUUx5HJQvnvhQGjX0bQ0AJ7whssX4JLN921UxsipAV6a5hUuTKxuR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903715; c=relaxed/simple;
	bh=CmlVuq1VZzJ4QPtFQNOI9/euJaJPj6jqYo36MIDVNXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQmKTNUN1JFUxuc2rGz+8zxhsv5rRYT/8rhEHeWAU8Sry5ZDycZtrIXgjjFIQVcnyUXKrF7Lzoqy+6OXVo7Jc3Bigq6/cKEMnqh0AHYdWb/vBT3ThRkVcvqZy56506kubXZ6Srbf/4r9ULRMClfH5afFipIHGq6VzdOqYUCf2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVaAz8gg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVaAz8gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767903712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzMl2lf5wfervHBeYiZB1UDrn3oKykhMBIvMEP9ZDyQ=;
	b=iVaAz8ggn5pteEOjkGwdTpyB5YxLPOJgK275r/1gMqptlVTipTZHax6NRJWdYK7XZ9BL9U
	TGVqq6cuoGVHJJfjC6/H9F1US4DUYPsVkgIzfIikGDdQ0+YjymtWNgUL568MfDKgmZgq95
	034lIVWvy+kJIgGNpneVPSAgHa0kFl4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-i4Fx0BgVMAK8DMk-3lHBkA-1; Thu, 08 Jan 2026 15:21:51 -0500
X-MC-Unique: i4Fx0BgVMAK8DMk-3lHBkA-1
X-Mimecast-MFC-AGG-ID: i4Fx0BgVMAK8DMk-3lHBkA_1767903710
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b8395caeb26so590038966b.0
        for <virtualization@lists.linux.dev>; Thu, 08 Jan 2026 12:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767903710; x=1768508510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EzMl2lf5wfervHBeYiZB1UDrn3oKykhMBIvMEP9ZDyQ=;
        b=kEaq9ZUY3PDVUMda67syD7bvxLTZioQRxdpV5ST55lmfKzBMD3MwsJmmSeMcXRrxOu
         jTLY3ce3r3ijyeywAd+p2UTKJD10pCbfaloukKY+biFa5UcuWbMN1+L2gqVTQXPWDiSr
         a3X8DErWdXpOsci96i7Bjs4/c1X54oxGl1ltSDIDTSkTOanz5r9Wl8hWXn/vdF1z52uD
         1Pmmle/3AAufUGB5ZWgBFTIhhLGXs9lk8d00XQhQuOW1JIyTVoEDKsy0ekL8vp6vYn2U
         NtH7h5JzMbjpmiPmFm3Lp8HiM9zU7l473tMqE9wuNb9WcR6Dsf3qB8UV17TrRAcMxf7k
         FCCg==
X-Forwarded-Encrypted: i=1; AJvYcCXZZ3eQgT6eYzowqIMaAk7t09OhOyS+uwGkN0SeA+w9LgZVYIvW9OYhDg70STpuaKfbMm2jexZ5xLqlt5XslA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsC2mQVMK8c6KTjqqx9VCaM8PjjPS70i4yMzx9dgNg+twAdXQJ
	4k0SaD6xP303yO+b2pizIKrudCPaf0kUV/Q4fiOfE94B28aXk6CqM4J/rya52cWsp23SYwaqHYK
	BHZmEPhs4rnAaFWE2hmLAaipwmXB4W2lvPid2J7F7zeC+zt4bauCCwVGdXfl+ox9l8uwGiXhGhh
	F4FYv2MC7ZKKLWKL2wdwWVEiK96zfJEgSVKARYKMSU1N8=
X-Gm-Gg: AY/fxX7hlarLmEbLcxytPKacxOJosKOatr1vb1gaH7wsSMoE8W/IVQ8hisp6vx9TfkM
	BYrHzPOttLxEAFvynlTk+YCpP6XKIgwr++grt4nlqbrYLcGOuhWSqUCZoSj1LO4XooX5+fa1wKW
	BQCLH5hl11PTEE3g5I8XyLqMo2XWXo4a937NiJMcJYjseN1DQJ2bwnW8sJqvxp2U3Av4T1VlAqW
	1FzL8IrwWkB+Gp+d7ODflkg
X-Received: by 2002:a17:907:1b08:b0:b80:3fb7:f3a8 with SMTP id a640c23a62f3a-b8445427d4dmr713617866b.63.1767903710001;
        Thu, 08 Jan 2026 12:21:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe4z9hk785ik31xjpmJ49qvthn+Dn6J/lk+VSduGWBe6cOZIlpU3qyrudI3zg3yRdeNfJzESXTUc0W9fABBQE=
X-Received: by 2002:a17:907:1b08:b0:b80:3fb7:f3a8 with SMTP id
 a640c23a62f3a-b8445427d4dmr713615366b.63.1767903709500; Thu, 08 Jan 2026
 12:21:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aQJRnX7OpFRY/1+H@fedora> <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora> <aT7XAsTWr0_yyfx_@bywater> <aU6lCL_vrF93lpYa@bywater>
 <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
 <aV6sHofXnZuu84OV@bywater> <aV7lplXiOehmw2iR@bywater> <CAHYGQ0yQ=20eFJN-_=_+uqyk=nRyotQLgf01B-Rb8NVk9N4DpQ@mail.gmail.com>
In-Reply-To: <CAHYGQ0yQ=20eFJN-_=_+uqyk=nRyotQLgf01B-Rb8NVk9N4DpQ@mail.gmail.com>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Thu, 8 Jan 2026 21:21:38 +0100
X-Gm-Features: AQt7F2r7y1JM7wbF19_CDer5KyA2VfYb4v3iyeNbLqnMCKk2nRR4hWrvA0FIxeE
Message-ID: <CAHYGQ0waHHLOOjX6cSkSHkNRGYDqsCccKUa5E2DGZwR9DtjMUA@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: eeNeoyJd629tEambqtsLoabblxQQIqClavRpvHBef3A_1767903710
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 12:21=E2=80=AFAM Matias Ezequiel Vara Larsen
<mvaralar@redhat.com> wrote:
>
> On Thu, Jan 8, 2026 at 12:01=E2=80=AFAM Francesco Valla <francesco@valla.=
it> wrote:
> >
> > On Wed, Jan 07, 2026 at 07:55:26PM +0100, Francesco Valla wrote:
> > > Hi Matias,
> > >
> > > On Wed, Jan 07, 2026 at 05:14:25PM +0100, Matias Ezequiel Vara Larsen=
 wrote:
> > > > On Fri, Dec 26, 2025 at 4:09=E2=80=AFPM Francesco Valla <francesco@=
valla.it> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> > > > > > While stress testing this, I noticed that flooding the virtio-c=
an
> > > > > > interface with packets leads to an hang of the interface itself=
.
> > > > > > I am seeing this issuing, at host side:
> > > > > >
> > > > > >       while true; do cansend can0 123#00; done
> > > > > >
> > > > > > with:
> > > > > >
> > > > > >  - QEMU: the tip of the master branch plus [2]
> > > > > >  - vhost-device: the tip of the main branch
> > > > > >
> > > > > > and the following QEMU invocation:
> > > > > >
> > > > > > qemu-system-x86_64 -serial mon:stdio \
> > > > > >     -m 2G -smp 2 \
> > > > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > > > >     -append "loglevel=3D7 console=3DttyS0" \
> > > > > >     -machine memory-backend=3Dpc.ram \
> > > > > >     -object memory-backend-file,id=3Dpc.ram,size=3D2G,mem-path=
=3D/tmp/pc.ram,share=3Don \
> > > > > >     -chardev socket,id=3Dcan0,path=3D/tmp/sock-can0 \
> > > > > >     -device vhost-user-can-pci,chardev=3Dcan0
> > > > > >
> > > > > >
> > > > > > Restarting the interface (i.e.: ip link set down and the up) do=
es not
> > > > > > fix the situation.
> > > > > >
> > > > > > I'll try to do some more testing during the next days.
> > > > >
> > > > > After a deep dive, I _think_ the problem actually lies in vhost-d=
evice,
> > > > > since it is not there (or al least, it seems so) using an alterna=
tive
> > > > > implementation that uses the qemu socketcan support [0] (implemen=
tation
> > > > > which builds on top of the work done by Harald and Mikhail):
> > > > >
> > > > > qemu-system-x86_64 -serial mon:stdio \
> > > > >     -m 2G -smp 2 -enable-kvm \
> > > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > > >     -append "loglevel=3D7 console=3DttyS0" \
> > > > >     -object can-bus,id=3Dcanbus0 -object can-host-socketcan,id=3D=
canhost0,if=3Dvcan0,canbus=3Dcanbus0 \
> > > > >     -device virtio-can-pci,canbus=3Dcanbus0
> > > > >
> > > > > Unfortunately, my Rust knoweledge is not sufficient to understand=
 the
> > > > > vhost-device implementation [1]; the issue seems to be related to=
 the
> > > > > host->guest vring becoming empty and not refilling anymore.
> > > > >
> > > >
> > > > Can you try with
> > > > https://github.com/MatiasVara/vhost-device/commits/fix-for-923/?
> > >
> > > I'll stress test it during the night, but this seems to fix it. Befor=
e
> > > it was reproducible in a consistent manner after mere seconds, while =
i
> > > now in a bunch of runs I never reproduced it.
> > >
> > > I also agree with your analysis on the commit.
> > >
> >
> > Quick update, unfortunately not good: the RX issue is solved, but now I
> > have a different one: if I send a single message either from the guset
> > or the host (e.g.: cansend can0 111#00) I get:
> >
> > [   16.496923] irq 11: nobody cared (try booting with the "irqpoll" opt=
ion)
> > [   16.511875] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-=
00002-gded0a4b9da5a #29 PREEMPT(voluntary)
> > [   16.511883] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> > [   16.511887] Call Trace:
> > [   16.511933]  <IRQ>
> > [   16.511938]  dump_stack_lvl+0x4d/0x70
> > [   16.511973]  __report_bad_irq+0x30/0xb7
> > [   16.511986]  note_interrupt.cold+0x28/0x66
> > [   16.511988]  handle_irq_event+0x6d/0x70
> > [   16.512004]  handle_fasteoi_irq+0xd5/0x1f0
> > [   16.512011]  __common_interrupt+0x3f/0xd0
> > [   16.512023]  ? tick_nohz_irq_exit+0x2e/0x60
> > [   16.512035]  common_interrupt+0x3b/0x90
> > [   16.512057]  asm_common_interrupt+0x26/0x40
> > [   16.512073] RIP: 0010:handle_softirqs+0x6d/0x270
> > [   16.512081] Code: 02 00 01 00 00 89 5c 24 14 48 89 6c 24 08 c7 44 24=
 10 0a 00 00 00 89 7c 24 04 31 c0 65 66 89 05 01 ce 3e 02 fb bb ff ff ff ff=
 <49> c7 c2 c0 80 a0 a2 44 89 ed 41 0f bc dd 83 c3 01 74 76 8d 43 ff
> > [   16.512082] RSP: 0018:ffffb22480003f98 EFLAGS: 00000246
> > [   16.512086] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000=
000000838
> > [   16.512087] RDX: 0000000000000000 RSI: ffffffffa2a0e940 RDI: 0000000=
000000000
> > [   16.512088] RBP: 00000000fffbac3e R08: 0000000000000001 R09: 0000000=
000000000
> > [   16.512088] R10: ffffa2d57da249d0 R11: ffffb22480003ff8 R12: 0000000=
000000000
> > [   16.512091] R13: 0000000000000082 R14: 0000000000000000 R15: 0000000=
000000000
> > [   16.512097]  irq_exit_rcu+0x89/0xb0
> > [   16.512099]  sysvec_apic_timer_interrupt+0x6b/0x80
> > [   16.512103]  </IRQ>
> > [   16.512104]  <TASK>
> > [   16.512104]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > [   16.512105] RIP: 0010:pv_native_safe_halt+0xf/0x20
> > [   16.512107] Code: 2c 81 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90=
 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 05 cf 18 00 fb f4=
 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
> > [   16.512109] RSP: 0018:ffffffffa2a03e80 EFLAGS: 00000212
> > [   16.512110] RAX: ffffa2d5da523000 RBX: ffffffffa2a0e940 RCX: 0000000=
000000838
> > [   16.512111] RDX: 4000000000000000 RSI: 0000000000000087 RDI: 0000000=
0000a722c
> > [   16.512111] RBP: 0000000000000000 R08: 00000000000a722c R09: ffffa2d=
57da249d0
> > [   16.512112] R10: ffffa2d57da1bac0 R11: 0000000000000001 R12: 0000000=
000000000
> > [   16.512112] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000014770
> > [   16.512113]  default_idle+0x9/0x10
> > [   16.512117]  default_idle_call+0x2a/0xf0
> > [   16.512119]  do_idle+0x1cb/0x230
> > [   16.512129]  cpu_startup_entry+0x24/0x30
> > [   16.512130]  rest_init+0xbc/0xc0
> > [   16.512133]  start_kernel+0x6d7/0x6e0
> > [   16.512164]  x86_64_start_reservations+0x24/0x30
> > [   16.512172]  x86_64_start_kernel+0xc8/0xd0
> > [   16.512173]  common_startup_64+0x13e/0x148
> > [   16.512181]  </TASK>
> > [   16.512181] handlers:
> > [   16.513166] [<00000000b61218c7>] vp_interrupt
> > [   16.515096] Disabling IRQ #11
> >
> > with IRQ#11 being:
> >
> > # cat /proc/interrupts
> >            CPU0       CPU1
> >  11:     102218          0  IO-APIC  11-fasteoi   virtio0
> >
> >
> > This cannot be reproduced with the old version of vhost-device. I think
> > it is due to the removal of the req_rx_buf variable and associated
> > logic: a vq kick is now being performed at every cycle of the event
> > loop, even if no processing happened. At guest side, this results in a
> > IRQ not cared for.
> >
>
> Thanks Francesco! right, I made a mistake. process_rx_queue() is only
> invoking signal_used_queue() when req_rx_buf is true, i.e., the device
> has actually added something to the used ring. I'll fix that.
>
Feel free to test the updated commit. I just fixed a few bugs. So far
my tests seem correct.

Matias

