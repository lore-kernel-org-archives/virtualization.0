From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 9/24] Wipe out traditional opt from x86_64 Makefile
Date: Fri,  9 Nov 2007 16:42:50 -0200
Message-ID: <11946338361369-git-send-email-gcosta__2595.17323361269$1194643877$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
	<1194633831882-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1194633831882-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Among other things, using -traditional as a gcc option stops us from
using macro token pasting, which is a feature we heavily rely on.

There was still a use of -traditional in arch/x86/kernel/Makefile_64,
which this patch removes.

I don't see any problems building kernels in my x86_64 box without
-traditional.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86/kernel/Makefile_64 |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/Makefile_64 b/arch/x86/kernel/Makefile_64
index ffee997..0714528 100644
--- a/arch/x86/kernel/Makefile_64
+++ b/arch/x86/kernel/Makefile_64
@@ -3,7 +3,6 @@
 #
 
 extra-y 	:= head_64.o head64.o init_task.o vmlinux.lds
-EXTRA_AFLAGS	:= -traditional
 obj-y	:= process_64.o signal_64.o entry_64.o traps_64.o irq_64.o \
 		ptrace_64.o time_64.o ioport_64.o ldt.o setup_64.o i8259_64.o sys_x86_64.o \
 		x8664_ksyms_64.o i387_64.o syscall_64.o vsyscall_64.o \
-- 
1.4.4.2
