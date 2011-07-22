From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Staging: hv: util: kvp: Fix the reported  OSVersion string
Date: Fri, 22 Jul 2011 10:14:31 -0700
Message-ID: <1311354871-13821-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, OHering@novell.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The current win7 host does not like it when we return the
complete kernel release information. Conform to what the host
expects.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/tools/hv_kvp_daemon.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/tools/hv_kvp_daemon.c b/drivers/staging/hv/tools/hv_kvp_daemon.c
index c230bae..6f3e5c2 100644
--- a/drivers/staging/hv/tools/hv_kvp_daemon.c
+++ b/drivers/staging/hv/tools/hv_kvp_daemon.c
@@ -119,6 +119,15 @@ void kvp_get_os_info(void)
 	os_build = uts_buf.release;
 	processor_arch = uts_buf.machine;
 
+	/*
+	 * The current windows host (win7) expects the build
+	 * string to be of the form: x.y.z
+	 * Strip additional information we may have.
+	 */
+	p = strchr(os_build, '-');
+	if (p)
+		*p = '\0';
+
 	file = fopen("/etc/SuSE-release", "r");
 	if (file != NULL)
 		goto kvp_osinfo_found;
-- 
1.7.4.1
