From: Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/3] target/mips: Support variable page size
Date: Wed,  8 Apr 2020 17:14:08 +0800
Message-ID: <1586337250-25149-1-git-send-email-chenhc@lemote.com>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, virtualization@lists.linux-foundation.org, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>, spice-devel@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

Traditionally, MIPS use 4KB page size, but Loongson prefer 16KB page
size in system emulator. So, let's define TARGET_PAGE_BITS_VARY and
TARGET_PAGE_BITS_MIN to support variable page size.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 target/mips/cpu-param.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 308660d..9c4a6ea 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -23,7 +23,12 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 #endif
+#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
+#else
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN 12
+#endif
 #define NB_MMU_MODES 4
 
 #endif
-- 
2.7.0
