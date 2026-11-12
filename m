Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794487275;
	b=q2PtIoWmcZHXGUp6G3+dRe1qkl/42xEIUVoPKBTy4ikkvfGjoSEVnZhxaf+v32UtAUoB
	 uNVpfVRZyLulGs6CnKF+hEt8lJR/8Y6RM54XpL06KbJNvIZ9S5wS/BC5/3yNC/3HzcC2P
	 ZAeTRo34ROgrrYtPWnGpH81j/QM/n0l50s2jgyMgxfg+d4uvZnfGCTSnLdGZ4rNANFQX+
	 wPeCgM+W5uS2fqynXLuwuGShkM4B7YGaFjk+sZIQVzPSqZL2KMAMVBy/wsgusk+E6M/Pp
	 fzGg8nTZo8KbGidPUz7Lkwugi0ycRVhUOCGxrufMie2exU8J2hZHU/PD2hLCjcM4fHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FIoCnP3oiDG1vIrSFHHGQKzBKdlWcMUHWJDoXuLp/j0=;
	b=itXc2o9OQbckwFtXF545orwNTweuSZWMKbuBokWaotjT89x3ECSSVgu7AOu9cm5iZgIw
	 aolWG76h3VJDW3sWapI2aZgDVIlsQ+OCFw8e3h+Gc8OpBj6Gvk0lXHTH4vqz6eJO8DkC8
	 8tcmtsy6/k/OFnbdEIg8XNpbsBp8AX9z9aNmlC4Ak/6sURLoFctRVcxXxiwCPT8+TN7Uw
	 Id5N167Sca2MSRGpIINDxGlxZfWeVemv+NYxuhCMWjPynROA4P/sStx7QFUAYrI7/1T/h
	 lAKLfBhZIQcYoz69SkN8+/zlCJVtqKT6HynJv77HGOqdh49WdQVNUxNASNO5pWK8qyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NZlyJ8iC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5D3606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 12:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C5D3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NZlyJ8iC
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91eb449364cso46923466d6.2
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 04:41:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794487274; cv=none;
        d=google.com; s=arc-20260327;
        b=EaazppvpR9aP1Xk5Vqu92dPnCMfLMXXjGL6juQvQKki8wGb95LjkaBnpBnLa82TA0j
         EumlkuxlWCSvVqJEdQeu3VxpHLiP5syiGZz3FDlWJTeNF7iTa1EF75B5NNAeh7nWciRi
         dtKviqxfdjWtZkBXybMSkcApxrBYahwZkl4GMOiRPxmaAzpMyLueTmtgvP7EukNyACsr
         oe7SGM/7sR2aOS0CwVWHQqa211RxHvbF9XgPYuvIA79PPgot6worR2mkW1ckG/NjjaJn
         yZX+RhL9UehXpD0DsI0YCNFbqc/IBRY0mOOIbbvCn/Uv+DE1NGkeBqLn79h9nVMYf2bp
         Yz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FIoCnP3oiDG1vIrSFHHGQKzBKdlWcMUHWJDoXuLp/j0=;
        fh=mDPaTo0iAje9WUoGuGJ2/xbo6lIXB6vpFlLzpuxsoqg=;
        b=Wzz9/f2CJJt9H5Xir9Vfb7Jnoq2/0KNy6OASJs3d4P/oQTaYRo1/j0eXoetCmmP/kt
         5opWY2D8mtCSjThpOQSR3Cv9SYLINPDm2HHLhGVInjSZcIUsVAg9AE3TpLi6yx0pEhU1
         s/r0WyZzBwZMwz/g2Ab2e7uyAutQq9HKsFJr1OntKTv13Y63nruBX+0c+fAEyRuBHfew
         yHdf0H041q4F0mW9HILpw/Uvy8I9kEXGGxzduFUraX77SoNYaTpxA43z8pCaObiw31Hh
         6vqQeIqzVATYNFCiOKRWsa385D/z3/vxKVi2efvlCYGZuh4nV9c5txFjLAznF/FW2H/V
         cGEQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794487274; x=1795092074; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FIoCnP3oiDG1vIrSFHHGQKzBKdlWcMUHWJDoXuLp/j0=;
        b=NZlyJ8iC8nao8V6EThpDNhIR/6jdJIjap8aHhOrdD6fxfXFgCyci/EkBvuTdcrun6A
         sj1jrSilPTdsh2rgyNSvp2+iA3EKqpk1c6NM+gflhIgkXJWyAJdueLB9FPsrJS4expRx
         /EENaOybt/TdYlGd881Rn808dE0jrBBP+fZ+r5eY0dMAJQXbh5ilQsAR4IcnU+viulDB
         s/BxVUaNjDlz7AX7LBPxY0NiNYcnFNf7CruvrquvswXKGR1ij+v3XI5SWwxqizFdlILj
         aSOQKqc64EvZ08cWg9Wf1hJYni21sTQ+w+oNB/I8o471Xm5mox/lkuZWcFma6Iho4H1q
         cZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794487274; x=1795092074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FIoCnP3oiDG1vIrSFHHGQKzBKdlWcMUHWJDoXuLp/j0=;
        b=No/otvOHwQxv1xqJLqYsg8PPOPvVdFaxW5/58ChO342RRUVm9BPCWODDWx+q29TZHq
         EF6WTS8r6BQ+Az3DRqHx6+C0pafn/GZZjfxp59+MX1vM7KUsxVYaVHoaWMd7c5wTdZFy
         woOMMnIsdjaZlZpsekValHJcMPyYuGL2AccdBDiLaP1Dxd2Q+nh8SErBFKBySbu4JWde
         uSz/VHZhDlfvIn1JCkE4A3w9f2cyuGQgSG4/rrU2kqjC0K/AOM8aNjf9MvZnAb22ITfy
         81u9Enrz+7OqTknJD+EGbUQMMAe7fsffyHIzFUGH54kIlaIZZpUgOVoFSckCzl1sENI5
         p/tw==
