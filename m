From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 1/1] hv: Use only one txf buffer per channel and
 kmalloc on initialize
Date: Mon, 13 Dec 2010 13:47:06 -0800
Message-ID: <20101213214706.GA20991@suse.de>
References: <1292274861-29673-1-git-send-email-hjanssen@microsoft.com>
 <alpine.LNX.2.00.1012132220220.26491@swampdragon.chaosbits.net>
 <8AFC7968D54FB448A30D8F38F259C5622C0BCDFC@TK5EX14MBXC116.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C5622C0BCDFC@TK5EX14MBXC116.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: Jesper Juhl <jj@chaosbits.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Evgeniy Polyakov <zbr@ioremap.net>, Ky Srinivasan <ksrinivasan@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 13, 2010 at 09:31:09PM +0000, Hank Janssen wrote:
> 
> > From: Jesper Juhl [mailto:jj@chaosbits.net]
> > Sent: Monday, December 13, 2010 1:22 PM
> > 
> > I can't spot any problems with these changes now, so feel free to add
> >   Reviewed-by: Jesper Juhl <jj@chaosbits.net> if you like.
> > 
> 
> Thank you for your help Jesper.
> 
> Greg, do you want me to resubmit with the Reviewed by line? Or do you 
> Add it once you queue it up for linux-next?

I add it when I apply it.

thanks,

greg k-h
