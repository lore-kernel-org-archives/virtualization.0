From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 02/27] ia64/xen: introduce synch bitops which is
	necessary for ia64/xen support.
Date: Tue, 17 Jun 2008 16:24:10 -0700
Message-ID: <57C9024A16AD2D4C97DC78E552063EA3061C5BF1__17866.9887049638$1213745363$gmane$org@orsmsx505.amr.corp.intel.com>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
	<1213084043534-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1213084043534-git-send-email-yamahata@valinux.co.jp>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Cc: Jeremy@smtp1.linux-foundation.org, "Dong, Eddie" <eddie.dong@intel.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Robin Holt <holt@sgi.com>, "xen-ia64-devel@lists.xensource.com" <xen-ia64-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

Just started digging through these ... part 01/27 was fine. But here
are a couple of comments for part 02/27

+/*
+ * Copyright 1992, Linus Torvalds.
+ * Heavily modified to provide guaranteed strong synchronisation
+ * when communicating with Xen or other guest OSes running on other CPUs.
+ */

Presumably Linus didn't write this in 1992.  Perhaps this file
contains enough new material to warrant your own copyright?

+static inline int sync_const_test_bit(int nr, const volatile void *addr)
+{
+       return test_bit(nr, addr);
+}
+
+static inline int sync_var_test_bit(int nr, volatile void *addr)
+{
+       return test_bit(nr, addr);
+}
 ...
+#define sync_test_bit(nr,addr)                 \
+       (__builtin_constant_p(nr) ?             \
+        sync_const_test_bit((nr), (addr)) :    \
+        sync_var_test_bit((nr), (addr)))

What use is this?  It doesn't matter whether "nr" is constant or
not you still end up using "test_bit" ... so why make the compiler
do all the extra work when you just mean this?

static inline int sync_test_bit(int nr, volatile void *addr)
{
        return test_bit(nr, addr);
}

-Tony
