From: Joe Perches <joe@perches.com>
Subject: RE: [PATCH 01/15] Drivers: hv: Format GUIDS as per MSFT standards
Date: Sat, 14 Jul 2012 16:28:31 -0700
Message-ID: <1342308511.8377.51.camel@joe2Laptop>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
 <1342298060-12662-1-git-send-email-kys@microsoft.com>
 <1342297484.8377.28.camel@joe2Laptop>
 <426367E2313C2449837CD2DE46E7EAF9223B702C@SN2PRD0310MB382.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <426367E2313C2449837CD2DE46E7EAF9223B702C@SN2PRD0310MB382.namprd03.prod.outlook.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "apw@canonical.com" <apw@canonical.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2012-07-14 at 23:23 +0000, KY Srinivasan wrote:
> > -----Original Message-----
> > From: Joe Perches [mailto:joe@perches.com]
> > Sent: Saturday, July 14, 2012 4:25 PM
[]
> > On Sat, 2012-07-14 at 13:34 -0700, K. Y. Srinivasan wrote:
> > > Format GUIDS as per MSFT standard. This makes interacting with MSFT
> > > tool stack easier.
[]
> > > @@ -166,7 +166,7 @@ static ssize_t vmbus_show_device_attr(struct device
> > *dev,
> > >  			       device_info->chn_type.b[15]);
> > >  	} else if (!strcmp(dev_attr->attr.name, "device_id")) {
> > >  		ret = sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
> > > -			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
> > > +			       "%02x%02x-%02x%02x%02x%02x%02x%02x}\n",
> > >  			       device_info->chn_instance.b[3],
> > >  			       device_info->chn_instance.b[2],
> > >  			       device_info->chn_instance.b[1],
> > 
> > 	ret = sprintf(buf, "{%pUl}\n", device_info->chn_instance.b);
> 
> Thank you Joe. I recall seeing some patches from you a longtime ago on this.
> I was just modifying existing code in this patch; if it is ok with you I will send a
> separate patch using the preferred format string for printing GUIDS.

Hi KY.  It's your code.  Do what you think best.  cheers, Joe
