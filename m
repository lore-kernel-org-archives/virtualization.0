From: Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH v9 14/19] ARM: STi: DT: STiH407: Add uniperif player dt
	nodes
Date: Wed, 14 Sep 2016 14:01:15 +0200
Message-ID: <e55bbf9e-c18e-7dc5-4f18-647cca52cba5__23333.3813179799$1474143855$gmane$org@st.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<1473081421-16555-15-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1473081421-16555-15-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, dan.j.williams@intel.com, airlied@linux.ie, kraxel@redhat.com, ohad@wizery.com, bjorn.andersson@linaro.org
Cc: devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, dmaengine@vger.kernel.org, lee.jones@linaro.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Peter

On 09/05/2016 03:16 PM, Peter Griffin wrote:
> This patch adds the DT nodes for the uniperif player
> IP blocks found on STiH407 family silicon.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 80 +++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index d1258d5..1edc36c 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -880,5 +880,85 @@
>  			status = "disabled";
>  			st,syscfg = <&syscfg_core>;
>  		};
> +
> +		sti_uni_player0: sti-uni-player@8d80000 {
> +			compatible = "st,sti-uni-player";
> +			#sound-dai-cells = <0>;
> +			st,syscfg = <&syscfg_core>;
> +			clocks = <&clk_s_d0_flexgen CLK_PCM_0>;
> +			assigned-clocks = <&clk_s_d0_quadfs 0>, <&clk_s_d0_flexgen CLK_PCM_0>;
> +			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 0>;
> +			assigned-clock-rates = <50000000>;
> +			reg = <0x8d80000 0x158>;
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_NONE>;
> +			dmas = <&fdma0 2 0 1>;
> +			dai-name = "Uni Player #0 (HDMI)";
> +			dma-names = "tx";
> +			st,uniperiph-id = <0>;
> +			st,version = <5>;
> +			st,mode = "HDMI";
> +
> +			status		= "disabled";
> +		};
> +
> +		sti_uni_player1: sti-uni-player@8d81000 {
> +			compatible = "st,sti-uni-player";
> +			#sound-dai-cells = <0>;
> +			st,syscfg = <&syscfg_core>;
> +			clocks = <&clk_s_d0_flexgen CLK_PCM_1>;
> +			assigned-clocks = <&clk_s_d0_quadfs 1>, <&clk_s_d0_flexgen CLK_PCM_1>;
> +			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 1>;
> +			assigned-clock-rates = <50000000>;
> +			reg = <0x8d81000 0x158>;
> +			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
> +			dmas = <&fdma0 3 0 1>;
> +			dai-name = "Uni Player #1 (PIO)";
> +			dma-names = "tx";
> +			st,uniperiph-id = <1>;
> +			st,version = <5>;
> +			st,mode = "PCM";
> +
> +			status = "disabled";
> +		};
> +
> +		sti_uni_player2: sti-uni-player@8d82000 {
> +			compatible = "st,sti-uni-player";
> +			#sound-dai-cells = <0>;
> +			st,syscfg = <&syscfg_core>;
> +			clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
> +			assigned-clocks = <&clk_s_d0_quadfs 2>, <&clk_s_d0_flexgen CLK_PCM_2>;
> +			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 2>;
> +			assigned-clock-rates = <50000000>;
> +			reg = <0x8d82000 0x158>;
> +			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
> +			dmas = <&fdma0 4 0 1>;
> +			dai-name = "Uni Player #1 (DAC)";
> +			dma-names = "tx";
> +			st,uniperiph-id = <2>;
> +			st,version = <5>;
> +			st,mode = "PCM";
> +
> +			status = "disabled";
> +		};
> +
> +		sti_uni_player3: sti-uni-player@8d85000 {
> +			compatible = "st,sti-uni-player";
> +			#sound-dai-cells = <0>;
> +			st,syscfg = <&syscfg_core>;
> +			clocks = <&clk_s_d0_flexgen CLK_SPDIFF>;
> +			assigned-clocks = <&clk_s_d0_quadfs 3>, <&clk_s_d0_flexgen CLK_SPDIFF>;
> +			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 3>;
> +			assigned-clock-rates = <50000000>;
> +			reg = <0x8d85000 0x158>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
> +			dmas = <&fdma0 7 0 1>;
> +			dma-names = "tx";
> +			dai-name = "Uni Player #1 (PIO)";
> +			st,uniperiph-id = <3>;
> +			st,version = <5>;
> +			st,mode = "SPDIF";
> +
> +			status = "disabled";
> +		};
>  	};
>  };
> 


Applied for STi next

Thanks
