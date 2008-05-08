From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC] stop_machine: make stop_machine_run more virtualization
	friendly
Date: Thu, 8 May 2008 15:20:38 +0200
Message-ID: <200805081520.38310.borntraeger__6114.78430587358$1210253171$gmane$org@de.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On kvm I have seen some rare hangs in stop_machine when I used more guest
cpus than hosts cpus. e.g. 32 guest cpus on 1 host cpu triggered the
hang quite often. I could also reproduce the problem on a 4 way z/VM host with 
a 64 way guest.

It turned out that the guest was consuming all available cpus mostly for
spinning on scheduler locks like rq->lock. This is expected as the threads are 
calling yield all the time. 
The problem is now, that the host scheduling decisings together with the guest 
scheduling decisions and spinlocks not being fair managed to create an 
interesting scenario similar to a live lock. (Sometimes the hang resolved 
itself after some minutes)

Changing stop_machine to yield the cpu to the hypervisor when yielding inside 
the guest fixed the problem for me. While I am not completely happy with this 
patch, I think it causes no harm and it really improves the situation for me.

I used cpu_relax for yielding to the hypervisor, does that work on all 
architectures?

p.s.: If you want to reproduce the problem, cpu hotplug and kprobes use 
stop_machine_run and both triggered the problem after some retries. 


Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>
CC: Rusty Russell <rusty@rustcorp.com.au>

---
 kernel/stop_machine.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: kvm/kernel/stop_machine.c
===================================================================
--- kvm.orig/kernel/stop_machine.c
+++ kvm/kernel/stop_machine.c
@@ -62,8 +62,7 @@ static int stopmachine(void *cpu)
 		 * help our sisters onto their CPUs. */
 		if (!prepared && !irqs_disabled)
 			yield();
-		else
-			cpu_relax();
+		cpu_relax();
 	}
 
 	/* Ack: we are exiting. */
@@ -106,8 +105,10 @@ static int stop_machine(void)
 	}
 
 	/* Wait for them all to come to life. */
-	while (atomic_read(&stopmachine_thread_ack) != stopmachine_num_threads)
+	while (atomic_read(&stopmachine_thread_ack) != stopmachine_num_threads) {
 		yield();
+		cpu_relax();
+	}
 
 	/* If some failed, kill them all. */
 	if (ret < 0) {
