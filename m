From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 10/13] x86/alternative: Support indirect call replacement
Date: Wed,  4 Oct 2017 10:58:31 -0500
Message-ID: <efabcfb022d29fb0a9ccb39380623573555c2bcb.1507128293.git.jpoimboe__48459.127758588$1509079676$gmane$org@redhat.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1507128293.git.jpoimboe@redhat.com>
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
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Add alternative patching support for replacing an instruction with an
indirect call.  This will be needed for the paravirt alternatives.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/alternative.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3344d3382e91..81c577c7deba 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -410,20 +410,28 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		insnbuf_sz = a->replacementlen;
 
 		/*
-		 * 0xe8 is a relative jump; fix the offset.
-		 *
-		 * Instruction length is checked before the opcode to avoid
-		 * accessing uninitialized bytes for zero-length replacements.
+		 * Fix the address offsets for call and jump instructions which
+		 * use PC-relative addressing.
 		 */
 		if (a->replacementlen == 5 && *insnbuf == 0xe8) {
+			/* direct call */
 			*(s32 *)(insnbuf + 1) += replacement - instr;
-			DPRINTK("Fix CALL offset: 0x%x, CALL 0x%lx",
+			DPRINTK("Fix direct CALL offset: 0x%x, CALL 0x%lx",
 				*(s32 *)(insnbuf + 1),
 				(unsigned long)instr + *(s32 *)(insnbuf + 1) + 5);
-		}
 
-		if (a->replacementlen && is_jmp(replacement[0]))
+		} else if (a->replacementlen == 6 && *insnbuf == 0xff &&
+			   *(insnbuf+1) == 0x15) {
+			/* indirect call */
+			*(s32 *)(insnbuf + 2) += replacement - instr;
+			DPRINTK("Fix indirect CALL offset: 0x%x, CALL *0x%lx",
+				*(s32 *)(insnbuf + 2),
+				(unsigned long)instr + *(s32 *)(insnbuf + 2) + 6);
+
+		} else if (a->replacementlen && is_jmp(replacement[0])) {
+			/* direct jump */
 			recompute_jump(a, instr, replacement, insnbuf);
+		}
 
 		if (a->instrlen > a->replacementlen) {
 			add_nops(insnbuf + a->replacementlen,
-- 
2.13.6
