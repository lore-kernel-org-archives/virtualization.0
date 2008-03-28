From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio_pci rmmod fix and lguest documentation/comment updates
Date: Fri, 28 Mar 2008 11:16:10 +1100
Message-ID: <200803281116.10314.rusty__1189.43838538161$1206663640$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: lguest <lguest@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 3085354de635179d70c240e6d942bcbd1d93056c:
  Ingo Molnar (1):
        x86: prefetch fix #2

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Anthony Liguori (1):
      virtio_pci: unregister virtio device at device remove

Paul Bolle (1):
      lguest: lguest.txt documentation fix

Rusty Russell (2):
      lguest: Don't need comment terminator before disk section.
      lguest: comment documentation update.

Tim Ansell (1):
      lguest: Add puppies which where previously missing.

 Documentation/lguest/lguest.c         |   70 ++++++++++++----------
 Documentation/lguest/lguest.txt       |   19 ++++--
 arch/x86/lguest/boot.c                |  108 +++++++++++++++++++--------------
 arch/x86/lguest/i386_head.S           |   15 +++-
 drivers/lguest/Makefile               |    8 +++
 drivers/lguest/core.c                 |   18 +++---
 drivers/lguest/hypercalls.c           |   11 +++-
 drivers/lguest/interrupts_and_traps.c |    7 +-
 drivers/lguest/lguest_device.c        |   11 ++--
 drivers/lguest/lguest_user.c          |   30 ++++++---
 drivers/lguest/page_tables.c          |   32 ++++++----
 drivers/lguest/x86/core.c             |   33 ++++++----
 drivers/lguest/x86/switcher_32.S      |    8 +-
 drivers/virtio/virtio_pci.c           |    1 +
 include/asm-x86/lguest_hcall.h        |    2 +-
 include/linux/lguest_launcher.h       |    6 ++-
 16 files changed, 229 insertions(+), 150 deletions(-)
