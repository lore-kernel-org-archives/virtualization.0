From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: RE: [PATCH 1/1] Rename camel case variables in channel.c  (updated
 again)
Date: Mon, 27 Sep 2010 17:57:32 +0000
Message-ID: <1FB5E1D5CA062146B38059374562DF7289F13EFE@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <1FB5E1D5CA062146B38059374562DF7289ED89CF@TK5EX14MBXC130.redmond.corp.microsoft.com>
 <1FB5E1D5CA062146B38059374562DF7289EDBC9E@TK5EX14MBXC130.redmond.corp.microsoft.com>
 <20100927011943.GA6936@kroah.com>
 <1FB5E1D5CA062146B38059374562DF7289F076BD@TK5EX14MBXC128.redmond.corp.microsoft.com>
 <20100927061029.GC22319@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100927061029.GC22319@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Greg KH <greg@kroah.com>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'devel@driverdev.osuosl.org'" <devel@driverdev.osuosl.org>, "'virtualization@lists.osdl.org'" <virtualization@lists.osdl.org>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Monday, September 27, 2010 2:10 AM
> >
> > I checked the email I sent on Friday, it was in "Plain Text" format.
> > This was the same format I used for my patches which were accepted
> > previously. Maybe Outlook server converted this one to MIME format?
> > I'm not sure.
> >
> > I have attached the patch in Linux text format, which I have verified
> > with 'patch' command. No error:
> >
> > linux-next> patch -p1 <0924.2-Rename-camel-case-variables-in-
> channel.c.patch
> > patching file drivers/staging/hv/channel.c
> > linux-next>
> >
> > Could you try the attached patch on your side?
> 
> Yes, that worked, but you do realize you attached it in base64 mode,
> right?  That sure isn't going to work...

While we are setting up a new mail server for sending patches, could you
apply attached patches in the meanwhile? So I can continue to work on
more patches.

This attachment can also be downloaded by this Linux command as plain text
without any encoding:
  wget http://driverdev.linuxdriverproject.org/pipermail/devel/attachments/20100927/51d954b0/attachment.obj

Thanks,

- Haiyang
