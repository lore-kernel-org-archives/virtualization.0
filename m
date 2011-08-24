From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 4/8] Staging: hv: vmbus: Fix checkpatch warnings
Date: Wed, 24 Aug 2011 01:10:32 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B23CD@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1311101018-23370-1-git-send-email-kys@microsoft.com>
	<1311101065-23417-1-git-send-email-kys@microsoft.com>
	<1311101065-23417-4-git-send-email-kys@microsoft.com>
	<20110823231657.GC9955@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110823231657.GC9955@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Greg KH <greg@kroah.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, August 23, 2011 7:17 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 4/8] Staging: hv: vmbus: Fix checkpatch warnings
> 
> On Tue, Jul 19, 2011 at 11:44:21AM -0700, K. Y. Srinivasan wrote:
> > Fix  checkpatch warnings in hv.c
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/staging/hv/hv.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/hv/hv.c b/drivers/staging/hv/hv.c
> > index e733173..14e6315 100644
> > --- a/drivers/staging/hv/hv.c
> > +++ b/drivers/staging/hv/hv.c
> > @@ -111,7 +111,7 @@ static u64 do_hypercall(u64 control, void *input, void
> *output)
> >  	u64 hv_status = 0;
> >  	u64 input_address = (input) ? virt_to_phys(input) : 0;
> >  	u64 output_address = (output) ? virt_to_phys(output) : 0;
> > -	volatile void *hypercall_page = hv_context.hypercall_page;
> > +	void *hypercall_page = hv_context.hypercall_page;
> 
> Are you sure?  This was just someone being foolish?  No other reason
> someone tried to use volatile here?

I cannot see any reason why this needs to be volatile.

Regards,

K. Y
> 
> greg k-h
