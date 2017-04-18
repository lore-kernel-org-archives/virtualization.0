From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 00/11] x86: xen cpuid() cleanup
Date: Tue, 18 Apr 2017 08:31:08 +0200
Message-ID: <20170418063119.11654-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, boris.ostrovsky@oracle.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Reduce special casing of xen_cpuid() by using cpu capabilities instead
of faked cpuid nodes.

This cleanup enables us remove the hypervisor specific set_cpu_features
callback as the same effect can be reached via
setup_[clear|force]_cpu_cap().

Removing the rest faked nodes from xen_cpuid() requires some more work
as the remaining cases (mwait leafs and extended topology info) have
to be handled at the consumer sides of this information.

Changes in V3:
- rewrite patch 9 (xsave) to use xgetbv instruction to test for osxsave
  availability (Andrew Cooper)

Changes in V2:
- added several features to this scheme
- removed hypervisor specific set_cpu_features() callbacks

Cc: Alok Kataria <akataria@vmware.com> 
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: "H. Peter Anvin" <hpa@zytor.com> 
Cc: x86@kernel.org 
Cc: virtualization@lists.linux-foundation.org

Juergen Gross (11):
  xen: set cpu capabilities from xen_start_kernel()
  x86/xen: don't indicate DCA support in pv domains
  x86/xen: use capabilities instead of fake cpuid values for aperf
  x86/xen: use capabilities instead of fake cpuid values for mtrr
  x86/xen: use capabilities instead of fake cpuid values for acc
  x86/xen: use capabilities instead of fake cpuid values for acpi
  x86/xen: use capabilities instead of fake cpuid values for mwait
  x86/xen: use capabilities instead of fake cpuid values for x2apic
  x86/xen: use capabilities instead of fake cpuid values for xsave
  vmware: set cpu capabilities during platform initialization
  x86/cpu: remove hypervisor specific set_cpu_features

 arch/x86/include/asm/hypervisor.h |  5 ---
 arch/x86/kernel/cpu/common.c      |  1 -
 arch/x86/kernel/cpu/hypervisor.c  |  8 ----
 arch/x86/kernel/cpu/vmware.c      | 39 ++++++++--------
 arch/x86/xen/enlighten_pv.c       | 95 +++++++++++++++++----------------------
 5 files changed, 61 insertions(+), 87 deletions(-)

-- 
2.12.0
