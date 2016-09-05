From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v9 03/19] dmaengine: st_fdma: Add STMicroelectronics FDMA DT
	binding documentation
Date: Mon,  5 Sep 2016 14:16:45 +0100
Message-ID: <1473081421-16555-4-git-send-email-peter.griffin@linaro.org>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
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
Cc: devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, peter.griffin@linaro.org, dmaengine@vger.kernel.org, lee.jones@linaro.org, Ludovic Barre <ludovic.barre@st.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch adds the DT binding documentation for the FDMA constroller
found on STi based chipsets from STMicroelectronics.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/st_fdma.txt | 87 +++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/st_fdma.txt

diff --git a/Documentation/devicetree/bindings/dma/st_fdma.txt b/Documentation/devicetree/bindings/dma/st_fdma.txt
new file mode 100644
index 0000000..495d853
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/st_fdma.txt
@@ -0,0 +1,87 @@
+* STMicroelectronics Flexible Direct Memory Access Device Tree bindings
+
+The FDMA is a general-purpose direct memory access controller capable of
+supporting 16 independent DMA channels. It accepts up to 32 DMA requests.
+The FDMA is based on a Slim processor which requires a firmware.
+
+* FDMA Controller
+
+Required properties:
+- compatible	: Should be one of
+		 - st,stih407-fdma-mpe31-11, "st,slim-rproc";
+		 - st,stih407-fdma-mpe31-12, "st,slim-rproc";
+		 - st,stih407-fdma-mpe31-13, "st,slim-rproc";
+- reg		: Should contain an entry for each name in reg-names
+- reg-names	: Must contain "slimcore", "dmem", "peripherals", "imem" entries
+- interrupts	: Should contain one interrupt shared by all channels
+- dma-channels	: Number of channels supported by the controller
+- #dma-cells	: Must be <3>. See DMA client section below
+- clocks	: Must contain an entry for each clock
+See: Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+
+Example:
+
+	fdma0: dma-controller@8e20000 {
+		compatible = "st,stih407-fdma-mpe31-11", "st,slim-rproc";
+		reg = <0x8e20000 0x8000>,
+		      <0x8e30000 0x3000>,
+		      <0x8e37000 0x1000>,
+		      <0x8e38000 0x8000>;
+		reg-names = "slimcore", "dmem", "peripherals", "imem";
+		clocks = <&clk_s_c0_flexgen CLK_FDMA>,
+			 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+			 <&clk_s_c0_flexgen CLK_EXT2F_A9>,
+			 <&clk_s_c0_flexgen CLK_EXT2F_A9>;
+		interrupts = <GIC_SPI 5 IRQ_TYPE_NONE>;
+		dma-channels = <16>;
+		#dma-cells = <3>;
+	};
+
+* DMA client
+
+Required properties:
+- dmas: Comma separated list of dma channel requests
+- dma-names: Names of the aforementioned requested channels
+
+Each dmas request consists of 4 cells:
+1. A phandle pointing to the FDMA controller
+2. The request line number
+3. A 32bit mask specifying (see include/linux/platform_data/dma-st-fdma.h)
+ -bit 2-0: Holdoff value, dreq will be masked for
+	0x0: 0-0.5us
+	0x1: 0.5-1us
+	0x2: 1-1.5us
+ -bit 17: data swap
+	0x0: disabled
+	0x1: enabled
+ -bit 21: Increment Address
+	0x0: no address increment between transfers
+	0x1: increment address between transfers
+ -bit 22: 2 STBus Initiator Coprocessor interface
+	0x0: high priority port
+	0x1: low priority port
+4. transfers type
+ 0 free running
+ 1 paced
+
+Example:
+
+	sti_uni_player2: sti-uni-player@2 {
+		compatible = "st,sti-uni-player";
+		status = "disabled";
+		#sound-dai-cells = <0>;
+		st,syscfg = <&syscfg_core>;
+		clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
+		assigned-clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
+		assigned-clock-parents = <&clk_s_d0_quadfs 2>;
+		assigned-clock-rates = <50000000>;
+		reg = <0x8D82000 0x158>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+		dmas = <&fdma0 4 0 1>;
+		dai-name = "Uni Player #1 (DAC)";
+		dma-names = "tx";
+		st,uniperiph-id = <2>;
+		st,version = <5>;
+		st,mode = "PCM";
+	};
-- 
1.9.1