X-Forwarded-Encrypted: i=1; AL+hErEnjSeDOaQ5p4Is9nWWXlL2MCAIf9JQb+HXZq7dq6LuoGVNQP8PQacPWs2UWAU/tJsnI0IrZV8wtwCq+bs4cw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/e6aKBNAPO0S0vQkqUq/lbeZ+IC9rO6elqvaB6I2/NV3xK9R5/
	kdt8yjIq7vyiP3w6DbXSOt4GNhNmLyaKCEIWlI3JrE1LHut8WbW9seSU8WhObZ3wQe+zx0MY8Ql
	fd3yTA7YM62HQLyVk9Sr10hsqdf2BWhgzagUUep5i
X-Gm-Gg: AYBFou3pCXtNoEyc0EwvG8HywwuI4+UBhheduzqUSvA5VDPGiBLcWbEtpr+r2XJ4McK
	O+LOXGIZ6+ECDSHQrlDJhnhNcQG463597BVof4DmWicz37hhYTmMXL624Cp20SWX4zr++uj6GUs
	/r9E3/hHDsASOpE/QwvQMYhucm869Zk9uUg9z6c+MMJkJipkT/eWoQYBt3BTCzhGp+1fIL6R+nP
	T22ES5r7+U/Hn1SfJZQjabVplwwBuJbgKmM2jhcs8zftfroKZCKFd6NPGtAX4RXmWZxdh0I1arn
	1Q+/q+wGrWqnXJwMpDMbVcUEB/Ev6Ow0HgIKldu0jfkGxrMDyeez3E4wcUFN1eV0VN73XanKDPR
	3fiHNAxruHfw4WBrLDJ9t+dIxaiw2HoVFIqsKFpajCNaJ3WwRoGxSNadWTz9VyR9JG7XITsEwmh
	b6dMIa1HDA4E5T62XLNC1cVuNvBVy3YGSoYBfOtLELgKA=
