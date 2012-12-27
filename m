From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH v3 10/11] drivers/xen: Export vmcoreinfo through sysfs
Date: Thu, 27 Dec 2012 03:18:59 +0100
Message-ID: <1356574740-6806-11-git-send-email-daniel.kiper__13788.4459495128$1356574916$gmane$org@oracle.com>
References: <1356574740-6806-1-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-2-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-3-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-4-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-5-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-6-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-7-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-8-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-9-git-send-email-daniel.kiper@oracle.com>
	<1356574740-6806-10-git-send-email-daniel.kiper@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1356574740-6806-10-git-send-email-daniel.kiper@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: andrew.cooper3@citrix.com, ebiederm@xmission.com, hpa@zytor.com, jbeulich@suse.com, konrad.wilk@oracle.com, maxim.uvarov@oracle.com, mingo@redhat.com, tglx@linutronix.de, vgoyal@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: Daniel Kiper <daniel.kiper@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Export vmcoreinfo through sysfs.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 drivers/xen/sys-hypervisor.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 41 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.c
index 96453f8..9dd290c 100644
--- a/drivers/xen/sys-hypervisor.c
+++ b/drivers/xen/sys-hypervisor.c
@@ -368,6 +368,41 @@ static void xen_properties_destroy(void)
 	sysfs_remove_group(hypervisor_kobj, &xen_properties_group);
 }
 
+#ifdef CONFIG_KEXEC_FIRMWARE
+static ssize_t vmcoreinfo_show(struct hyp_sysfs_attr *attr, char *buffer)
+{
+	return sprintf(buffer, "%lx %lx\n", xen_vmcoreinfo_maddr,
+						xen_vmcoreinfo_max_size);
+}
+
+HYPERVISOR_ATTR_RO(vmcoreinfo);
+
+static int __init xen_vmcoreinfo_init(void)
+{
+	if (!xen_vmcoreinfo_max_size)
+		return 0;
+
+	return sysfs_create_file(hypervisor_kobj, &vmcoreinfo_attr.attr);
+}
+
+static void xen_vmcoreinfo_destroy(void)
+{
+	if (!xen_vmcoreinfo_max_size)
+		return;
+
+	sysfs_remove_file(hypervisor_kobj, &vmcoreinfo_attr.attr);
+}
+#else
+static int __init xen_vmcoreinfo_init(void)
+{
+	return 0;
+}
+
+static void xen_vmcoreinfo_destroy(void)
+{
+}
+#endif
+
 static int __init hyper_sysfs_init(void)
 {
 	int ret;
@@ -390,9 +425,14 @@ static int __init hyper_sysfs_init(void)
 	ret = xen_properties_init();
 	if (ret)
 		goto prop_out;
+	ret = xen_vmcoreinfo_init();
+	if (ret)
+		goto vmcoreinfo_out;
 
 	goto out;
 
+vmcoreinfo_out:
+	xen_properties_destroy();
 prop_out:
 	xen_sysfs_uuid_destroy();
 uuid_out:
@@ -407,12 +447,12 @@ out:
 
 static void __exit hyper_sysfs_exit(void)
 {
+	xen_vmcoreinfo_destroy();
 	xen_properties_destroy();
 	xen_compilation_destroy();
 	xen_sysfs_uuid_destroy();
 	xen_sysfs_version_destroy();
 	xen_sysfs_type_destroy();
-
 }
 module_init(hyper_sysfs_init);
 module_exit(hyper_sysfs_exit);
-- 
1.5.6.5
