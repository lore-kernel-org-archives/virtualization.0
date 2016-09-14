From: Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH v9 16/19] ARM: DT: STi: stihxxx-b2120: Add DT nodes for
	STi audio card
Date: Wed, 14 Sep 2016 14:01:46 +0200
Message-ID: <27eec291-dde4-846a-995a-fab6a2c76110__36570.9424521357$1474143903$gmane$org@st.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<1473081421-16555-17-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1473081421-16555-17-git-send-email-peter.griffin@linaro.org>
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
> This patch enables the uniperif players 2 & 3 for b2120 boards
> and also adds the "simple-audio-card" device node to interconnect
> the SoC sound device and the codec.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index 722c63f..4939501 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -131,5 +131,50 @@
>  				dvb-card	= <STV0367_TDA18212_NIMA_1>;
>  			};
>  		};
> +
> +		sti_uni_player2: sti-uni-player@8d82000 {
> +			status = "okay";
> +		};
> +
> +		sti_uni_player3: sti-uni-player@8d85000 {
> +			status = "okay";
> +		};
> +
> +		sti_sasg_codec: sti-sasg-codec {
> +			status = "okay";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spdif_out>;
> +		};
> +
> +		sound {
> +			compatible = "simple-audio-card";
> +			simple-audio-card,name = "sti audio card";
> +			status = "okay";
> +
> +			simple-audio-card,dai-link@0 {
> +				/* DAC */
> +				format = "i2s";
> +				mclk-fs = <256>;
> +				cpu {
> +					sound-dai = <&sti_uni_player2>;
> +				};
> +
> +				codec {
> +					sound-dai = <&sti_sasg_codec 1>;
> +				};
> +			};
> +			simple-audio-card,dai-link@1 {
> +				/* SPDIF */
> +				format = "left_j";
> +				mclk-fs = <128>;
> +				cpu {
> +					sound-dai = <&sti_uni_player3>;
> +				};
> +
> +				codec {
> +					sound-dai = <&sti_sasg_codec 0>;
> +				};
> +			};
> +		};
>  	};
>  };
> 


Applied for STi next

Thanks
