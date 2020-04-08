From: Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/3] mips/mips_fulong2e: Set preferred page size to 16KB
Date: Wed,  8 Apr 2020 17:14:09 +0800
Message-ID: <1586337250-25149-2-git-send-email-chenhc@lemote.com>
References: <1586337250-25149-1-git-send-email-chenhc@lemote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1586337250-25149-1-git-send-email-chenhc@lemote.com>
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

Loongson processor prefers 16KB page size in system emulator, so let's
define mc->minimum_page_bits to 14.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 hw/mips/mips_fulong2e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 5040afd..23897d7 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -399,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fulong2e.ram";
+    mc->minimum_page_bits = 14;
 }
 
 DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
-- 
2.7.0
