From: Greg KH <gregkh@suse.de>
Subject: Re: [patch 47/54] Staging: hv: make gVmbusConnection.ChannelLock a
 real spinlock
Date: Mon, 20 Jul 2009 19:11:26 -0700
Message-ID: <20090721021126.GB11051@suse.de>
References: <20090717180850.873962925@mini.kroah.org>
 <20090717180923.620590305@mini.kroah.org>
 <200907210139.19672.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754749AbZGUCfV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200907210139.19672.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org, Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 21, 2009 at 01:39:19AM +0200, Arnd Bergmann wrote:
> On Friday 17 July 2009, Greg Kroah-Hartman wrote:
> > I don't think we really want to be doing a irqsave for this code, but I
> > left it alone to preserve the original codepath.  It should be reviewed
> > later.
> 
> This patch does not preserve the original code path if any of the
> callers has a different irq state from the others. When flags is
> shared, releasing the lock actually sets the irq state to whatever
> another thread was using when failing to acquire the lock while
> it was held.
> 
> The patch of course looks good, but the comment is misleading.

Good point, sorry for the misleading comment.

I'll let Hank work out the details as to if the irqsave mode is needed
or not :)

thanks,

greg k-h
