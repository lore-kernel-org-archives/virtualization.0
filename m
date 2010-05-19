From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 2/2] staging: hv: Add autoloading to hv_utils module
Date: Wed, 19 May 2010 15:56:28 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7266B8931E__17601.0822099217$1274284871$gmane$org@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_1FB5E1D5CA062146B38059374562DF7266B8931ETK5EX14MBXC128r_"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualiz>
List-Id: virtualization@lists.linuxfoundation.org

--_002_1FB5E1D5CA062146B38059374562DF7266B8931ETK5EX14MBXC128r_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Haiyang Zhang <haiyangz@microsoft.com>

Subject: [PATCH 2/2] staging: hv: Add autoloading to hv_utils module
Added autoloading based on pci id and dmi strings.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/hv_utils.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hv_utils.c b/drivers/staging/hv/hv_utils.c
index f9826c7..b831a65 100644
--- a/drivers/staging/hv/hv_utils.c
+++ b/drivers/staging/hv/hv_utils.c
@@ -24,6 +24,8 @@
 #include <linux/slab.h>
 #include <linux/sysctl.h>
 #include <linux/reboot.h>
+#include <linux/dmi.h>
+#include <linux/pci.h>
=20
 #include "logging.h"
 #include "osd.h"
@@ -251,10 +253,37 @@ static void heartbeat_onchannelcallback(void *context=
)
 	DPRINT_EXIT(VMBUS);
 }
