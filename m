From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [PATCH 2/9] define ELF notes for adding to a boot image
Date: Wed, 20 Jun 2007 16:17:28 -0700
Message-ID: <20070620231852.545716163@goop.org>
References: <20070620231726.834538992@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=elf-bootnotes.patch
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
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, v12n <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>

---
 include/linux/elf_boot.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

===================================================================
--- /dev/null
+++ b/include/linux/elf_boot.h
@@ -0,0 +1,15 @@
+#ifndef ELF_BOOT_H
+#define ELF_BOOT_H
+
+/* Elf notes to help bootloaders identify what program they are booting.
+ */
+
+/* Standardized Elf image notes for booting... The name for all of these is ELFBoot */
+#define ELF_NOTE_BOOT		"ELFBoot"
+
+#define EIN_PROGRAM_NAME	1 /* The program in this ELF file */
+#define EIN_PROGRAM_VERSION	2 /* The version of the program in this ELF file */
+#define EIN_PROGRAM_CHECKSUM	3 /* ip style checksum of the memory image. */
+#define EIN_ARGUMENT_STYLE	4 /* String identifying argument passing style */
+
+#endif /* ELF_BOOT_H */

-- 
