From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 05/15] x86/paravirt: make paravirt_patch_call() and
	paravirt_patch_jmp() static
Date: Tue, 28 Aug 2018 09:40:16 +0200
Message-ID: <20180828074026.820-6-jgross__5229.9385228709$1535442133$gmane$org@suse.com>
References: <20180828074026.820-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180828074026.820-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com, tglx@linutronix.de
List-Id: virtualization@lists.linuxfoundation.org

paravirt_patch_call() and paravirt_patch_jmp() are used in paravirt.c
only. Convert them to static.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/paravirt_types.h |  6 ------
 arch/x86/kernel/paravirt.c            | 12 ++++++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 4b75acc23b30..7d13197d760b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -373,12 +373,6 @@ extern struct pv_lock_ops pv_lock_ops;
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
-unsigned paravirt_patch_call(void *insnbuf,
-			     const void *target, u16 tgt_clobbers,
-			     unsigned long addr, u16 site_clobbers,
-			     unsigned len);
-unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
-			    unsigned long addr, unsigned len);
 unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 				unsigned long addr, unsigned len);
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index afdb303285f8..1abdbde35049 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -81,10 +81,10 @@ struct branch {
 	u32 delta;
 } __attribute__((packed));
 
-unsigned paravirt_patch_call(void *insnbuf,
-			     const void *target, u16 tgt_clobbers,
-			     unsigned long addr, u16 site_clobbers,
-			     unsigned len)
+static unsigned paravirt_patch_call(void *insnbuf,
+				    const void *target, u16 tgt_clobbers,
+				    unsigned long addr, u16 site_clobbers,
+				    unsigned len)
 {
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
@@ -103,8 +103,8 @@ unsigned paravirt_patch_call(void *insnbuf,
 	return 5;
 }
 
-unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
-			    unsigned long addr, unsigned len)
+static unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
+				   unsigned long addr, unsigned len)
 {
 	struct branch *b = insnbuf;
 	unsigned long delta = (unsigned long)target - (addr+5);
-- 
2.16.4
