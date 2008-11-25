From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 0/5] ia64/pv_ops, xen: binary patch optimization
Date: Tue, 25 Nov 2008 22:03:50 +0900
Message-ID: <1227618235-3890-1-git-send-email-yamahata__35868.9440218315$1227618725$gmane$org@valinux.co.jp>
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

This patch set is for binary patch optimization for paravirt_ops.
The binary patch optimization is important on native case because
the paravirt_ops overhead can be reduced by converting indirect 
call into in-place execution or direct call.


The first patch imports helper functions which themselves doesn't interesting
things.
The second patch replaces the indirect function calls with a special
call written in gcc extended inline asm and introduces native methods.
The third patch introduces binary patch for kernel modules.
The forth patch suppress false positive warnings which were caused by
the previous patches.
The last patch implements xen methods.


For convenience the working full source is available from
http://people.valinux.co.jp/~yamahata/xen-ia64/for_eagl/linux-2.6-ia64-pv-ops.git/
branch: ia64-pv-ops-2008nov25-xen-ia64-optimized-domu-binary-patch

For the status of this patch series
http://wiki.xensource.com/xenwiki/XenIA64/UpstreamMerge

thanks,

Diffstat:
 arch/ia64/include/asm/intrinsics.h      |    6 +-
 arch/ia64/include/asm/module.h          |    6 +
 arch/ia64/include/asm/paravirt.h        |    8 +
 arch/ia64/include/asm/paravirt_patch.h  |  143 +++++++
 arch/ia64/include/asm/paravirt_privop.h |  347 ++++++++++++++++-
 arch/ia64/include/asm/xen/privop.h      |    4 +
 arch/ia64/kernel/Makefile               |    3 +-
 arch/ia64/kernel/efi.c                  |    1 +
 arch/ia64/kernel/module.c               |   32 ++
 arch/ia64/kernel/paravirt.c             |  520 ++++++++++++++++++++++++-
 arch/ia64/kernel/paravirt_patch.c       |  509 +++++++++++++++++++++++
 arch/ia64/kernel/paravirtentry.S        |  101 ++++-
 arch/ia64/kernel/setup.c                |    1 +
 arch/ia64/kernel/vmlinux.lds.S          |   24 ++
 arch/ia64/kvm/vtlb.c                    |    2 +
 arch/ia64/xen/hypercall.S               |    2 +
 arch/ia64/xen/xen_pv_ops.c              |  667 +++++++++++++++++++++++++++++++
 17 files changed, 2351 insertions(+), 25 deletions(-)
