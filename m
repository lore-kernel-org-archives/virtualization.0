From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/3] virtio module alias support
Date: Mon, 24 Sep 2007 20:10:34 -0700
Message-ID: <20070925031034.GA16425__15456.7452533685$1190689754$gmane$org@kroah.com>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
	<1190625394.27805.206.camel@localhost.localdomain>
	<20070924160221.GB5846@kroah.com>
	<1190681405.27805.243.camel@localhost.localdomain>
	<20070925015747.GA16011@kroah.com>
	<1190686275.27805.255.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1190686275.27805.255.camel@localhost.localdomain>
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

On Tue, Sep 25, 2007 at 12:11:15PM +1000, Rusty Russell wrote:
> On Mon, 2007-09-24 at 18:57 -0700, Greg KH wrote:
> > On Tue, Sep 25, 2007 at 10:50:04AM +1000, Rusty Russell wrote:
> > > Not sure why I need the modalias here when it's in sysfs.  But, it
> > > works.
> > 
> > udev does not read from sysfs anymore, it just uses the environment
> > variables.  It's faster and race-free that way.
> 
> Should I leave the modalias entry in sysfs for back compat, or not?
> This will be for >= 2.6.24 only...

No, leave it in sysfs, other tools use it (like older versions of udev).

thanks,

greg k-h
