From: Balaji Rao <balajirrao@gmail.com>
Subject: Re: kernel BUG at drivers/virtio/virtio_ring.c:218!
Date: Sun, 6 Apr 2008 13:43:37 +0530
Message-ID: <200804061343.37624.balajirrao__41437.8715133809$1207470184$gmane$org@gmail.com>
References: <200804041346.21618.balajirrao@gmail.com>
	<200804051923.39933.balajirrao@gmail.com>
	<200804061726.33918.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804061726.33918.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 06 April 2008 12:56:33 pm Rusty Russell wrote:
> On Sunday 06 April 2008 00:53:39 Balaji Rao wrote:
> > On Friday 04 April 2008 01:46:21 pm Balaji Rao wrote:
> > > Hi Rusty,
> > >
> > > I hit a bug in virtio_ring.c:218 when I was stressing virtio_net using
> > > kvm with -smp 4.
> > >
> > > static void vring_disable_cb(struct virtqueue *_vq)
> > > {
> > >         struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > >         START_USE(vq);
> > > -->        BUG_ON(vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT);
> > >         vq->vring.avail->flags |= VRING_AVAIL_F_NO_INTERRUPT;
> > >         END_USE(vq);
> > > }
> > >
> > > Going through the source code, I felt that this BUG_ON is not required as
> > > any CPU could race and call disable_cb when one cpu still believes that
> > > its enabled. To validate my understanding, I commented out the BUG_ON and
> > > everything worked perfectly well.
> > >
> > > I also get a lot of "Unlikely: restart svq race" on my console. Under
> > > high load conditions, a race could occur very often and I'm not sure if
> > > that signals a buggy situation. We could printk_ratelimit if at all we
> > > need to retain it.
> > >
> > > If you agree, I'll send a patch to this.
> >
> > Christian Borntraeger CCed.
> 
> Hi Balaji,
> 
> Interesting case.... can you put a '#define DEBUG' at the top of 
> drivers/virtio/virtio_ring.c and re-run?
> 
> The reason we don't simply remove that check is that interrupt bugs are nasty 
> to track down, usually leading to performance problems rather than outright 
> breakage.
> 
Hi Rusty,

Here's the output with #define DEBUG. As soon as I start netperf on the remote machine, the guest panics.

