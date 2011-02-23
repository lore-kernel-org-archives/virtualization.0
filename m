From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/6] Staging: hv: hv.c Removed all DPRINT and debug -
 using pr_err now
Date: Wed, 23 Feb 2011 15:48:25 -0800
Message-ID: <20110223234825.GB16936@kroah.com>
References: <1298417565-12356-1-git-send-email-hjanssen@microsoft.com>
 <1298417565-12356-2-git-send-email-hjanssen@microsoft.com>
 <20110223191533.GB1030@kroah.com>
 <8AFC7968D54FB448A30D8F38F259C56233FADA94@TK5EX14MBXC118.redmond.corp.microsoft.com>
 <20110223215658.GB16908@kroah.com>
 <8AFC7968D54FB448A30D8F38F259C56233FAE0E8@TK5EX14MBXC118.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C56233FAE0E8@TK5EX14MBXC118.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, KY Srinivasan <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 23, 2011 at 11:17:54PM +0000, Hank Janssen wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH [mailto:greg@kroah.com]
> > Sent: Wednesday, February 23, 2011 1:57 PM
> > They where compile and run tested. And syslog was not a mess. What did
> > > I mess up here? The amount of printouts now are a fraction of what
> > > they where before.
> > 
> > You forgot to put '\n' at the end of all of your pr_XXX lines, so they will be
> > merged with the next one, messing up your syslog.  Joe also pointed this
> > problem out.
> > 
> > Take a look at your syslog to see what I am talking about...
> 
> I am trying to get some of these patches corrected and out today, but it might
> be tomorrow. So far I have lost power for a minutes or so twice this afternoon.

No rush, I've flushed out all of my staging tree patches today, so it
will be a number of days before I revisit them again.

thanks,

greg k-h
