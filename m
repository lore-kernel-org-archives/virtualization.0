From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH]  xen: fix xen-smp.patch: setup_runstate_info
Date: Wed, 06 Jun 2007 15:40:37 -0700
Message-ID: <466737E5.9090802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

Somehow an smp_processor_id() survived the transition to passing the
cpu around.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Jan Beulich <jbeulich@novell.com>

---
 arch/i386/xen/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- a/arch/i386/xen/time.c
+++ b/arch/i386/xen/time.c
@@ -110,7 +110,7 @@ static void setup_runstate_info(int cpu)
 	area.addr.v = &per_cpu(runstate, cpu);
 
 	if (HYPERVISOR_vcpu_op(VCPUOP_register_runstate_memory_area,
-			       smp_processor_id(), &area))
+			       cpu, &area))
 		BUG();
 }
