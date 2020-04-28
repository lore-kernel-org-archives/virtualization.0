From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 20/75] x86/boot/compressed/64: Call set_sev_encryption_mask
 earlier
Date: Tue, 28 Apr 2020 17:16:30 +0200
Message-ID: <20200428151725.31091-21-joro@8bytes.org>
References: <20200428151725.31091-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200428151725.31091-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

Call set_sev_encryption_mask() while still on the stage 1 #VC-handler,
because the stage 2 handler needs our own page-tables to be set up, to
which calling set_sev_encryption_mask() is a prerequisite.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/head_64.S      | 8 +++++++-
 arch/x86/boot/compressed/ident_map_64.c | 3 ---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index af571127c9ba..940d44149a29 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -534,9 +534,15 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	rep	stosq
 
 /*
- * Load stage2 IDT and switch to our own page-table
+ * If running as an SEV guest, the encryption mask is required in the
+ * page-table setup code below. When the guest also has SEV-ES enabled
+ * set_sev_encryption_mask() will cause #VC exceptions, but the stage2
+ * handler can't map its GHCB because the page-table is not set up yet.
+ * So set up the encryption mask here while still on the stage1 #VC
+ * handler. Then load stage2 IDT and switch to our own page-table.
  */
 	pushq	%rsi
+	call	set_sev_encryption_mask
 	call	load_stage2_idt
 	call	initialize_identity_maps
 	popq	%rsi
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 83385a551f01..6ee089fdc65a 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -107,9 +107,6 @@ static void add_identity_map(unsigned long start, unsigned long end)
 /* Locates and clears a region for a new top level page table. */
 void initialize_identity_maps(void)
 {
-	/* If running as an SEV guest, the encryption mask is required. */
-	set_sev_encryption_mask();
-
 	/* Exclude the encryption mask from __PHYSICAL_MASK */
 	physical_mask &= ~sme_me_mask;
 
-- 
2.17.1
