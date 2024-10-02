Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB9A84A52
	for <virtualization@lists.linux.dev>; Wed,  2 Oct 2024 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861692; cv=none; b=oHWLraQq6SsshPaAvibfKGIKxtZhF88JOzMZWH19/BM5OWm3iNj8CUV0fBOvhjvRQ0GfyxwTqD+grwpw3g9TbEinI5yT+v9/Lrz2Yv433EwMJt419RRtO6kdbXGxyNsBbUhUqv9RiAhrE72v0vihRJV2D21GWgoW9wmceNWgDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861692; c=relaxed/simple;
	bh=z42AILfW3lehWIERFSZCKAKcexDwgy8lAcrbjprBCMk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QCxn9R6AWX7MaKdmxQRA0uMQO3JFEOxKOiJU6iBZSnx7y9RapeNEDIRp8HyhmG+lDXkDra2zufwC/mXp+ttaFgPDdENjNUmsP1xLND+Kqb8cm5DhWiaAfaQ+U+DpX/JuiJcQYBv5CL+crlcTqIXSIelMsT4NPDXJJ70KziMeQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVMBpDkr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVMBpDkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B3FC4CEC5;
	Wed,  2 Oct 2024 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727861691;
	bh=z42AILfW3lehWIERFSZCKAKcexDwgy8lAcrbjprBCMk=;
	h=Date:From:To:Cc:Subject:From;
	b=JVMBpDkr4+zXWEUK5NPkBN1JAzoOrumWWooMxyAwVLTlXZTPjEQ5jzD9lIB93kRPs
	 w4ljtOcBibEOma+zG8hd2A8p82DU01K/y2a9L+jcxWYDhqZ5w/3b2GoH+VzyRvktQt
	 dczOLINEvepG/CE84R86LpU+8GZ22daDCMhZASuyBO+svhGZji1cbGHATzCvLbgi5U
	 NchrI80zig02VaZ181P8Pfd4XtvoaK2Bc/IqZSB/pOdgS5jTxd5HmLMF0Xl2OUJl25
	 HCp7C2LJ+AunqiLpgge+nTysHSa3N4vCiBCxtatuPYsytMSbFk4TOV2SJgfwC6O3sL
	 2l1egyAGeFNQw==
Date: Wed, 2 Oct 2024 11:34:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
Subject: Splat with v6.12-rc1
Message-ID: <hfcr2aget2zojmqpr4uhlzvnep4vgskblx5b6xf2ddosbsrke7@nt34bxgp7j2x>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hey,

I'm seeing the following splat on v6.12-rc1 in case this hasn't been
reported yet:

