From: Hank Janssen <hjanssen@microsoft.com>
Subject: RE: [PATCH 1/1] hv: Use only one receive buffer per channel and
 kmalloc on initialize
Date: Tue, 14 Dec 2010 00:11:23 +0000
Message-ID: <8AFC7968D54FB448A30D8F38F259C5622C0BD022@TK5EX14MBXC116.redmond.corp.microsoft.com>
References: <1292272498-29483-1-git-send-email-hjanssen@microsoft.com>
 <4D0636270200003000091D23@novprvoes0310.provo.novell.com>
 <alpine.LNX.2.00.1012140048290.26491@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1012140048290.26491@swampdragon.chaosbits.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>, Ky Srinivasan <ksrinivasan@novell.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Jesper Juhl [mailto:jj@chaosbits.net]
> Sent: Monday, December 13, 2010 3:51 PM
> To: Ky Srinivasan
> > > +	shut_txf_buf = kmalloc(PAGE_SIZE, GFP_ATOMIC);
> > > +	time_txf_buf = kmalloc(PAGE_SIZE, GFP_ATOMIC);
> > > +	hbeat_txf_buf = kmalloc(PAGE_SIZE, GFP_ATOMIC);
> > Why are these allocations GFP_ATOMIC. Clearly this is in module
> loading context and you can afford to sleep. GFP_KERNEL should be fine.
> >
> 
> I actually also noticed this when I did my first review of the patch,
> but
> I didn't point it out since I thought that "there must be a good
> reason".
> But now that you point it out and I look at the code once more I can't
> actually think of a "good reason",, so I agree with you completely that
> these should just be GFP_KERNEL.

I was looking at some of the back code to make sure it is okay, and I see
No reason not make this change either. I will change it and resubmit.

Thanks,

Hank.
