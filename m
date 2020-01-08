From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 4/9] virtio: pci: Constify ioreadX() iomem argument (as in
 generic implementation)
Date: Wed,  8 Jan 2020 21:05:23 +0100
Message-ID: <20200108200528.4614-5-krzk__30367.6475816005$1578514065$gmane$org@kernel.org>
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
 drivers/virtio/virtio_pci_modern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7abcc50838b8..fc58db4ab6c3 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -26,16 +26,16 @@
  * method, i.e. 32-bit accesses for 32-bit fields, 16-bit accesses
  * for 16-bit fields and 8-bit accesses for 8-bit fields.
  */
-static inline u8 vp_ioread8(u8 __iomem *addr)
+static inline u8 vp_ioread8(const u8 __iomem *addr)
 {
 	return ioread8(addr);
 }
-static inline u16 vp_ioread16 (__le16 __iomem *addr)
+static inline u16 vp_ioread16 (const __le16 __iomem *addr)
 {
 	return ioread16(addr);
 }
 
-static inline u32 vp_ioread32(__le32 __iomem *addr)
+static inline u32 vp_ioread32(const __le32 __iomem *addr)
 {
 	return ioread32(addr);
 }
-- 
2.17.1
