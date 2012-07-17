From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 01/15] Drivers: hv: Format GUIDS as per MSFT standards
Date: Tue, 17 Jul 2012 17:42:33 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9224EA2E5@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
 <1342298060-12662-1-git-send-email-kys@microsoft.com>
 <20120717160402.GA20481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20120717160402.GA20481@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Tuesday, July 17, 2012 12:04 PM
> To: KY Srinivasan
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org; olaf@aepfle.de; apw@canonical.com
> Subject: Re: [PATCH 01/15] Drivers: hv: Format GUIDS as per MSFT standards
> 
> On Sat, Jul 14, 2012 at 01:34:06PM -0700, K. Y. Srinivasan wrote:
> > Format GUIDS as per MSFT standard. This makes interacting with MSFT
> > tool stack easier.
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  drivers/hv/vmbus_drv.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index a220e57..1f7e54a 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -147,7 +147,7 @@ static ssize_t vmbus_show_device_attr(struct device
> *dev,
> >
> >  	if (!strcmp(dev_attr->attr.name, "class_id")) {
> >  		ret = sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
> > -			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
> > +			       "%02x%02x-%02x%02x%02x%02x%02x%02x}\n",
> 
> As Joe pointed out, please just use the printk modifier the kernel
> already has for GUIDS, and don't roll your own here.  That will work
> properly for you, right?

Will do. Please drop the patch-set; I will post new patches soon.

K. Y
