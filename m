From: Alexey Makhalov via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH 2/5] x86/vmware: Remove vmware_sched_clock_setup()
Date: Wed, 12 Feb 2020 20:03:09 +0000
Message-ID: <20200212200312.2033-3-amakhalov@vmware.com>
References: <20200212200312.2033-1-amakhalov@vmware.com>
Reply-To: Alexey Makhalov <amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200212200312.2033-1-amakhalov@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>, Jonathan Corbet <corbet@lwn.net>, "VMware,
 Inc." <pv-drivers@vmware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

Move cyc2ns setup logic to separate function.
This separation will allow to use cyc2ns mult/shift pair
not only for the sched_clock but also for other clocks
such as steal_clock.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 arch/x86/kernel/cpu/vmware.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index d280560fd75e..efb22fa76ba4 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -122,7 +122,7 @@ static unsigned long long notrace vmware_sched_clock(void)
 	return ns;
 }
 
-static void __init vmware_sched_clock_setup(void)
+static void __init vmware_cyc2ns_setup(void)
 {
 	struct cyc2ns_data *d = &vmware_cyc2ns;
 	unsigned long long tsc_now = rdtsc();
@@ -132,8 +132,7 @@ static void __init vmware_sched_clock_setup(void)
 	d->cyc2ns_offset = mul_u64_u32_shr(tsc_now, d->cyc2ns_mul,
 					   d->cyc2ns_shift);
 
-	pv_ops.time.sched_clock = vmware_sched_clock;
-	pr_info("using sched offset of %llu ns\n", d->cyc2ns_offset);
+	pr_info("using clock offset of %llu ns\n", d->cyc2ns_offset);
 }
 
 static void __init vmware_paravirt_ops_setup(void)
@@ -141,8 +140,14 @@ static void __init vmware_paravirt_ops_setup(void)
 	pv_info.name = "VMware hypervisor";
 	pv_ops.cpu.io_delay = paravirt_nop;
 
-	if (vmware_tsc_khz && vmw_sched_clock)
-		vmware_sched_clock_setup();
+	if (vmware_tsc_khz == 0)
+		return;
+
+	vmware_cyc2ns_setup();
+
+	if (vmw_sched_clock)
+		pv_ops.time.sched_clock = vmware_sched_clock;
+
 }
 #else
 #define vmware_paravirt_ops_setup() do {} while (0)
-- 
2.14.2
