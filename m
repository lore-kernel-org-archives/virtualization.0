From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 2/3] x86/hyperv: move TSC reading method to asm/mshyperv.h
Date: Fri,  3 Mar 2017 14:21:41 +0100
Message-ID: <20170303132142.25595-3-vkuznets__32477.5781519294$1488547328$gmane$org@redhat.com>
References: <20170303132142.25595-1-vkuznets@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170303132142.25595-1-vkuznets@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

As a preparation to making Hyper-V TSC page suitable for vDSO move
the TSC page reading logic to asm/mshyperv.h. While on it, do the
following
- Document the reading algorithm.
- Simplify the code a bit.
- Add explicit READ_ONCE() to not rely on 'volatile'.
- Add explicit barriers to prevent re-ordering (we need to read sequence
  strictly before and after)
- Use mul_u64_u64_shr() instead of assembly, gcc generates a single 'mul'
  instruction on x86_64 anyway.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/hyperv/hv_init.c       | 36 ++++-------------------------
 arch/x86/include/asm/mshyperv.h | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6b64cae..63dd00e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -38,39 +38,11 @@ struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 
 static u64 read_hv_clock_tsc(struct clocksource *arg)
 {
-	u64 current_tick;
+	u64 current_tick = hv_read_tsc_page(tsc_pg);
+
+	if (current_tick == U64_MAX)
+		rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
 
-	if (tsc_pg->tsc_sequence != 0) {
-		/*
-		 * Use the tsc page to compute the value.
-		 */
-
-		while (1) {
-			u64 tmp;
-			u32 sequence = tsc_pg->tsc_sequence;
-			u64 cur_tsc;
-			u64 scale = tsc_pg->tsc_scale;
-			s64 offset = tsc_pg->tsc_offset;
-
-			rdtscll(cur_tsc);
-			/* current_tick = ((cur_tsc *scale) >> 64) + offset */
-			asm("mulq %3"
-				: "=d" (current_tick), "=a" (tmp)
-				: "a" (cur_tsc), "r" (scale));
-
-			current_tick += offset;
-			if (tsc_pg->tsc_sequence == sequence)
-				return current_tick;
-
-			if (tsc_pg->tsc_sequence != 0)
-				continue;
-			/*
-			 * Fallback using MSR method.
-			 */
-			break;
-		}
-	}
-	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
 	return current_tick;
 }
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index d324dce..4ff25436 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -178,6 +178,56 @@ void hyperv_cleanup(void);
 #endif
 #ifdef CONFIG_HYPERV_TSCPAGE
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
+static inline u64 hv_read_tsc_page(const struct ms_hyperv_tsc_page *tsc_pg)
+{
+	u64 scale, offset, current_tick, cur_tsc;
+	u32 sequence;
+
+	/*
+	 * The protocol for reading Hyper-V TSC page is specified in Hypervisor
+	 * Top-Level Functional Specification ver. 3.0 and above. To get the
+	 * reference time we must do the following:
+	 * - READ ReferenceTscSequence
+	 *   A special '0' value indicates the time source is unreliable and we
+	 *   need to use something else. The currently published specification
+	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
+	 *   instead of '0' as the special value, see commit c35b82ef0294.
+	 * - ReferenceTime =
+	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
+	 * - READ ReferenceTscSequence again. In case its value has changed
+	 *   since our first reading we need to discard ReferenceTime and repeat
+	 *   the whole sequence as the hypervisor was updating the page in
+	 *   between.
+	 */
+	while (1) {
+		sequence = READ_ONCE(tsc_pg->tsc_sequence);
+		if (!sequence)
+			break;
+		/*
+		 * Make sure we read sequence before we read other values from
+		 * TSC page.
+		 */
+		smp_rmb();
+
+		scale = READ_ONCE(tsc_pg->tsc_scale);
+		offset = READ_ONCE(tsc_pg->tsc_offset);
+		cur_tsc = rdtsc_ordered();
+
+		current_tick = mul_u64_u64_shr(cur_tsc, scale, 64) + offset;
+
+		/*
+		 * Make sure we read sequence after we read all other values
+		 * from TSC page.
+		 */
+		smp_rmb();
+
+		if (READ_ONCE(tsc_pg->tsc_sequence) == sequence)
+			return current_tick;
+	}
+
+	return U64_MAX;
+}
+
 #else
 static inline struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-- 
2.9.3
