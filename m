From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v2] vsock: Fix a lockdep warning in __vsock_release()
Date: Mon, 30 Sep 2019 15:51:25 +0200
Message-ID: <20190930135125.prztj336splp74wq__6035.7451484137$1569851527$gmane$org@steredhat>
References: <1569460241-57800-1-git-send-email-decui@microsoft.com>
	<20190926074749.sltehhkcgfduu7n2@steredhat.homenet.telecomitalia.it>
	<PU1P153MB01698C46C9348B9762D5E122BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB01698C46C9348B9762D5E122BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ytht.net@gmail.com" <ytht.net@gmail.com>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "jhansen@vmware.com" <jhansen@vmware.com>, Michael Kelley <mikelley@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 27, 2019 at 05:37:20AM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Stefano Garzarella
> > Sent: Thursday, September 26, 2019 12:48 AM
> > 
> > Hi Dexuan,
> > 
> > On Thu, Sep 26, 2019 at 01:11:27AM +0000, Dexuan Cui wrote:
> > > ...
> > > NOTE: I only tested the code on Hyper-V. I can not test the code for
> > > virtio socket, as I don't have a KVM host. :-( Sorry.
> > >
> > > @Stefan, @Stefano: please review & test the patch for virtio socket,
> > > and let me know if the patch breaks anything. Thanks!
> > 
> > Comment below, I'll test it ASAP!
> 
> Stefano, Thank you!
> 
> BTW, this is how I tested the patch:
> 1. write a socket server program in the guest. The program calls listen()
> and then calls sleep(10000 seconds). Note: accept() is not called.
> 
> 2. create some connections to the server program in the guest.
> 
> 3. kill the server program by Ctrl+C, and "dmesg" will show the scary
> call-trace, if the kernel is built with 
> 	CONFIG_LOCKDEP=y
> 	CONFIG_LOCKDEP_SUPPORT=y
> 
> 4. Apply the patch, do the same test and we should no longer see the call-trace.
> 

Hi Dexuan,
I tested on virtio socket and it works as expected!

With your patch applied I don't have issues and call-trace. Without
the patch I have a very similar call-trace (as expected):
    ============================================
    WARNING: possible recursive locking detected
    5.3.0-vsock #17 Not tainted
    --------------------------------------------
    python3/872 is trying to acquire lock:
    ffff88802b650110 (sk_lock-AF_VSOCK){+.+.}, at: virtio_transport_release+0x34/0x330 [vmw_vsock_virtio_transport_common]

    but task is already holding lock:
    ffff88803597ce10 (sk_lock-AF_VSOCK){+.+.}, at: __vsock_release+0x3f/0x130 [vsock]

    other info that might help us debug this:
     Possible unsafe locking scenario:

           CPU0
           ----
      lock(sk_lock-AF_VSOCK);
      lock(sk_lock-AF_VSOCK);

     *** DEADLOCK ***

     May be due to missing lock nesting notation

    2 locks held by python3/872:
     #0: ffff88802c957180 (&sb->s_type->i_mutex_key#8){+.+.}, at: __sock_release+0x2d/0xb0
     #1: ffff88803597ce10 (sk_lock-AF_VSOCK){+.+.}, at: __vsock_release+0x3f/0x130 [vsock]

    stack backtrace:
    CPU: 0 PID: 872 Comm: python3 Not tainted 5.3.0-vsock #17
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
    Call Trace:
     dump_stack+0x85/0xc0
     __lock_acquire.cold+0xad/0x22b
     lock_acquire+0xc4/0x1a0
     ? virtio_transport_release+0x34/0x330 [vmw_vsock_virtio_transport_common]
     lock_sock_nested+0x5d/0x80
     ? virtio_transport_release+0x34/0x330 [vmw_vsock_virtio_transport_common]
     virtio_transport_release+0x34/0x330 [vmw_vsock_virtio_transport_common]
     ? mark_held_locks+0x49/0x70
     ? _raw_spin_unlock_irqrestore+0x44/0x60
     __vsock_release+0x2d/0x130 [vsock]
     __vsock_release+0xb9/0x130 [vsock]
     vsock_release+0x12/0x30 [vsock]
     __sock_release+0x3d/0xb0
     sock_close+0x14/0x20
     __fput+0xc1/0x250
     task_work_run+0x93/0xb0
     exit_to_usermode_loop+0xd3/0xe0
     syscall_return_slowpath+0x205/0x310
     entry_SYSCALL_64_after_hwframe+0x49/0xbe


Feel free to add:

Tested-by: Stefano Garzarella <sgarzare@redhat.com>
