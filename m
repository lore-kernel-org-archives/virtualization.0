From: "Sinclair Yeh" <syeh@vmware.com>
Subject: [PATCH 1/6] x86: Add VMWare Host Communication Macros
Date: Tue, 19 Jan 2016 13:46:00 -0800
Message-ID: <1453239965-1466-2-git-send-email-syeh@vmware.com>
References: <1449271183-1746-1-git-send-email-syeh@vmware.com>
	<1453239965-1466-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1453239965-1466-1-git-send-email-syeh@vmware.com>
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
Cc: Sinclair Yeh <syeh@vmware.com>, Xavier Deguillard <xdeguillard@vmware.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

These macros will be used by multiple VMWare modules for handling
host communication.

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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---

v2:
* Keeping only the minimal common platform defines
* added vmware_platform() check function

v3:
* Added new field to handle different hypervisor magic values

v4:
* Make it so that "cmd" is always the first parameter for both
  High-Bandwidh and non-High-Bandwidth version of the macro
* Addressed comments from H. Peter Anvin on the assembly code

v5:
* Separate SI/DI as independent input/output arguments, given
  the latest update to vmw_balloon.c
---
 arch/x86/include/asm/vmware.h | 138 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 arch/x86/include/asm/vmware.h

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
new file mode 100644
index 0000000..7d02a2b
--- /dev/null
+++ b/arch/x86/include/asm/vmware.h
@@ -0,0 +1,138 @@
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
+ * The last two parameters are both input and output and must be initialized.
+ *
+ * @cmd: [IN] Message Cmd
+ * @in_ebx: [IN] Message Len, through EBX
+ * @in_si: [IN] Input argument through SI, set to 0 if not used
+ * @in_di: [IN] Input argument through DI, set ot 0 if not used
+ * @port_num: [IN] port number + [channel id]
+ * @magic: [IN] hypervisor magic value
+ * @eax: [OUT] value of EAX register
+ * @ebx: [OUT] e.g. status from an HB message status command
+ * @ecx: [OUT] e.g. status from a non-HB message status command
+ * @edx: [OUT] e.g. channel id
+ * @si:  [OUT]
+ * @di:  [OUT]
+ */
+#define VMW_PORT(cmd, in_ebx, in_si, in_di,	\
+		 port_num, magic,		\
+		 eax, ebx, ecx, edx, si, di)	\
+({						\
+	asm volatile ("inl %%dx, %%eax;" :	\
+		"=a"(eax),			\
+		"=b"(ebx),			\
+		"=c"(ecx),			\
+		"=d"(edx),			\
+		"=S"(si),			\
+		"=D"(di) :			\
+		"a"(magic),			\
+		"b"(in_ebx),			\
+		"c"(cmd),			\
+		"d"(port_num),			\
+		"S"(in_si),			\
+		"D"(in_di) :			\
+		"memory");			\
+})
+
+
+/**
+ * Hypervisor-specific bi-directional communication channel.  Should never
+ * execute on bare metal hardware.  The caller must make sure to check for
+ * supported hypervisor before using these macros.
+ *
+ * The last 3 parameters are both input and output and must be initialized.
+ *
+ * @cmd: [IN] Message Cmd
+ * @in_ecx: [IN] Message Len, through ECX
+ * @in_si: [IN] Input argument through SI, set to 0 if not used
+ * @in_di: [IN] Input argument through DI, set to 0 if not used
+ * @port_num: [IN] port number + [channel id]
+ * @magic: [IN] hypervisor magic value
+ * @eax: [OUT] value of EAX register
+ * @ebx: [OUT] e.g. status from an HB message status command
+ * @ecx: [OUT] e.g. status from a non-HB message status command
+ * @edx: [OUT] e.g. channel id
+ * @si:  [OUT]
+ * @di:  [OUT]
+ * @bp:  [INOUT] set to 0 if not used
+ */
+#define VMW_PORT_HB_OUT(cmd, in_ecx, in_si, in_di,	\
+			port_num, magic,		\
+			eax, ebx, ecx, edx, si, di, bp)	\
+({							\
+	asm volatile ("push %%rbp;"			\
+		"xchgq %6, %%rbp;"			\
+		"rep outsb;"				\
+		"xchgq %%rbp, %6;"			\
+		"pop %%rbp;" :				\
+		"=a"(eax),				\
+		"=b"(ebx),				\
+		"=c"(ecx),				\
+		"=d"(edx),				\
+		"=S"(si),				\
+		"=D"(di),				\
+		"+r"(bp) :				\
+		"a"(magic),				\
+		"b"(cmd),				\
+		"c"(in_ecx),				\
+		"d"(port_num),				\
+		"S"(in_si),				\
+		"D"(in_di) :				\
+		"memory", "cc");			\
+})
+
+
+#define VMW_PORT_HB_IN(cmd, in_ecx, in_si, in_di,	\
+		       port_num, magic,			\
+		       eax, ebx, ecx, edx, si, di, bp)	\
+({							\
+	asm volatile ("push %%rbp;"			\
+		"xchgq %6, %%rbp;"			\
+		"rep insb;"				\
+		"xchgq %%rbp, %6;"			\
+		"pop %%rbp" :				\
+		"=a"(eax),				\
+		"=b"(ebx),				\
+		"=c"(ecx),				\
+		"=d"(edx),				\
+		"=S"(si),				\
+		"=D"(di),				\
+		"+r"(bp) :				\
+		"a"(magic),				\
+		"b"(cmd),				\
+		"c"(in_ecx),				\
+		"d"(port_num),				\
+		"S"(in_si),				\
+		"D"(in_di) :				\
+		"memory", "cc");			\
+})
+
+
+#endif
+
-- 
1.9.1
