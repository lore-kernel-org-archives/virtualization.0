From: Tim Gardner <tim.gardner@canonical.com>
Subject: [PATCH linux-next] xen/multicall: xen_mc_callback(): avoid buffer
	overflow
Date: Fri,  8 Feb 2013 13:34:37 -0700
Message-ID: <1360355677-52442-1-git-send-email-tim.gardner__1204.11945176802$1360626690$gmane$org@canonical.com>
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
To: linux-kernel@vger.kernel.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Tim Gardner <tim.gardner@canonical.com>
List-Id: virtualization@lists.linuxfoundation.org

This buffer overflow was introduced with 91e0c5f3dad47838cb2ecc1865ce789a0b7182b1
(2.6.24).

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.linux-foundation.org
Cc: stable@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

This patch applies cleanly to 3.1.10 and newer. Requires a backport
for 2.6.24-3.2.y

 arch/x86/xen/multicalls.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/multicalls.c b/arch/x86/xen/multicalls.c
index 0d82003..5270407 100644
--- a/arch/x86/xen/multicalls.c
+++ b/arch/x86/xen/multicalls.c
@@ -195,9 +195,10 @@ void xen_mc_callback(void (*fn)(void *), void *data)
 	struct mc_buffer *b = &__get_cpu_var(mc_buffer);
 	struct callback *cb;
 
-	if (b->cbidx == MC_BATCH) {
+	if (b->cbidx >= MC_BATCH) {
 		trace_xen_mc_flush_reason(XEN_MC_FL_CALLBACK);
 		xen_mc_flush();
+		return;
 	}
 
 	trace_xen_mc_callback(fn, data);
-- 
1.7.9.5
