From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 00/15] ia64/pv_ops, xen: more paravirtualization. TAKE 4
Date: Mon, 22 Dec 2008 14:50:07 +0900
Message-ID: <1229925022-31365-1-git-send-email-yamahata__26873.4198216864$1229925755$gmane$org@valinux.co.jp>
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
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


This patch set is intended for the next merge window. They are just
enhancements of the already merged patches or ia64 porting from x86
paravirt techniques and that their quality is enough for merge.

This patch set is for more paravirtualization on ia64/xen domU.
This patch set does
- remove existing warnings
- paravirtualize fsys call (fsys.S) by multi compile
- paravirtualize gate page (gate.S) by multi compile
- support save/restore
  For this purpose, the followings needs to be paravirtualized
  - ar.itc instruction 
  - sched_clock()
  This is because timer may changed before/after saving/restoring.

For convenience the working full source is available from
http://people.valinux.co.jp/~yamahata/xen-ia64/for_eagl/linux-2.6-ia64-pv-ops.git/
branch: ia64-pv-ops-2008dec22-xen-ia64-optimized-domu

For the status of this patch series
http://wiki.xensource.com/xenwiki/XenIA64/UpstreamMerge

thanks,

Changes from take 3
- removed trivial compilation error depending on .config

Changes from take 2
- two patches to remove warnings.
- rebased to 2.6.28-rc8

Changes from take 1
- refreshed to 2.6.28-rc6
  no essential change.


Diffstat:
 arch/ia64/include/asm/native/inst.h       |   13 ++
 arch/ia64/include/asm/native/patchlist.h  |   38 +++++++
 arch/ia64/include/asm/native/pvchk_inst.h |    8 ++
 arch/ia64/include/asm/paravirt.h          |   57 ++++++++++
 arch/ia64/include/asm/timex.h             |    1 +
 arch/ia64/include/asm/xen/inst.h          |   28 +++++
 arch/ia64/include/asm/xen/interface.h     |    9 ++
 arch/ia64/include/asm/xen/minstate.h      |   11 ++-
 arch/ia64/include/asm/xen/patchlist.h     |   38 +++++++
 arch/ia64/include/asm/xen/privop.h        |    2 +
 arch/ia64/kernel/Makefile                 |   36 +-----
 arch/ia64/kernel/Makefile.gate            |   27 +++++
 arch/ia64/kernel/asm-offsets.c            |    2 +
 arch/ia64/kernel/entry.S                  |    4 +-
 arch/ia64/kernel/fsys.S                   |   35 +++---
 arch/ia64/kernel/gate.S                   |  171 +++++++++++++++--------------
 arch/ia64/kernel/gate.lds.S               |   17 ++--
 arch/ia64/kernel/head.S                   |   10 ++-
 arch/ia64/kernel/ivt.S                    |    2 +-
 arch/ia64/kernel/paravirt.c               |    1 +
 arch/ia64/kernel/paravirt_patchlist.c     |   79 +++++++++++++
 arch/ia64/kernel/paravirt_patchlist.h     |   28 +++++
 arch/ia64/kernel/patch.c                  |   48 ++++++---
 arch/ia64/kernel/time.c                   |    9 ++
 arch/ia64/kernel/vmlinux.lds.S            |    6 +
 arch/ia64/mm/init.c                       |    9 +-
 arch/ia64/scripts/pvcheck.sed             |    1 +
 arch/ia64/xen/Kconfig                     |    1 +
 arch/ia64/xen/Makefile                    |   19 +++-
 arch/ia64/xen/gate-data.S                 |    3 +
 arch/ia64/xen/time.c                      |   48 ++++++++
 arch/ia64/xen/xen_pv_ops.c                |  132 +++++++++++++++++++++-
 32 files changed, 729 insertions(+), 164 deletions(-)
