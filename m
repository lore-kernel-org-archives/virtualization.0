Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A819343D
	for <virtualization@lists.linux.dev>; Wed,  2 Oct 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873835; cv=none; b=YIHAkI07KkFL2HvonPnyqw3uqg+nWdVWntvePZAMFx//09y95LI/G91iKh5vRgC0ECfKCQw90gTfdMdxInVwWLUkLLzrrwNehIpS/2sf1eNR67da8BoOohSiH9Lbh6cPDDReW12PkF4GQ9T8whrOFMSCb+z5fMG2oPxA/Eyz3YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873835; c=relaxed/simple;
	bh=jrEVMw8IJkCSvE4QE7C3Hnwe8cJQ8tAiTVNhS99+h8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=rc/KRBJP69RUFYPqrnS4/JACLJMhrfe6oU6KsACRejXqMXvaKViapht+tC74yb5Yuu3moa7NTI9sSBWrwk8G0GnREa6YVeMstvXrlCw5Fdexqy4A2S7MYW52B+2AXEY62bAba4t3e5I8qVd5F2krs5uuSRCc9yE0njRVIShTC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CwG/XM+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CwG/XM+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727873833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWtc7AuL9Wxo8lOYw3JlBimRBKyzoSOtZ4LRGgXJzjU=;
	b=CwG/XM+PHjsm9jKN0sQodilE9S8NS9tVt1VPgyUdeF1IB8AetmPiAtRHWriiZXlpZu9Yh2
	tK0P4lPmynjf3GZIWdJfvoGPBY56dRptgB0YB7ZAeviSBYkY67iiLuvcyaP4HqfoOkngwm
	iOWMqfusuS5DdMS8A7m4+r184SWbU4Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-P5YRNknxOVCMT-2yZAGRiQ-1; Wed, 02 Oct 2024 08:57:11 -0400
X-MC-Unique: P5YRNknxOVCMT-2yZAGRiQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a8e19833cso563438566b.1
        for <virtualization@lists.linux.dev>; Wed, 02 Oct 2024 05:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873830; x=1728478630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWtc7AuL9Wxo8lOYw3JlBimRBKyzoSOtZ4LRGgXJzjU=;
        b=JpgiFEH1XAkrEZdtmZKjV576aptLjDj1c+ph8drLSCAtzMz2yTQKky3q7/qULYUhOZ
         IKjp8k5JsAFjZVPyaaIUR6IFVTxvTSo5UtZdUGxhEiu5KHtyG3ajfePWCy8no7zUcG/2
         PCux1WyJOAJJ5Ht7h53aE8C7Gqrv13TK/6oHtYODLeOtl/tv2ObRwLYd2PwdZ30qCRrT
         OIILWOp0dt4Cr7fL/U+izdjyd+JmoHSsxWXVYIUa7UZmcMxS/CVPDpvoLD5PkScMj+yd
         QYjwYfX3RYOULAHUdoFF+P3vQbCl7V1XCtiGA37AnOZu93pVwsgQqLX3CmkYQGh4idBq
         WDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPJygNDcHXLbORwiXUeXxb5CUl3CrkpzyjPHLvc/cDKOGEAKTjkog81EANqYDAij9YRgTQwhDbvjHPHukE7w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyerY1PFsjjB7auJryMW/mXBBBOko84PH+fwkm/YI+HgPy2NCjo
	AQ9fkA4jfRUPSyfjofgNmUGlhQZlsX3jP3rr/6MaN3YAbqze4hGoohHtuVT4H93uhDvdnb8oOCi
	uH6SQpmzQeKgMrorSH+TFOeXrD/5oM3yVUrYtg7vvjUBwNfvdfWKSjqEV4jVC9arC
X-Received: by 2002:a17:907:1c02:b0:a8d:14e4:f94a with SMTP id a640c23a62f3a-a98f8257e90mr328604666b.38.1727873830367;
        Wed, 02 Oct 2024 05:57:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1wJIX1m2aS5swO1sUw1GUADX+2zaX2RGhKEWIJ+67dFN70Lw0ZXDeLut6kmJgsBGjHn+cvA==
