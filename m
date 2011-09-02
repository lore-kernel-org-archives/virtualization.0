From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Staging: hv: vmbus: Show the modalias in
	/sys/bus/vmbus/devices/*/
Date: Fri, 2 Sep 2011 11:12:03 -0700
Message-ID: <20110902181203.GA29430@suse.de>
References: <20110902162556.GA25073@aepfle.de> <20110902163550.GA5508@suse.de>
	<6E21E5352C11B742B20C142EB499E048081B605D@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E048081B605D@TK5EX14MBXC126.redmond.corp.microsoft.com>
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
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Olaf Hering <olaf@aepfle.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 02, 2011 at 05:53:37PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Friday, September 02, 2011 12:36 PM
> > To: Olaf Hering
> > Cc: KY Srinivasan; linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> > virtualization@lists.osdl.org
> > Subject: Re: [PATCH] Staging: hv: vmbus: Show the modalias in
> > /sys/bus/vmbus/devices/*/
> > 
> > On Fri, Sep 02, 2011 at 06:25:56PM +0200, Olaf Hering wrote:
> > > Show a modalias file in /sys/bus/vmbus/devices/*/
> > > Add a helper function to print the same content in modalias and uevent.
> > >
> > > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> > 
> > Nice idea, thanks for this, one minor nit below:
> > 
> > > ---
> > >  drivers/staging/hv/vmbus_drv.c |   21 ++++++++++++++++-----
> > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > >
> > > --- a/drivers/staging/hv/vmbus_drv.c
> > > +++ b/drivers/staging/hv/vmbus_drv.c
> > > @@ -93,6 +93,14 @@ static void get_channel_info(struct hv_d
> > >  		debug_info.outbound.bytes_avail_towrite;
> > >  }
> > >
> > > +#define VMBUS_ALIAS_LEN ((sizeof((struct hv_vmbus_device_id *)0)->guid)
> > * 2)
> > > +static void print_alias_name(struct hv_device *hv_dev, char *alias_name)
> > > +{
> > > +	int i;
> > > +	for (i = 0; i < VMBUS_ALIAS_LEN; i += 2)
> > > +		sprintf(&alias_name[i], "%02x", hv_dev->dev_type.b[i/2]);
> > > +}
> > > +
> > >  /*
> > >   * vmbus_show_device_attr - Show the device attribute in sysfs.
> > >   *
> > > @@ -105,6 +113,7 @@ static ssize_t vmbus_show_device_attr(st
> > >  {
> > >  	struct hv_device *hv_dev = device_to_hv_device(dev);
> > >  	struct hv_device_info device_info;
> > > +	char alias_name[VMBUS_ALIAS_LEN + 1];
> > 
> > Is that too big to put on the stack?  64 bytes, right?  Hm, maybe not.
> > 
> > Wait, hv_device_info is huge, that should be dynamic in the first place.
> > Olaf, not your issue, but KY, want to fix that up?
> 
> hv_device_info is about 101 bytes. I will fix this. Greg, if you are applying Olaf's patch,
> I will generate my patch on top of Olaf's. Let me know.

I'll take his, and then feel free to send me one on top of that fixing
this.

But again, as kernel.org is still down, I can't apply anything until
next week at the earliest, sorry.

greg k-h
