From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Connector: Correctly set the error code in case of
 success when dispatching receive callbacks
Date: Tue, 17 May 2011 16:05:15 -0700
Message-ID: <20110517230515.GA18386@kroah.com>
References: <1305671138-19443-1-git-send-email-kys@microsoft.com>
 <1305671138-19443-2-git-send-email-kys@microsoft.com>
 <20110517223155.GC15741@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481FB74C@TK5EX14MBXC122.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481FB74C@TK5EX14MBXC122.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 17, 2011 at 10:53:18PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Tuesday, May 17, 2011 6:32 PM
> > To: KY Srinivasan
> > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; virtualization@lists.osdl.org
> > Subject: Re: [PATCH 2/2] Connector: Correctly set the error code in case of
> > success when dispatching receive callbacks
> > 
> > On Tue, May 17, 2011 at 03:25:38PM -0700, K. Y. Srinivasan wrote:
> > > The recent changes to the connector code introduced this bug where even
> > > when a callback was invoked, we would return an error resulting in
> > > double freeing of the skb. This patch fixes this bug.
> > 
> > By "recent" what do you mean?  Is this something that is in the .39
> > kernel?  Do you have a git commit id that caused this?
> > 
> > Or is this due to changes that are queued up for the .40 merge window?
> 
> I just happened to test KVP functionality yesterday on latest bits from your tree (NEXT)
> and discovered that whenever  something was sent to the kernel from userland on a 
> connector channel, the system would hang. The following commit appears to be where
> this bug was introduced:
> 
> commit 04f482faf50535229a5a5c8d629cf963899f857c
> Author: Patrick McHardy <kaber@trash.net>
> Date:   Mon Mar 28 08:39:36 2011 +0000
> 
> Since prior to this commit I don't see this problem. In any event the current code is clearly
> broken.

Ok, since this was released in the 2.6.39-rc2 kernel, this needs to get
backported to the .39-stable kernel release as well, I'll mark it as
such when I apply it to the tree.

thanks,

greg k-h
