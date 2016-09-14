From: Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH v9 10/19] ARM: DT: STiH407: Add i2s_out pinctrl
	configuration
Date: Wed, 14 Sep 2016 14:00:11 +0200
Message-ID: <2784abd2-59ed-33d1-60d8-e7b9e4e777a6__37303.3896823928$1474143931$gmane$org@st.com>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<1473081421-16555-11-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1473081421-16555-11-git-send-email-peter.griffin@linaro.org>
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
> This patch adds the pinctrl config for the i2s_out pins
> used by the uniperif player IP.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index a538ae5..0fb5c8a 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -1067,6 +1067,29 @@
>  				};
>  			};
>  
> +			i2s_out {
> +				pinctrl_i2s_8ch_out: i2s_8ch_out{
> +					st,pins {
> +						mclk = <&pio33 5 ALT1 OUT>;
> +						lrclk = <&pio33 7 ALT1 OUT>;
> +						sclk = <&pio33 6 ALT1 OUT>;
> +						data0 = <&pio33 4 ALT1 OUT>;
> +						data1 = <&pio34 0 ALT1 OUT>;
> +						data2 = <&pio34 1 ALT1 OUT>;
> +						data3 = <&pio34 2 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_i2s_2ch_out: i2s_2ch_out{
> +					st,pins {
> +						mclk = <&pio33 5 ALT1 OUT>;
> +						lrclk = <&pio33 7 ALT1 OUT>;
> +						sclk = <&pio33 6 ALT1 OUT>;
> +						data0 = <&pio33 4 ALT1 OUT>;
> +					};
> +				};
> +			};
> +
>  			serial3 {
>  				pinctrl_serial3: serial3-0 {
>  					st,pins {
> 


Applied for STi next

Thanks
