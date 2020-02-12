From: Alexey Makhalov via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH 4/5] x86/vmware: Enable steal time accounting
Date: Wed, 12 Feb 2020 20:03:11 +0000
Message-ID: <20200212200312.2033-5-amakhalov@vmware.com>
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

Set paravirt_steal_rq_enabled if steal clock present.
paravirt_steal_rq_enabled is used in sched/core.c to
adjust task progress by offsetting stolen time.
Use 'no-steal-acc' off switch (share same name with KVM)
to disable steal time accounting.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/kernel/cpu/vmware.c                    | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 87176a90e61a..07fbdccdd77c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3152,7 +3152,7 @@
 			[X86,PV_OPS] Disable paravirtualized VMware scheduler
 			clock and use the default one.
 
-	no-steal-acc	[X86,KVM,ARM64] Disable paravirtualized steal time
+	no-steal-acc	[X86,PV_OPS,ARM64] Disable paravirtualized steal time
 			accounting. steal time is computed, but won't
 			influence scheduler behaviour
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 59459992ad47..0c65d661d88b 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -125,6 +125,7 @@ static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
 static int vmw_sched_clock __initdata = 1;
 static DEFINE_PER_CPU_DECRYPTED(struct vmware_steal_time, steal_time) __aligned(64);
 static bool has_steal_clock;
+static bool steal_acc __initdata = true; /* steal time accounting */
 
 static __init int setup_vmw_sched_clock(char *s)
 {
@@ -133,6 +134,13 @@ static __init int setup_vmw_sched_clock(char *s)
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
 
+static __init int parse_no_stealacc(char *arg)
+{
+	steal_acc = false;
+	return 0;
+}
+early_param("no-steal-acc", parse_no_stealacc);
+
 static unsigned long long notrace vmware_sched_clock(void)
 {
 	unsigned long long ns;
@@ -306,8 +314,11 @@ static int vmware_cpu_down_prepare(unsigned int cpu)
 
 static __init int activate_jump_labels(void)
 {
-	if (has_steal_clock)
+	if (has_steal_clock) {
 		static_key_slow_inc(&paravirt_steal_enabled);
+		if (steal_acc)
+			static_key_slow_inc(&paravirt_steal_rq_enabled);
+	}
 
 	return 0;
 }
-- 
2.14.2
