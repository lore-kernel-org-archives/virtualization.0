From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for Jailhouse
Date: Wed, 28 Feb 2018 07:34:51 +0100
Message-ID: <394fdbc4d90e55403e5c0907d90f7e5aaba48ed7.1519799691.git.jan.kiszka__20471.7387365692$1519799643$gmane$org@siemens.com>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1519799691.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1519799691.git.jan.kiszka@siemens.com>
References: <cover.1519799691.git.jan.kiszka@siemens.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93a12af4f180..4b889f282c77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7521,6 +7521,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/dvb-frontends/ix2505v*
 
+JAILHOUSE HYPERVISOR INTERFACE
+M:	Jan Kiszka <jan.kiszka@siemens.com>
+L:	jailhouse-dev@googlegroups.com
+S:	Maintained
+F:	arch/x86/kernel/jailhouse.c
+F:	arch/x86/include/asm/jailhouse_para.h
+
 JC42.4 TEMPERATURE SENSOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.13.6
