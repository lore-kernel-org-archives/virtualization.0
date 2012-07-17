From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/15] Drivers: hv: Format GUIDS as per MSFT standards
Date: Tue, 17 Jul 2012 09:32:48 -0700
Message-ID: <20120717163248.GA29345@kroah.com>
References: <1342297930-12607-1-git-send-email-kys@microsoft.com>
	<1342298060-12662-1-git-send-email-kys@microsoft.com>
	<20120717160402.GA20481@kroah.com>
	<1342541966.15318.4.camel@joe2Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1342541966.15318.4.camel@joe2Laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: olaf@aepfle.de, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, apw@canonical.com, devel@linuxdriverproject.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 17, 2012 at 09:19:26AM -0700, Joe Perches wrote:
> On Tue, 2012-07-17 at 09:04 -0700, Greg KH wrote:
> > On Sat, Jul 14, 2012 at 01:34:06PM -0700, K. Y. Srinivasan wrote:
> > > Format GUIDS as per MSFT standard. This makes interacting with MSFT
> > > tool stack easier.
> []
> > > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> []
> > > @@ -147,7 +147,7 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
> > >  
> > >  	if (!strcmp(dev_attr->attr.name, "class_id")) {
> > >  		ret = sprintf(buf, "{%02x%02x%02x%02x-%02x%02x-%02x%02x-"
> > > -			       "%02x%02x%02x%02x%02x%02x%02x%02x}\n",
> > > +			       "%02x%02x-%02x%02x%02x%02x%02x%02x}\n",
> > 
> > As Joe pointed out, please just use the printk modifier the kernel
> > already has for GUIDS, and don't roll your own here.  That will work
> > properly for you, right?
> 
> %pU became available in 2.6.33
> 
> I think one of their support targets is RHEL6 which
> I believe is 2.6.32+.

That's nice, but it's nothing that I care about for in-kernel code, nor
should anyone else.

greg k-h
