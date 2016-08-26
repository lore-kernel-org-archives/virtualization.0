From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v8 02/18] MAINTAINERS: Add st slim core rproc driver to STi
	section.
Date: Fri, 26 Aug 2016 15:56:37 +0100
Message-ID: <1472223413-7254-3-git-send-email-peter.griffin__979.761037933891$1472226722$gmane$org@linaro.org>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, patrice.chotard@st.com, dan.j.williams@intel.com, airlied@linux.ie, kraxel@redhat.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, peter.griffin@linaro.org, dmaengine@vger.kernel.org, lee.jones@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

This patch adds the slim core rproc driver to the STi section
of the MAINTAINERS file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bbe4b1..5dd3b24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1749,6 +1749,7 @@ F:	drivers/phy/phy-stih407-usb.c
 F:	drivers/phy/phy-stih41x-usb.c
 F:	drivers/pinctrl/pinctrl-st.c
 F:	drivers/remoteproc/st_remoteproc.c
+F:	drivers/remoteproc/st_slim_rproc.c
 F:	drivers/reset/sti/
 F:	drivers/rtc/rtc-st-lpc.c
 F:	drivers/tty/serial/st-asc.c
@@ -1757,6 +1758,7 @@ F:	drivers/usb/host/ehci-st.c
 F:	drivers/usb/host/ohci-st.c
 F:	drivers/watchdog/st_lpc_wdt.c
 F:	drivers/ata/ahci_st.c
+F:	include/linux/remoteproc/st_slim_rproc.h
 
 ARM/STM32 ARCHITECTURE
 M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>
-- 
1.9.1
