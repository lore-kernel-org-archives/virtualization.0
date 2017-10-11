From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH v1 26/27] x86/relocs: Add option to generate 64-bit relocations
Date: Wed, 11 Oct 2017 13:30:26 -0700
Message-ID: <20171011203027.11248-27-thgarnie__38911.3178629943$1509080471$gmane$org@google.com>
References: <20171011203027.11248-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171011203027.11248-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Garnier <thgarnie@google.com>, Kees Cook <keescook@chromium.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Matthias Kaehlcke <mka@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, Andy Lutomirski <luto@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov <bp@suse.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.>
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

The x86 relocation tool generates a list of 32-bit signed integers. There
was no need to use 64-bit integers because all addresses where above the 2G
top of the memory.

This change add a large-reloc option to generate 64-bit unsigned integers.
It can be used when the kernel plan to go below the top 2G and 32-bit
integers are not enough.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/tools/relocs.c        | 60 +++++++++++++++++++++++++++++++++---------
 arch/x86/tools/relocs.h        |  4 +--
 arch/x86/tools/relocs_common.c | 15 +++++++----
 3 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index bc032ad88b22..e7497ea1fe76 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -12,8 +12,14 @@
 
 static Elf_Ehdr ehdr;
 
+#if ELF_BITS == 64
+typedef uint64_t rel_off_t;
+#else
+typedef uint32_t rel_off_t;
+#endif
+
 struct relocs {
-	uint32_t	*offset;
+	rel_off_t	*offset;
 	unsigned long	count;
 	unsigned long	size;
 };
@@ -684,7 +690,7 @@ static void print_absolute_relocs(void)
 		printf("\n");
 }
 
