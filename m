From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 00/23] ia64/xen domU take 5
Date: Wed, 30 Apr 2008 21:30:31 +0900
Message-ID: <1209558654694-git-send-email-yamahata__38229.3545095765$1209560577$gmane$org@valinux.co.jp>
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
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi. This patchset implements ia64/xen domU support based on
ia64/pv_ops frame work which was sent as another patchest.


This patchset does the followings.
- Some preparation work. Mainly importing header files to define
  related structures.
- Then, define functions related to hypercall which is the way to
  communicate with Xen hypervisor.
- Add some helper functions which is necessary to utilize
  xen arch generic portion.
- Next implements the xen instance of pv_ops introducing
  pv_info, pv_init_ops, pv_cpu_ops and its assembler counter part,
  pv_iosapic_ops, pv_irq_ops and, pv_time_ops step by step.
- Introduce xen machine vector to describe xen platform.
  By using machine vector, xen domU implementation can be simplified.
- Lastly update Kconfig to allow paravirtualization support and
  xen domU support to compile.


The working full source is available from
http://people.valinux.co.jp/~yamahata/xen-ia64/linux-2.6-xen-ia64.git/
branch: xen-ia64-2008apr30

At this phase, we don't address the following issues.
Those will be addressed after the first merge.
- optimization by binary patch
  In fact, we had the patch to do that, but we intentionally dropped
  for patch size/readability/cleanness.
- freeing the unused pages, i.e. pages for unused ivt.S.

Changes from take 4:
- fix synch bit ops definitions to prevent accidental namespace clashes.
- rebased and fixed breakages due to the upstream change.

Changes from take 3:
- split the patch set into pv_op part and xen domU part.
- many clean ups.
- introduced pv_ops: pv_cpu_ops and pv_time_ops.

Changes from take 2:
- many clean ups following to comments.
- clean up:assembly instruction macro.
- introduced pv_ops: pv_info, pv_init_ops, pv_iosapic_ops, pv_irq_ops.

Changes from take 1:
Single IVT source code. compile multitimes using assembler macros.

thanks,

Diffstat:
 arch/ia64/Kconfig                  |   32 +++
 arch/ia64/Makefile                 |    2 +
 arch/ia64/kernel/acpi.c            |    5 +
 arch/ia64/kernel/asm-offsets.c     |   27 ++
 arch/ia64/kernel/head.S            |    6 +
 arch/ia64/kernel/nr-irqs.c         |    1 +
 arch/ia64/xen/Kconfig              |   21 ++
 arch/ia64/xen/Makefile             |   22 ++
 arch/ia64/xen/grant-table.c        |  155 +++++++++++
 arch/ia64/xen/hypercall.S          |   91 +++++++
 arch/ia64/xen/hypervisor.c         |   96 +++++++
 arch/ia64/xen/irq_xen.c            |  422 ++++++++++++++++++++++++++++++
 arch/ia64/xen/irq_xen.h            |   34 +++
 arch/ia64/xen/machvec.c            |    4 +
 arch/ia64/xen/time.c               |  165 ++++++++++++
 arch/ia64/xen/time.h               |   23 ++
 arch/ia64/xen/xcom_hcall.c         |  424 ++++++++++++++++++++++++++++++
 arch/ia64/xen/xen_pv_ops.c         |  362 ++++++++++++++++++++++++++
 arch/ia64/xen/xencomm.c            |   95 +++++++
 arch/ia64/xen/xenivt.S             |   57 ++++
 arch/ia64/xen/xensetup.S           |   49 ++++
 include/asm-ia64/machvec.h         |    2 +
 include/asm-ia64/machvec_xen.h     |   22 ++
 include/asm-ia64/meminit.h         |    3 +-
 include/asm-ia64/sync_bitops.h     |   57 ++++
 include/asm-ia64/xen/events.h      |   50 ++++
 include/asm-ia64/xen/grant_table.h |   29 ++
 include/asm-ia64/xen/hypercall.h   |  263 +++++++++++++++++++
 include/asm-ia64/xen/hypervisor.h  |   72 +++++
 include/asm-ia64/xen/inst.h        |  504 ++++++++++++++++++++++++++++++++++++
 include/asm-ia64/xen/interface.h   |  320 +++++++++++++++++++++++
 include/asm-ia64/xen/irq.h         |   44 +++
 include/asm-ia64/xen/minstate.h    |  133 ++++++++++
 include/asm-ia64/xen/page.h        |   65 +++++
 include/asm-ia64/xen/privop.h      |  129 +++++++++
 include/asm-ia64/xen/xcom_hcall.h  |   51 ++++
 include/asm-ia64/xen/xencomm.h     |   33 +++
 37 files changed, 3869 insertions(+), 1 deletions(-)
