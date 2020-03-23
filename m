From: Alexey Makhalov via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 5/5] x86/vmware: Use bool type for vmw_sched_clock
Date: Mon, 23 Mar 2020 19:57:07 +0000
Message-ID: <20200323195707.31242-6-amakhalov@vmware.com>
References: <20200212200312.2033-1-amakhalov@vmware.com>
 <20200323195707.31242-1-amakhalov@vmware.com>
Reply-To: Alexey Makhalov <amakhalov@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200323195707.31242-1-amakhalov@vmware.com>
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
Cc: Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

To be aligned with other bool variables.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/vmware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index e885f73bebd4..9b6fafa69be9 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -122,14 +122,14 @@ static unsigned long vmware_get_tsc_khz(void)
 
 #ifdef CONFIG_PARAVIRT
 static struct cyc2ns_data vmware_cyc2ns __ro_after_init;
-static int vmw_sched_clock __initdata = 1;
+static bool vmw_sched_clock __initdata = true;
 static DEFINE_PER_CPU_DECRYPTED(struct vmware_steal_time, vmw_steal_time) __aligned(64);
 static bool has_steal_clock;
 static bool steal_acc __initdata = true; /* steal time accounting */
 
 static __init int setup_vmw_sched_clock(char *s)
 {
-	vmw_sched_clock = 0;
+	vmw_sched_clock = false;
 	return 0;
 }
 early_param("no-vmw-sched-clock", setup_vmw_sched_clock);
-- 
2.14.2
