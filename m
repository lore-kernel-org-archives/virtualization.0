From: "Sinclair Yeh" <syeh@vmware.com>
Subject: [PATCH 1/6] x86: Add VMWare Host Communication Macros
Date: Tue,  1 Dec 2015 14:18:47 -0800
Message-ID: <1449008332-9394-1-git-send-email-syeh@vmware.com>
References: <1449008047-8252-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1449008047-8252-1-git-send-email-syeh@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Sinclair Yeh <syeh@vmware.com>, Xavier Deguillard <xdeguillard@vmware.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

These macros will be used by multiple VMWare modules for handling
host communication.

v2:
* Keeping only the minimal common platform defines
* added vmware_platform() check function

v3:
* Added new field to handle different hypervisor magic values

Signed-off-by: Sinclair Yeh <syeh@vmware.com>
Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Reviewed-by: Alok N Kataria <akataria@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alok Kataria <akataria@vmware.com>
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: Xavier Deguillard <xdeguillard@vmware.com>
---
 arch/x86/include/asm/vmware.h | 110 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 arch/x86/include/asm/vmware.h

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
new file mode 100644
index 0000000..32bf99b
--- /dev/null
+++ b/arch/x86/include/asm/vmware.h
@@ -0,0 +1,110 @@
+/*
+ * Copyright (C) 2015, VMware, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * Based on code from vmware.c and vmmouse.c.
+ * Author:
+ *   Sinclair Yeh <syeh@vmware.com>
+ */
+#ifndef _ASM_X86_VMWARE_H
+#define _ASM_X86_VMWARE_H
+
+
+/**
+ * Hypervisor-specific bi-directional communication channel.  Should never
+ * execute on bare metal hardware.  The caller must make sure to check for
+ * supported hypervisor before using these macros.
+ *
+ * Several of the parameters are both input and output and must be initialized.
+ *
+ * @in1: [IN] Message Len or Message Cmd (HB)
+ * @in2: [IN] Message Len (HB) or Message Cmd
+ * @port_num: [IN] port number + [channel id]
+ * @magic: [IN] hypervisor magic value
+ * @eax: [OUT] value of EAX register
+ * @ebx: [OUT] e.g. status from an HB message status command
+ * @ecx: [OUT] e.g. status from a non-HB message status command
+ * @edx: [OUT] e.g. channel id
+ * @si: [INOUT] set to 0 if not used
+ * @di: [INOUT] set to 0 if not used
+ * @bp: [INOUT] set to 0 if not used
+ */
+#define VMW_PORT(in1, in2, port_num, magic, eax, ebx, ecx, edx, si, di) \
+({                                                                      \
+	__asm__ __volatile__ ("inl %%dx" :                              \
+		"=a"(eax),                                              \
+		"=b"(ebx),                                              \
+		"=c"(ecx),                                              \
+		"=d"(edx),                                              \
+		"=S"(si),                                               \
+		"=D"(di) :                                              \
+		"a"(magic),                                             \
+		"b"(in1),                                               \
+		"c"(in2),                                               \
+		"d"(port_num),                                          \
+		"S"(si),                                                \
+		"D"(di) :                                               \
+		"memory");                                              \
+})
+
+
+#define VMW_PORT_HB_OUT(in1, in2, port_num, magic,      \
+			eax, ebx, ecx, edx, si, di, bp) \
+({                                                      \
+	__asm__ __volatile__ ("movq %13, %%rbp;"        \
+		"cld; rep outsb; "                      \
+		"movq %%rbp, %6" :                      \
+		"=a"(eax),                              \
+		"=b"(ebx),                              \
+		"=c"(ecx),                              \
+		"=d"(edx),                              \
+		"=S"(si),                               \
+		"=D"(di),                               \
+		"=r"(bp) :                              \
+		"a"(magic),                             \
+		"b"(in1),                               \
+		"c"(in2),                               \
+		"d"(port_num),                          \
+		"S"(si),                                \
+		"D"(di),                                \
+		"r"(bp) :                               \
+		"memory", "cc");                        \
+})
+
+
+#define VMW_PORT_HB_IN(in1, in2, port_num, magic,            \
+		       eax, ebx, ecx, edx, si, di, bp)       \
+({                                                           \
+	__asm__ __volatile__ ("push %%rbp; movq %13, %%rbp;" \
+		"cld; rep insb; "                            \
+		"movq %%rbp, %6;pop %%rbp" :                 \
+		"=a"(eax),                                   \
+		"=b"(ebx),                                   \
+		"=c"(ecx),                                   \
+		"=d"(edx),                                   \
+		"=S"(si),                                    \
+		"=D"(di),                                    \
+		"=r"(bp) :                                   \
+		"a"(magic),                                  \
+		"b"(in1),                                    \
+		"c"(in2),                                    \
+		"d"(port_num),                               \
+		"S"(si),                                     \
+		"D"(di),                                     \
+		"r"(bp) :                                    \
+		"memory", "cc");                             \
+})
+
+
+#endif
+
-- 
1.9.1
