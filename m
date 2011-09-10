From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 09/25] Staging: hv: util: Perform some service specific
	de-initialization in util_remove()
Date: Sat, 10 Sep 2011 14:31:15 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081DC4C7@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-9-git-send-email-kys@microsoft.com>
	<20110909204240.GF19127@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110909204240.GF19127@kroah.com>
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
> Sent: Friday, September 09, 2011 4:43 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 09/25] Staging: hv: util: Perform some service specific de-
> initialization in util_remove()
> 
> On Thu, Sep 08, 2011 at 07:24:20AM -0700, K. Y. Srinivasan wrote:
> > In preparation for modifying the util driver to fully conform to the
> > Linux Driver Model, perform some service specific de-initialization in
> > util_remove() as opposed to in exit_hyperv_utils() as is currently done.
> >
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/staging/hv/hv_util.c |   29 ++++++++++++++++++++++++-----
> >  1 files changed, 24 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
> > index b86128a..2475ab2 100644
> > --- a/drivers/staging/hv/hv_util.c
> > +++ b/drivers/staging/hv/hv_util.c
> > @@ -291,6 +291,30 @@ error:
> >  static int util_remove(struct hv_device *dev,
> >  			const struct hv_vmbus_device_id *dev_id)
> >  {
> > +	int service = dev_id->driver_data;
> > +
> > +	switch (service) {
> > +	case HV_SHUTDOWN:
> > +		kfree(shut_txf_buf);
> > +		break;
> 
> This switch and "static" pointers you need to free aren't needed at all
> if you do this code logic correctly (i.e. a per-device buffer.)
> 
> {sigh}
> 
> I'm stopping reviewing now, this is making me grumpy, someone owes me a
> bunch of beer...

Greg,

I will rework this to be more on the lines of what you had suggested; and yes,
I remember my original promise! I want to re-spin these patches and send it to 
you as soon as possible. Which tree can I clone to get your latest check-ins; kernel.org
still seems to have issues this morning. Have you checked in Olaf's patches.

Thanks,

K. Y
