From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/3]: Staging: hv: Use native page allocation/free
 functions
Date: Fri, 11 Feb 2011 21:27:14 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C56233F93EB6@TK5EX14MBXC114.redmond.corp.microsoft.com>
References: <1297447140-21777-1-git-send-email-kys@microsoft.com>
 <20110211182949.GA10751@suse.de>
 <FB42D5CCD7B5934EB1827DB5ED9B850E0B2653@tk5ex14mbxc106.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <FB42D5CCD7B5934EB1827DB5ED9B850E0B2653@tk5ex14mbxc106.redmond.corp.microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>, Greg KH <gregkh@suse.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> And then KY Srinivasan spoke on Friday, February 11, 2011 12:56 PM
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Friday, February 11, 2011 1:30 PM
> > > -	virtaddr = osd_virtual_alloc_exec(PAGE_SIZE);
> > > +#ifdef __x86_64__
> > > +	virtaddr = __vmalloc(PAGE_SIZE, GFP_KERNEL,
> PAGE_KERNEL_EXEC);
> > #else
> > > +	virtaddr =  __vmalloc(PAGE_SIZE, GFP_KERNEL,
> > > +			__pgprot(__PAGE_KERNEL & (~_PAGE_NX))); #endif
> >
> > I'm not saying this patch is wrong at all, but I still don't
> > understand why this is different depending on the architecture of the
> > machine.  Why is this necessary, it should be ok to do the same type
> > of allocation no matter what the processor is, right?
> 
> You are right Greg; I don't think there is a need to specify different page
> protection bits based on the architecture - PAGE_KERNEL_EXEC should be
> enough.
> However, this is the code that is currently in the tree - refer to osd.c.
> If it is ok with you, I could submit an additional patch to clean this up.
> 

I seem to recall that we did it for very old versions of Linux (pre 2.6.18)
But I cannot for the life of me remember why.

Hank.
