From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: [PATCH v2 16/27] compiler: Option to add PROVIDE_HIDDEN replacement
	for weak symbols
Date: Tue, 13 Mar 2018 13:59:34 -0700
Message-ID: <20180313205945.245105-17-thgarnie__18744.2973758609$1520974863$gmane$org@google.com>
References: <20180313205945.245105-1-thgarnie@google.com>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180313205945.245105-1-thgarnie@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Thomas Garnier <thgarnie@google.com>, Arnd Bergmann <arnd@arndb.de>, Philippe Ombredanne <pombredanne@nexb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Matthias Kaehlcke <mka@chromium.org>, Kees Cook <keescook@chromium.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>, Raf
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-sparse@vger.kernel.org, linux-crypto@vger.kernel.org, kernel-hardening@lists.openwall.com, xen-devel@lists.xenproject.org
List-Id: virtualization@lists.linuxfoundation.org

Provide an option to have a PROVIDE_HIDDEN (linker script) entry for
each weak symbol. This option solve an error in x86_64 where the linker
optimizes pie generate code to be non-pie because --emit-relocs was used
instead of -pie (to reduce dynamic relocations).

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 init/Kconfig            |  7 +++++++
 scripts/link-vmlinux.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index c924babc6d47..fe9f9ada4db0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1927,6 +1927,13 @@ config ASN1
 	  inform it as to what tags are to be expected in a stream and what
 	  functions to call on what tags.
 
+config WEAK_PROVIDE_HIDDEN
+	bool
+	help
+	  Generate linker script PROVIDE_HIDDEN entries for all weak symbols. It
+	  allows to prevent non-pie code being replaced by the linker if the
+	  emit-relocs option is used instead of pie (useful for x86_64 pie).
+
 source "kernel/Kconfig.locks"
 
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 08ca08e9105c..c015f5142ecf 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -146,6 +146,17 @@ kallsyms()
 	${CC} ${aflags} -c -o ${2} ${afile}
 }
 
+gen_weak_provide_hidden()
+{
+        if [ -n "${CONFIG_WEAK_PROVIDE_HIDDEN}" ]; then
+                local pattern="s/^\s\+ w \(\w\+\)$/PROVIDE_HIDDEN(\1 = .);/gp"
+                echo -e "SECTIONS {\n. = _end;" > .tmp_vmlinux_hiddenld
+                ${NM} ${1} | sed -n "${pattern}" >> .tmp_vmlinux_hiddenld
+                echo "}" >> .tmp_vmlinux_hiddenld
+                LDFLAGS_vmlinux="${LDFLAGS_vmlinux} -T .tmp_vmlinux_hiddenld"
+        fi
+}
+
 # Create map file with all symbols from ${1}
 # See mksymap for additional details
 mksysmap()
@@ -230,6 +241,9 @@ modpost_link vmlinux.o
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
 
+# Generate weak linker script
+gen_weak_provide_hidden vmlinux.o
+
 kallsymso=""
 kallsyms_vmlinux=""
 if [ -n "${CONFIG_KALLSYMS}" ]; then
-- 
2.16.2.660.g709887971b-goog
