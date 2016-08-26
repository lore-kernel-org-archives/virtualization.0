From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v8 10/18] ARM: DT: STiH407: Add i2s_out pinctrl configuration
Date: Fri, 26 Aug 2016 15:56:45 +0100
Message-ID: <1472223413-7254-11-git-send-email-peter.griffin__108.29691677845$1472226831$gmane$org@linaro.org>
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
Cc: devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, peter.griffin@linaro.org, dmaengine@vger.kernel.org, lee.jones@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

This patch adds the pinctrl config for the i2s_out pins
used by the uniperif player IP.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a538ae5..0fb5c8a 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -1067,6 +1067,29 @@
 				};
 			};
 
+			i2s_out {
+				pinctrl_i2s_8ch_out: i2s_8ch_out{
+					st,pins {
+						mclk = <&pio33 5 ALT1 OUT>;
+						lrclk = <&pio33 7 ALT1 OUT>;
+						sclk = <&pio33 6 ALT1 OUT>;
+						data0 = <&pio33 4 ALT1 OUT>;
+						data1 = <&pio34 0 ALT1 OUT>;
+						data2 = <&pio34 1 ALT1 OUT>;
+						data3 = <&pio34 2 ALT1 OUT>;
+					};
+				};
+
+				pinctrl_i2s_2ch_out: i2s_2ch_out{
+					st,pins {
+						mclk = <&pio33 5 ALT1 OUT>;
+						lrclk = <&pio33 7 ALT1 OUT>;
+						sclk = <&pio33 6 ALT1 OUT>;
+						data0 = <&pio33 4 ALT1 OUT>;
+					};
+				};
+			};
+
 			serial3 {
 				pinctrl_serial3: serial3-0 {
 					st,pins {
-- 
1.9.1
