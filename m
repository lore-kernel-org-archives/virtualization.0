From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH v2 5/9] arc: Constify ioreadX() iomem argument (as in
 generic implementation)
Date: Wed, 19 Feb 2020 18:50:03 +0100
Message-ID: <20200219175007.13627-6-krzk__34995.6728446827$1582134736$gmane$org@kernel.org>
References: <20200219175007.13627-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200219175007.13627-1-krzk@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Vineet Gupta <vgupta@synopsys.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jirislaby@gmail.com>, Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, "David S. Miller" <davem@davemloft.net>, Dave Jiang <dave.jiang@intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The ioreadX() helpers have inconsistent interface.  On some architectures
void *__iomem address argument is a pointer to const, on some not.

Implementations of ioreadX() do not modify the memory under the
address so they can be converted to a "const" version for const-safety
and consistency among architectures.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>

---

Changes since v1:
1. Add Alexey's ack.
---
 arch/arc/plat-axs10x/axs10x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
index 63ea5a606ecd..180c260a8221 100644
--- a/arch/arc/plat-axs10x/axs10x.c
+++ b/arch/arc/plat-axs10x/axs10x.c
@@ -84,7 +84,7 @@ static void __init axs10x_print_board_ver(unsigned int creg, const char *str)
 		unsigned int val;
 	} board;
 
-	board.val = ioread32((void __iomem *)creg);
+	board.val = ioread32((const void __iomem *)creg);
 	pr_info("AXS: %s FPGA Date: %u-%u-%u\n", str, board.d, board.m,
 		board.y);
 }
@@ -95,7 +95,7 @@ static void __init axs10x_early_init(void)
 	char mb[32];
 
 	/* Determine motherboard version */
-	if (ioread32((void __iomem *) CREG_MB_CONFIG) & (1 << 28))
+	if (ioread32((const void __iomem *) CREG_MB_CONFIG) & (1 << 28))
 		mb_rev = 3;	/* HT-3 (rev3.0) */
 	else
 		mb_rev = 2;	/* HT-2 (rev2.0) */
-- 
2.17.1
