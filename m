From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] cpumask: make Xen use the new operators.
Date: Wed, 11 Mar 2009 16:35:05 +1030
Message-ID: <200903111635.05924.rusty__39471.2308342152$1236751713$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Impact: cleanup

In particular, *map are deprecated, and you have to use the accessors
as *mask are const.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 drivers/xen/cpu_hotplug.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/cpu_hotplug.c b/drivers/xen/cpu_hotplug.c
--- a/drivers/xen/cpu_hotplug.c
+++ b/drivers/xen/cpu_hotplug.c
@@ -10,7 +10,7 @@ static void enable_hotplug_cpu(int cpu)
 	if (!cpu_present(cpu))
 		arch_register_cpu(cpu);
 
-	cpu_set(cpu, cpu_present_map);
+	set_cpu_present(cpu, true);
 }
 
 static void disable_hotplug_cpu(int cpu)
@@ -18,7 +18,7 @@ static void disable_hotplug_cpu(int cpu)
 	if (cpu_present(cpu))
 		arch_unregister_cpu(cpu);
 
-	cpu_clear(cpu, cpu_present_map);
+	set_cpu_present(cpu, false);
 }
 
 static void vcpu_hotplug(unsigned int cpu)
