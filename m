Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E215328603
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373458; cv=none; b=blkP2TzXlkcK0pvTfMKjpb+yLN/Y3H8jhDRv9NulB6FKpYlZQDBnAlIqZP5zPYxHpBHhxoT+Pu0NncTbbBe5bUHiyjrlU3vGwU7F9Pei9bLrvCyKkSIULcyXwolFNSMOOjhY3Deqo3Kw9Dbpohu1a3DjD+q+MX1iXLjwUvWt1Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373458; c=relaxed/simple;
	bh=28pFU7amwJNudkLV4ASV8uVjtueADNX6pTrvQXgsL8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uEOqv5Tmf0BxE0zffZ5/SF/RcuMQfmdzHIG2YDpSeU2yTvwKadhSAzug2B3ENW0nZZFgyWG4tP+4I6Zoi+YTNQvvrzC60osXfMEpPr3+2rqEn2kOzBAAjHzG2gmCB06JD43kS5Ar3qy9kLpLG4XPfFM3B/VxBztVuPclNc024Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2IAAyJk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2IAAyJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763373453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXL+8AkvBN5xmyuybLdZ8RubjN7nYDtLBw5DrAt1WDc=;
	b=i2IAAyJkcqKL3fMl9NfNKiTnDJjB4/IuOe/JcdhKz2k6elHj1466+BzjP296JSiEMl4hbL
	92+zIz6ul5GCRxBhwkTzIK9l8+SmZR3N4TEEMsGL5dKJiK1FPbQvnue3ZQkubh7OAE6/7A
	gxDOjWD2AwoCXOdJtkIu79WPFwgL+gU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-cL-1Zw0hMIO14uC7soafow-1; Mon, 17 Nov 2025 04:57:31 -0500
X-MC-Unique: cL-1Zw0hMIO14uC7soafow-1
X-Mimecast-MFC-AGG-ID: cL-1Zw0hMIO14uC7soafow_1763373451
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477964c22e0so14771905e9.0
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 01:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373450; x=1763978250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXL+8AkvBN5xmyuybLdZ8RubjN7nYDtLBw5DrAt1WDc=;
        b=ND2IjTjymeU+yqII3FdtZui6FDhCj9FcFYcFCnrZ8xuaUsTjiK0qEcojaDu0ZY4oW+
         I8n2t4sGqwHev622p16RWqknwTVAs4r7RGhG19zvixYCNjncEIHydJlXRZ9RnPkB3vhm
         gp0Np4IkyqifnjQHgoGAvg0mLUlfKzTqKfmZpqGuGh45B7jmiXRkZlfg5JYzCaxdS31u
         qxWeBEG0zHfrvT/QuzfXEx4OIygCAcMghun/UYXvcR9FG/FWmN2Gfrfl6a3xDKHnWjdA
         cCMng6HHj7dVIQ3HlljlMs+BxvIjbFdvd85jBnr9wrBuQgVyk4syTBPzK6gki5jJRuP7
         nX2w==
X-Forwarded-Encrypted: i=1; AJvYcCVvMzcBYW4BZDnDwi8BivakhV3UMZfXJDDUuqFkgHz2Awwcv8tu1bk+RMUvqMP02QCZaszCU4m+VAoxnZ6F8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGPSw5SQ2S9hmmLosXc7NLOALoz2NBLtbkozWJa4rKtsvFEWOK
	a8Vu8343os+AbdoyAa8DjIGsYxok5HSlFyrVkJBtgTEwIqdui2DGo0AGE4BvkVnPfpJHeXiLPmi
	tI40O03caiD3Zhvzl1BrF3+WSP9O75fDsB25seIjGdE94aDUGpXZcuzcwK2IW9uUAZfWI
X-Gm-Gg: ASbGncu+ZEASh7FilM4yzwDgycHhhK9VvDOqAG3QUseOdo8jC0f1TaLmDJwpnq8Lnx/
	JAgmsYT3sSRfim106SdKHRL52y6suE6nLz1svu4LW9qfE5qK4g5ncVlRQ7NvWyxkIC3S+QWnPCd
	HgNtGGIJ66ruORJy+WrXyrf4hNFLjT98DCgqaQnaHy8Q0hQQQDCIxq390ft1FP2IEx5qmywaV8c
	njtykPzq6vm0CPmalFh2h2OGZGqpPnJrJRcor6RasY3mO09UHk+SWELxqFtvKMvtzAdCxcIbaTK
	XI8ssVrZMq2OdElPktwjaWCj88FXdIHWSqe0GddKqWnrET8yxa4ixXBKMWUP7jfR+4jtAzHb7uy
	bTkSSbAgv1XogW2XmZN52orn3GaIR4Qdofzu7o15RGxWP3s9gZHs=
