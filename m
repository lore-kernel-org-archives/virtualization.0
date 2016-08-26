From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v8 09/18] ARM: multi_v7_defconfig: Enable STi and simple-card
	drivers.
Date: Fri, 26 Aug 2016 15:56:44 +0100
Message-ID: <1472223413-7254-10-git-send-email-peter.griffin__31033.8307790973$1472226826$gmane$org@linaro.org>
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
Cc: devicetree@vger.kernel.org, arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, peter.griffin@linaro.org, broonie@kernel.org, dmaengine@vger.kernel.org, lee.jones@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

This patch enables the STi ALSA drivers found on STi platforms
as well as the simple-card driver which is a dependency to have
working sound.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: arnaud.pouliquen@st.com
Cc: broonie@kernel.org
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 998578a..51a38b1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -644,6 +644,9 @@ CONFIG_SND_SOC_AK4642=m
 CONFIG_SND_SOC_SGTL5000=m
 CONFIG_SND_SOC_SPDIF=m
 CONFIG_SND_SOC_WM8978=m
+CONFIG_SND_SOC_STI=m
+CONFIG_SND_SOC_STI_SAS=m
+CONFIG_SND_SIMPLE_CARD=m
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_MVEBU=y
-- 
1.9.1
