From: <gregkh@linuxfoundation.org>
Subject: Patch "x86/cpu/vmware: Do not trace vmware_sched_clock()" has been
	added to the 4.19-stable tree
Date: Mon, 19 Nov 2018 14:00:06 +0100
Message-ID: <154263240620718@kroah.com>
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
To: 20181109152207.4d3e7d70@gandalf.local.home, akataria@vmware.com, bp@suse.de, gregkh@linuxfoundation.org, gy741.kim@gmail.com, hpa@zytor.com, mingo@kernel.org, rostedt@goodmis.org, tglx@linutronix.de, virtualization@lists.linux-foundation.org, x86@kernel.org
Cc: stable-commits@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


This is a note to let you know that I've just added the patch titled

    x86/cpu/vmware: Do not trace vmware_sched_clock()

to the 4.19-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     x86-cpu-vmware-do-not-trace-vmware_sched_clock.patch
and it can be found in the queue-4.19 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From 15035388439f892017d38b05214d3cda6578af64 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Fri, 9 Nov 2018 15:22:07 -0500
Subject: x86/cpu/vmware: Do not trace vmware_sched_clock()

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
 


Patches currently in stable-queue which might be from rostedt@goodmis.org are

queue-4.19/tracing-kprobes-check-the-probe-on-unloaded-module-correctly.patch
queue-4.19/x86-cpu-vmware-do-not-trace-vmware_sched_clock.patch
