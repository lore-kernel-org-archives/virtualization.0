From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH] x86, paravirt: BUG_ON on {rd,wr}msr exceptions
Date: Mon, 28 Jul 2014 16:04:38 -0300
Message-ID: <1406574278-23946-1-git-send-email-ehabkost@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

When CONFIG_PARAVIRT is enabled, the kernel is ignoring exceptions on
the {rd,wr}msr instructions. This makes serious issues (either on the
guest kernel, or on the host) be silently ignored, and is different from
the native MSR code (which does not ignore the exceptions).

As paravirt.h already includes linux/bug.h, I don't see what was the
original issue preventing BUG_ON from being used.

Change rdmsr(), wrmsr(), and rdmsrl() to BUG_ON() on errors.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
* Build-tested using allyesconfig, with no build errors.

* Tested by being able to detect the following host bug:
  https://bugzilla.redhat.com/show_bug.cgi?id=1025868
  (#GP exception on wrmsr(0x410, 0xfffffffffffffbff) during MCE
  initialization)
---
 arch/x86/include/asm/paravirt.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cd6e161..7d42ca4 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -133,24 +133,27 @@ static inline int paravirt_write_msr(unsigned msr, unsigned low, unsigned high)
 	return PVOP_CALL3(int, pv_cpu_ops.write_msr, msr, low, high);
 }
 
-/* These should all do BUG_ON(_err), but our headers are too tangled. */
 #define rdmsr(msr, val1, val2)			\
 do {						\
 	int _err;				\
 	u64 _l = paravirt_read_msr(msr, &_err);	\
+	BUG_ON(_err);				\
 	val1 = (u32)_l;				\
 	val2 = _l >> 32;			\
 } while (0)
 
-#define wrmsr(msr, val1, val2)			\
-do {						\
-	paravirt_write_msr(msr, val1, val2);	\
+#define wrmsr(msr, val1, val2)				\
+do {							\
+	int _err;					\
+	_err = paravirt_write_msr(msr, val1, val2);	\
+	BUG_ON(_err);					\
 } while (0)
 
 #define rdmsrl(msr, val)			\
 do {						\
 	int _err;				\
 	val = paravirt_read_msr(msr, &_err);	\
+	BUG_ON(_err);				\
 } while (0)
 
 #define wrmsrl(msr, val)	wrmsr(msr, (u32)((u64)(val)), ((u64)(val))>>32)
-- 
1.9.3
