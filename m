From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/1] staging: hv: Fix Kconfig dependency of hv_blkvsc
Date: Fri, 23 Jul 2010 21:24:42 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7280E610A2__20492.6378596157$1279920336$gmane$org@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_1FB5E1D5CA062146B38059374562DF7280E610A2TK5EX14MBXC126r_"
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
Cc: vrataj2 <vrataj2@comcast.net>
List-Id: virtualization@lists.linuxfoundation.org

--_002_1FB5E1D5CA062146B38059374562DF7280E610A2TK5EX14MBXC126r_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Haiyang Zhang <haiyangz@microsoft.com>

Subject: staging: hv: Fix Kconfig dependency of hv_blkvsc
LBDAF is not available nor necessary on 64BIT kernel. This patch
fixed the dependency for hv_blkvsc module on 64BIT kernel.
Thanks vrataj2 [vrataj2@comcast.net] for reporting this problem.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/Kconfig b/drivers/staging/hv/Kconfig
index 97480f5..7455c80 100644
--- a/drivers/staging/hv/Kconfig
+++ b/drivers/staging/hv/Kconfig
@@ -17,7 +17,7 @@ config HYPERV_STORAGE
=20
 config HYPERV_BLOCK
 	tristate "Microsoft Hyper-V virtual block driver"
-	depends on BLOCK && SCSI && LBDAF
+	depends on BLOCK && SCSI && (LBDAF || 64BIT)
 	default HYPERV
 	help
 	  Select this option to enable the Hyper-V virtual block driver.
--=20
1.6.3.2


--_002_1FB5E1D5CA062146B38059374562DF7280E610A2TK5EX14MBXC126r_
Content-Type: application/octet-stream;
	name="0723-Fix-Kconfig-dependency-of-hv_blkvsc.patch"
Content-Description: 0723-Fix-Kconfig-dependency-of-hv_blkvsc.patch
Content-Disposition: attachment;
	filename="0723-Fix-Kconfig-dependency-of-hv_blkvsc.patch"; size=992;
	creation-date="Fri, 23 Jul 2010 18:17:04 GMT";
	modification-date="Fri, 23 Jul 2010 21:22:18 GMT"
Content-Transfer-Encoding: base64

RnJvbTogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4NCg0KU3ViamVjdDog
c3RhZ2luZzogaHY6IEZpeCBLY29uZmlnIGRlcGVuZGVuY3kgb2YgaHZfYmxrdnNjDQpMQkRBRiBp
cyBub3QgYXZhaWxhYmxlIG5vciBuZWNlc3Nhcnkgb24gNjRCSVQga2VybmVsLiBUaGlzIHBhdGNo
DQpmaXhlZCB0aGUgZGVwZW5kZW5jeSBmb3IgaHZfYmxrdnNjIG1vZHVsZSBvbiA2NEJJVCBrZXJu
ZWwuDQpUaGFua3MgdnJhdGFqMiBbdnJhdGFqMkBjb21jYXN0Lm5ldF0gZm9yIHJlcG9ydGluZyB0
aGlzIHByb2JsZW0uDQoNClNpZ25lZC1vZmYtYnk6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1p
Y3Jvc29mdC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBIYW5rIEphbnNzZW4gPGhqYW5zc2VuQG1pY3Jv
c29mdC5jb20+DQoNCi0tLQ0KIGRyaXZlcnMvc3RhZ2luZy9odi9LY29uZmlnIHwgICAgMiArLQ0K
IDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2h2L0tjb25maWcgYi9kcml2ZXJzL3N0YWdpbmcvaHYv
S2NvbmZpZw0KaW5kZXggOTc0ODBmNS4uNzQ1NWM4MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3Rh
Z2luZy9odi9LY29uZmlnDQorKysgYi9kcml2ZXJzL3N0YWdpbmcvaHYvS2NvbmZpZw0KQEAgLTE3
LDcgKzE3LDcgQEAgY29uZmlnIEhZUEVSVl9TVE9SQUdFDQogDQogY29uZmlnIEhZUEVSVl9CTE9D
Sw0KIAl0cmlzdGF0ZSAiTWljcm9zb2Z0IEh5cGVyLVYgdmlydHVhbCBibG9jayBkcml2ZXIiDQot
CWRlcGVuZHMgb24gQkxPQ0sgJiYgU0NTSSAmJiBMQkRBRg0KKwlkZXBlbmRzIG9uIEJMT0NLICYm
IFNDU0kgJiYgKExCREFGIHx8IDY0QklUKQ0KIAlkZWZhdWx0IEhZUEVSVg0KIAloZWxwDQogCSAg
U2VsZWN0IHRoaXMgb3B0aW9uIHRvIGVuYWJsZSB0aGUgSHlwZXItViB2aXJ0dWFsIGJsb2NrIGRy
aXZlci4NCi0tIA0KMS42LjMuMg0KDQo=

--_002_1FB5E1D5CA062146B38059374562DF7280E610A2TK5EX14MBXC126r_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--_002_1FB5E1D5CA062146B38059374562DF7280E610A2TK5EX14MBXC126r_--
