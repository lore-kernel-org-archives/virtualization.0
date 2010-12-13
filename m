From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] hv: Use only one receive buffer and kmalloc on
	initialize
Date: Mon, 13 Dec 2010 11:41:01 -0800
Message-ID: <20101213194101.GA18431@kroah.com>
References: <1292262350-29001-1-git-send-email-hjanssen@microsoft.com>
	<20101213183448.GA11745@kroah.com>
	<8AFC7968D54FB448A30D8F38F259C5622C0BB71F@TK5EX14MBXC116.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C5622C0BB71F@TK5EX14MBXC116.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 13, 2010 at 07:31:42PM +0000, Hank Janssen wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Monday, December 13, 2010 10:35 AM
> > > ---
> > >  drivers/staging/hv/hv_utils.c |   68 +++++++++++++++++++------------------
> > ---
> > >  1 files changed, 32 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/drivers/staging/hv/hv_utils.c
> > > b/drivers/staging/hv/hv_utils.c index 53e1e29..4ed4ab8 100644
> > > --- a/drivers/staging/hv/hv_utils.c
> > > +++ b/drivers/staging/hv/hv_utils.c
> > > @@ -38,12 +38,15 @@
> > >  #include "vmbus_api.h"
> > >  #include "utils.h"
> > >
> > > +/*
> > > + * Buffer used to receive packets from Hyper-V  */ static u8
> > > +*chan_buf;
> > 
> > One buffer is nicer, yes, but what's controlling access to this buffer?
> > You use it in multiple functions, and what's to say those functions can't be
> > called at the same time on different cpus?  So, shouldn't you either have
> > some locking for access to the buffer, or have a per-function buffer instead?
> > 
> > And if you have a per-function buffer, again, you might need to control
> > access to it as the functions could be called multiple times at the same time,
> > right?
> > 
> 
> The current versions of Hyper-V support interrupt handling on CPU0 only.
> I can make multiple buffers per channel, but because of Hyper-V implementation
> It does not really make a difference.

Then put a big fat note in there saying this, and that it will have to
change if the hyperv channel ever changes.

Hm, how will you handle things if the hyperv core changes and an old
kernel is running this code where things were "assumed" about the
reentrancy happening here?

thanks,

greg k-h
