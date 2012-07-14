From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 01/15] Drivers: hv: Format GUIDS as per MSFT standards
Date: Sat, 14 Jul 2012 23:23:08 +0000
Message-ID: <426367E2313C2449837CD2DE46E7EAF9223B702C@SN2PRD0310MB382.namprd03.prod.outlook.com>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
 <1342298060-12662-1-git-send-email-kys@microsoft.com>
 <1342297484.8377.28.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1342297484.8377.28.camel@joe2Laptop>
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
To: Joe Perches <joe@perches.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Saturday, July 14, 2012 4:25 PM
> To: KY Srinivasan
> Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; olaf@aepfle.de;
> apw@canonical.com
> Subject: Re: [PATCH 01/15] Drivers: hv: Format GUIDS as per MSFT standards
> 
> On Sat, 2012-07-14 at 13:34 -0700, K. Y. Srinivasan wrote:
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
> >  			       device_info->chn_type.b[3],
> >  			       device_info->chn_type.b[2],
> >  			       device_info->chn_type.b[1],
> > @@ -166,7 +166,7 @@ static ssize_t vmbus_show_device_attr(struct device
> *dev,
> >  			       device_info->chn_type.b[15]);
> >  	} else if (!strcmp(dev_attr->attr.name, "device_id")) {
> >  		ret = sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
> > -			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
> > +			       "%02x%02x-%02x%02x%02x%02x%02x%02x}\n",
> >  			       device_info->chn_instance.b[3],
> >  			       device_info->chn_instance.b[2],
> >  			       device_info->chn_instance.b[1],
> 
> 	ret = sprintf(buf, "{%pUl}\n", device_info->chn_instance.b);

Thank you Joe. I recall seeing some patches from you a longtime ago on this.
I was just modifying existing code in this patch; if it is ok with you I will send a
separate patch using the preferred format string for printing GUIDS.
 
Regards,

K. Y
