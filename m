From: Vaughan Cao <vaughan.cao@oracle.com>
Subject: [PATCH] xen: initialize xen panic handler for PVHVM
Date: Fri, 16 Aug 2013 16:10:56 +0800
Message-ID: <1376640656-32381-1-git-send-email-vaughan.cao__40695.1861842119$1376666984$gmane$org@oracle.com>
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
To: konrad.wilk@oracle.com, jeremy@goop.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: vaughan.cao@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

kernel use callback linked in panic_notifier_list to notice others when panic
happens.
NORET_TYPE void panic(const char * fmt, ...){
    ...
    atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
}
When xen aware this, it will call xen_reboot(SHUTDOWN_crash) to send out an
event with reason code - SHUTDOWN_crash.
xen_panic_handler_init() is defined to register on panic_notifier_list but
we only call it in xen_arch_setup which only be called by pvm, this patch is
 necessary for pvhvm.

Signed-off-by: Vaughan Cao <vaughan.cao@oracle.com>
---
 arch/x86/xen/enlighten.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 4aec5ed..53e5726 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1713,6 +1713,8 @@ static void __init xen_hvm_guest_init(void)
 
 	xen_hvm_init_shared_info();
 
+	xen_panic_handler_init();
+
 	if (xen_feature(XENFEAT_hvm_callback_vector))
 		xen_have_vector_callback = 1;
 	xen_hvm_smp_init();
-- 
1.7.11.7