=20
+
+static const struct pci_device_id __initconst
+hv_utils_pci_table[] __maybe_unused =3D {
+	{ PCI_DEVICE(0x1414, 0x5353) }, /* Hyper-V emulated VGA controller */
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, hv_utils_pci_table);
+
+
+static const struct dmi_system_id __initconst
+hv_utils_dmi_table[] __maybe_unused  =3D {
+	{
+		.ident =3D "Hyper-V",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
+			DMI_MATCH(DMI_BOARD_NAME, "Virtual Machine"),
+		},
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(dmi, hv_utils_dmi_table);
+
+
 static int __init init_hyperv_utils(void)
 {
 	printk(KERN_INFO "Registering HyperV Utility Driver...\n");
=20
+	if (!dmi_check_system(hv_utils_dmi_table))
+		return -ENODEV;
+
 	/* Wait until all IC channels are initialized */
 	while (atomic_read(&hv_utils_initcnt) < MAX_MSG_TYPES)
 		msleep(100);
--=20
1.6.3.2


--_002_1FB5E1D5CA062146B38059374562DF7266B8931ETK5EX14MBXC128r_
Content-Type: application/octet-stream;
	name="0518-2-Add-autoloading-to-hv_utils-module.patch"
Content-Description: 0518-2-Add-autoloading-to-hv_utils-module.patch
Content-Disposition: attachment;
	filename="0518-2-Add-autoloading-to-hv_utils-module.patch"; size=1768;
	creation-date="Tue, 18 May 2010 22:22:31 GMT";
	modification-date="Tue, 18 May 2010 23:12:16 GMT"
Content-Transfer-Encoding: base64

RnJvbTogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4KClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIHN0YWdpbmc6IGh2OiBBZGQgYXV0b2xvYWRpbmcgdG8gaHZfdXRpbHMgbW9kdWxl
CkFkZGVkIGF1dG9sb2FkaW5nIGJhc2VkIG9uIHBjaSBpZCBhbmQgZG1pIHN0cmluZ3MuCgpTaWdu
ZWQtb2ZmLWJ5OiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPgpTaWduZWQt
b2ZmLWJ5OiBIYW5rIEphbnNzZW4gPGhqYW5zc2VuQG1pY3Jvc29mdC5jb20+CgotLS0KIGRyaXZl
cnMvc3RhZ2luZy9odi9odl91dGlscy5jIHwgICAyOSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwogMSBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9odi9odl91dGlscy5jIGIvZHJpdmVycy9zdGFn
aW5nL2h2L2h2X3V0aWxzLmMKaW5kZXggZjk4MjZjNy4uYjgzMWE2NSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9zdGFnaW5nL2h2L2h2X3V0aWxzLmMKKysrIGIvZHJpdmVycy9zdGFnaW5nL2h2L2h2X3V0
aWxzLmMKQEAgLTI0LDYgKzI0LDggQEAKICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAjaW5jbHVk
ZSA8bGludXgvc3lzY3RsLmg+CiAjaW5jbHVkZSA8bGludXgvcmVib290Lmg+CisjaW5jbHVkZSA8
bGludXgvZG1pLmg+CisjaW5jbHVkZSA8bGludXgvcGNpLmg+CiAKICNpbmNsdWRlICJsb2dnaW5n
LmgiCiAjaW5jbHVkZSAib3NkLmgiCkBAIC0yNTEsMTAgKzI1MywzNyBAQCBzdGF0aWMgdm9pZCBo
ZWFydGJlYXRfb25jaGFubmVsY2FsbGJhY2sodm9pZCAqY29udGV4dCkKIAlEUFJJTlRfRVhJVChW
TUJVUyk7CiB9CiAKKworc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkIF9faW5pdGNv
bnN0Citodl91dGlsc19wY2lfdGFibGVbXSBfX21heWJlX3VudXNlZCA9IHsKKwl7IFBDSV9ERVZJ
Q0UoMHgxNDE0LCAweDUzNTMpIH0sIC8qIEh5cGVyLVYgZW11bGF0ZWQgVkdBIGNvbnRyb2xsZXIg
Ki8KKwl7IDAgfQorfTsKK01PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBodl91dGlsc19wY2lfdGFi
bGUpOworCisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBfX2luaXRjb25zdAor
aHZfdXRpbHNfZG1pX3RhYmxlW10gX19tYXliZV91bnVzZWQgID0geworCXsKKwkJLmlkZW50ID0g
Ikh5cGVyLVYiLAorCQkubWF0Y2hlcyA9IHsKKwkJCURNSV9NQVRDSChETUlfU1lTX1ZFTkRPUiwg
Ik1pY3Jvc29mdCBDb3Jwb3JhdGlvbiIpLAorCQkJRE1JX01BVENIKERNSV9QUk9EVUNUX05BTUUs
ICJWaXJ0dWFsIE1hY2hpbmUiKSwKKwkJCURNSV9NQVRDSChETUlfQk9BUkRfTkFNRSwgIlZpcnR1
YWwgTWFjaGluZSIpLAorCQl9LAorCX0sCisJeyB9LAorfTsKK01PRFVMRV9ERVZJQ0VfVEFCTEUo
ZG1pLCBodl91dGlsc19kbWlfdGFibGUpOworCisKIHN0YXRpYyBpbnQgX19pbml0IGluaXRfaHlw
ZXJ2X3V0aWxzKHZvaWQpCiB7CiAJcHJpbnRrKEtFUk5fSU5GTyAiUmVnaXN0ZXJpbmcgSHlwZXJW
IFV0aWxpdHkgRHJpdmVyLi4uXG4iKTsKIAorCWlmICghZG1pX2NoZWNrX3N5c3RlbShodl91dGls
c19kbWlfdGFibGUpKQorCQlyZXR1cm4gLUVOT0RFVjsKKwogCS8qIFdhaXQgdW50aWwgYWxsIElD
IGNoYW5uZWxzIGFyZSBpbml0aWFsaXplZCAqLwogCXdoaWxlIChhdG9taWNfcmVhZCgmaHZfdXRp
bHNfaW5pdGNudCkgPCBNQVhfTVNHX1RZUEVTKQogCQltc2xlZXAoMTAwKTsKLS0gCjEuNi4zLjIK
Cg==

--_002_1FB5E1D5CA062146B38059374562DF7266B8931ETK5EX14MBXC128r_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--_002_1FB5E1D5CA062146B38059374562DF7266B8931ETK5EX14MBXC128r_--
