From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 00/12] Staging: hv: Cleanup vmbus driver - Phase II
Date: Thu, 17 Mar 2011 14:45:37 -0700
Message-ID: <20110317214537.GA28608@suse.de>
References: <1300226527-26933-1-git-send-email-kys@microsoft.com>
 <20110315220454.GC30390@suse.de>
 <30255.1300397967@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <30255.1300397967@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 17, 2011 at 05:39:27PM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 15 Mar 2011 15:04:54 PDT, Greg KH said:
> 
> > Thanks for the patches, but as the .39 merge window is closed, I'll be
> > holding on to these until after .39-rc1 is out before I can do anything
> > with them.
> 
> Is that Linus's merge window, or your window to freeze a for-linus tree?

My window.

Linus's merge window is for the subsystem maintainers.  Everything that
is to be sent during Linus's merge window had to be in the linux-next
tree for a bit of time before the merge window opens.

It's been this way for a number of years now, nothing new happening
here...

I also posted the "my tree is now closed for .39 stuff" message to the
devel mailing list, so there shouldn't have been any questions about
this.

thanks,

greg k-h
