From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/1] virtio: console: regression in virtqueue_add_buf()
	change
Date: Mon, 10 Dec 2012 10:06:12 +1030
Message-ID: <87lid6er2r.fsf@rustcorp.com.au>
References: <cover.1354859479.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1354859479.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Amit Shah <amit.shah@redhat.com> writes:

> Hi Rusty,
>
> The linux-next kernel was failing my virtio-console test suite for a
> while.  I looked into it today, and it's due to the
> virtqueue_add_buf() change that doesn't return > 0 values anymore.  I
> found your commit that adjusts virtio_console.c, but you missed one
> instance where the return value mattered, and as a result not enough
> buffers were queued for the host to send in data.
>
> This resulted in the port's name to be not populated in sysfs, which
> meant udev didn't create any symlinks in /dev/virtio-ports/.
>
> I've just updated your commit with the small diff (attached below).
> Please put this commit after 
>
> commit e794093a52cdfef09b3fdb6294b75ab8cacb30a8
> Author: Rusty Russell <rusty@rustcorp.com.au>
> Date:   Tue Oct 16 23:56:14 2012 +1030
>
>     virtio_net: don't rely on virtqueue_add_buf() returning capacity.
>     
> and before
>
> commit 08d088e8357b3c031db7de006247f613c7f136ab
> Author: Rusty Russell <rusty@rustcorp.com.au>
> Date:   Tue Oct 16 23:56:15 2012 +1030
>
>     virtio: make virtqueue_add_buf() returning 0 on success, not capacity.
>     
> in the pull request you send so that there's no regression in
> virtio_console on bisection.
>
> (commit ids from linux-next/master).

I will append it for now, then fold it before pushing to Linus.  I try
not to rebase linux-next until just before the push.

Thanks,
Rusty.
