From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] lguest: paravirt boot code
Date: Tue, 23 Oct 2007 09:10:21 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710230903330.30120__4918.51937626979$1193156097$gmane$org@woody.linux-foundation.org>
References: <200710221237.14542.rusty@rustcorp.com.au>
	<alpine.LFD.0.999.0710221927131.30120@woody.linux-foundation.org>
	<200710231603.21620.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710231603.21620.rusty@rustcorp.com.au>
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
Cc: lguest <lguest@ozlabs.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On Tue, 23 Oct 2007, Rusty Russell wrote:
>
> Well, with that out the way, and some scatterlist fixups, please pull from
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-lguest.git

Ok. However, please include a proper diffstat. And by proper, I mean:

	git diff -M --stat --summary

because right now your diffstat doesn't contain the final "total number of 
lines added/removed" (which is the easiest way for me to see that there 
isn't anything strange in there), and your diffstat doesn't do renames, so 
renames look like delete/create pairs. For example, you had:

>  arch/x86/lguest/boot.c                | 1070 ++++++++++++++++++++++
>  drivers/lguest/lguest.c               | 1108 ----------------------

but in reality it was not at all thousands of lines changed, but instead a 
rename with much smaller changes:

 drivers/lguest/lguest.c => arch/x86/lguest/boot.c  |  102 +-

which is a lot more readable and tells me much more about what is going 
on.

And at the end, I really do want to see the details like this:

	 70 files changed, 4822 insertions(+), 4401 deletions(-)
	 create mode 100644 arch/x86/lguest/Kconfig
	 create mode 100644 arch/x86/lguest/Makefile
	 rename drivers/lguest/lguest.c => arch/x86/lguest/boot.c (93%)
	 rename drivers/lguest/lguest_asm.S => arch/x86/lguest/i386_head.S (73%)
	 delete mode 100644 drivers/block/lguest_blk.c
	 create mode 100644 drivers/block/virtio_blk.c
	 delete mode 100644 drivers/char/hvc_lguest.c
	 create mode 100644 drivers/char/virtio_console.c
	 delete mode 100644 drivers/lguest/io.c
	 delete mode 100644 drivers/lguest/lguest_bus.c
	 create mode 100644 drivers/lguest/lguest_device.c
	 create mode 100644 drivers/lguest/x86/core.c
	 rename drivers/lguest/{switcher.S => x86/switcher_32.S} (99%)
	 delete mode 100644 drivers/net/lguest_net.c
	 create mode 100644 drivers/net/virtio_net.c
	 create mode 100644 drivers/virtio/Kconfig
	 create mode 100644 drivers/virtio/Makefile
	 create mode 100644 drivers/virtio/config.c
	 create mode 100644 drivers/virtio/virtio.c
	 create mode 100644 drivers/virtio/virtio_ring.c
	 create mode 100644 include/asm-x86/lguest.h
	 create mode 100644 include/asm-x86/lguest_hcall.h
	 delete mode 100644 include/linux/lguest_bus.h
	 create mode 100644 include/linux/virtio.h
	 create mode 100644 include/linux/virtio_blk.h
	 create mode 100644 include/linux/virtio_config.h
	 create mode 100644 include/linux/virtio_console.h
	 create mode 100644 include/linux/virtio_net.h
	 create mode 100644 include/linux/virtio_ring.h

which again gives a nice overview of what the heck is actually going on 
here. All of which you get for free if you use the above git command line.

Anyway, pulled. But just for future reference,

		Linus
