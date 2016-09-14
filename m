From: Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH v9 15/19] ARM: STi: DT: STiH407: Add uniperif reader dt
	nodes
Date: Wed, 14 Sep 2016 14:01:28 +0200
Message-ID: <71053640-c050-7875-2a3c-a6206864beb0__27474.1843263202$1474143892$gmane$org@st.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<1473081421-16555-16-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1473081421-16555-16-git-send-email-peter.griffin@linaro.org>
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
> This patch adds the DT node for the uniperif reader
> IP block found on STiH407 family silicon.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-family.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 1edc36c..883019a 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -960,5 +960,33 @@
>  
>  			status = "disabled";
>  		};
> +
> +		sti_uni_reader0: sti-uni-reader@8d83000 {
> +			compatible = "st,sti-uni-reader";
> +			#sound-dai-cells = <0>;
> +			st,syscfg = <&syscfg_core>;
> +			reg = <0x8d83000 0x158>;
> +			interrupts = <GIC_SPI 87 IRQ_TYPE_NONE>;
> +			dmas = <&fdma0 5 0 1>;
> +			dma-names = "rx";
> +			dai-name = "Uni Reader #0 (PCM IN)";
> +			st,version = <3>;
> +
> +			status = "disabled";
> +		};
> +
> +		sti_uni_reader1: sti-uni-reader@8d84000 {
> +			compatible = "st,sti-uni-reader";
> +			#sound-dai-cells = <0>;
> +			st,syscfg = <&syscfg_core>;
> +			reg = <0x8d84000 0x158>;
> +			interrupts = <GIC_SPI 88 IRQ_TYPE_NONE>;
> +			dmas = <&fdma0 6 0 1>;
> +			dma-names = "rx";
> +			dai-name = "Uni Reader #1 (HDMI RX)";
> +			st,version = <3>;
> +
> +			status = "disabled";
> +		};
>  	};
>  };
> 



Applied for STi next

Thanks