sh-3.2# [   40.053295] Unlikely: restart svq race
[   39.999687] Unlikely: restart svq race
[   40.000687] ------------[ cut here ]------------
[   40.001885] kernel BUG at drivers/virtio/virtio_ring.c:219!
[   40.003401] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
[   40.003670] Modules linked in:
[   40.003670] 
[   40.003670] Pid: 1553, comm: netserver Not tainted (2.6.25-rc7 #19)
[   40.003670] EIP: 0060:[<c03a4c22>] EFLAGS: 00010202 CPU: 3
[   40.003670] EIP is at vring_disable_cb+0x2c/0x4e
[   40.003670] EAX: f7570430 EBX: c0616a64 ECX: f74e8800 EDX: 00000001
[   40.003670] ESI: f6c45000 EDI: f75d8c80 EBP: f6c879e0 ESP: f6c879e0
[   40.003670]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[   40.003670] Process netserver (pid: 1553, ti=f6c86000 task=f6cf0000 task.ti=f6c86000)
[   40.003670] Stack: f6c87b94 c0319cde c059fe55 f75d8840 00000002 c16da8a2 00000020 0000000a 
[   40.003670]        00000000 00000000 c16fb8a2 00000b8e 00000042 00000000 00000000 00000000 
[   40.003670]        00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
[   40.003670] Call Trace:
[   40.003670]  [<c0319cde>] ? start_xmit+0x1c6/0x209
[   40.003670]  [<c0434104>] ? ipt_route_hook+0x18/0x1d
[   40.003670]  [<c03e8a7f>] ? dev_hard_start_xmit+0x204/0x272
[   40.003670]  [<c04086b2>] ? ip_finish_output+0x0/0x201
[   40.003670]  [<c03f77cb>] ? __qdisc_run+0x78/0x15a
[   40.003670]  [<c03ead5f>] ? dev_queue_xmit+0x17e/0x28b
[   40.003670]  [<c040887b>] ? ip_finish_output+0x1c9/0x201
[   40.003670]  [<c0408b50>] ? ip_output+0x7e/0x83
[   40.003670]  [<c04083eb>] ? ip_local_out+0x18/0x1b
[   40.003670]  [<c0408e5d>] ? ip_queue_xmit+0x278/0x2b9
[   40.003670]  [<c01729d6>] ? check_object+0x139/0x18f
[   40.003670]  [<c017351b>] ? __slab_alloc+0x3d7/0x467
[   40.003670]  [<c041af67>] ? tcp_v4_send_check+0x7d/0xb7
[   40.003670]  [<c0416d9d>] ? tcp_transmit_skb+0x618/0x64b
[   40.003670]  [<c01741ed>] ? __kmalloc_track_caller+0x7d/0xcb
[   40.003670]  [<c0416e69>] ? tcp_send_ack+0x25/0xb6
[   40.003670]  [<c03e43db>] ? __alloc_skb+0x4f/0xfd
[   40.003670]  [<c0416ef2>] ? tcp_send_ack+0xae/0xb6
[   40.003670]  [<c0414a11>] ? __tcp_ack_snd_check+0x5e/0x73
[   40.003670]  [<c0415f1b>] ? tcp_rcv_established+0x5f1/0x652
[   40.003670]  [<c0478e85>] ? _spin_lock_bh+0xb/0x22
[   40.003670]  [<c041a973>] ? tcp_v4_do_rcv+0x28/0x18d
[   40.003670]  [<c040d2b6>] ? tcp_prequeue_process+0x52/0x66
[   40.003670]  [<c040f236>] ? tcp_recvmsg+0x32a/0x6af
[   40.003670]  [<c03e0667>] ? sock_common_recvmsg+0x31/0x4a
[   40.003670]  [<c03df11d>] ? sock_recvmsg+0xe9/0x105
[   40.003670]  [<c01181c0>] ? kvm_mmu_write+0x2f/0x31
[   40.003670]  [<c01370d6>] ? autoremove_wake_function+0x0/0x33
[   40.003670]  [<c011833d>] ? kvm_set_pte_at+0x43/0x4b
[   40.003670]  [<c015481f>] ? unlock_page+0x25/0x28
[   40.003670]  [<c015fe85>] ? __do_fault+0x3fa/0x436
[   40.003670]  [<c0478e20>] ? _spin_unlock_bh+0xd/0xf
[   40.003670]  [<c03dfe09>] ? sys_recvfrom+0x7b/0xbd
[   40.003670]  [<c01393f2>] ? hrtimer_forward+0xd7/0xed
[   40.003670]  [<c0123848>] ? scheduler_tick+0x1ac/0x26d
[   40.003670]  [<c013b414>] ? getnstimeofday+0x2f/0xb4
[   40.003670]  [<c03dfe63>] ? sys_recv+0x18/0x1a
[   40.003670]  [<c03e01d1>] ? sys_socketcall+0x10a/0x186
[   40.003670]  [<c012b547>] ? irq_exit+0x53/0x6b
[   40.003670]  [<c0107b1e>] ? syscall_call+0x7/0xb
[   40.003670]  [<c0470000>] ? serial8250_remove+0x31/0x35
[   40.003670]  =======================
[   40.003670] Code: 8b 50 38 89 e5 85 d2 74 0b 52 68 95 fc 5b c0 e8 10 23 d8 ff c7 40 38 da 00 00 00 0f ae f0 66 90 8b 48 
18 66 8b 11 f6 c2 01 74 04 <0f> 0b eb fe 83 ca 01 66 89 11 83 78 38 00 75 04 0f 0b eb fe c7 
[   40.003670] EIP: [<c03a4c22>] vring_disable_cb+0x2c/0x4e SS:ESP 0068:f6c879e0
[   40.003683] Kernel panic - not syncing: Fatal exception in interrupt

I was able to reproduce with -smp 1 also.

BTW, I think the performance has also reduced from the previous version.It has reduced from ~900 Mbps to ~330 Mbps. 

Setup :
I have two machines. I run netserver from within the guest running on machine 1. From machine 2 which is connected to 
machine 1 via a gigabit ethernet, I run netperf with the default arguments.

-- 
regards,
Balaji Rao
Dept. of Mechanical Engineering,
National Institute of Technology Karnataka, India