X-Received: by 2002:a05:6214:55c1:b0:91f:10c3:1bfc with SMTP id
 6a1803df08f44-91f10c32037mr52866176d6.48.1794487273295; Thu, 12 Nov 2026
 04:41:13 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <6af55517.a0c627da.5d811.0011.GAE@google.com>
In-Reply-To: <6af55517.a0c627da.5d811.0011.GAE@google.com>
From: Pimyn Girgis <pimyn@google.com>
Date: Thu, 12 Nov 2026 13:41:02 +0100
X-Gm-Features: AclHuK_attCAnoNuGFMRE_bVy_a69Tw0-PxKKa9Q328h3Xb-ONM8x-Dc5m4eh3o
Message-ID: <CAJWNTGzTPD-pWeKhVcAO-J475n0osXVrZTG-gmHtwXRTAgWWig@mail.gmail.com>
Subject: Re: [syzbot] [virt?] BUG: unable to handle kernel paging request in
 __run_timers (3)
To: syzbot <syzbot+0d91f453e89c72a04157@syzkaller.appspotmail.com>
Cc: ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, 
	virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz invalid


On Thu, Nov 12, 2026 at 6:56=E2=80=AFAM syzbot
<syzbot+0d91f453e89c72a04157@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d164c7d754f0 Merge tag 'devicetree-fixes-for-7.4-1' of gi=
t..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D179566fd58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1cf189394a856=
f11
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0d91f453e89c72a=
04157
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for D=
ebian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D173a724e580=
000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-d164c7d7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0f548ae8bf9e/vmlinu=
x-d164c7d7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/79563ef77b97/b=
zImage-d164c7d7.xz
>
> AI-generated root cause summary:
> proc_bus_pci_write() in drivers/pci/proc.c allows userspace to write raw =
values
> directly into the PCI configuration space of PCI devices without restrict=
ing
> writes to critical platform host bridge registers when lockdown is not ac=
tive.
> Writing to device 00:00.0 (the Q35 Host Bridge / DRAM Controller) overwri=
tes
> memory controller registers, causing QEMU to unmap system RAM and return
> all-ones (0xffffffffffffffff) for affected physical addresses. Consequent=
ly,
> when the timer subsystem in __run_timers() dequeues an active timer from =
an
> affected page, entry->next and entry->pprev evaluate to 0xfffffffffffffff=
f,
> causing __hlist_del() to trigger a fatal supervisor write page fault at a=
ddress
> 0xffffffffffffffff.
>
> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=3D0d91f45=
3e89c72a04157
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0d91f453e89c72a04157@syzkaller.appspotmail.com
>
> BUG: unable to handle page fault for address: ffffffffffffffff
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD fd99067 P4D fd99067 PUD fd9b067 PMD 0
> Oops: Oops: 0002 [#1] SMP KASAN NOPTI
> CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted syzkaller #0 PREEMPT(ful=
l)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:__hlist_del include/linux/list.h:1045 [inline]
> RIP: 0010:detach_timer kernel/time/timer.c:892 [inline]
> RIP: 0010:expire_timers kernel/time/timer.c:1783 [inline]
> RIP: 0010:__run_timers+0x68a/0xb00 kernel/time/timer.c:2375
> Code: 8b 3b 48 89 f8 48 c1 e8 03 42 80 3c 20 00 0f 85 08 03 00 00 48 8b 4=
3 08 48 89 c2 48 c1 ea 03 42 80 3c 22 00 0f 85 db 02 00 00 <4c> 89 38 48 89=
 44 24 08 4d 85 ff 74 24 e8 54 50 15 00 49 8d 7f 08