X-Received: by 2002:a05:600c:4c14:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-4779d88318amr36265125e9.0.1763373449836;
        Mon, 17 Nov 2025 01:57:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ4w6NACEVONq7vBMQgMk6jVaCUQPhHegE9Q9L5O4oMC+7xXcdXI7Bcs+2joXwdJwTRVfM0A==
X-Received: by 2002:a05:600c:4c14:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-4779d88318amr36264835e9.0.1763373449311;
        Mon, 17 Nov 2025 01:57:29 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47799768409sm129895385e9.3.2025.11.17.01.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:57:28 -0800 (PST)
Date: Mon, 17 Nov 2025 10:57:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: syzbot <syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] possible deadlock in vsock_linger
Message-ID: <awg7m76nw234dqgbe5e3tzuwpr6aznj6htvypwoulg5sjwax36@z6wqmopayakt>
References: <68f6cdb0.a70a0220.205af.0039.GAE@google.com>
 <pehr4umqwjv3a7p4uudrz3uuqacu3ut66kmazw2ovm73gimyry@oevxmd4o664k>
 <CAGxU2F5y+kdByEwAq-t15fyrfrgQGpmapmLgkmDmY4xH4TJSDw@mail.gmail.com>
 <CAGxU2F6KaqmmK7qP55Rs8YHLOX62HyT77wY-RU1qPFpjhgV4jg@mail.gmail.com>
 <60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BmoBHQG5G1K62viPWUTWCJ03tb4AJ2ZN4PJiXG53OVg_1763373451
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Nov 15, 2025 at 05:00:28PM +0100, Michal Luczaj wrote:
>On 10/21/25 14:19, Stefano Garzarella wrote:
>> On Tue, 21 Oct 2025 at 12:48, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>
>>> On Tue, 21 Oct 2025 at 10:27, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>>>
>>>> Hi Michal,
>>>>
>>>> On Mon, Oct 20, 2025 at 05:02:56PM -0700, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot found the following issue on:
>>>>>
>>>>> HEAD commit:    d9043c79ba68 Merge tag 'sched_urgent_for_v6.18_rc2' of git..
>>>>> git tree:       upstream
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=130983cd980000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e7b5a3627a90dd
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=10e35716f8e4929681fa
>>>>> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f0f52f980000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ea9734580000
>>>>>
>>>>> Downloadable assets:
>>>>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d9043c79.raw.xz
>>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/0546b6eaf1aa/vmlinux-d9043c79.xz
>>>>> kernel image: https://storage.googleapis.com/syzbot-assets/81285b4ada51/bzImage-d9043c79.xz
>>>>>
>>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>>> Reported-by: syzbot+10e35716f8e4929681fa@syzkaller.appspotmail.com
>>>>>
>>>>> ======================================================
>>>>> WARNING: possible circular locking dependency detected
>>>>> syzkaller #0 Not tainted
>>>>> ------------------------------------------------------
>>>>> syz.0.17/6098 is trying to acquire lock:
>>>>> ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
>>>>> ffff8880363b8258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_linger+0x25e/0x4d0 net/vmw_vsock/af_vsock.c:1066
>>>>
>>>> Could this be related to our recent work on linger in vsock?
>>>>
>>>>>
>>>>> but task is already holding lock:
>>>>> ffffffff906260a8 (vsock_register_mutex){+.+.}-{4:4}, at: vsock_assign_transport+0xf2/0x900 net/vmw_vsock/af_vsock.c:469
>>>>>
>>>>> which lock already depends on the new lock.
>>>>>
>>>>>
>>>>> the existing dependency chain (in reverse order) is:
>>>>>
>>>>> -> #1 (vsock_register_mutex){+.+.}-{4:4}:
>>>>>       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>>>>>       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>>>>>       vsock_registered_transport_cid net/vmw_vsock/af_vsock.c:560 [inline]
>>>>
>>>> Ah, no maybe this is related to commit 209fd720838a ("vsock:
>>>> Fix transport_{g2h,h2g} TOCTOU") where we added locking in
>>>> vsock_find_cid().
>>>>
>>>> Maybe we can just move the checks on top of __vsock_bind() to the
>>>> caller. I mean:
>>>>
>>>>         /* First ensure this socket isn't already bound. */
>>>>         if (vsock_addr_bound(&vsk->local_addr))
>>>>                 return -EINVAL;
>>>>
>>>>         /* Now bind to the provided address or select appropriate values if
>>>>          * none are provided (VMADDR_CID_ANY and VMADDR_PORT_ANY).  Note that
>>>>          * like AF_INET prevents binding to a non-local IP address (in most
>>>>          * cases), we only allow binding to a local CID.
>>>>          */
>>>>         if (addr->svm_cid != VMADDR_CID_ANY && !vsock_find_cid(addr->svm_cid))
>>>>                 return -EADDRNOTAVAIL;
>>>>
>>>> We have 2 callers: vsock_auto_bind() and vsock_bind().
>>>>
>>>> vsock_auto_bind() is already checking if the socket is already bound,
>>>> if not is setting VMADDR_CID_ANY, so we can skip those checks.
>>>>
>>>> In vsock_bind() we can do the checks before lock_sock(sk), at least the
>>>> checks on vm_addr, calling vsock_find_cid().
>>>>
>>>> I'm preparing a patch to do this.
>>>
>>> mmm, no, this is more related to vsock_linger() where sk_wait_event()
>>> releases and locks again the sk_lock.
>>> So, it should be related to commit 687aa0c5581b ("vsock: Fix
>>> transport_* TOCTOU") where we take vsock_register_mutex in
>>> vsock_assign_transport() while calling vsk->transport->release().
>>>
>>> So, maybe we need to move the release and vsock_deassign_transport()
>>> after unlocking vsock_register_mutex.
>>
>> I implemented this here:
>> https://lore.kernel.org/netdev/20251021121718.137668-1-sgarzare@redhat.com/
>>
>> sysbot successfully tested it.
>>
>> Stefano
>
>Hi Stefano

Hi Michal!

>
>Apologies for missing this, I was away for a couple of weeks.

Don't worry at all!

>
>Turns out it's vsock_connect()'s reset-on-signal that strikes again. While
>you've fixed the lock order inversion (thank you), being able to reset an
>established socket, combined with SO_LINGER's lock-release-lock dance,
>still leads to crashes.

Yeah, I see!

>
>I think it goes like this: if user hits connect() with a signal right after
>connection is established (which implies an assigned transport), `sk_state`
>gets set to TCP_CLOSING and `state` to SS_UNCONNECTED. SS_UNCONNECTED means
>connect() can be retried. If re-connect() is for a different CID, transport
>reassignment takes place. That involves transport->release() of the old
>transport. Because `sk_state == TCP_CLOSING`, vsock_linger() is called.
>Lingering temporarily releases socket lock. Which can be raced by another
>thread doing connect(). Basically thread-1 can release resources from under
>thread-0. That breaks the assumptions, e.g. virtio_transport_unsent_bytes()
>does not expect a disappearing transport.

Makes sense to me!

>
>BUG: KASAN: slab-use-after-free in _raw_spin_lock_bh+0x34/0x40
>Read of size 1 at addr ffff888107c99420 by task a.out/1385
>CPU: 6 UID: 1000 PID: 1385 Comm: a.out Tainted: G            E
>6.18.0-rc5+ #241 PREEMPT(voluntary)
>Call Trace:
> dump_stack_lvl+0x7e/0xc0
> print_report+0x170/0x4de
> kasan_report+0xc2/0x180
> __kasan_check_byte+0x3a/0x50
> lock_acquire+0xb2/0x300
> _raw_spin_lock_bh+0x34/0x40
> virtio_transport_unsent_bytes+0x3b/0x80
> vsock_linger+0x263/0x370
> virtio_transport_release+0x3ff/0x510
> vsock_assign_transport+0x358/0x780
> vsock_connect+0x5a2/0xc40
> __sys_connect+0xde/0x110
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x94/0xbb0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Allocated by task 1384:
> kasan_save_stack+0x1c/0x40
> kasan_save_track+0x10/0x30
> __kasan_kmalloc+0x92/0xa0
> virtio_transport_do_socket_init+0x48/0x320
> vsock_assign_transport+0x4ff/0x780
> vsock_connect+0x5a2/0xc40
> __sys_connect+0xde/0x110
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x94/0xbb0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>Freed by task 1384:
> kasan_save_stack+0x1c/0x40
> kasan_save_track+0x10/0x30
> __kasan_save_free_info+0x37/0x50
> __kasan_slab_free+0x63/0x80
> kfree+0x142/0x6a0
> virtio_transport_destruct+0x86/0x170
> vsock_assign_transport+0x3a8/0x780
> vsock_connect+0x5a2/0xc40
> __sys_connect+0xde/0x110
> __x64_sys_connect+0x6e/0xc0
> do_syscall_64+0x94/0xbb0
> entry_SYSCALL_64_after_hwframe+0x4b/0x53
>
>I suppose there are many ways this chain of events can be stopped, but I
>see it as yet another reason to simplify vsock_connect(): do not let it
>"reset" an already established socket. I guess that would do the trick.
>What do you think?

I agree, we should do that. Do you have time to take a look?

Thanks for the help!
Stefano

