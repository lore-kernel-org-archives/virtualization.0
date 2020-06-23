From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 16:53:44 +0200
Message-ID: <20200623145344.GA117543@hirez.programming.kicks-ass.net>
References: <CALCETrW2Y6UFC=zvGbXEYqpsDyBh0DSEM4NQ+L=_pp4aOd6Fuw@mail.gmail.com>
 <CALCETrXGr+o1_bKbnre8cVY14c_76m8pEf3iB_i7h+zfgE5_jA@mail.gmail.com>
 <20200428075512.GP30814@suse.de>
 <20200623110706.GB4817@hirez.programming.kicks-ass.net>
 <20200623113007.GH31822@suse.de>
 <20200623114818.GD4817@hirez.programming.kicks-ass.net>
 <20200623120433.GB14101@suse.de>
 <20200623125201.GG4817@hirez.programming.kicks-ass.net>
 <20200623134003.GD14101@suse.de>
 <20200623135916.GI4817@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200623135916.GI4817@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <JGross@suse.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, X86 ML <x86@kernel.org>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 03:59:16PM +0200, Peter Zijlstra wrote:

> So basically when your exception frame points to your own IST, you die.
> That sounds like something we should have in generic IST code.

Something like this... #DF already dies and NMI is 'magic'

---
 arch/x86/entry/common.c         |  7 +++++++
 arch/x86/include/asm/idtentry.h | 12 +++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index af0d57ed5e69..e38e4f34c90c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -742,6 +742,13 @@ noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
 	__nmi_exit();
 }
 
+noinstr void idtentry_validate_ist(struct pt_regs *regs)
+{
+	if ((regs->sp & ~(EXCEPTION_STKSZ-1)) ==
+	    (_RET_IP_ & ~(EXCEPTION_STKSZ-1)))
+		die("IST stack recursion", regs, 0);
+}
+
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 4e399f120ff8..974c1a4eacbb 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -19,6 +19,8 @@ void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
 bool idtentry_enter_nmi(struct pt_regs *regs);
 void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
 
+void idtentry_validate_ist(struct pt_regs *regs);
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -322,7 +324,15 @@ static __always_inline void __##func(struct pt_regs *regs)
  * Maps to DEFINE_IDTENTRY_RAW
  */
 #define DEFINE_IDTENTRY_IST(func)					\
-	DEFINE_IDTENTRY_RAW(func)
+static __always_inline void __##func(struct pt_regs *regs);		\
+									\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	idtentry_validate_ist(regs);					\
+	__##func(regs);							\
+}									\
+									\
+static __always_inline void __##func(struct pt_regs *regs)
 
 /**
  * DEFINE_IDTENTRY_NOIST - Emit code for NOIST entry points which
