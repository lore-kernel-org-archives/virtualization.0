From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v8 01/18] remoteproc: st_slim_rproc: add a slimcore rproc
	driver
Date: Wed, 31 Aug 2016 12:11:36 +0100
Message-ID: <20160831111136.GA16490@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
	<1472223413-7254-2-git-send-email-peter.griffin@linaro.org>
	<20160830123453.GG10121@dell> <20160830165409.GM15161@tuxbot>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160830165409.GM15161@tuxbot>
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
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, vinod.koul@intel.com, linux-remoteproc@vger.kernel.org, patrice.chotard@st.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, airlied@linux.ie, dmaengine@vger.kernel.org, dan.j.williams@intel.com, virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Bjorn,

On Tue, 30 Aug 2016, Bjorn Andersson wrote:

> On Tue 30 Aug 05:34 PDT 2016, Lee Jones wrote:
> 
> Thanks for your review Lee.
> 
> > On Fri, 26 Aug 2016, Peter Griffin wrote:
> [..]
> > > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > > index 1a8bf76a..06765e0 100644
> > > --- a/drivers/remoteproc/Kconfig
> > > +++ b/drivers/remoteproc/Kconfig
> > > @@ -100,4 +100,12 @@ config ST_REMOTEPROC
> > >  	  processor framework.
> > >  	  This can be either built-in or a loadable module.
> > >  
> > > +config ST_SLIM_REMOTEPROC
> > > +	tristate "ST Slim remoteproc support"
> > > +	select REMOTEPROC
> > > +	help
> > > +	  Say y here to support firmware loading on IP based around
> > > +	  the Slim core.
> > > +	  If unsure say N.
> 
> Saw one more thing when browsing through...
> 
> As this piece of code doesn't do anything on its own and is going to be
> selected by the "function driver" I don't think this should be
> user-selectable.

Applogies, I believe you pointed this out in a previous review, but it seems to
have slipped through the net. Will fix in the next version.

Regards,

Peter.
