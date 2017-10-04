From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [RFC v3 21/27] x86/mm/dump_pagetables: Fix address markers index on
	x86_64
Date: Wed,  4 Oct 2017 14:19:57 -0700
Message-ID: <20171004212003.28296-22-thgarnie__4019.79345265335$1509079953$gmane$org@google.com>
References: <20171004212003.28296-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171004212003.28296-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Garnier <thgarnie@google.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>Bor
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

The address_markers_idx enum is not aligned with the table when EFI is
enabled. Add an EFI_VA_END_NR entry in this case.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/mm/dump_pagetables.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 5e3ac6fe6c9e..8691a57da63e 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -52,12 +52,15 @@ enum address_markers_idx {
 	LOW_KERNEL_NR,
 	VMALLOC_START_NR,
 	VMEMMAP_START_NR,
-#ifdef CONFIG_KASAN
+# ifdef CONFIG_KASAN
 	KASAN_SHADOW_START_NR,
 	KASAN_SHADOW_END_NR,
-#endif
+# endif
 # ifdef CONFIG_X86_ESPFIX64
 	ESPFIX_START_NR,
+# endif
+# ifdef CONFIG_EFI
+	EFI_VA_END_NR,
 # endif
 	HIGH_KERNEL_NR,
 	MODULES_VADDR_NR,
-- 
2.14.2.920.gcf0c67979c-goog
