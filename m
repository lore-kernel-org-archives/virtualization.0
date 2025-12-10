Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39812882A8;
	Wed, 10 Dec 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765382326; cv=none; b=mSN7VAzL06QIbzAqDsEPX06uRiAfSbtEJ/moYi9xZRajGM5TFabCTA7QoatdrDgpTMRKPctNhYcOQMUWxkGrk3Jm2tX46ArNPe7tUZfA4RIKUGmBNdoH9nIVa9MQoR0Kw+mYYtBOrc0vHAPKzGurWx64rUCwk4NE3XIxLjZ7UpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765382326; c=relaxed/simple;
	bh=qvjwYOSej14LmnAXuJAPw6t4oA5ObOE8CaNcBS1erKs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tt0eg/Llzg3X65iXIni+pf8mp+RHAvpF2N/wMLaiq/ZGylTiz7UUS8j/WLoHz2Jl51ALjvMhtcMkLbaV4q885IlK4ev7940tnZ8SYbd1PhSAJtw6Bjzov9eIrPV2oKKEzgz1K93/087b2k6YYZSyVYB1TgutKTEITm0HQXmeeAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht/zMm4x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht/zMm4x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C989C4CEF1;
	Wed, 10 Dec 2025 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765382325;
	bh=qvjwYOSej14LmnAXuJAPw6t4oA5ObOE8CaNcBS1erKs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Ht/zMm4xWtwcIugK0fz35DG2FNcgIhqpjXK23YKu3nd9wsRb88GBHMZ3+jkBXAhd5
	 edaE7JRVypbpgTON2IPQaHuEo5OMAwFnAylH1qrTX/17Colr/3aeA29L3iF/BRZAcz
	 sOonnrSlYzPBd7W9S5hZdw7GOhcGFWDrm2fe+pQbjGOraJWB2AZ1Ak99QyinhaxBH6
	 nHxKAxTP94b5UjR9Q2c8dk52MzYNSUynJiVhTOo0mZDNzFUCyiuD9xmaNpxm5ju+87
	 RD//VNhMUGwyDPjQ7ekYHavTczy9JfkvvNnZsbaQA7S7MYZ2T2bvKzo9cCDJIVIGXX
	 fT+3/7O/nVcuA==
Message-ID: <564165392dfefdbb6e1739102ed80c3aee92881b.camel@kernel.org>
Subject: Re: virtio_console: lost wakeup due to race between
 port_fops_poll() and vring_interrupt()
From: Amit Shah <amit@kernel.org>
To: Lorenz Bauer <lmb@isovalent.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>
Date: Wed, 10 Dec 2025 16:58:42 +0100
In-Reply-To: <CAN+4W8hLrR1B1pNdDXiVuzoJ1q8Ta1kjV0v8vKVEZeHdRFKGcg@mail.gmail.com>
References: 
	<CAN+4W8hLrR1B1pNdDXiVuzoJ1q8Ta1kjV0v8vKVEZeHdRFKGcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2025-12-05 at 18:06 +0000, Lorenz Bauer wrote:
> Hi,
>=20
> I've been chasing a bug when using virtio console to exchange data
> between guest and host. It manifests in a process inside the guest
> getting stuck while writing to the serial port:
>=20
> =C2=A0=C2=A0=C2=A0 [<0>] wait_port_writable+0x139/0x2d0
> =C2=A0=C2=A0=C2=A0 [<0>] port_fops_write+0x88/0x130
> =C2=A0=C2=A0=C2=A0 [<0>] vfs_write+0xf3/0x450
> =C2=A0=C2=A0=C2=A0 [<0>] ksys_write+0x6d/0xe0
> =C2=A0=C2=A0=C2=A0 [<0>] do_syscall_64+0x9e/0x1a0
> =C2=A0=C2=A0=C2=A0 [<0>] entry_SYSCALL_64_after_hwframe+0x77/0x7
>=20
> I managed to track this down to a race in virtio_console.c. The
> driver
> doesn't properly account for a port that receives blocking writes and
> is polled at the same time. I suspect that a similar problem exists
> in
> port_fops_read().
>=20
> Here is how it goes. We need two threads inside the guest, A and B.
>=20
> - Thread A writes to the serial port until the virtqueue fills up.
> - Thread A invokes port_fops_write() which calls
> wait_port_writable().
> There are no used buffers to reclaim and the thread is suspended,
> waiting on port->waitqueue.
> - The host side of the device makes some progress, marks some buffers
> as consumed / used and=C2=A0 sends an interrupt to the guest.
> - Before the guest can service the interrupt, thread B executes
> port_fops_poll(). This calls into
> =C2=A0 reclaim_consumed_buffers() via will_write_block(), which removes
> all
> used buffers.
> - The interrupt gets serviced, calling into vring_interrupt(). Here
> the check for more_used() returns false because the poll just went
> through all the work. The handler returns without waking
> port->waitqueue.
> - port_fops_write() never returns.

Both port_fops_write() and port_fops_poll() call will_write_block() for
checking the block condition -- which is whether port->outvq_full is
set.  Even if buffers were consumed via poll, outvq_full should just
return false, right?

Hm, does adding wake_up(port->waitqueue) in case 'ret' is false in
will_write_block() help?

> I'm not exactly sure how to best fix this. Maybe it's enough to only
> check outvq_full in poll? It'd also be nice to fix this on the read
> side as well.
>=20
> I only have a reproducer which requires a Go toolchain unfortunately:
> https://github.com/lmb/vimto/issues/29
>=20
> Best
> Lorenz

		Amit
