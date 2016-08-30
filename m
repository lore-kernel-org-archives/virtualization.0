From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v8 15/18] ARM: STi: DT: STiH407: Add uniperif reader dt
	nodes
Date: Tue, 30 Aug 2016 15:21:12 +0100
Message-ID: <20160830142112.GA22514@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
	<1472223413-7254-16-git-send-email-peter.griffin@linaro.org>
	<20160830100148.GO1661@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160830100148.GO1661@dell>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, airlied@linux.ie, dmaengine@vger.kernel.org, dan.j.williams@intel.com, bjorn.andersson@linaro.org, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Lee,

Thanks for reviewing and your very valuable feedback.

On Tue, 30 Aug 2016, Lee Jones wrote:

> On Fri, 26 Aug 2016, Peter Griffin wrote:
> 
> > This patch adds the DT node for the uniperif reader
> > IP block found on STiH407 family silicon.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index d263c96..bdddf2c 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -956,5 +956,31 @@
> >  			st,version = <5>;
> >  			st,mode = "SPDIF";
> >  		};
> > +
> > +		sti_uni_reader0: sti-uni-reader@0 {
> > +			compatible = "st,sti-uni-reader";
> > +			status = "disabled";
> 
> I find it's normally nicer to place the status of the node at the
> bottom, separated by a '\n'.

Ok I'll add a superflous '\n' in the next version.

>  There isn't a functional difference
> admittedly, but it would be my preference, since it's not describing
> the device per se.

Will change to your preference in the next version.

> 
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			reg = <0x8D83000 0x158>;
> 
> We usually use lower-case for the address.

Will fix.

> 
> Since this has a 'reg' property, the '0' in the node name does not
> look appropriate.

Will fix.
> 
> > +			interrupts = <GIC_SPI 87 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 5 0 1>;
> > +			dma-names = "rx";
> > +			dai-name = "Uni Reader #0 (PCM IN)";
> 
> Oooo, not seen something like this before.
> 
> If it does not already have one, it would require a DT Ack.

No idea, the driver got merged 1 year ago.

Arnaud did you get a DT ack when you merged this driver & binding?
> 
> > +			st,version = <3>;
> 
> This will likely need a DT Ack too.  We usually encode this sort of
> information in the compatible string.

See 05c1b4480e86a871b18030d6f3d532dc0ecdf38c
> 
> > +		};
> > +
> > +		sti_uni_reader1: sti-uni-reader@1 {
> > +			compatible = "st,sti-uni-reader";
> > +			status = "disabled";
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			reg = <0x8D84000 0x158>;
> > +			interrupts = <GIC_SPI 88 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 6 0 1>;
> > +			dma-names = "rx";
> > +			dai-name = "Uni Reader #1 (HDMI RX)";
> > +			st,version = <3>;
> > +		};
> 
> All as above.
> 
> >  	};
> >  };
> 

Regards,

Peter.