-static void add_reloc(struct relocs *r, uint32_t offset)
+static void add_reloc(struct relocs *r, rel_off_t offset)
 {
 	if (r->count == r->size) {
 		unsigned long newsize = r->size + 50000;
@@ -1058,26 +1064,48 @@ static void sort_relocs(struct relocs *r)
 	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
 }
 
-static int write32(uint32_t v, FILE *f)
+static int write32(rel_off_t rel, FILE *f)
 {
-	unsigned char buf[4];
+	unsigned char buf[sizeof(uint32_t)];
+	uint32_t v = (uint32_t)rel;
 
 	put_unaligned_le32(v, buf);
-	return fwrite(buf, 1, 4, f) == 4 ? 0 : -1;
+	return fwrite(buf, 1, sizeof(buf), f) == sizeof(buf) ? 0 : -1;
 }
 
-static int write32_as_text(uint32_t v, FILE *f)
+static int write32_as_text(rel_off_t rel, FILE *f)
 {
+	uint32_t v = (uint32_t)rel;
 	return fprintf(f, "\t.long 0x%08"PRIx32"\n", v) > 0 ? 0 : -1;
 }
 
-static void emit_relocs(int as_text, int use_real_mode)
+static int write64(rel_off_t rel, FILE *f)
+{
+	unsigned char buf[sizeof(uint64_t)];
+	uint64_t v = (uint64_t)rel;
+
+	put_unaligned_le64(v, buf);
+	return fwrite(buf, 1, sizeof(buf), f) == sizeof(buf) ? 0 : -1;
+}
+
+static int write64_as_text(rel_off_t rel, FILE *f)
+{
+	uint64_t v = (uint64_t)rel;
+	return fprintf(f, "\t.quad 0x%016"PRIx64"\n", v) > 0 ? 0 : -1;
+}
+
+static void emit_relocs(int as_text, int use_real_mode, int use_large_reloc)
 {
 	int i;
-	int (*write_reloc)(uint32_t, FILE *) = write32;
+	int (*write_reloc)(rel_off_t, FILE *);
 	int (*do_reloc)(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 			const char *symname);
 
+	if (use_large_reloc)
+		write_reloc = write64;
+	else
+		write_reloc = write32;
+
 #if ELF_BITS == 64
 	if (!use_real_mode)
 		do_reloc = do_reloc64;
@@ -1088,6 +1116,9 @@ static void emit_relocs(int as_text, int use_real_mode)
 		do_reloc = do_reloc32;
 	else
 		do_reloc = do_reloc_real;
+
+	/* Large relocations only for 64-bit */
+	use_large_reloc = 0;
 #endif
 
 	/* Collect up the relocations */
@@ -1111,8 +1142,13 @@ static void emit_relocs(int as_text, int use_real_mode)
 		 * gas will like.
 		 */
 		printf(".section \".data.reloc\",\"a\"\n");
-		printf(".balign 4\n");
-		write_reloc = write32_as_text;
+		if (use_large_reloc) {
+			printf(".balign 8\n");
+			write_reloc = write64_as_text;
+		} else {
+			printf(".balign 4\n");
+			write_reloc = write32_as_text;
+		}
 	}
 
 	if (use_real_mode) {
@@ -1180,7 +1216,7 @@ static void print_reloc_info(void)
 
 void process(FILE *fp, int use_real_mode, int as_text,
 	     int show_absolute_syms, int show_absolute_relocs,
-	     int show_reloc_info)
+	     int show_reloc_info, int use_large_reloc)
 {
 	regex_init(use_real_mode);
 	read_ehdr(fp);
@@ -1203,5 +1239,5 @@ void process(FILE *fp, int use_real_mode, int as_text,
 		print_reloc_info();
 		return;
 	}
-	emit_relocs(as_text, use_real_mode);
+	emit_relocs(as_text, use_real_mode, use_large_reloc);
 }
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 1d23bf953a4a..cb771cc4412d 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -30,8 +30,8 @@ enum symtype {
 
 void process_32(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int use_large_reloc);
 void process_64(FILE *fp, int use_real_mode, int as_text,
 		int show_absolute_syms, int show_absolute_relocs,
-		int show_reloc_info);
+		int show_reloc_info, int use_large_reloc);
 #endif /* RELOCS_H */
diff --git a/arch/x86/tools/relocs_common.c b/arch/x86/tools/relocs_common.c
index acab636bcb34..9cf1391af50a 100644
--- a/arch/x86/tools/relocs_common.c
+++ b/arch/x86/tools/relocs_common.c
@@ -11,14 +11,14 @@ void die(char *fmt, ...)
 
 static void usage(void)
 {
-	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode]" \
-	    " vmlinux\n");
+	die("relocs [--abs-syms|--abs-relocs|--reloc-info|--text|--realmode|" \
+	    "--large-reloc]  vmlinux\n");
 }
 
 int main(int argc, char **argv)
 {
 	int show_absolute_syms, show_absolute_relocs, show_reloc_info;
-	int as_text, use_real_mode;
+	int as_text, use_real_mode, use_large_reloc;
 	const char *fname;
 	FILE *fp;
 	int i;
@@ -29,6 +29,7 @@ int main(int argc, char **argv)
 	show_reloc_info = 0;
 	as_text = 0;
 	use_real_mode = 0;
+	use_large_reloc = 0;
 	fname = NULL;
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
@@ -53,6 +54,10 @@ int main(int argc, char **argv)
 				use_real_mode = 1;
 				continue;
 			}
+			if (strcmp(arg, "--large-reloc") == 0) {
+				use_large_reloc = 1;
+				continue;
+			}
 		}
 		else if (!fname) {
 			fname = arg;
@@ -74,11 +79,11 @@ int main(int argc, char **argv)
 	if (e_ident[EI_CLASS] == ELFCLASS64)
 		process_64(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, use_large_reloc);
 	else
 		process_32(fp, use_real_mode, as_text,
 			   show_absolute_syms, show_absolute_relocs,
-			   show_reloc_info);
+			   show_reloc_info, use_large_reloc);
 	fclose(fp);
 	return 0;
 }
-- 
2.15.0.rc0.271.g36b669edcc-goog