X-Received: by 2002:a17:907:1c02:b0:a8d:14e4:f94a with SMTP id a640c23a62f3a-a98f8257e90mr328599966b.38.1727873829569;
        Wed, 02 Oct 2024 05:57:09 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9901058c4esm87382966b.194.2024.10.02.05.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:57:07 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:57:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev, luigi.leonardi@outlook.com
Subject: Re: Splat with v6.12-rc1
Message-ID: <eqrb4x2cypdj65owm74w5ci2llo3ri6yadgn5dpjx7t6itpdvq@cxg6d3ypays3>
References: <hfcr2aget2zojmqpr4uhlzvnep4vgskblx5b6xf2ddosbsrke7@nt34bxgp7j2x>
 <20241002072453-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241002072453-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 02, 2024 at 07:50:41AM GMT, Michael S. Tsirkin wrote:
>On Wed, Oct 02, 2024 at 11:34:48AM +0200, Christian Brauner wrote:
>> Hey,
>>
>> I'm seeing the following splat on v6.12-rc1 in case this hasn't been
>> reported yet:

@Christian thanks for the report, any suggestions on how to replicate 
it?

>>
>> [   33.662603] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:330
>> [   33.667624] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 772, name: incus-agent
>> [   33.671430] preempt_count: 0, expected: 0
>> [   33.674664] RCU nest depth: 1, expected: 0
>> [   33.676600] 3 locks held by incus-agent/772:
>> [   33.678184]  #0: ffff8881d1b38258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connectible_sendmsg+0x142/0x11c0 [vsock]
>> [   33.681712]  #1: ffffffff9b6f3420 (rcu_read_lock){....}-{1:2}, at: virtio_transport_send_pkt+0x7c/0x520 [vmw_vsock_virtio_transport]
>> [   33.685627]  #2: ffff88818ca2d160 (&vsock->tx_lock){+.+.}-{3:3}, at: virtio_transport_send_pkt+0x43a/0x520 [vmw_vsock_virtio_transport]
>> [   33.688906] CPU: 23 UID: 0 PID: 772 Comm: incus-agent Not tainted 6.12.0-rc1-g9852d85ec9d4 #23
>> [   33.690849] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/Incus, BIOS unknown 2/2/2022
>> [   33.692746] Call Trace:
>> [   33.693337]  <TASK>
>> [   33.693846]  dump_stack_lvl+0x6f/0xa0
>> [   33.694740]  __might_resched.cold+0x1ed/0x253
>> [   33.696031]  ? perf_trace_sched_switch+0x6f0/0x6f0
>> [   33.697143]  ? virtqueue_add_split+0x9b2/0x1f50
>> [   33.698120]  __kmalloc_noprof+0x313/0x440
>> [   33.698942]  ? __lock_acquire+0xcf6/0x4790
>> [   33.699861]  virtqueue_add_split+0x9b2/0x1f50
>> [   33.700864]  ? find_held_lock+0x2d/0x110
>> [   33.701691]  ? reacquire_held_locks+0x4d0/0x4d0
>> [   33.702646]  ? virtqueue_kick+0xe0/0xe0
>> [   33.703462]  ? __virt_addr_valid+0x155/0x440
>> [   33.709313]  ? lock_acquire+0x31/0xc0
>> [   33.710078]  ? __virt_addr_valid+0x155/0x440
>> [   33.710981]  virtqueue_add_sgs+0x10c/0x140
>> [   33.711891]  virtio_transport_send_skb+0x102/0x560 [vmw_vsock_virtio_transport]
>
>
>This passes GFP_KERNEL to virtqueue_add_sgs
>
>> [   33.713480]  virtio_transport_send_pkt+0x450/0x520 [vmw_vsock_virtio_transport]
>> [   33.713499]  virtio_transport_send_pkt_info+0x64f/0x1050 [vmw_vsock_virtio_transport_common]
>
>This calls a mutex taking function under rcu read lock.
>Plus plus ungood.
>
>
>
>> [   33.713525]  virtio_transport_stream_enqueue+0xaa/0xe0 [vmw_vsock_virtio_transport_common]
>> [   33.713534]  ? virtio_transport_shutdown+0xf0/0xf0 [vmw_vsock_virtio_transport_common]
>> [   33.713548]  ? _raw_spin_unlock_irqrestore+0x53/0x80
>> [   33.724011]  ? lockdep_hardirqs_on+0x78/0x100
>> [   33.724948]  ? _raw_spin_unlock_irqrestore+0x40/0x80
>> [   33.726954]  vsock_connectible_sendmsg+0xc9d/0x11c0 [vsock]
>> [   33.728983]  ? vsock_ioctl+0x240/0x240 [vsock]
>> [   33.730554]  ? __init_waitqueue_head+0x150/0x150
>> [   33.732409]  ? __lock_acquire+0xcf6/0x4790
>> [   33.733833]  ? vsock_ioctl+0x240/0x240 [vsock]
>> [   33.734976]  __sock_sendmsg+0xc1/0x150
>> [   33.736048]  sock_write_iter+0x21e/0x380
>> [   33.737055]  ? __sock_sendmsg+0x150/0x150
>> [   33.738179]  ? lockdep_hardirqs_on_prepare+0x410/0x410
>> [   33.742393]  ? security_file_permission+0x24/0x70
>> [   33.742437]  ? rw_verify_area+0x70/0x5e0
>> [   33.746265]  vfs_write+0xa4e/0xe40
>> [   33.746291]  ? reacquire_held_locks+0x4d0/0x4d0
>> [   33.746303]  ? trace_lock_acquire+0x141/0x1c0
>> [   33.746317]  ? kernel_write+0x630/0x630
>> [   33.746342]  ? __fget_files+0x30/0x350
>> [   33.757003]  ksys_write+0x178/0x1d0
>> [   33.757027]  ? __x64_sys_read+0xb0/0xb0
>> [   33.757044]  ? syscall_trace_enter+0x118/0x1e0
>> [   33.757091]  do_syscall_64+0x74/0x190
>> [   33.763371]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> [   33.763390] RIP: 0033:0x40720e
>> [   33.763411] Code: 48 83 ec 38 e8 13 00 00 00 48 83 c4 38 5d c3 cc cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
>> [   33.763418] RSP: 002b:000000c00021f508 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>> [   33.763441] RAX: ffffffffffffffda RBX: 000000000000000f RCX: 000000000040720e
>> [   33.763446] RDX: 00000000000003b5 RSI: 000000c00014e000 RDI: 000000000000000f
>> [   33.763451] RBP: 000000c00021f548 R08: 0000000000000000 R09: 0000000000000000
>> [   33.763455] R10: 0000000000000000 R11: 0000000000000202 R12: 000000c00021f688
>> [   33.763460] R13: 0000000924924924 R14: 000000c0001d0820 R15: 0000000000000011
>> [   33.763566]  </TASK>
>
>
>Caused by this:
>
>commit efcd71af38be403fa52223092f79ada446e121ba (tag: for_linus, tag: kernel.org/tags/for_linus)
>Author: Luigi Leonardi <luigi.leonardi@outlook.com>
>Date:   Tue Jul 30 21:47:32 2024 +0200
>
>    vsock/virtio: avoid queuing packets when intermediate queue is empty
>
>    When the driver needs to send new packets to the device, it always
>

Yep, I agree, thanks for the analysis!

>I guess this is exactly the reason we have an intermediate queue.

Not sure, IIRC we added the RCU later to fix some hotplug/unplug bug.

>RCU is tricky, so I am inclined to revert, but if there is
>a convincing patch addressing this, I might reconsider.

What about using GFP_ATOMIC when calling virtqueue_add_sgs() ?

We already used it in several drivers, including virtio-fs 
(fs/fuse/virtio_fs.c) where in virtio_fs_send_req() it does something 
similar of what we did in that commit.

I checked other places where we can sleep, and the only other one could 
be:

virtio_transport_deliver_tap_pkt()
   vsock_deliver_tap()
     virtio_transport_build_skb()
       alloc_skb()
       ^
       this is already called whit GFP_ATOMIC, and vsock_deliver_tap()
       also call it under another RCU section.

WDYT?

Thanks,
Stefano

