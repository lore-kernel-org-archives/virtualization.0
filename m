From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [RFC v3 25/27] x86/pie: Add option to build the kernel as PIE
Date: Wed,  4 Oct 2017 14:20:01 -0700
Message-ID: <20171004212003.28296-26-thgarnie__36813.8131373145$1509079994$gmane$org@google.com>
References: <20171004212003.28296-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171004212003.28296-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Garnier <thgarnie@google.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>Bor
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

Add the CONFIG_X86_PIE option which builds the kernel as a Position
Independent Executable (PIE). The kernel is currently build with the
mcmodel=kernel option which forces it to stay on the top 2G of the
virtual address space. With PIE, the kernel will be able to move below
the current limit.

The --emit-relocs linker option was kept instead of using -pie to limit
the impact on mapped sections. Any incompatible relocation will be
catch by the arch/x86/tools/relocs binary at compile time.

Performance/Size impact:
Size of vmlinux (Default configuration):
 File size:
 - PIE disabled: +0.000031%
 - PIE enabled: -3.210% (less relocations)
 .text section:
 - PIE disabled: +0.000644%
 - PIE enabled: +0.837%

Size of vmlinux (Ubuntu configuration):
 File size:
 - PIE disabled: -0.201%
 - PIE enabled: -0.082%
 .text section:
 - PIE disabled: same
 - PIE enabled: +1.319%

Size of vmlinux (Default configuration + ORC):
 File size:
 - PIE enabled: -3.167%
 .text section:
 - PIE enabled: +0.814%

Size of vmlinux (Ubuntu configuration + ORC):
 File size:
 - PIE enabled: -3.167%
 .text section:
 - PIE enabled: +1.26%

The size increase is mainly due to not having access to the 32-bit signed
relocation that can be used with mcmodel=kernel. A small part is due to reduced
optimization for PIE code. This bug [1] was opened with gcc to provide a better
code generation for kernel PIE.

Hackbench (50% and 1600% on thread/process for pipe/sockets):
 - PIE disabled: no significant change (avg +0.1% on latest test).
 - PIE enabled: between -0.50% to +0.86% in average (default and Ubuntu config).

slab_test (average of 10 runs):
 - PIE disabled: no significant change (-2% on latest run, likely noise).
 - PIE enabled: between -1% and +0.8% on latest runs.

Kernbench (average of 10 Half and Optimal runs):
 Elapsed Time:
 - PIE disabled: no significant change (avg -0.239%)
 - PIE enabled: average +0.07%
 System Time:
 - PIE disabled: no significant change (avg -0.277%)
 - PIE enabled: average +0.7%

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82303

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/Kconfig  | 8 ++++++++
 arch/x86/Makefile | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1e4b399c64e5..b92f96923712 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2141,6 +2141,14 @@ config X86_GLOBAL_STACKPROTECTOR
 	bool
 	depends on CC_STACKPROTECTOR
 
+config X86_PIE
+	bool
+	depends on X86_64
+	select DEFAULT_HIDDEN
+	select DYNAMIC_MODULE_BASE
+	select MODULE_REL_CRCS if MODVERSIONS
+	select X86_GLOBAL_STACKPROTECTOR if CC_STACKPROTECTOR
+
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 42774185a58a..c49855b4b1be 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -144,6 +144,7 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
 ifdef CONFIG_X86_PIE
+        KBUILD_CFLAGS += -fPIC
         KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/x86/kernel/module.lds
 else
         KBUILD_CFLAGS += -mcmodel=kernel
-- 
2.14.2.920.gcf0c67979c-goog
