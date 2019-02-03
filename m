From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.16 140/305] x86/hyper-v: Enable PIT shutdown quirk
Date: Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.833541284__3808.29356597445$1549341485$gmane$org@decadent.org.uk>
References: <lsq.1549201507.384106140@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "jgross@suse.com" <jgross@suse.com>, "olaf@aepfle.de" <olaf@aepfle.de>, Michael Kelley <mikelley@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Denis Kirjanov <kda@linux-powerpc.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "apw@canonical.com" <apw@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, akpm@linux-foundation.org, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "akataria@vmware.com" <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mikelley@microsoft.com>

commit 1de72c706488b7be664a601cf3843bd01e327e58 upstream.

Hyper-V emulation of the PIT has a quirk such that the normal PIT shutdown
path doesn't work, because clearing the counter register restarts the
timer.

Disable the counter clearing on PIT shutdown.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "jgross@suse.com" <jgross@suse.com>
Cc: "akataria@vmware.com" <akataria@vmware.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>
Cc: "apw@canonical.com" <apw@canonical.com>
Cc: vkuznets <vkuznets@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Cc: KY Srinivasan <kys@microsoft.com>
Link: https://lkml.kernel.org/r/1541303219-11142-3-git-send-email-mikelley@microsoft.com
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/mshyperv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -18,6 +18,7 @@
 #include <linux/efi.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/i8253.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv.h>
@@ -143,6 +144,16 @@ static void __init ms_hyperv_init_platfo
 	no_timer_check = 1;
 #endif
 
+	/*
+	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
+	 * counter register during PIT shutdown restarts the PIT. So it
+	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
+	 * to false tells pit_shutdown() not to zero the counter so that
+	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
+	 * and setting this value has no effect.
+	 */
+	i8253_clear_counter_on_shutdown = false;
+
 }
 
 const __refconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
