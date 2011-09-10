From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 18/25] Staging: hv: storvsc: Eliminate the usage of ext
 field in struct  hv_device
Date: Sat, 10 Sep 2011 20:28:31 +0200
Message-ID: <20110910182831.GA30865@suse.de>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
 <1315491876-9554-1-git-send-email-kys@microsoft.com>
 <1315491876-9554-18-git-send-email-kys@microsoft.com>
 <20110909204451.GH19127@kroah.com>
 <6E21E5352C11B742B20C142EB499E048081DC4A1@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E048081DC4A1@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <greg@kroah.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Sep 10, 2011 at 02:16:14PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Friday, September 09, 2011 4:45 PM
> > To: KY Srinivasan
> > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> > Subject: Re: [PATCH 18/25] Staging: hv: storvsc: Eliminate the usage of ext field in
> > struct hv_device
> > 
> > On Thu, Sep 08, 2011 at 07:24:29AM -0700, K. Y. Srinivasan wrote:
> > > Now, eliminate the usage of ext field in struct  hv_device for storvsc driver.
> > > We do this by registering pointer to struct storvsc_device as the driver
> > > specific data and eliminating the current usage of driver specific data to
> > > save and retrieve the pointer to struct Scsi_Host.
> > > Additionally, all access to the driver specific data is through
> > > the vmbus wrapper functions.
> > >
> > > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > ---
> > >  drivers/staging/hv/storvsc_drv.c |   24 +++++++++++++++---------
> > >  1 files changed, 15 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
> > > index 57c1035..98d47cd 100644
> > > --- a/drivers/staging/hv/storvsc_drv.c
> > > +++ b/drivers/staging/hv/storvsc_drv.c
> > > @@ -266,6 +266,7 @@ struct storvsc_device {
> > >  	bool	 destroy;
> > >  	bool	 drain_notify;
> > >  	atomic_t num_outstanding_req;
> > > +	struct Scsi_Host *host;
> > 
> > You are properly reference counting this pointer, right?
> 
> The scsi_host_alloc() which we use to allocate the host structure, gives us
> the needed reference.

Ok, thanks, I missed that.  The casting though should be taken out,
otherwise the janitor project will just come along and clean it up
again...

greg k-h
