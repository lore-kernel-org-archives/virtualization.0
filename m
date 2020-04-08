From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 14/26] x86/alternatives: Handle native insns in
 text_poke_loc*()
Date: Tue,  7 Apr 2020 22:03:11 -0700
Message-ID: <20200408050323.4237-15-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: jgross@suse.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, Ankur Arora <ankur.a.arora@oracle.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, vkuznets@redhat.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Intended to handle scenarios where we might want to patch arbitrary
instructions (ex. inlined opcodes in pv_lock_ops.)

Users for native mode (as opposed to emulated) are introduced in
later patches.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/text-patching.h |  4 +-
 arch/x86/kernel/alternative.c        | 61 ++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 04778c2bc34e..c4b2814f2f9d 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -25,10 +25,10 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 
 /*
  * Currently, the max observed size in the kernel code is
- * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
+ * NOP7 for indirect call, which is 7.
  * Raise it if needed.
  */
-#define POKE_MAX_OPCODE_SIZE	5
+#define POKE_MAX_OPCODE_SIZE	7
 
 extern void text_poke_early(void *addr, const void *opcode, size_t len);
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 337aad8c2521..004fe86f463f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -981,8 +981,15 @@ void text_poke_sync(void)
 
 struct text_poke_loc {
 	s32 rel_addr; /* addr := _stext + rel_addr */
-	s32 rel32;
-	u8 opcode;
+	union {
+		struct {
+			s32 rel32;
+			u8 opcode;
+		} emulated;
+		struct {
+			u8 len;
+		} native;
+	};
 	const u8 text[POKE_MAX_OPCODE_SIZE];
 };
 
@@ -990,6 +997,7 @@ struct bp_patching_desc {
 	struct text_poke_loc *vec;
 	int nr_entries;
 	atomic_t refs;
+	bool native;
 };
 
 static struct bp_patching_desc *bp_desc;
@@ -1071,10 +1079,13 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 			goto out_put;
 	}
 
-	len = text_opcode_size(tp->opcode);
+	if (desc->native)
+		BUG();
+
+	len = text_opcode_size(tp->emulated.opcode);
 	ip += len;
 
-	switch (tp->opcode) {
+	switch (tp->emulated.opcode) {
 	case INT3_INSN_OPCODE:
 		/*
 		 * Someone poked an explicit INT3, they'll want to handle it,
@@ -1083,12 +1094,12 @@ int notrace poke_int3_handler(struct pt_regs *regs)
 		goto out_put;
 
 	case CALL_INSN_OPCODE:
-		int3_emulate_call(regs, (long)ip + tp->rel32);
+		int3_emulate_call(regs, (long)ip + tp->emulated.rel32);
 		break;
 
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
-		int3_emulate_jmp(regs, (long)ip + tp->rel32);
+		int3_emulate_jmp(regs, (long)ip + tp->emulated.rel32);
 		break;
 
 	default:
@@ -1134,6 +1145,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 		.vec = tp,
 		.nr_entries = nr_entries,
 		.refs = ATOMIC_INIT(1),
+		.native = false,
 	};
 	unsigned char int3 = INT3_INSN_OPCODE;
 	unsigned int i;
@@ -1161,7 +1173,7 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * Second step: update all but the first byte of the patched range.
 	 */
 	for (do_sync = 0, i = 0; i < nr_entries; i++) {
-		int len = text_opcode_size(tp[i].opcode);
+		int len = text_opcode_size(tp[i].emulated.opcode);
 
 		if (len - INT3_INSN_SIZE > 0) {
 			text_poke(text_poke_addr(&tp[i]) + INT3_INSN_SIZE,
@@ -1205,11 +1217,25 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 }
 
 static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
-			       const void *opcode, size_t len, const void *emulate)
+			       const void *opcode, size_t len,
+			       const void *emulate, bool native)
 {
 	struct insn insn;
 
+	memset((void *)tp, 0, sizeof(*tp));
 	memcpy((void *)tp->text, opcode, len);
+
+	tp->rel_addr = addr - (void *)_stext;
+
+	/*
+	 * Native mode: when we might be poking
+	 * arbitrary (perhaps) multiple instructions.
+	 */
+	if (native) {
+		tp->native.len = (u8)len;
+		return;
+	}
+
 	if (!emulate)
 		emulate = opcode;
 
@@ -1219,31 +1245,30 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 	BUG_ON(!insn_complete(&insn));
 	BUG_ON(len != insn.length);
 
-	tp->rel_addr = addr - (void *)_stext;
-	tp->opcode = insn.opcode.bytes[0];
+	tp->emulated.opcode = insn.opcode.bytes[0];
 
-	switch (tp->opcode) {
+	switch (tp->emulated.opcode) {
 	case INT3_INSN_OPCODE:
 		break;
 
 	case CALL_INSN_OPCODE:
 	case JMP32_INSN_OPCODE:
 	case JMP8_INSN_OPCODE:
-		tp->rel32 = insn.immediate.value;
+		tp->emulated.rel32 = insn.immediate.value;
 		break;
 
 	default: /* assume NOP */
 		switch (len) {
 		case 2: /* NOP2 -- emulate as JMP8+0 */
 			BUG_ON(memcmp(emulate, ideal_nops[len], len));
-			tp->opcode = JMP8_INSN_OPCODE;
-			tp->rel32 = 0;
+			tp->emulated.opcode = JMP8_INSN_OPCODE;
+			tp->emulated.rel32 = 0;
 			break;
 
 		case 5: /* NOP5 -- emulate as JMP32+0 */
 			BUG_ON(memcmp(emulate, ideal_nops[NOP_ATOMIC5], len));
-			tp->opcode = JMP32_INSN_OPCODE;
-			tp->rel32 = 0;
+			tp->emulated.opcode = JMP32_INSN_OPCODE;
+			tp->emulated.rel32 = 0;
 			break;
 
 		default: /* unknown instruction */
@@ -1299,7 +1324,7 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
 	text_poke_flush(addr);
 
 	tp = &tp_vec[tp_vec_nr++];
-	text_poke_loc_init(tp, addr, opcode, len, emulate);
+	text_poke_loc_init(tp, addr, opcode, len, emulate, false);
 }
 
 /**
@@ -1322,7 +1347,7 @@ void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *
 		return;
 	}
 
-	text_poke_loc_init(&tp, addr, opcode, len, emulate);
+	text_poke_loc_init(&tp, addr, opcode, len, emulate, false);
 	text_poke_bp_batch(&tp, 1);
 }
 
-- 
2.20.1
