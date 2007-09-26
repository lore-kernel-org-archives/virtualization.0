From: rusty@rustcorp.com.au
Subject: [patch 00/43] lguest: Patches for 2.6.24 (and patchbomb test)
Date: Wed, 26 Sep 2007 16:36:18 +1000
Message-ID: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

	These are the patches I'm planning to submit for 2.6.24.  Comments
gratefully accepted.  Along with the usual cleanups and improvements are Jes'
de-i386-ification patches, and a new "virtio" mechanism designed to be shared
with KVM (and hopefully other hypervisors).

Cheers,
Rusty.

 Documentation/lguest/Makefile                    |   30 
 Documentation/lguest/lguest.c                    | 1745 ++++++++++++-----------
 Documentation/lguest/lguest.txt                  |   67 
 a/drivers/block/lguest_blk.c                     |  423 -----
 a/drivers/char/hvc_lguest.c                      |  177 --
 a/drivers/lguest/io.c                            |  628 --------
 a/drivers/lguest/lguest.c                        | 1101 --------------
 a/drivers/lguest/lguest_asm.S                    |   94 -
 a/drivers/lguest/lguest_bus.c                    |  220 --
 a/drivers/lguest/switcher.S                      |  351 ----
 a/drivers/net/lguest_net.c                       |  552 -------
 a/include/linux/lguest_bus.h                     |   51 
 arch/i386/Kconfig                                |   48 
 arch/i386/Makefile                               |    3 
 arch/i386/kernel/asm-offsets.c                   |    1 
 arch/i386/kernel/i8259.c                         |    3 
 arch/i386/kernel/io_apic.c                       |   13 
 arch/i386/kernel/traps.c                         |   10 
 arch/i386/lguest/Kconfig                         |    6 
 arch/i386/lguest/boot.c                          |   79 -
 arch/i386/lguest/head.S                          |   41 
 arch/i386/xen/Kconfig                            |    5 
 b/arch/i386/lguest/Kconfig                       |    8 
 b/arch/i386/lguest/Makefile                      |    1 
 b/arch/i386/lguest/boot.c                        | 1101 ++++++++++++++
 b/arch/i386/lguest/head.S                        |   93 +
 b/drivers/block/virtio_blk.c                     |  327 ++++
 b/drivers/char/virtio_console.c                  |  225 ++
 b/drivers/lguest/i386_core.c                     |  476 ++++++
 b/drivers/lguest/i386_switcher.S                 |  350 ++++
 b/drivers/lguest/lguest_device.c                 |  373 ++++
 b/drivers/net/virtio_net.c                       |  438 +++++
 b/drivers/virtio/Kconfig                         |    3 
 b/drivers/virtio/Makefile                        |    1 
 b/drivers/virtio/config.c                        |   13 
 b/drivers/virtio/virtio.c                        |  171 ++
 b/drivers/virtio/virtio_ring.c                   |  313 ++++
 b/include/asm-i386/lguest.h                      |   88 +
 b/include/linux/virtio.h                         |  110 +
 b/include/linux/virtio_blk.h                     |   52 
 b/include/linux/virtio_config.h                  |  112 +
 b/include/linux/virtio_console.h                 |   13 
 b/include/linux/virtio_net.h                     |   37 
 b/include/linux/virtio_ring.h                    |  120 +
 drivers/Kconfig                                  |    4 
 drivers/Makefile                                 |    1 
 drivers/block/Kconfig                            |    6 
 drivers/block/Makefile                           |    2 
 drivers/char/Kconfig                             |    8 
 drivers/char/Makefile                            |    2 
 drivers/char/hvc_console.c                       |   67 
 drivers/kvm/Kconfig                              |    7 
 drivers/lguest/Kconfig                           |   17 
 drivers/lguest/Makefile                          |   20 
 drivers/lguest/core.c                            |  588 -------
 drivers/lguest/hypercalls.c                      |  228 +--
 drivers/lguest/i386_core.c                       |  127 +
 drivers/lguest/i386_switcher.S                   |    6 
 drivers/lguest/interrupts_and_traps.c            |  131 +
 drivers/lguest/io.c                              |   28 
 drivers/lguest/lg.h                              |  198 --
 drivers/lguest/lguest.c                          |    1 
 drivers/lguest/lguest_asm.S                      |    7 
 drivers/lguest/lguest_bus.c                      |    3 
 drivers/lguest/lguest_user.c                     |  162 --
 drivers/lguest/page_tables.c                     |  288 ++-
 drivers/lguest/segments.c                        |   31 
 drivers/net/Kconfig                              |    6 
 drivers/net/Makefile                             |    3 
 drivers/net/lguest_net.c                         |    7 
 drivers/virtio/Kconfig                           |    5 
 drivers/virtio/Makefile                          |    1 
 drivers/virtio/virtio.c                          |   26 
 include/asm-i386/irq.h                           |    4 
 include/asm-i386/lguest.h                        |    4 
 include/asm-i386/lguest_hcall.h                  |   14 
 include/linux/Kbuild                             |    1 
 include/linux/lguest.h                           |   88 -
 include/linux/lguest_launcher.h                  |  134 -
 include/linux/mod_devicetable.h                  |    6 
 linux-2.6-lguest/include/asm-i386/lguest_hcall.h |   67 
 scripts/mod/file2alias.c                         |   19 
 82 files changed, 6455 insertions(+), 5935 deletions(-)
--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
