From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 0/3] x86: Support compiling out userspace I/O (iopl and ioperm)
Date: Tue, 22 Oct 2013 03:33:58 +0100
Message-ID: <cover.1382407802.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <keescook@chromium.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ross Lagerwall <rosslagerwall@gmail.com>, Chris
List-Id: virtualization@lists.linuxfoundation.org

This patch series makes it possible to compile out the iopl and ioperm system
calls, which allow privileged processes to request permission to directly poke
I/O ports from userspace.

Nothing on a modern Linux system uses these calls anymore, and anything new
should be using /dev/port instead, or better yet writing a driver.

Copying the bloat-o-meter stats from the final patch:

32-bit bloat-o-meter:
add/remove: 0/3 grow/shrink: 0/10 up/down: 0/-17681 (-17681)
function                                     old     new   delta
cpu_init                                     676     668      -8
ioperm_active                                 18       7     -11
init_task                                   1296    1284     -12
exit_thread                                  179      91     -88
ioperm_get                                   103      10     -93
__switch_to_xtra                             254     161     -93
sys_iopl                                     127       -    -127
SyS_iopl                                     127       -    -127
copy_thread                                  606     446    -160
vt_ioctl                                    4127    3919    -208
sys_ioperm                                   370       -    -370
init_tss                                    8576     384   -8192
doublefault_tss                             8576     384   -8192

64-bit bloat-o-meter:
add/remove: 0/4 grow/shrink: 2/9 up/down: 45/-9764 (-9719)
function                                     old     new   delta
cpu_init                                     958     995     +37
arch_align_stack                              78      86      +8
perf_event_exit_task                         525     517      -8
ioperm_active                                 17       8      -9
init_task                                   1968    1944     -24
stub_iopl                                     81       -     -81
ioperm_get                                   111      11    -100
__switch_to_xtra                             281     164    -117
exit_thread                                  212      92    -120
vt_ioctl                                    4432    4304    -128
sys_iopl                                     137       -    -137
SyS_iopl                                     137       -    -137
copy_thread                                  694     520    -174
sys_ioperm                                   473       -    -473
init_tss                                    8896     640   -8256

Josh Triplett (3):
  x86: process: Unify 32-bit and 64-bit copy_thread I/O bitmap handling
  x86: tss: Eliminate fragile calculation of TSS segment limit
  x86: Support compiling out userspace I/O (iopl and ioperm)

 arch/x86/Kconfig                      | 10 ++++
 arch/x86/include/asm/desc.h           | 11 +----
 arch/x86/include/asm/paravirt.h       |  2 +
 arch/x86/include/asm/paravirt_types.h |  2 +
 arch/x86/include/asm/processor.h      | 54 +++++++++++++++++---
 arch/x86/include/asm/syscalls.h       |  3 ++
 arch/x86/kernel/Makefile              |  3 +-
 arch/x86/kernel/cpu/common.c          | 12 +----
 arch/x86/kernel/entry_64.S            |  9 ++--
 arch/x86/kernel/paravirt.c            |  2 +
 arch/x86/kernel/process-io.h          | 93 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c             | 34 ++-----------
 arch/x86/kernel/process_32.c          | 40 ++++-----------
 arch/x86/kernel/process_64.c          | 26 ++--------
 arch/x86/kernel/ptrace.c              |  8 +++
 arch/x86/xen/enlighten.c              |  4 ++
 drivers/tty/vt/vt_ioctl.c             |  2 +-
 kernel/sys_ni.c                       |  5 ++
 18 files changed, 206 insertions(+), 114 deletions(-)
 create mode 100644 arch/x86/kernel/process-io.h

-- 
1.8.4.rc3
