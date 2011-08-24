From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 086/117] Staging: hv: storvsc: Leverage the spinlock to
	manage ref_cnt
Date: Wed, 24 Aug 2011 00:58:36 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B239E@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-86-git-send-email-kys@microsoft.com>
	<20110823231028.GO9641@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110823231028.GO9641@kroah.com>
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
> Sent: Tuesday, August 23, 2011 7:10 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 086/117] Staging: hv: storvsc: Leverage the spinlock to
> manage ref_cnt
> 
> On Fri, Jul 15, 2011 at 10:47:14AM -0700, K. Y. Srinivasan wrote:
> > Now that we have a spin lock protecting access to the stor device pointer,
> > use it manage the reference count as well.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/staging/hv/hyperv_storage.h |    8 ++++----
> >  drivers/staging/hv/storvsc.c        |   10 +++++-----
> >  2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/staging/hv/hyperv_storage.h
> b/drivers/staging/hv/hyperv_storage.h
> > index 53b65be..d946211 100644
> > --- a/drivers/staging/hv/hyperv_storage.h
> > +++ b/drivers/staging/hv/hyperv_storage.h
> > @@ -265,7 +265,7 @@ struct storvsc_device {
> >  	struct hv_device *device;
> >
> >  	/* 0 indicates the device is being destroyed */
> > -	atomic_t ref_count;
> > +	int	 ref_count;
> 
> Is this really needed?  Can't you rely on the reference count of the
> hv_device itself?

We don't have a reference count on the hv_device and this count is taken
to deal with racing unloads and incoming traffic on the channel from the 
host. 

Regards,

K. Y
