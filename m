Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454E62D1911
	for <virtualization@lists.linux.dev>; Wed,  7 Jan 2026 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826879; cv=pass; b=n2a0g7xxSZTRypnyub5eHf9o+GbHNPIy+PdOqbbLUKiECI8QJ/yHzJfcfybQcRthEPE55WjcZoMIPOLOktNliCTMP1KxbWjWmsAA3gKna8A8yEokw5VT5wr+SR1J9WVeauYcNvSnWd8kcorxz/oFGAx3hH8yG4dxSQz0KGyaUtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826879; c=relaxed/simple;
	bh=oP8pGZm+cqLJGzSioIxWYFk0K1HQ5KdZH03aqEoZKeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZw51CLcV7Jgy8g9I+VPirOonmNAHcuNgoCZKHw8z5F3vX2j6L/OZVbgs5CtbBjSQG8Vf/5+67g9MbhCX/t7Udc7n8HSRVtIZmtlu2bsu1KgpG+p1lKzLjIwaLfn1qvSXookfCgM/aEAlh74obDclgy90MI3y/qbHQTNtXbaxMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=vUqY4IX6; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=M0vnFg1L; arc=pass smtp.client-ip=185.56.87.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="vUqY4IX6";
	dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b="M0vnFg1L"
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-0n7x.prod.antispam.mailspamprotection.com; s=arckey; t=1767826877;
	 b=H2S95KG4aC3J7jOhG6M24DcumO99DgeTFtYcNCnXjSztjsLPrJwZUo+6pkQ8CsOuSonMN1HnNE
	  xawuBma/JkLSbR6F4AwcsQJfbnGCVJzUzHeVhrPqYh8WrDeMiDFDr/Il/ZX9z8ojEFcgSO3xog
	  ABM9XieexUovBPIKX/UK3hl79m4LKCEdZ7U84dMZtsw8AYalNX4uCH/0JMt6cOHjmzLQ5VvmM3
	  2lQcE9Uq7KFeIkELyw5R091oJ3NC3MI6s6woViYqg4FvjEl+BXonw7A/+fu1M6tVW4ZCrjGQcn
	  u34YoU7TBlkfgs4/PcwjfWl+jQn+WgNj0Stl9z6Vvel4ig==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-0n7x.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-0n7x.prod.antispam.mailspamprotection.com; s=arckey; t=1767826877;
	bh=oP8pGZm+cqLJGzSioIxWYFk0K1HQ5KdZH03aqEoZKeE=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=DuacQOSwzgE/VDXWzA0zsnOfrm2al/eoJDDy7IippPaH1vuOMuhKNy4HvXRMEeNj+uWuLONSCx
	  1TVVGABex0z62juZpUGoqFhEI/NnaCX0Z3X5pa5wi6rq9G4afpy17gGhnf+eKTf6ugh9PjgKjc
	  +O89S1R3B2nt7Ghw4NKf4tbmdkFxAWaynt5oPFJ6smBROJ7MPubLOA7/GiLLYDKqeCsNkSdm5T
	  lcGa1Mce6O4+THHFXdDmN41sp1s+iCjeRgur210cYcP4sdwkeb0/7glerwYR2dPIy8DUfeLI5f
	  +KdSeMFoXv8xofVNLKuvUah9cqoJuP+I/67muzrSWVEr0g==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=Hp53a5udJ6PijpVNE3Z6TiuRFMY1qRySTLf6XmsTlzA=; b=vUqY4IX6DRltPXVG2UAoZMCsPY
	sYIsyYkJiTMq8lBTVjwxVopIDkDlB277rBVVoEKuHUEp/t6qrQRd2ywmfbOh2f4jnq3usYBB4z5yi
	GQbWhNT7xeV+1I6MH0XmFf59ExIUbzu80+f6/ok6w4N+NJ69BGJrGO89YJO68C4nnc54=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-0n7x.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdcWd-00000002law-46md
	for virtualization@lists.linux.dev;
	Wed, 07 Jan 2026 23:01:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=Hp53a5udJ6PijpVNE3Z6TiuRFMY1qRySTLf6XmsTlzA=; b=M0vnFg1L9s6y3FlLV9nlL7XZRB
	YyMyo7MhooNP/5owr/EJCyg7v7Wws7yh9NZ5JpEv5opp3drwAFs3Pt40lx4pskoYwBJ5KryUfdlL0
	0LHMOS7pAvVU3C1snRkAVv1aA28dTKmNUalXUNPIXt3HvjwTbtbzu7EmADThBDFoZQwM=;
