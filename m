From: Andy Lutomirski <luto@mit.edu>
Subject: [PATCH v2 6/6] x86-64: Add vsyscall:emulate_vsyscall trace event
Date: Wed,  3 Aug 2011 09:31:54 -0400
Message-ID: <cdaad7da946a80b200df16647c1700db3e1171e9.1312378163.git.luto__43246.5353319005$1312379005$gmane$org@mit.edu>
References: <cover.1312378163.git.luto@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1312378163.git.luto@mit.edu>
In-Reply-To: <cover.1312378163.git.luto@mit.edu>
References: <cover.1312378163.git.luto@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com, Andy Lutomirski <luto@mit.edu>
List-Id: virtualization@lists.linuxfoundation.org

Vsyscall emulation is slow, so make it easy to track down.

Signed-off-by: Andy Lutomirski <luto@mit.edu>
---
 arch/x86/kernel/vsyscall_64.c    |    6 ++++++
 arch/x86/kernel/vsyscall_trace.h |   29 +++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/kernel/vsyscall_trace.h

diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
index 1725930..93a0d46 100644
--- a/arch/x86/kernel/vsyscall_64.c
+++ b/arch/x86/kernel/vsyscall_64.c
@@ -50,6 +50,9 @@
 #include <asm/vgtod.h>
 #include <asm/traps.h>
 
+#define CREATE_TRACE_POINTS
+#include "vsyscall_trace.h"
+
 DEFINE_VVAR(int, vgetcpu_mode);
 DEFINE_VVAR(struct vsyscall_gtod_data, vsyscall_gtod_data) =
 {
@@ -146,6 +149,9 @@ void dotraplinkage do_emulate_vsyscall(struct pt_regs *regs, long error_code)
 	 * and int 0xcc is two bytes long.
 	 */
 	vsyscall_nr = addr_to_vsyscall_nr(regs->ip - 2);
+
+	trace_emulate_vsyscall(vsyscall_nr);
+
 	if (vsyscall_nr < 0) {
 		warn_bad_vsyscall(KERN_WARNING, regs,
 				  "illegal int 0xcc (exploit attempt?)");
diff --git a/arch/x86/kernel/vsyscall_trace.h b/arch/x86/kernel/vsyscall_trace.h
new file mode 100644
index 0000000..a8b2ede
--- /dev/null
+++ b/arch/x86/kernel/vsyscall_trace.h
@@ -0,0 +1,29 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM vsyscall
+
+#if !defined(__VSYSCALL_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __VSYSCALL_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(emulate_vsyscall,
+
+	    TP_PROTO(int nr),
+
+	    TP_ARGS(nr),
+
+	    TP_STRUCT__entry(__field(int, nr)),
+
+	    TP_fast_assign(
+			   __entry->nr = nr;
+			   ),
+
+	    TP_printk("nr = %d", __entry->nr)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../arch/x86/kernel
+#define TRACE_INCLUDE_FILE vsyscall_trace
+#include <trace/define_trace.h>
-- 
1.7.6
