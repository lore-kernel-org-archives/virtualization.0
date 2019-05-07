From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] vsock/virtio: Initialize core virtio vsock before
	registering the driver
Date: Tue, 7 May 2019 14:25:43 +0200
Message-ID: <20190507122543.kgh44rvaw7nwlhjn__41860.0567894586$1557231961$gmane$org@steredhat>
References: <20190501003001.186239-1-jemoreira@google.com>
	<20190501190831.GF22391@stefanha-x1.localdomain>
	<20190502082045.u3xypjbac5npbhtc@steredhat.homenet.telecomitalia.it>
	<CAJi--POaVsfprbp5na5BvR=VNONKGfFya_BnmTzzcWmOQ1DM2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJi--POaVsfprbp5na5BvR=VNONKGfFya_BnmTzzcWmOQ1DM2Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jorge Moreira Broche <jemoreira@google.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, kernel-team@android.com, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Hi Jorge,

On Mon, May 06, 2019 at 01:19:55PM -0700, Jorge Moreira Broche wrote:
> > On Wed, May 01, 2019 at 03:08:31PM -0400, Stefan Hajnoczi wrote:
> > > On Tue, Apr 30, 2019 at 05:30:01PM -0700, Jorge E. Moreira wrote:
> > > > Avoid a race in which static variables in net/vmw_vsock/af_vsock.c are
> > > > accessed (while handling interrupts) before they are initialized.
> > > >
> > > >
> > > > [    4.201410] BUG: unable to handle kernel paging request at ffffffffffffffe8
> > > > [    4.207829] IP: vsock_addr_equals_addr+0x3/0x20
> > > > [    4.211379] PGD 28210067 P4D 28210067 PUD 28212067 PMD 0
> > > > [    4.211379] Oops: 0000 [#1] PREEMPT SMP PTI
> > > > [    4.211379] Modules linked in:
> > > > [    4.211379] CPU: 1 PID: 30 Comm: kworker/1:1 Not tainted 4.14.106-419297-gd7e28cc1f241 #1
> > > > [    4.211379] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > > > [    4.211379] Workqueue: virtio_vsock virtio_transport_rx_work
> > > > [    4.211379] task: ffffa3273d175280 task.stack: ffffaea1800e8000
> > > > [    4.211379] RIP: 0010:vsock_addr_equals_addr+0x3/0x20
> > > > [    4.211379] RSP: 0000:ffffaea1800ebd28 EFLAGS: 00010286
> > > > [    4.211379] RAX: 0000000000000002 RBX: 0000000000000000 RCX: ffffffffb94e42f0
> > > > [    4.211379] RDX: 0000000000000400 RSI: ffffffffffffffe0 RDI: ffffaea1800ebdd0
> > > > [    4.211379] RBP: ffffaea1800ebd58 R08: 0000000000000001 R09: 0000000000000001
> > > > [    4.211379] R10: 0000000000000000 R11: ffffffffb89d5d60 R12: ffffaea1800ebdd0
> > > > [    4.211379] R13: 00000000828cbfbf R14: 0000000000000000 R15: ffffaea1800ebdc0
> > > > [    4.211379] FS:  0000000000000000(0000) GS:ffffa3273fd00000(0000) knlGS:0000000000000000
> > > > [    4.211379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [    4.211379] CR2: ffffffffffffffe8 CR3: 000000002820e001 CR4: 00000000001606e0
> > > > [    4.211379] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > [    4.211379] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > [    4.211379] Call Trace:
> > > > [    4.211379]  ? vsock_find_connected_socket+0x6c/0xe0
> > > > [    4.211379]  virtio_transport_recv_pkt+0x15f/0x740
> > > > [    4.211379]  ? detach_buf+0x1b5/0x210
> > > > [    4.211379]  virtio_transport_rx_work+0xb7/0x140
> > > > [    4.211379]  process_one_work+0x1ef/0x480
> > > > [    4.211379]  worker_thread+0x312/0x460
> > > > [    4.211379]  kthread+0x132/0x140
> > > > [    4.211379]  ? process_one_work+0x480/0x480
> > > > [    4.211379]  ? kthread_destroy_worker+0xd0/0xd0
> > > > [    4.211379]  ret_from_fork+0x35/0x40
> > > > [    4.211379] Code: c7 47 08 00 00 00 00 66 c7 07 28 00 c7 47 08 ff ff ff ff c7 47 04 ff ff ff ff c3 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 8b 47 08 <3b> 46 08 75 0a 8b 47 04 3b 46 04 0f 94 c0 c3 31 c0 c3 90 66 2e
> > > > [    4.211379] RIP: vsock_addr_equals_addr+0x3/0x20 RSP: ffffaea1800ebd28
> > > > [    4.211379] CR2: ffffffffffffffe8
> > > > [    4.211379] ---[ end trace f31cc4a2e6df3689 ]---
> > > > [    4.211379] Kernel panic - not syncing: Fatal exception in interrupt
> > > > [    4.211379] Kernel Offset: 0x37000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > > > [    4.211379] Rebooting in 5 seconds..
> > > >
> > > > Fixes: 22b5c0b63f32 ("vsock/virtio: fix kernel panic after device hot-unplug")
> > > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Cc: "David S. Miller" <davem@davemloft.net>
> > > > Cc: kvm@vger.kernel.org
> > > > Cc: virtualization@lists.linux-foundation.org
> > > > Cc: netdev@vger.kernel.org
> > > > Cc: kernel-team@android.com
> > > > Cc: stable@vger.kernel.org [4.9+]
> > > > Signed-off-by: Jorge E. Moreira <jemoreira@google.com>
> > > > ---
> > > >  net/vmw_vsock/virtio_transport.c | 13 ++++++-------
> > > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > > > index 15eb5d3d4750..96ab344f17bb 100644
> > > > --- a/net/vmw_vsock/virtio_transport.c
> > > > +++ b/net/vmw_vsock/virtio_transport.c
> > > > @@ -702,28 +702,27 @@ static int __init virtio_vsock_init(void)
> > > >     if (!virtio_vsock_workqueue)
> > > >             return -ENOMEM;
> > > >
> > > > -   ret = register_virtio_driver(&virtio_vsock_driver);
> > > > +   ret = vsock_core_init(&virtio_transport.transport);
> > >
> > > Have you checked that all transport callbacks are safe even if another
> > > CPU calls them while virtio_vsock_probe() is executing on another CPU?
> > >
> >
> > I have the same doubt.
> >
> > What do you think to take the 'the_virtio_vsock_mutex' in the
> > virtio_vsock_init(), keeping the previous order?
> >
> > This should prevent this issue because the virtio_vsock_probe() remains
> > blocked in the mutex until the end of vsock_core_init().
> >
> > Cheers,
> > Stefano
> 
> Hi Stefan, Stefano,
> Sorry for the late reply.

Don't worry :)

> 
> @Stefan
> The order of vsock_core_exit() does not need to be changed to fix the
> bug I found, but not changing it means the exit function is not
> symmetric to the init function.
> 
> @Stefano
> Taking the mutex from virtio_vsock_init() could work too (I haven't
> tried it yet), but it's unnecessary, all that needs to be done is
> properly initialize vsock_core before attempting to use it.
> 
> I would prefer to change the order in virtio_vsock_init, while leaving
> virtio_vsock_exit unchanged, but I'll leave the final decision to you
> since I am not very familiar with the inner workings of these modules.

In order to fix your issue, IMO changing the order in virtio_vsock_init(),
is enough.

I think also that is correct to change the order in the virtio_vsock_exit(),
otherwise, we should have the same issue if an interrupt comes while we
are removing the module.
This should not lead to the problem that I tried to solve in 22b5c0b63f32,
because the vsock_core_exit() should not be called if there are open sockets,
since the virtio-vsock driver become the owner of AF_VSOCK protocol
family.

Not related to this patch, maybe there are some issues in the
virtio_vsock_probe(). I'd check better if it is correct to set
'the_virtio_vsock' before the end of the initialization (e.g. spinlocks
are initialized later).

Accordingly,

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
