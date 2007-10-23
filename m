From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [git pull] lguest: paravirt boot code
Date: Tue, 23 Oct 2007 16:03:21 +1000
Message-ID: <200710231603.21620.rusty__3260.63637990064$1193119555$gmane$org@rustcorp.com.au>
References: <200710221237.14542.rusty@rustcorp.com.au>
	<alpine.LFD.0.999.0710221927131.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0710221927131.30120@woody.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lguest <lguest@ozlabs.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 23 October 2007 12:28:32 Linus Torvalds wrote:
> On Mon, 22 Oct 2007, Rusty Russell wrote:
> > 	First attempt at git, so please pull carefully.  I've just put the
> > three i386 boot changes in the repo for the moment.  If this works I'll
> > pile on the 44 lguest patches.
>
> Well, it looked ok, but I had already merged the same patches through
> Andrew, so when I pulled, I had no differences.

Well, with that out the way, and some scatterlist fixups, please pull from

	git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-lguest.git

This should be fairly clean: 45 lguest patches including the more generic
drivers (aimed to be used by KVM as well, and hopefully others) and the start
of separation of arch-specific from general lguest code.

 Documentation/lguest/Makefile         |   26 +-
 Documentation/lguest/lguest.c         | 1629 ++++++++++++++++++---------------
 Documentation/lguest/lguest.txt       |   72 +-
 arch/i386/Kconfig                     |   32 +-
 arch/i386/Makefile                    |    3 +
 arch/x86/kernel/asm-offsets_32.c      |    1 +
 arch/x86/lguest/Kconfig               |   14 +
 arch/x86/lguest/Makefile              |    1 +
 arch/x86/lguest/boot.c                | 1070 ++++++++++++++++++++++
 arch/x86/lguest/i386_head.S           |  115 +++
 arch/x86/xen/Kconfig                  |    5 +-
 drivers/Kconfig                       |    2 +-
 drivers/Makefile                      |    1 +
 drivers/block/Kconfig                 |    6 +
 drivers/block/Makefile                |    2 +-
 drivers/block/lguest_blk.c            |  421 ---------
 drivers/block/virtio_blk.c            |  308 +++++++
 drivers/char/Kconfig                  |    4 +
 drivers/char/Makefile                 |    2 +-
 drivers/char/hvc_lguest.c             |  177 ----
 drivers/char/virtio_console.c         |  225 +++++
 drivers/kvm/Kconfig                   |    4 +
 drivers/lguest/Kconfig                |   13 +-
 drivers/lguest/Makefile               |   10 +-
 drivers/lguest/core.c                 |  568 +-----------
 drivers/lguest/hypercalls.c           |  177 ++---
 drivers/lguest/interrupts_and_traps.c |  125 ++-
 drivers/lguest/io.c                   |  626 -------------
 drivers/lguest/lg.h                   |  189 ++---
 drivers/lguest/lguest.c               | 1108 ----------------------
 drivers/lguest/lguest_asm.S           |   93 --
 drivers/lguest/lguest_bus.c           |  218 -----
 drivers/lguest/lguest_device.c        |  373 ++++++++
 drivers/lguest/lguest_user.c          |  138 +---
 drivers/lguest/page_tables.c          |  250 +++---
 drivers/lguest/segments.c             |   28 +-
 drivers/lguest/switcher.S             |  350 -------
 drivers/lguest/x86/core.c             |  577 ++++++++++++
 drivers/lguest/x86/switcher_32.S      |  351 +++++++
 drivers/net/Kconfig                   |    6 +
 drivers/net/Makefile                  |    2 +-
 drivers/net/lguest_net.c              |  555 -----------
 drivers/net/virtio_net.c              |  435 +++++++++
 drivers/virtio/Kconfig                |    8 +
 drivers/virtio/Makefile               |    2 +
 drivers/virtio/config.c               |   13 +
 drivers/virtio/virtio.c               |  189 ++++
 drivers/virtio/virtio_ring.c          |  313 +++++++
 include/asm-x86/Kbuild                |    3 +
 include/asm-x86/bootparam.h           |  108 ++--
 include/asm-x86/e820.h                |   28 +
 Documentation/lguest/Makefile         |   26 +-
 Documentation/lguest/lguest.c         | 1629 ++++++++++++++++++---------------
 Documentation/lguest/lguest.txt       |   72 +-
 arch/i386/Kconfig                     |   32 +-
 arch/i386/Makefile                    |    3 +
 arch/x86/kernel/asm-offsets_32.c      |    1 +
 arch/x86/lguest/Kconfig               |   14 +
 arch/x86/lguest/Makefile              |    1 +
 arch/x86/lguest/boot.c                | 1070 ++++++++++++++++++++++
 arch/x86/lguest/i386_head.S           |  115 +++
 arch/x86/xen/Kconfig                  |    5 +-
 drivers/Kconfig                       |    2 +-
 drivers/Makefile                      |    1 +
 drivers/block/Kconfig                 |    6 +
 drivers/block/Makefile                |    2 +-
 drivers/block/lguest_blk.c            |  421 ---------
 drivers/block/virtio_blk.c            |  308 +++++++
 drivers/char/Kconfig                  |    4 +
 drivers/char/Makefile                 |    2 +-
 drivers/char/hvc_lguest.c             |  177 ----
 drivers/char/virtio_console.c         |  225 +++++
 drivers/kvm/Kconfig                   |    4 +
 drivers/lguest/Kconfig                |   13 +-
