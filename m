From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH v4 00/10] x86: Support compiling out userspace IO (iopl and
	ioperm)
Date: Sun, 2 Nov 2014 09:31:22 -0800
Message-ID: <cover.1414870871.git.josh@joshtriplett.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

This patch series makes it possible to compile out the userspace IO system
calls, iopl and ioperm.

The first patch does some 32/64 unification in copy_thread to make subsequent
changes easier.  The second patch simplifies the complex calculation of the TSS
segment limit, which also makes it easier to change in the last patch.  Patches
3-9 introduce helpers to make it easier to compile out IO.  The last patch adds
and uses the new CONFIG_X86_IOPORT to support compiling out userspace IO.

v3 had patches 3-10 as a single patch; v4 splits out the various helpers and
macros into separate patches, as requested by Thomas Gleixner.

I've verified that this compiles after each patch.

Josh Triplett (10):
  x86: process: Unify 32-bit and 64-bit copy_thread I/O bitmap handling
  x86: tss: Eliminate fragile calculation of TSS segment limit
  x86: processor.h: Introduce macros to initialize IO fields of thread
    and TSS
  x86: paravirt: Wrap initialization of set_iopl_mask in a macro
  x86: cpu: Add helper function unifying 32-bit and 64-bit IO init in
    cpu_init
  x86: process: Introduce helper to clear a thread's IO bitmap
  x86: process: Introduce helper to switch iopl mask
  x86: process: Introduce helper for IO-related bits of exit_thread
  x86: process: Introduce helper to switch IO bitmap
  x86: Support compiling out userspace IO (iopl and ioperm)

 arch/x86/Kconfig                      | 10 ++++
 arch/x86/include/asm/desc.h           | 11 +----
 arch/x86/include/asm/paravirt.h       |  2 +
 arch/x86/include/asm/paravirt_types.h |  5 ++
 arch/x86/include/asm/processor.h      | 55 +++++++++++++++++----
 arch/x86/include/asm/syscalls.h       |  3 ++
 arch/x86/kernel/Makefile              |  3 +-
 arch/x86/kernel/cpu/common.c          | 12 +----
 arch/x86/kernel/entry_64.S            |  9 ++--
 arch/x86/kernel/paravirt.c            |  2 +-
 arch/x86/kernel/process-io.h          | 93 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c             | 34 ++-----------
 arch/x86/kernel/process_32.c          | 41 +++++----------
 arch/x86/kernel/process_64.c          | 27 +++-------
 arch/x86/kernel/ptrace.c              |  8 +++
 arch/x86/xen/enlighten.c              |  4 +-
 drivers/tty/vt/vt_ioctl.c             |  2 +-
 kernel/sys_ni.c                       |  5 ++
 18 files changed, 208 insertions(+), 118 deletions(-)
 create mode 100644 arch/x86/kernel/process-io.h

-- 
2.1.1
