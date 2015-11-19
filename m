From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v2 0/3] Fix and cleanup for 32-bit PV sysexit
Date: Thu, 19 Nov 2015 16:55:44 -0500
Message-ID: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
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
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, david.vrabel@citrix.com, konrad.wilk@oracle.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, luto@kernel.org, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, bp@suse.de
List-Id: virtualization@lists.linuxfoundation.org

The first patch fixes Xen PV regression introduced by 32-bit rewrite. Unlike the
earlier version it uses ALTERNATIVE instruction and avoids using xen_sysexit
(and sysret32 in compat mode) pv ops, as suggested by Andy.

As result of this patch irq_enable_sysexit and usergs_sysret32 pv ops are not
used anymore by anyone and so can be removed.


v2:
  * patch both TEST and JZ intructions with a single JMP
  * Add magic prefix to X86_FEATURE_XENPV comment to avoid having it printed in
    /proc/cpuinfo
  * Clarify in commit messages why irq_enable_sysexit and usergs_sysret32 are
    removed


Boris Ostrovsky (3):
  x86/xen: Avoid fast syscall path for Xen PV guests
  x86: irq_enable_sysexit pv op is no longer needed
  x86: usergs_sysret32 pv op is no longer needed

 arch/x86/entry/entry_32.S             | 13 +++++--------
 arch/x86/entry/entry_64_compat.S      | 20 ++++++++------------
 arch/x86/include/asm/cpufeature.h     |  1 +
 arch/x86/include/asm/paravirt.h       | 12 ------------
 arch/x86/include/asm/paravirt_types.h | 17 -----------------
 arch/x86/kernel/asm-offsets.c         |  3 ---
 arch/x86/kernel/asm-offsets_64.c      |  1 -
 arch/x86/kernel/paravirt.c            | 12 ------------
 arch/x86/kernel/paravirt_patch_32.c   |  2 --
 arch/x86/kernel/paravirt_patch_64.c   |  3 ---
 arch/x86/xen/enlighten.c              |  7 +++----
 arch/x86/xen/xen-asm_32.S             | 14 --------------
 arch/x86/xen/xen-asm_64.S             | 19 -------------------
 arch/x86/xen/xen-ops.h                |  3 ---
 14 files changed, 17 insertions(+), 110 deletions(-)

-- 
1.8.1.4
