From: tip-bot for Michael Kelley <tipbot@zytor.com>
Subject: [tip:x86/urgent] x86/hyper-v: Enable PIT shutdown quirk
Date: Sun, 4 Nov 2018 02:10:38 -0800
Message-ID: <tip-1de72c706488b7be664a601cf3843bd01e327e58__25298.4890401878$1541327762$gmane$org@git.kernel.org>
References: <1541303219-11142-3-git-send-email-mikelley@microsoft.com>
Reply-To: mingo@kernel.org, mikelley@microsoft.com, jgross@suse.com,
	daniel.lezcano@linaro.org, olaf@aepfle.de, apw@canonical.com,
	virtualization@lists.linux-foundation.org, jasowang@redhat.com,
	akataria@vmware.com, gregkh@linuxfoundation.org,
	devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
	marcelo.cerri@canonical.com, kys@microsoft.com,
	tglx@linutronix.de, hpa@zytor.com, vkuznets@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1541303219-11142-3-git-send-email-mikelley@microsoft.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-tip-commits@vger.kernel.org
Cc: jgross@suse.com, olaf@aepfle.de, gregkh@linuxfoundation.org, daniel.lezcano@linaro.org, akataria@vmware.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, marcelo.cerri@canonical.com, tglx@linutronix.de, hpa@zytor.com, apw@canonical.com, devel@linuxdriverproject.org, mikelley@microsoft.com, mingo@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Commit-ID:  1de72c706488b7be664a601cf3843bd01e327e58
Gitweb:     https://git.kernel.org/tip/1de72c706488b7be664a601cf3843bd01e327e58
Author:     Michael Kelley <mikelley@microsoft.com>
AuthorDate: Sun, 4 Nov 2018 03:48:57 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 4 Nov 2018 11:04:46 +0100

x86/hyper-v: Enable PIT shutdown quirk

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1541303219-11142-3-git-send-email-mikelley@microsoft.com

---
 arch/x86/kernel/cpu/mshyperv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 1c72f3819eb1..e81a2db42df7 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kexec.h>
+#include <linux/i8253.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -295,6 +296,16 @@ static void __init ms_hyperv_init_platform(void)
 	if (efi_enabled(EFI_BOOT))
 		x86_platform.get_nmi_reason = hv_get_nmi_reason;
 
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
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
 	 * Setup the hook to get control post apic initialization.
