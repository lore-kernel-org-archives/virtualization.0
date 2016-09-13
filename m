From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v9 00/19] Add support for FDMA DMA controller and slim
	core rproc found on STi chipsets
Date: Tue, 13 Sep 2016 11:06:16 -0700
Message-ID: <20160913180616.GD21438__20029.256566386$1473790000$gmane$org@tuxbot>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<20160913093107.GA10953@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160913093107.GA10953@griffinp-ThinkPad-X1-Carbon-2nd>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Griffin <peter.griffin@linaro.org>, vinod.koul@intel.com
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, airlied@linux.ie, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, dan.j.williams@intel.com, virtualization@lists.linux-foundation.org, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue 13 Sep 02:31 PDT 2016, Peter Griffin wrote:

> Hi Vinod & Bjorn,
> 
> [..]
> 
> On Mon, 05 Sep 2016, Peter Griffin wrote:
> 
> > v8 actions some review feedback from Bjorn to the slim rproc driver, and also includes
> > a patch which fixes a recursive Kconfig error which is triggered when st_fdma selects
> > slim_rproc driver. The series has also been rebased on v4.8-rc3.
> > 
> > v9 actions some review feedback from Bjorn, Lee and Vinod. See below. Importantly a bug
> > was found during testing now that the platform boots without clk_ignore_unused parameter
> > whereby the clocks would not be enabled properly before firmware loading was attempted.
> > 
> > regards,
> > 
> > Peter.
> > 
> > Changes since v8:
> >  - Add MODULE_ALIAS (Vinod)
> >  - devm_kzalloc to devm_kcalloc (Vinod)
> >  - quisce tasklet initialised by vchan_init() (Vinod)
> >  - Don't make SLIM rproc user selectable (Bjorn)
> >  - slim_rproc: Ensure clocks enabled before firmware load (Peter)
> >  - Various code style nits / commit message change (Lee)
> >  - Separate patch for '\n' kconfig removal (Vinod)
> 
> I hate to send a ping,

Sorry about that.

> but do you think we can merge this fdma series? It has gone
> through quite a few review rounds now.
> 

I think the remoteproc part looks good.

Vinod, I don't have any changes queued in remoteproc that should cause
merge issues. If you want to you could take the remoteproc patch
through your tree.


I do however think that the dts patches should go through arm-soc.

Regards,
Bjorn
