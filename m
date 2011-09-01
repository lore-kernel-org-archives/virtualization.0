From: Greg KH <greg@kroah.com>
Subject: Re: Hyper-V TODO file
Date: Thu, 1 Sep 2011 13:31:13 -0700
Message-ID: <20110901203113.GA15259@kroah.com>
References: <1314829011-28922-1-git-send-email-kys@microsoft.com>
 <alpine.LNX.2.00.1108311907130.20924@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1108311907130.20924@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Foley <pefoley2@verizon.net>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 31, 2011 at 07:11:39PM -0400, Peter Foley wrote:
> On Wed, 31 Aug 2011, K. Y. Srinivasan wrote:
> > Greg, as I have been pestering you for some time now, we are very interested in
> > exiting staging and we are willing to dedicate the necessary development 
> > resources to address whatever issues that may still be pending. So, your help
> > in identifying what needs to be done will be greatly appreciated. To that end,
> > I think it will be useful to update the TODO file to reflect the current state of
> > the drivers. Let us know how we should proceed here. 
>  
> An issue I've come across in the hyper-v drivers is the forced modular 
> build. You might want to see if the "depends on m" is still needed.

Ah, good point, KY, can you try this out and see if that can be changed?
If not, something is wrong and that needs to get fixed.

thanks,

greg k-h
