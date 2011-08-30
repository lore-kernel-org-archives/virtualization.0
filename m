From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 46/46] Staging: hv: Update the TODO file
Date: Tue, 30 Aug 2011 17:13:01 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B5328@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-46-git-send-email-kys@microsoft.com>
	<20110829181206.GB19668@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110829181206.GB19668@kroah.com>
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
> Sent: Monday, August 29, 2011 2:12 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 46/46] Staging: hv: Update the TODO file
> 
> On Sat, Aug 27, 2011 at 11:31:45AM -0700, K. Y. Srinivasan wrote:
> > Update the TODO file.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/staging/hv/TODO |   24 ++++++++++++++++++++----
> >  1 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO
> > index 582fd4a..23c74ed 100644
> > --- a/drivers/staging/hv/TODO
> > +++ b/drivers/staging/hv/TODO
> > @@ -1,14 +1,30 @@
> >  TODO:
> > -	- fix remaining checkpatch warnings and errors
> >  	- audit the vmbus to verify it is working properly with the
> >  	  driver model
> > -	- see if the vmbus can be merged with the other virtual busses
> > -	  in the kernel
> > +
> > +		STATUS (July 19, 2011):
> > +		All outstanding issues (known to us)  with regards
> > +		to conforming to Linux Driver Model have been addressed.
> 
> The TODO file is not a place to have a "conversation" about what is and
> is not completed by having status reports.
> 
> Let's discuss this through email, and if we all agree, then the TODO
> entries can be removed.

Ok; will do.

K. Y
> 
> greg k-h