> RSP: 0018:ffffc90000658d48 EFLAGS: 00010046
> RAX: ffffffffffffffff RBX: ffff8880456d98d8 RCX: 0000000000000102
> RDX: 1fffffffffffffff RSI: ffffffff81f92b99 RDI: ffff8880456d98e0
> RBP: ffffc90000658e08 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffffff926ab25f R11: 0000000000000001 R12: dffffc0000000000
> R13: fffff520000cb1c1 R14: ffff88806a2266c0 R15: ffffffffffffffff
> FS:  0000000000000000(0000) GS:ffff8880d4675000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffffffffff CR3: 0000000059bd9000 CR4: 0000000000352ef0
> Call Trace:
>  <IRQ>
>  __run_timer_base kernel/time/timer.c:2387 [inline]
>  __run_timer_base kernel/time/timer.c:2379 [inline]
>  run_timer_base+0x114/0x190 kernel/time/timer.c:2396
>  run_timer_softirq+0x1a/0x50 kernel/time/timer.c:2406
>  handle_softirqs+0x216/0xa20 kernel/softirq.c:669
>  __do_softirq kernel/softirq.c:703 [inline]
>  invoke_softirq kernel/softirq.c:542 [inline]
>  __irq_exit_rcu+0x178/0x220 kernel/softirq.c:786
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inli=
ne]
>  sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:674
> RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:64
> Code: 67 a0 02 e9 43 61 03 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d c3 6d 1c 00 fb f4 <c3> cc cc cc cc=
 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
> RSP: 0018:ffffc90000197e00 EFLAGS: 00000206
> RAX: 000000000004ea47 RBX: ffff888020aba580 RCX: ffffffff8bef5325
> RDX: 0000000000000001 RSI: ffffffff8e629989 RDI: ffffffff8c835980
> RBP: ffffed10041574b0 R08: 0000000000000001 R09: ffffed100d446825
> R10: ffff88806a23412b R11: 0000000000000001 R12: 0000000000000000
> R13: 0000000000000000 R14: 1ffff92000032fc4 R15: dffffc0000000000
>  arch_safe_halt arch/x86/include/asm/paravirt.h:62 [inline]
>  default_idle+0x9/0x10 arch/x86/kernel/process.c:768
>  default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
>  cpuidle_idle_call kernel/sched/idle.c:199 [inline]
>  do_idle+0x3ae/0x5b0 kernel/sched/idle.c:355
>  cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:458
>  start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
>  common_startup_64+0x13e/0x158
>  </TASK>
> Modules linked in:
> CR2: ffffffffffffffff
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   8b 3b                   mov    (%rbx),%edi
>    2:   48 89 f8                mov    %rdi,%rax
>    5:   48 c1 e8 03             shr    $0x3,%rax
>    9:   42 80 3c 20 00          cmpb   $0x0,(%rax,%r12,1)
>    e:   0f 85 08 03 00 00       jne    0x31c
>   14:   48 8b 43 08             mov    0x8(%rbx),%rax
>   18:   48 89 c2                mov    %rax,%rdx
>   1b:   48 c1 ea 03             shr    $0x3,%rdx
>   1f:   42 80 3c 22 00          cmpb   $0x0,(%rdx,%r12,1)
>   24:   0f 85 db 02 00 00       jne    0x305
> * 2a:   4c 89 38                mov    %r15,(%rax) <-- trapping instructi=
on
>   2d:   48 89 44 24 08          mov    %rax,0x8(%rsp)
>   32:   4d 85 ff                test   %r15,%r15
>   35:   74 24                   je     0x5b
>   37:   e8 54 50 15 00          call   0x155090
>   3c:   49 8d 7f 08             lea    0x8(%r15),%rdi
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/syzkaller=
-bugs/6af55517.a0c627da.5d811.0011.GAE%40google.com.



--=20
=E2=B2=A0=E2=B2=9F=E2=B2=93=E2=B2=99=E2=B2=8F=E2=B2=9B =E2=B2=84=E2=B2=89=
=E2=B2=B1=E2=B2=A3=E2=B2=85=E2=B2=93=E2=B2=9F=E2=B2=A5 - Pimyn Girgis
Software Engineer
Kernel Dynamic Analysis
pimyn@google.com
