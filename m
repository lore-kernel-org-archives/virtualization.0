Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975766;
	b=Jy74BcGKanyLDqEPq44aogCAuhM2lKNdw59A1EqGogiuvkaXeb/o2/xuc7Eibt+8yKE7
	 GOFK16W7pysOTYjZtF8hih7O/ZfxdDpknLXEdfXgLQXMC4cBW437Nu1GGuN77mm0Xnuz8
	 0mIcUlHZzo3DEqulwFFJSM3PXm3KxFf2O7h869GqAwo/S0+Fe4WFJY27++S0WdtT3dqNH
	 26thBc1VJ4f6sH4VOHu4qeRw9RYanGxSwK+Ii2eJbcCNMqh62y64eFQu+FCR77+fk2JEp
	 jWnkaLGn4Jv6gB4I2CNpwgYNOELoz2RAjSVwIngdTEZOFnjF2ew0EGgvRiBjd1XMNNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975766;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UZBaqvXPYn8tsPq6ir45XhyHFYphF5yT8PXZDHmG2I8=;
	b=Jj+RnLeaI0HTz76CRccN1+KNx+VRMmWfT0NXmA6kzpsxXHBS0RVJvFf+2QinqLXg6V3X
	 vfMIVuXxXAGy0BdBE0ffQIwYvVVO6ldnRU8RRFTf7V7i2haTUtYdd1BRlTWdYQKtShWUy
	 4qsRCwUM43ZEtYf6EPs9idrB4yP3rQH14dseyACILLInsLymsLjWEOTG+Bktd4byIeRBN
	 hRcdAGhXhdOYkNuOjqwxryBAgDbnso4zLfqR97bDV1s2SemEjXiMg8RjqvCYMeiTWxYku
	 IY/CUzBfHt5lhkTBQfbkpaFFMzl/mXkVkVJG4+ECaA3BjK6s7FMtkq7t9ZRDatMq2ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=J1z4+EaZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74D606A326;
	Fri,  6 Nov 2026 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=J1z4+EaZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79121F0089F;
	Fri,  6 Nov 2026 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793975765;
	bh=UZBaqvXPYn8tsPq6ir45XhyHFYphF5yT8PXZDHmG2I8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J1z4+EaZDFsbx+ArXSCT0Os32UYwumgcR2YWYvuejXsp3MhXUuP9ctZZmUeYcERH9
	 eUHE/cvZsncIQ5sFF97yBYKVeetwePQJ190R0nQmUNaw91Y0ShsyOnYU3oUj4XgoDp
	 4IWhUV3VWz/f6GeG99lXcTNOr2P5fx2Dq0PnMdfk=
Date: Fri, 6 Nov 2026 09:36:03 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: amit@kernel.org, arnd@arndb.de, rusty@rustcorp.com.au,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] virtio_console: fix buffer ownership and unplug races
 in the read path
Message-ID: <2026110624-crowd-unveiling-34bc@gregkh>
References: <20261106091739.1334178-1-shunsheng1218@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106091739.1334178-1-shunsheng1218@gmail.com>