[   33.662603] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:330
[   33.667624] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 772, name: incus-agent
[   33.671430] preempt_count: 0, expected: 0
[   33.674664] RCU nest depth: 1, expected: 0
[   33.676600] 3 locks held by incus-agent/772:
[   33.678184]  #0: ffff8881d1b38258 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connectible_sendmsg+0x142/0x11c0 [vsock]
[   33.681712]  #1: ffffffff9b6f3420 (rcu_read_lock){....}-{1:2}, at: virtio_transport_send_pkt+0x7c/0x520 [vmw_vsock_virtio_transport]
[   33.685627]  #2: ffff88818ca2d160 (&vsock->tx_lock){+.+.}-{3:3}, at: virtio_transport_send_pkt+0x43a/0x520 [vmw_vsock_virtio_transport]
[   33.688906] CPU: 23 UID: 0 PID: 772 Comm: incus-agent Not tainted 6.12.0-rc1-g9852d85ec9d4 #23
[   33.690849] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/Incus, BIOS unknown 2/2/2022
[   33.692746] Call Trace:
[   33.693337]  <TASK>
[   33.693846]  dump_stack_lvl+0x6f/0xa0
[   33.694740]  __might_resched.cold+0x1ed/0x253
[   33.696031]  ? perf_trace_sched_switch+0x6f0/0x6f0
[   33.697143]  ? virtqueue_add_split+0x9b2/0x1f50
[   33.698120]  __kmalloc_noprof+0x313/0x440
[   33.698942]  ? __lock_acquire+0xcf6/0x4790
[   33.699861]  virtqueue_add_split+0x9b2/0x1f50
[   33.700864]  ? find_held_lock+0x2d/0x110
[   33.701691]  ? reacquire_held_locks+0x4d0/0x4d0
[   33.702646]  ? virtqueue_kick+0xe0/0xe0
[   33.703462]  ? __virt_addr_valid+0x155/0x440
[   33.709313]  ? lock_acquire+0x31/0xc0
[   33.710078]  ? __virt_addr_valid+0x155/0x440
[   33.710981]  virtqueue_add_sgs+0x10c/0x140
[   33.711891]  virtio_transport_send_skb+0x102/0x560 [vmw_vsock_virtio_transport]
[   33.713480]  virtio_transport_send_pkt+0x450/0x520 [vmw_vsock_virtio_transport]
[   33.713499]  virtio_transport_send_pkt_info+0x64f/0x1050 [vmw_vsock_virtio_transport_common]
[   33.713525]  virtio_transport_stream_enqueue+0xaa/0xe0 [vmw_vsock_virtio_transport_common]
[   33.713534]  ? virtio_transport_shutdown+0xf0/0xf0 [vmw_vsock_virtio_transport_common]
[   33.713548]  ? _raw_spin_unlock_irqrestore+0x53/0x80
[   33.724011]  ? lockdep_hardirqs_on+0x78/0x100
[   33.724948]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[   33.726954]  vsock_connectible_sendmsg+0xc9d/0x11c0 [vsock]
[   33.728983]  ? vsock_ioctl+0x240/0x240 [vsock]
[   33.730554]  ? __init_waitqueue_head+0x150/0x150
[   33.732409]  ? __lock_acquire+0xcf6/0x4790
[   33.733833]  ? vsock_ioctl+0x240/0x240 [vsock]
[   33.734976]  __sock_sendmsg+0xc1/0x150
[   33.736048]  sock_write_iter+0x21e/0x380
[   33.737055]  ? __sock_sendmsg+0x150/0x150
[   33.738179]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[   33.742393]  ? security_file_permission+0x24/0x70
[   33.742437]  ? rw_verify_area+0x70/0x5e0
[   33.746265]  vfs_write+0xa4e/0xe40
[   33.746291]  ? reacquire_held_locks+0x4d0/0x4d0
[   33.746303]  ? trace_lock_acquire+0x141/0x1c0
[   33.746317]  ? kernel_write+0x630/0x630
[   33.746342]  ? __fget_files+0x30/0x350
[   33.757003]  ksys_write+0x178/0x1d0
[   33.757027]  ? __x64_sys_read+0xb0/0xb0
[   33.757044]  ? syscall_trace_enter+0x118/0x1e0
[   33.757091]  do_syscall_64+0x74/0x190
[   33.763371]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   33.763390] RIP: 0033:0x40720e
[   33.763411] Code: 48 83 ec 38 e8 13 00 00 00 48 83 c4 38 5d c3 cc cc cc cc cc cc cc cc cc cc cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
[   33.763418] RSP: 002b:000000c00021f508 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[   33.763441] RAX: ffffffffffffffda RBX: 000000000000000f RCX: 000000000040720e
[   33.763446] RDX: 00000000000003b5 RSI: 000000c00014e000 RDI: 000000000000000f
[   33.763451] RBP: 000000c00021f548 R08: 0000000000000000 R09: 0000000000000000
[   33.763455] R10: 0000000000000000 R11: 0000000000000202 R12: 000000c00021f688
[   33.763460] R13: 0000000924924924 R14: 000000c0001d0820 R15: 0000000000000011
[   33.763566]  </TASK>
