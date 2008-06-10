From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 06/27] ia64/xen: define NET_SKB_NET to 18 if xen.
Date: Tue, 10 Jun 2008 16:47:02 +0900
Message-ID: <12130840432829-git-send-email-yamahata__36213.4187053472$1213084988$gmane$org@valinux.co.jp>
References: <12130840433561-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12130840433561-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: eddie.dong@intel.com, virtualization@lists.linux-foundation.org, yamahata@valinux.co.jp, Kouya SHIMURA <kouya@jp.fujitsu.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On native ia64 NET_SKB_NET isn't necessary to define.
However on xen it needs to be slightly larger. (More specifically
it's xen-netfront.c requirement.)
It causes annoying kernel unalgned access message and
network layer troubles.
Resolve it by increasing NET_SKB_NET from the default value 16 to 18.

Cc: Kouya SHIMURA <kouya@jp.fujitsu.com>
Cc: Akio Takebe <takebe_akio@jp.fujitsu.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/asm-offsets.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
index 6bd3fc5..6a8d95e 100644
--- a/arch/ia64/kernel/asm-offsets.c
+++ b/arch/ia64/kernel/asm-offsets.c
@@ -292,6 +292,17 @@ void foo(void)
 #ifdef CONFIG_XEN
 	BLANK();
 
+	{
+		union __net_skb_pad
+		{
+			/* default NET_SKB_PAD (= 16) + NET_IP_ALIGN (= 2) */
+			char xen_pad[16 + 2];
+		};
+		COMMENT("On xen NET_SKB_PAD needs to be");
+		COMMENT(" default NET_SKB_PAD (= 16) + NET_IP_ALIGN (= 2)");
+		DEFINE(NET_SKB_PAD, sizeof(union __net_skb_pad));
+	}
+
 #define DEFINE_MAPPED_REG_OFS(sym, field) \
 	DEFINE(sym, (XMAPPEDREGS_OFS + offsetof(struct mapped_regs, field)))
 
-- 
1.5.3
