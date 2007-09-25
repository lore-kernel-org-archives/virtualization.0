From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/3] virtio module alias support
Date: Mon, 24 Sep 2007 18:57:47 -0700
Message-ID: <20070925015747.GA16011__20753.4790192314$1190685537$gmane$org@kroah.com>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
	<1190625394.27805.206.camel@localhost.localdomain>
	<20070924160221.GB5846@kroah.com>
	<1190681405.27805.243.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1190681405.27805.243.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Sep 25, 2007 at 10:50:04AM +1000, Rusty Russell wrote:
> On Mon, 2007-09-24 at 09:02 -0700, Greg KH wrote:
> > On Mon, Sep 24, 2007 at 07:16:34PM +1000, Rusty Russell wrote:
> > > This adds the logic to convert the virtio ids into module aliases, and
> > > includes a modalias entry in sysfs.
> > > 
> > > Unfortunately this does not seem sufficient to have the module
> > > autoprobed at startup on my Ubuntu system.  Greg?  Am I missing some
> > > udev magic?
> > 
> > You also need to pass the MODINFO environment variable to the hotplug
> > call so that udev can pick it up.
> > 
> > hope this helps,
> 
> Well, I finally decoded this as follows:
> 
>         You need to implement the bus_type.uevent hook, and use
>         add_uevent_var() to add a "MODALIAS=virtio:..." var.  See
>         drivers/pci/hotplug.c.

Ah, sorry, thanks for intrepreting it properly :)

> Not sure why I need the modalias here when it's in sysfs.  But, it
> works.

udev does not read from sysfs anymore, it just uses the environment
variables.  It's faster and race-free that way.

thanks,

greg k-h
