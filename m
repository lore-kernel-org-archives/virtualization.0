From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 118/205] x86/cpu/vmware: Do not trace vmware_sched_clock()
Date: Mon, 19 Nov 2018 17:27:05 +0100
Message-ID: <20181119162635.743730364__28757.4003138163$1542645194$gmane$org@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: x86-ml <x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, GwanYeong Kim <gy741.kim@gmail.com>, Alok Kataria <akataria@vmware.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 15035388439f892017d38b05214d3cda6578af64 upstream.

When running function tracing on a Linux guest running on VMware
Workstation, the guest would crash. This is due to tracing of the
sched_clock internal call of the VMware vmware_sched_clock(), which
causes an infinite recursion within the tracing code (clock calls must
not be traced).

Make vmware_sched_clock() not traced by ftrace.

Fixes: 80e9a4f21fd7c ("x86/vmware: Add paravirt sched clock")
Reported-by: GwanYeong Kim <gy741.kim@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: Alok Kataria <akataria@vmware.com>
CC: GwanYeong Kim <gy741.kim@gmail.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
CC: Thomas Gleixner <tglx@linutronix.de>
CC: virtualization@lists.linux-foundation.org
CC: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/20181109152207.4d3e7d70@gandalf.local.home
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/vmware.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -77,7 +77,7 @@ static __init int setup_vmw_sched_clock(
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
 
-static unsigned long long vmware_sched_clock(void)
+static unsigned long long notrace vmware_sched_clock(void)
 {
 	unsigned long long ns;
