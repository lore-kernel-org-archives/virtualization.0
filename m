From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] x86/vmware: Do not trace vmware_sched_clock()
Date: Fri, 9 Nov 2018 15:22:07 -0500
Message-ID: <20181109152207.4d3e7d70__27218.7541042969$1541794810$gmane$org@gandalf.local.home>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: GwanYeong Kim <gy741.kim@gmail.com>, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

When running function tracing on a Linux guest running on VMware
Workstation, the guest would crash. This is due to tracing of the
sched_clock internal call of the VMware vmware_sched_clock(), which
causes an infinite recursion within the tracing code (clock calls must
not be traced).

Make vmware_sched_clock() not traced by ftrace.

Cc: stable@vger.kernel.org
Fixes: 80e9a4f21fd7c ("x86/vmware: Add paravirt sched clock")
Reported-by: GwanYeong Kim <gy741.kim@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d9ab49bed8af..0eda91f8eeac 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -77,7 +77,7 @@ static __init int setup_vmw_sched_clock(char *s)
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
 
-static unsigned long long vmware_sched_clock(void)
+static unsigned long long notrace vmware_sched_clock(void)
 {
 	unsigned long long ns;
