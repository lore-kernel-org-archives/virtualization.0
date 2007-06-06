From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH] paravirt: fix error handling in paravirt_disable_iospace
Date: Wed, 06 Jun 2007 15:34:37 -0700
Message-ID: <4667367D.4090207@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964972AbXFFWft@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

Make sure everything is backed out if it fails.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/kernel/paravirt.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

===================================================================
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -254,8 +254,11 @@ int paravirt_disable_iospace(void)
 	int ret;
 
 	ret = request_resource(&ioport_resource, &reserve_ioports);
-	if (ret == 0)
+	if (ret == 0) {
 		ret = request_resource(&iomem_resource, &reserve_iomem);
+		if (ret)
+			release_resource(&reserve_ioports);
+	}
 
 	return ret;
 }