Received: from [95.248.141.113] (port=62613 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdcWO-00000000N79-10Xp;
	Wed, 07 Jan 2026 23:00:56 +0000
Date: Thu, 8 Jan 2026 00:00:54 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aV7lplXiOehmw2iR@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU6lCL_vrF93lpYa@bywater>
 <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
 <aV6sHofXnZuu84OV@bywater>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV6sHofXnZuu84OV@bywater>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: d88dc8af74dc1413d5da73bf575511f6
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vdcWd-00000002law-46md-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-0n7x.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Wed, Jan 07, 2026 at 07:55:26PM +0100, Francesco Valla wrote:
> Hi Matias,
> 
> On Wed, Jan 07, 2026 at 05:14:25PM +0100, Matias Ezequiel Vara Larsen wrote:
> > On Fri, Dec 26, 2025 at 4:09 PM Francesco Valla <francesco@valla.it> wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> > > > While stress testing this, I noticed that flooding the virtio-can
> > > > interface with packets leads to an hang of the interface itself.
> > > > I am seeing this issuing, at host side:
> > > >
> > > >       while true; do cansend can0 123#00; done
> > > >
> > > > with:
> > > >
> > > >  - QEMU: the tip of the master branch plus [2]
> > > >  - vhost-device: the tip of the main branch
> > > >
> > > > and the following QEMU invocation:
> > > >
> > > > qemu-system-x86_64 -serial mon:stdio \
> > > >     -m 2G -smp 2 \
> > > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > > >     -append "loglevel=7 console=ttyS0" \
> > > >     -machine memory-backend=pc.ram \
> > > >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> > > >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> > > >     -device vhost-user-can-pci,chardev=can0
> > > >
> > > >
> > > > Restarting the interface (i.e.: ip link set down and the up) does not
> > > > fix the situation.
> > > >
> > > > I'll try to do some more testing during the next days.
> > >
> > > After a deep dive, I _think_ the problem actually lies in vhost-device,
> > > since it is not there (or al least, it seems so) using an alternative
> > > implementation that uses the qemu socketcan support [0] (implementation
> > > which builds on top of the work done by Harald and Mikhail):
> > >
> > > qemu-system-x86_64 -serial mon:stdio \
> > >     -m 2G -smp 2 -enable-kvm \
> > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > >     -append "loglevel=7 console=ttyS0" \
> > >     -object can-bus,id=canbus0 -object can-host-socketcan,id=canhost0,if=vcan0,canbus=canbus0 \
> > >     -device virtio-can-pci,canbus=canbus0
> > >
> > > Unfortunately, my Rust knoweledge is not sufficient to understand the
> > > vhost-device implementation [1]; the issue seems to be related to the
> > > host->guest vring becoming empty and not refilling anymore.
> > >
> > 
> > Can you try with
> > https://github.com/MatiasVara/vhost-device/commits/fix-for-923/?
> 
> I'll stress test it during the night, but this seems to fix it. Before
> it was reproducible in a consistent manner after mere seconds, while i
> now in a bunch of runs I never reproduced it.
> 
> I also agree with your analysis on the commit.
>

Quick update, unfortunately not good: the RX issue is solved, but now I
have a different one: if I send a single message either from the guset
or the host (e.g.: cansend can0 111#00) I get:

[   16.496923] irq 11: nobody cared (try booting with the "irqpoll" option)
[   16.511875] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-00002-gded0a4b9da5a #29 PREEMPT(voluntary)
[   16.511883] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[   16.511887] Call Trace:
[   16.511933]  <IRQ>
[   16.511938]  dump_stack_lvl+0x4d/0x70
[   16.511973]  __report_bad_irq+0x30/0xb7
[   16.511986]  note_interrupt.cold+0x28/0x66
[   16.511988]  handle_irq_event+0x6d/0x70
[   16.512004]  handle_fasteoi_irq+0xd5/0x1f0
[   16.512011]  __common_interrupt+0x3f/0xd0
[   16.512023]  ? tick_nohz_irq_exit+0x2e/0x60
[   16.512035]  common_interrupt+0x3b/0x90
[   16.512057]  asm_common_interrupt+0x26/0x40
[   16.512073] RIP: 0010:handle_softirqs+0x6d/0x270
[   16.512081] Code: 02 00 01 00 00 89 5c 24 14 48 89 6c 24 08 c7 44 24 10 0a 00 00 00 89 7c 24 04 31 c0 65 66 89 05 01 ce 3e 02 fb bb ff ff ff ff <49> c7 c2 c0 80 a0 a2 44 89 ed 41 0f bc dd 83 c3 01 74 76 8d 43 ff
[   16.512082] RSP: 0018:ffffb22480003f98 EFLAGS: 00000246
[   16.512086] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000838
[   16.512087] RDX: 0000000000000000 RSI: ffffffffa2a0e940 RDI: 0000000000000000
[   16.512088] RBP: 00000000fffbac3e R08: 0000000000000001 R09: 0000000000000000
[   16.512088] R10: ffffa2d57da249d0 R11: ffffb22480003ff8 R12: 0000000000000000
[   16.512091] R13: 0000000000000082 R14: 0000000000000000 R15: 0000000000000000
[   16.512097]  irq_exit_rcu+0x89/0xb0
[   16.512099]  sysvec_apic_timer_interrupt+0x6b/0x80
[   16.512103]  </IRQ>
[   16.512104]  <TASK>
[   16.512104]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   16.512105] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   16.512107] Code: 2c 81 00 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 05 cf 18 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[   16.512109] RSP: 0018:ffffffffa2a03e80 EFLAGS: 00000212
[   16.512110] RAX: ffffa2d5da523000 RBX: ffffffffa2a0e940 RCX: 0000000000000838
[   16.512111] RDX: 4000000000000000 RSI: 0000000000000087 RDI: 00000000000a722c
[   16.512111] RBP: 0000000000000000 R08: 00000000000a722c R09: ffffa2d57da249d0
[   16.512112] R10: ffffa2d57da1bac0 R11: 0000000000000001 R12: 0000000000000000
[   16.512112] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000014770
[   16.512113]  default_idle+0x9/0x10
[   16.512117]  default_idle_call+0x2a/0xf0
[   16.512119]  do_idle+0x1cb/0x230
[   16.512129]  cpu_startup_entry+0x24/0x30
[   16.512130]  rest_init+0xbc/0xc0
[   16.512133]  start_kernel+0x6d7/0x6e0
[   16.512164]  x86_64_start_reservations+0x24/0x30
[   16.512172]  x86_64_start_kernel+0xc8/0xd0
[   16.512173]  common_startup_64+0x13e/0x148
[   16.512181]  </TASK>
[   16.512181] handlers:
[   16.513166] [<00000000b61218c7>] vp_interrupt
[   16.515096] Disabling IRQ #11

with IRQ#11 being:

# cat /proc/interrupts
           CPU0       CPU1
 11:     102218          0  IO-APIC  11-fasteoi   virtio0


This cannot be reproduced with the old version of vhost-device. I think
it is due to the removal of the req_rx_buf variable and associated
logic: a vq kick is now being performed at every cycle of the event
loop, even if no processing happened. At guest side, this results in a
IRQ not cared for.


Francesco

