From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v15 08/15] lfsr: a simple binary Galois linear feedback shift
	register
Date: Mon,  6 Apr 2015 22:55:43 -0400
Message-ID: <1428375350-9213-9-git-send-email-Waiman.Long__44754.6349991628$1428375514$gmane$org@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Waiman Long <Waiman.Long@hp.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch is based on the code sent out by Peter Zijstra as part
of his queue spinlock patch to provide a hashing function with open
addressing.  The lfsr() function can be used to return a sequence of
numbers that cycle through all the bit patterns (2^n -1) of a given
bit width n except the value 0 in a somewhat random fashion depending
on the LFSR taps that is being used. Callers can provide their own
taps value or use the default.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 include/linux/lfsr.h |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/lfsr.h

diff --git a/include/linux/lfsr.h b/include/linux/lfsr.h
new file mode 100644
index 0000000..f570819
--- /dev/null
+++ b/include/linux/lfsr.h
@@ -0,0 +1,80 @@
+#ifndef _LINUX_LFSR_H
+#define _LINUX_LFSR_H
+
+/*
+ * Simple Binary Galois Linear Feedback Shift Register
+ *
+ * http://en.wikipedia.org/wiki/Linear_feedback_shift_register
+ *
+ * This function only currently supports only bits values of 4-30. Callers
+ * that doesn't pass in a constant bits value can optionally define
+ * LFSR_MIN_BITS and LFSR_MAX_BITS before including the lfsr.h header file
+ * to reduce the size of the jump table in the compiled code, if desired.
+ */
+#ifndef LFSR_MIN_BITS
+#define LFSR_MIN_BITS	4
+#endif
+
+#ifndef LFSR_MAX_BITS
+#define LFSR_MAX_BITS	30
+#endif
+
+static __always_inline u32 lfsr_taps(int bits)
+{
+	BUG_ON((bits < LFSR_MIN_BITS) || (bits > LFSR_MAX_BITS));
+	BUILD_BUG_ON((LFSR_MIN_BITS < 4) || (LFSR_MAX_BITS > 30));
+
+#define _IF_BITS_EQ(x)	\
+	if (((x) >= LFSR_MIN_BITS) && ((x) <= LFSR_MAX_BITS) && ((x) == bits))
+
+	/*
+	 * Feedback terms copied from
+	 * http://users.ece.cmu.edu/~koopman/lfsr/index.html
+	 */
+	_IF_BITS_EQ(4)  return 0x0009;
+	_IF_BITS_EQ(5)  return 0x0012;
+	_IF_BITS_EQ(6)  return 0x0021;
+	_IF_BITS_EQ(7)  return 0x0041;
+	_IF_BITS_EQ(8)  return 0x008E;
+	_IF_BITS_EQ(9)  return 0x0108;
+	_IF_BITS_EQ(10) return 0x0204;
+	_IF_BITS_EQ(11) return 0x0402;
+	_IF_BITS_EQ(12) return 0x0829;
+	_IF_BITS_EQ(13) return 0x100D;
+	_IF_BITS_EQ(14) return 0x2015;
+	_IF_BITS_EQ(15) return 0x4122;
+	_IF_BITS_EQ(16) return 0x8112;
+	_IF_BITS_EQ(17) return 0x102C9;
+	_IF_BITS_EQ(18) return 0x20195;
+	_IF_BITS_EQ(19) return 0x403FE;
+	_IF_BITS_EQ(20) return 0x80637;
+	_IF_BITS_EQ(21) return 0x100478;
+	_IF_BITS_EQ(22) return 0x20069E;
+	_IF_BITS_EQ(23) return 0x4004B2;
+	_IF_BITS_EQ(24) return 0x800B87;
+	_IF_BITS_EQ(25) return 0x10004F3;
+	_IF_BITS_EQ(26) return 0x200072D;
+	_IF_BITS_EQ(27) return 0x40006AE;
+	_IF_BITS_EQ(28) return 0x80009E3;
+	_IF_BITS_EQ(29) return 0x10000583;
+	_IF_BITS_EQ(30) return 0x20000C92;
+#undef _IF_BITS_EQ
+
+	/* Unreachable */
+	return 0;
+}
+
+/*
+ * Please note that LFSR doesn't work with a start state of 0.
+ */
+static inline u32 lfsr(u32 val, int bits, u32 taps)
+{
+	u32 bit = val & 1;
+
+	val >>= 1;
+	if (bit)
+		val ^= taps ? taps : lfsr_taps(bits);
+	return val;
+}
+
+#endif /* _LINUX_LFSR_H */
-- 
1.7.1
