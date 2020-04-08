From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 03/26] x86/paravirt: PVRTOP macros for PARAVIRT_RUNTIME
Date: Tue,  7 Apr 2020 22:03:00 -0700
Message-ID: <20200408050323.4237-4-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Define PVRT* macros which can be used to put pv-ops in
.parainstructions.runtime.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/paravirt_types.h | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 00e4a062ca10..f1153f53c529 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -337,6 +337,12 @@ struct paravirt_patch_template {
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
 
+#ifdef CONFIG_PARAVIRT_RUNTIME
+#define PVRT_SUFFIX ".runtime"
+#else
+#define PVRT_SUFFIX ""
+#endif
+
 /* Sub-section for .parainstructions */
 #define PV_SUFFIX ""
 
@@ -693,6 +699,49 @@ int paravirt_disable_iospace(void);
 #define PVOP_VCALL4(op, arg1, arg2, arg3, arg4)				\
 	_PVOP_VCALL4(PV_SUFFIX, op, arg1, arg2, arg3, arg4)
 
+/*
+ * PVRTOP macros for .parainstructions.runtime
+ */
+#define PVRTOP_CALL0(rettype, op)					\
+	_PVOP_CALL0(PVRT_SUFFIX, rettype, op)
+#define PVRTOP_VCALL0(op)						\
+	_PVOP_VCALL0(PVRT_SUFFIX, op)
+
+#define PVRTOP_CALLEE0(rettype, op)					\
+	_PVOP_CALLEE0(PVRT_SUFFIX, rettype, op)
+#define PVRTOP_VCALLEE0(op)						\
+	_PVOP_VCALLEE0(PVRT_SUFFIX, op)
+
+#define PVRTOP_CALL1(rettype, op, arg1)					\
+	_PVOP_CALL1(PVRT_SUFFIX, rettype, op, arg1)
+#define PVRTOP_VCALL1(op, arg1)						\
+	_PVOP_VCALL1(PVRT_SUFFIX, op, arg1)
+
+#define PVRTOP_CALLEE1(rettype, op, arg1)				\
+	_PVOP_CALLEE1(PVRT_SUFFIX, rettype, op, arg1)
+#define PVRTOP_VCALLEE1(op, arg1)					\
+	_PVOP_VCALLEE1(PVRT_SUFFIX, op, arg1)
+
+#define PVRTOP_CALL2(rettype, op, arg1, arg2)				\
+	_PVOP_CALL2(PVRT_SUFFIX, rettype, op, arg1, arg2)
+#define PVRTOP_VCALL2(op, arg1, arg2)					\
+	_PVOP_VCALL2(PVRT_SUFFIX, op, arg1, arg2)
+
+#define PVRTOP_CALLEE2(rettype, op, arg1, arg2)				\
+	_PVOP_CALLEE2(PVRT_SUFFIX, rettype, op, arg1, arg2)
+#define PVRTOP_VCALLEE2(op, arg1, arg2)					\
+	_PVOP_VCALLEE2(PVRT_SUFFIX, op, arg1, arg2)
+
+#define PVRTOP_CALL3(rettype, op, arg1, arg2, arg3)			\
+	_PVOP_CALL3(PVRT_SUFFIX, rettype, op, arg1, arg2, arg3)
+#define PVRTOP_VCALL3(op, arg1, arg2, arg3)				\
+	_PVOP_VCALL3(PVRT_SUFFIX, op, arg1, arg2, arg3)
+
+#define PVRTOP_CALL4(rettype, op, arg1, arg2, arg3, arg4)		\
+	_PVOP_CALL4(PVRT_SUFFIX, rettype, op, arg1, arg2, arg3, arg4)
+#define PVRTOP_VCALL4(op, arg1, arg2, arg3, arg4)			\
+	_PVOP_VCALL4(PVRT_SUFFIX, op, arg1, arg2, arg3, arg4)
+
 /* Lazy mode for batching updates / context switch */
 enum paravirt_lazy_mode {
 	PARAVIRT_LAZY_NONE,
-- 
2.20.1
