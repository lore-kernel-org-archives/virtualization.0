From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v9 00/19] Add support for FDMA DMA controller and slim
	core rproc found on STi chipsets
Date: Thu, 15 Sep 2016 21:50:30 +0530
Message-ID: <20160915162030.GX13920__18825.7078211338$1473955953$gmane$org@localhost>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
	<20160913093107.GA10953@griffinp-ThinkPad-X1-Carbon-2nd>
	<20160913180616.GD21438@tuxbot> <20160914130739.GE13920@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160914130739.GE13920@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, airlied@linux.ie, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, dmaengine@vger.kernel.org, dan.j.williams@intel.com, virtualization@lists.linux-foundation.org, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 14, 2016 at 06:37:40PM +0530, Vinod Koul wrote:
> On Tue, Sep 13, 2016 at 11:06:16AM -0700, Bjorn Andersson wrote:
> > > I hate to send a ping,
> > 
> > Sorry about that.
> > 
> > > but do you think we can merge this fdma series? It has gone
> > > through quite a few review rounds now.
> > > 
> > 
> > I think the remoteproc part looks good.
> 
> yeah I was waiting for ack on other patches. But looks like at least
> remoteproc ones have it
> 
> 
> > Vinod, I don't have any changes queued in remoteproc that should cause
> > merge issues. If you want to you could take the remoteproc patch
> > through your tree.
> 
> I rechecked the dma part, they look good to me, so I should be able to apply
> these. I will wait a day for ack/nacks. It is the time to speak up :)

And I have applied thru 9th patch. Others are applied by Patrice.

Btw you should send drm ones to drm folks separately and not in this
series..

Thanks
-- 
~Vinod