On Fri, Nov 06, 2026 at 05:17:39PM +0800, Yaohan Li wrote:
> The read path hands port buffers to readers without any ownership
> protocol.  Two threads sharing one file descriptor can both pick up
> port->inbuf, copy from it concurrently and requeue it twice, and an
> input virtqueue callback prefetching the next buffer can drop the
> remainder a reader is about to put back.  During port unplug a
> reader can also call add_inbuf() on a virtqueue that is being torn
> down (KASAN: slab-use-after-free in virtqueue_get_buf_ctx), or
> requeue a buffer nobody will free anymore.  The input virtqueue
> callback itself can run past find_port_by_vq() into port->portdev
> and the virtqueue after unplug_port() has cleared them.
> 
> Track buffer ownership explicitly:
> 
> - fill_readbuf() claims port->inbuf under inbuf_lock and owns it
>   exclusively across the unlocked copy.  port_read_snapshot() and
>   the input virtqueue callback do not prefetch another buffer while
>   a claim is held (nor once the port is being unplugged), so a
>   partially consumed buffer is always finished before the next one
>   and the byte order is preserved.
> 
> - The input state and the connection state are snapshotted together
>   under inbuf_lock as empty, readable (a buffer can be acquired),
>   claimed, or unplugged, together with guest_connected and
>   host_connected.  poll() reports EPOLLIN when a buffer is available,
>   or when the host has disconnected with no pending data so that a
>   reader can observe EOF; a claimed buffer is not reported as
>   immediately readable.  A claimed buffer is data pending for the EOF
>   and host-disconnect logic, so a peer reader sharing the file
>   descriptor does not observe EOF while another reader still owns
>   unread bytes and instead waits for the claim to be released.  A
>   nonblocking reader gets -EAGAIN (or 0 when the host has
>   disconnected and no data is left).  Because the unplug state and
>   the connection state are taken in the same critical section, a read
>   that observes PORT_INPUT_UNPLUGGED in its snapshot returns -ENODEV,
>   and poll() reports EPOLLHUP without a fake EPOLLIN.  A concurrent
>   read may complete according to an earlier snapshot instead of
>   observing the unplug immediately.  This
>   ordering guarantee is against unplug_port(); the normal
>   host_connected control-message update is not serialized by
>   inbuf_lock and is read with READ_ONCE(), as before.  The atomic
>   HVC poll simply retries.  will_read_block() uses the same snapshot
>   for its wait predicate.
> 
> - unplug_port() publishes an "unplugging" state under inbuf_lock
>   before any teardown.  After observing the unplugging state under
>   inbuf_lock, in_intr() drops its port reference and returns without
>   accessing portdev or the input virtqueue.  The separate HVC adapter
>   lifetime race after inbuf_lock is dropped is addressed by the
>   independently submitted hvc_kick change.  Readers stop touching the
>   input virtqueue from that point; a reader returning a claimed buffer
>   frees it instead of requeueing it.  A userspace read() that has not
>   copied any byte returns -ENODEV for an unplugged port, while the HVC
>   get_chars() path keeps returning 0.  In the fill_readbuf() release
>   branches of this change, the teardown, copy-fault and
>   failed-requeue paths defer free_buf() until inbuf_lock is dropped,
>   so a userspace read may sleep in free_buf() for DMA buffers.  Other
>   driver paths still free buffers under their own locks.  Nothing
>   reads the buffer after it is freed, and the claim is
>   always released with a wakeup, so readers waiting for the claim
>   are not stalled until the next packet.
> 
>   The deferred rproc DMA buffers are reclaimed in unplug_port() after
>   hvc_remove().  For the normal HVC polling path, the console entry is
>   removed from pdrvdata.consoles before hvc_remove(), so a get_chars()
>   that starts later cannot find this port; hvc_remove() also waits
>   (via hp->lock) for a get_chars() that already found it.  The
>   CONFIG_CONSOLE_POLL path is outside this normal teardown
>   synchronization and has not been runtime-tested.
> 
>   For device-wide removal, virtio_break_device(), the virtqueue
>   callback synchronization during reset, and cancellation of the
>   control/config work precede unplug_port(); remove_vqs() subsequently
>   frees remaining buffers in sleepable context.  For the virtio-pci
>   and virtio-mmio transports, the reset-time callback synchronization
>   is synchronize_irq() over the device vectors, and vring_interrupt()
>   checks vq->broken before invoking the driver callback, so a late
>   interrupt cannot invoke the callback after reset.  This does not
>   establish runtime coverage of single-port PORT_REMOVE, where the
>   device stays up and the remaining virtqueue callbacks are not
>   stopped by reset, nor of all remoteproc transport behavior.
> 
> - A zero-length read returns 0 before the unplug checks, preserving
>   the normal read(fd, buf, 0) semantics.
> 
> This issue was investigated and the fix was developed with AI
> assistance (ZCode/GLM-4).
> 
> Testing with QEMU and KASAN injection (lockdep and
> CONFIG_DEBUG_ATOMIC_SLEEP enabled in the test kernel):
> 
> - A shared-fd, two-reader test without unplug delivered all 20000
>   records exactly once, with no corruption or reordering.  The
>   unmodified kernel delivered 19979 of them more than once and only
>   48 could be attributed to any consistent stream order.
> - Stalling the input callback right after find_port_by_vq() while a
>   QMP device_del unplugs the port made the previous version
>   dereference the cleared portdev (KASAN null-ptr-deref in
>   in_intr()); this version returns through the unplug check and
>   reports nothing.
> - Stalling a userspace read() just before fill_readbuf() and
>   unplugging the port while it is parked: the previous version
>   returns 0 (treated as a normal host disconnect), this version
>   returns -ENODEV.
> - With one reader parked while holding a claim, poll() no longer
>   reports EPOLLIN and a nonblocking read from the second reader
>   returns -EAGAIN instead of a readable/EAGAIN mismatch.  With the
>   host disconnecting at the same point, the second reader gets
>   -EAGAIN rather than a premature EOF, and the following blocking
>   read receives the remainder the first reader puts back.
> - During concurrent unplug, readers received a valid contiguous
>   prefix before disconnect, with no duplicates or KASAN reports;
>   the same stall sequences produce six slab use-after-free reports
>   per run on the unmodified kernel.
> - A separate fault-injection run exercised 20 failed buffer
>   requeues, all going through the deferred free path, without a
>   reported use-after-free, lockdep splat or invalid-context sleep.
> - A nonblocking read with an empty input raced against unplug: the
>   previous version returned 0 (a false EOF) once unplug cleared
>   host_connected.  A read that observes the unplug state in its
>   input/connection snapshot returns -ENODEV; a concurrent read may
>   complete according to an earlier snapshot.  In this test the new
>   version returns -EAGAIN and the next read -ENODEV.
> - Polling while unplug_port() had published the unplugging state but
>   not yet cleared the connection state: the previous version reported
>   EPOLLIN | EPOLLRDNORM; this version reports EPOLLHUP only.
> - A normal host disconnect still returns 0.
> - Combined with the hvc_kick change for the HVC adapter lifetime,
>   the 20000-record integrity test, the callback/unplug injection
>   and a normal PORT_REMOVE run all complete without new KASAN,
>   lockdep, duplicate or reordered data.  The 20000-record, High and
>   -ENODEV tests were re-run on this version.
> 
> The test environment provides virtual virtio-console devices only.
> Real remoteproc DMA buffers were not available, so the rproc-serial
> DMA buffer path is covered by code inspection of the claim, deferred
> free and reclaim ordering, not by a runtime test.
> 
> Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off data from host to readers")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

This wall of text is insane and is not ok.  Please delete it all and
write it by hand, without using any LLM at all, to describe simply what
the problem is and why you are solving it this way.

thanks,

greg k-h
