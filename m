From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/9] net: wireless: rtl818x: Constify ioreadX() iomem
 argument (as in generic implementation)
Date: Wed,  8 Jan 2020 21:05:21 +0100
Message-ID: <20200108200528.4614-3-krzk__17099.2087967292$1578514038$gmane$org@kernel.org>
References: <20200108200528.4614-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200108200528.4614-1-krzk@kernel.org>
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
List-Id: virtualization@lists.linuxfoundation.org

The ioreadX() helpers have inconsistent interface.  On some architectures
void *__iomem address argument is a pointer to const, on some not.

Implementations of ioreadX() do not modify the memory under the address
so they can be converted to a "const" version for const-safety and
consistency among architectures.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes since v1:
1. Add Geert's review.
---
 drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8180.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8180.h b/drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8180.h
index 7948a2da195a..2ff00800d45b 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8180.h
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/rtl8180.h
@@ -150,17 +150,17 @@ void rtl8180_write_phy(struct ieee80211_hw *dev, u8 addr, u32 data);
 void rtl8180_set_anaparam(struct rtl8180_priv *priv, u32 anaparam);
 void rtl8180_set_anaparam2(struct rtl8180_priv *priv, u32 anaparam2);
 
-static inline u8 rtl818x_ioread8(struct rtl8180_priv *priv, u8 __iomem *addr)
+static inline u8 rtl818x_ioread8(struct rtl8180_priv *priv, const u8 __iomem *addr)
 {
 	return ioread8(addr);
 }
 
-static inline u16 rtl818x_ioread16(struct rtl8180_priv *priv, __le16 __iomem *addr)
+static inline u16 rtl818x_ioread16(struct rtl8180_priv *priv, const __le16 __iomem *addr)
 {
 	return ioread16(addr);
 }
 
-static inline u32 rtl818x_ioread32(struct rtl8180_priv *priv, __le32 __iomem *addr)
+static inline u32 rtl818x_ioread32(struct rtl8180_priv *priv, const __le32 __iomem *addr)
 {
 	return ioread32(addr);
 }
-- 
2.17.1
