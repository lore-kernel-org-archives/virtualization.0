From: Sander Eikelenboom <linux@eikelenboom.it>
Subject: Re: [Xen-devel] [PATCH v2 0/6] Collected vdso/vsyscall fixes for 3.1
Date: Wed, 3 Aug 2011 19:34:25 +0200
Message-ID: <284611976.20110803193425__19760.5748232037$1312482940$gmane$org@eikelenboom.it>
References: <cover.1312378163.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1312378163.git.luto@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andy Lutomirski <luto@MIT.EDU>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hello Andy,

Wednesday, August 3, 2011, 3:31:48 PM, you wrote:

> This fixes various problems that cropped up with the vdso patches.

>  - Patch 1 fixes an information leak to userspace.
>  - Patches 2 and 3 fix the kernel build on gold.
>  - Patches 4 and 5 fix Xen (I hope).
>  - Patch 6 (optional) adds a trace event to vsyscall emulation.  It will
>    make it easier to handle performance regression reports :)

> [1] https://gitorious.org/linux-test-utils/linux-clock-tests

> Changes from v1:
>  - Improve changelog message for "x86-64/xen: Enable the vvar mapping"
>  - Fix 32-bit build.
>  - Add patch 6.

> Andy Lutomirski (6):
>   x86-64: Pad vDSO to a page boundary
>   x86-64: Move the "user" vsyscall segment out of the data segment.
>   x86-64: Work around gold bug 13023
>   x86-64/xen: Enable the vvar mapping
>   x86-64: Add user_64bit_mode paravirt op
>   x86-64: Add vsyscall:emulate_vsyscall trace event

>  arch/x86/include/asm/desc.h           |    4 +-
>  arch/x86/include/asm/paravirt_types.h |    6 ++++
>  arch/x86/include/asm/ptrace.h         |   19 +++++++++++++
>  arch/x86/kernel/paravirt.c            |    4 +++
>  arch/x86/kernel/step.c                |    2 +-
>  arch/x86/kernel/vmlinux.lds.S         |   46 ++++++++++++++++++---------------
>  arch/x86/kernel/vsyscall_64.c         |   12 +++++---
>  arch/x86/kernel/vsyscall_trace.h      |   29 ++++++++++++++++++++
>  arch/x86/mm/fault.c                   |    2 +-
>  arch/x86/vdso/vdso.S                  |    1 +
>  arch/x86/xen/enlighten.c              |    4 +++
>  arch/x86/xen/mmu.c                    |    4 ++-
>  12 files changed, 102 insertions(+), 31 deletions(-)
>  create mode 100644 arch/x86/kernel/vsyscall_trace.h

Compile and boot tested on Xen 4.1.1 and baremetal on x86_64, it fixes my boot panic under Xen.

Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
