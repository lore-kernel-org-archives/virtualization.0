From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 06/10] add WEAK() for creating weak asm labels
Date: Thu, 14 Jun 2007 17:48:24 -0700
Message-ID: <20070615005013.190869383__21684.835109818$1181919202$gmane$org@goop.org>
References: <20070615004818.424726597@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=weak-linkage.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Xen-Devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, v12n <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 include/linux/linkage.h |    6 ++++++
 1 file changed, 6 insertions(+)

===================================================================
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -34,6 +34,12 @@
   name:
 #endif
 
+#ifndef WEAK
+#define WEAK(name)	   \
+	.weak name;	   \
+	name:
+#endif
+
 #define KPROBE_ENTRY(name) \
   .pushsection .kprobes.text, "ax"; \
   ENTRY(name)

-- 
