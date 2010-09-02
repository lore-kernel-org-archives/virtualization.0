From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 5/5] staging: hv: Gracefully handle SCSI resets - RESEND
Date: Thu, 2 Sep 2010 13:08:39 -0700
Message-ID: <20100902200839.GD16897@kroah.com>
References: <4C7D4848.6090409@sailtheuniverse.com>
	<1283358535.1797.174.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1283358535.1797.174.camel@Joe-Laptop>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Joe Perches <joe@perches.com>
Cc: devel@driverdev.osuosl.org, haiyangz@microsoft.com, gregkh@suse.de, Hank Janssen <hjanssen@sailtheuniverse.com>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 01, 2010 at 09:28:53AM -0700, Joe Perches wrote:
> On Tue, 2010-08-31 at 11:22 -0700, Hank Janssen wrote:
> > If we get a SCSI host bus reset we now gracefully handle it, and we 
> > take the device offline. This before sometimes caused hangs.
> > ---
> >  drivers/staging/hv/storvsc.c |   36 +++++++++++++++++++++++++++++++++++-
> []
> > +	/*
> > +	 * Wait for traffic in transit to complete
> > +	 */
> > +	while (atomic_read(&storDevice->NumOutstandingRequests))
> > +		udelay(1000);
> > +
> 
> Is it useful to have a maximum check or timeout?
> Maybe use usleep_range?

Yeah, that's not good, you need to have some way to get out of here in
case something bad happens and that number never goes down.

Why not just use a completion function instead of a busy loop?

thanks,

greg k-h
