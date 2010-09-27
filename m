From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/1] Rename camel case variables in channel.c  (updated
	again)
Date: Mon, 27 Sep 2010 12:32:16 -0700
Message-ID: <20100927193216.GA25924@kroah.com>
References: <1FB5E1D5CA062146B38059374562DF7289ED89CF@TK5EX14MBXC130.redmond.corp.microsoft.com> <1FB5E1D5CA062146B38059374562DF7289EDBC9E@TK5EX14MBXC130.redmond.corp.microsoft.com> <20100927011943.GA6936@kroah.com> <1FB5E1D5CA062146B38059374562DF7289F076BD@TK5EX14MBXC128.redmond.corp.microsoft.com> <20100927061029.GC22319@suse.de> <1FB5E1D5CA062146B38059374562DF7289F13EFE@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF7289F13EFE@TK5EX14MBXC128.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Greg KH <gregkh@suse.de>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 27, 2010 at 05:57:32PM +0000, Haiyang Zhang wrote:
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Monday, September 27, 2010 2:10 AM
> > >
> > > I checked the email I sent on Friday, it was in "Plain Text" format.
> > > This was the same format I used for my patches which were accepted
> > > previously. Maybe Outlook server converted this one to MIME format?
> > > I'm not sure.
> > >
> > > I have attached the patch in Linux text format, which I have verified
> > > with 'patch' command. No error:
> > >
> > > linux-next> patch -p1 <0924.2-Rename-camel-case-variables-in-
> > channel.c.patch
> > > patching file drivers/staging/hv/channel.c
> > > linux-next>
> > >
> > > Could you try the attached patch on your side?
> > 
> > Yes, that worked, but you do realize you attached it in base64 mode,
> > right?  That sure isn't going to work...
> 
> While we are setting up a new mail server for sending patches, could you
> apply attached patches in the meanwhile? So I can continue to work on
> more patches.

I'd prefer not to, there are plenty of "free" email servers out there
that work just fine that you could use, right?

What's wrong with using 'git send-email' with your server?  Have you
tried that?  That shouldn't change the mime-type of the patch, and if it
does, that would be grounds for a bug to be filed against such a server,
right?

> This attachment can also be downloaded by this Linux command as plain text
> without any encoding:
>   wget http://driverdev.linuxdriverproject.org/pipermail/devel/attachments/20100927/51d954b0/attachment.obj

While nice, that's just not going to work with our workflow, sorry.
Somehow over 2000 other kernel developers each year get their email
clients/server to work fine, there's no reason you all can't as well :)

thanks,

greg k-h
