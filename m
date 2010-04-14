From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] lguest fixes: for lguest-under-kvm and older CPU configs
Date: Wed, 14 Apr 2010 21:47:35 +0930
Message-ID: <201004142147.36149.rusty__14212.4808081009$1271247586$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: lguest <lguest@ozlabs.org>, Matias Zabaljauregui <zabaljauregui@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 2ba3abd8186f24c7fb418927025b4e2120e3a362:
  Linus Torvalds (1):
        Merge branch 'pm-fixes' of git://git.kernel.org/.../rafael/suspend-2.6

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Rusty Russell (2):
      lguest: workaround cmpxchg8b_emu by ignoring cli in the guest.
      lguest: stop using KVM hypercall mechanism

 arch/x86/include/asm/lguest_hcall.h |   29 +++++++++++++---
 arch/x86/lguest/boot.c              |   61 +++++++++++++++++------------------
 arch/x86/lguest/i386_head.S         |    2 +-
 drivers/lguest/lguest_device.c      |    4 +-
 drivers/lguest/x86/core.c           |   12 +++++++
 5 files changed, 68 insertions(+), 40 deletions(-)

commit 5094aeafbbd500509f648e3cd102b053bc7926b3
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Wed Apr 14 21:43:53 2010 -0600

    lguest: workaround cmpxchg8b_emu by ignoring cli in the guest.
    
    It's only used by cmpxchg8b_emu (see db677ffa5f5a for the gory
    details), and fixing that to be paravirt aware would be more work than
    simply ignoring it (and AFAICT only help lguest).  This makes lguest
    work on machines which have cmpxchg8b, for kernels compiled for older
    processors.
    
    (We can't emulate it properly: the popf which expects to restore interrupts
    does not trap).
    
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
    Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
    Cc: virtualization@lists.osdl.org

 drivers/lguest/x86/core.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

commit 091ebf07a2408f9a56634caa0f86d9360e9af23b
Author: Rusty Russell <rusty@rustcorp.com.au>
Date:   Wed Apr 14 21:43:54 2010 -0600

    lguest: stop using KVM hypercall mechanism
    
    This is a partial revert of 4cd8b5e2a159 "lguest: use KVM hypercalls";
    we revert to using (just as questionable but more reliable) int $15 for
    hypercalls.  I didn't revert the register mapping, so we still use the
    same calling convention as kvm.
    
    KVM in more recent incarnations stopped injecting a fault when a guest
    tried to use the VMCALL instruction from ring 1, so lguest under kvm
    fails to make hypercalls.  It was nice to share code with our KVM
    cousins, but this was overreach.
    
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
    Cc: Matias Zabaljauregui <zabaljauregui@gmail.com>
    Cc: Avi Kivity <avi@redhat.com>

 arch/x86/include/asm/lguest_hcall.h |   29 +++++++++++++---
 arch/x86/lguest/boot.c              |   61 +++++++++++++++++------------------
 arch/x86/lguest/i386_head.S         |    2 +-
 drivers/lguest/lguest_device.c      |    4 +-
 4 files changed, 56 insertions(+), 40 deletions(-)
