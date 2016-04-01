From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 6/6] xen: add xen_pin_vcpu() to support calling functions
	on a dedicated pcpu
Date: Fri,  1 Apr 2016 09:14:34 +0200
Message-ID: <1459494874-12194-7-git-send-email-jgross@suse.com>
References: <1459494874-12194-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1459494874-12194-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, jdelvare@suse.com, konrad.wilk@oracle.com, peterz@infradead.org, hpa@zytor.com, akataria@vmware.com, x86@kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, mingo@redhat.com, david.vrabel@citrix.com, Douglas_Warzecha@dell.com, pali.rohar@gmail.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, linux@roeck-us.net
List-Id: virtualization@lists.linuxfoundation.org

Some hardware models (e.g. Dell Studio 1555 laptops) require calls to
the firmware to be issued on cpu 0 only. As Dom0 might have to use
these calls, add xen_pin_vcpu() to achieve this functionality.

In case either the domain doesn't have the privilege to make the
related hypercall or the hypervisor isn't supporting it, issue a
warning once and disable further pinning attempts.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/enlighten.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 880862c..7907bcf8 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1885,6 +1885,45 @@ static void xen_set_cpu_features(struct cpuinfo_x86 *c)
 	}
 }
 
+static void xen_pin_vcpu(int cpu)
+{
+	static bool disable_pinning;
+	struct sched_pin_override pin_override;
+	int ret;
+
+	if (disable_pinning)
+		return;
+
+	pin_override.pcpu = cpu;
+	ret = HYPERVISOR_sched_op(SCHEDOP_pin_override, &pin_override);
+	if (cpu < 0)
+		return;
+
+	switch (ret) {
+	case -ENOSYS:
+		pr_warn("The kernel tried to call a function on physical cpu %d, but Xen isn't\n"
+			"supporting this. In case of problems you might consider vcpu pinning.\n",
+			cpu);
+		disable_pinning = true;
+		break;
+	case -EPERM:
+		WARN(1, "Trying to pin vcpu without having privilege to do so\n");
+		disable_pinning = true;
+		break;
+	case -EINVAL:
+	case -EBUSY:
+		pr_warn("The kernel tried to call a function on physical cpu %d, but this cpu\n"
+			"seems not to be available. Please check your Xen cpu configuration.\n",
+			cpu);
+		break;
+	case 0:
+		break;
+	default:
+		WARN(1, "rc %d while trying to pin vcpu\n", ret);
+		disable_pinning = true;
+	}
+}
+
 const struct hypervisor_x86 x86_hyper_xen = {
 	.name			= "Xen",
 	.detect			= xen_platform,
@@ -1893,6 +1932,7 @@ const struct hypervisor_x86 x86_hyper_xen = {
 #endif
 	.x2apic_available	= xen_x2apic_para_available,
 	.set_cpu_features       = xen_set_cpu_features,
+	.pin_vcpu               = xen_pin_vcpu,
 };
 EXPORT_SYMBOL(x86_hyper_xen);
 
-- 
2.6.2
