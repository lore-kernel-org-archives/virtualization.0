Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3124841DE02;
	Mon, 24 Aug 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576239; cv=none; b=FP0a9BnfZ579qfjuAbLVrT4/2lreGHm3WatDnU4UXZwDtJZIyTp/N45n2XMFOlx0OoOWrHaTInmuk83ZhqXrlp0MfePhWcrZEGZl4KWtIWrvVCHU/qAjEh6kFD9xqmerKqMZahpzcZQC9gKYr0rDJ4H3e3D6ex3HtU1VlliHgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576239; c=relaxed/simple;
	bh=gFPkcIHnQkRgZ6LvoT82P7KXrjaxtmSA5hYHJkD/53k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pQinPk8FnwiXnKbVP/KVH0DZer+NIIh5bsq9r67SVdr6yiT+3lpGO9ujfSMlw64Q+B+Tb46//QyQDj0autzVtWAdzZUaGTTN87AjbXilNZZqZCfBHOTE9uytoa1f+pprdMAsX6Wzz+jqmqL9DCxr81SbxGeBFyGHF0N6GCC5UrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UELVG1hp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UELVG1hp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D244C1F000E9;
	Mon, 24 Aug 2026 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787576237;
	bh=wCQGBGKrnXzElrElzJa+hggu/yGdQXuY5mcnoZzygSg=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=UELVG1hprXVRRgMB5RGtVROPuTKxv2LSMQF9qPKNg33hKdTyfASd75+SI4DupNVWb
	 jhESm3EATnoBEvg7egA1HEGZIQ8hY2Q+RDVDYDOXI9ZjE7nmmrxtl6v4LTeks40GYd
	 so7o+nDOjGeAq2z6p7MW/AYlOKW30CF1Bw5Mcet7tEBfoiCXLoL0oWdiO9JUfvzwim
	 pspPheZ57oQncrkDKoC3uaJvSmTqWHV0RLbdibb2ntdakLqmdodJXei0LRtYy5Meko
	 z5T+/mUnwH5O6iRRlgvMZtEGTT/0pUYtRUGsZuLPmJV/3X4Sj1Zp/8BFT2hZ+oH+dW
	 z3gMl3TbIf6Jw==
Message-ID: <0e69abdc-0127-45dc-9bc1-bf48772cc7ea@kernel.org>
Date: Mon, 24 Aug 2026 14:57:12 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virt?] INFO: trying to register non-static key in
 stats_request (2)
To: syzbot <syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com>,
 eperezma@redhat.com, jasowangio@gmail.com, linux-kernel@vger.kernel.org,
 mst@redhat.com, syzkaller-bugs@googlegroups.com,
 virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
References: <6a88e933.ae6ddae5.3da009.0046.GAE@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <6a88e933.ae6ddae5.3da009.0046.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/26 02:11, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8d3ae59288f1 Linux 7.2
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10240679580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c9eb8e593cf8c5c
> dashboard link: https://syzkaller.appspot.com/bug?extid=13df72e0dc4be5c62215
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> 

virtio-balloon in an RT kernel/environment, unlikely in pactice ... :)

> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cd49b631c498/disk-8d3ae592.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/05d3ad83c130/vmlinux-8d3ae592.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3a2efa4a6769/bzImage-8d3ae592.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+13df72e0dc4be5c62215@syzkaller.appspotmail.com
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 0 UID: 0 PID: 20235 Comm: irq/10-virtio2 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  assign_lock_key+0x133/0x150 kernel/locking/lockdep.c:984
>  register_lock_class+0xcc/0x2e0 kernel/locking/lockdep.c:1299
>  __lock_acquire+0xab/0x2ce0 kernel/locking/lockdep.c:5112
>  lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
>  rt_spin_lock+0x83/0x400 kernel/locking/spinlock_rt.c:56
>  spin_lock include/linux/spinlock_rt.h:45 [inline]
>  start_wakeup_event drivers/virtio/virtio_balloon.c:150 [inline]
>  stats_request+0xa5/0x1f0 drivers/virtio/virtio_balloon.c:435


I don't really understand what's happening here, Is the register_lock_class()
trying to reguster a non-static key?

I don't immediately see how virtio-balloon is doing something odd here, all it
does is a spin_lock_irqsave(&vb->wakeup_lock, flags), that was earlier
initialized with spin_lock_init(&vb->wakeup_lock), before the device was ready.

-- 
Cheers,

David
