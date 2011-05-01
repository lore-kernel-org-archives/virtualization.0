From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Sun, 1 May 2011 15:46:23 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481DF253@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <20110426232843.GA31184@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DD185@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427064550.GA597@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD266@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427121856.GA20633@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD676@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110429164025.GA7698@kroah.com> <20110501154041.GB15210@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110501154041.GB15210@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Sunday, May 01, 2011 11:41 AM
> To: Greg KH
> Cc: KY Srinivasan; Christoph Hellwig; gregkh@suse.de; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org
> Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
> 
> On Fri, Apr 29, 2011 at 09:40:25AM -0700, Greg KH wrote:
> > Are you sure the libata core can't see this ide controller and connect
> > to it?  That way you would use the scsi system if you do that and you
> > would need a much smaller ide driver, perhaps being able to merge it
> > with your scsi driver.
> >
> > We really don't want to write new IDE drivers anymore that don't use
> > libata.
> 
> The blkvsc driver isn't an IDE driver, although it currently claims
> the old IDE drivers major numbers, which is a no-no and can't work
> in most usual setups.

What is the issue here? This is no different than what is done in other
Virtualization platforms. For instance, the Xen blkfront driver is no
different - if you specify the block device to be presented to the guest
as an ide device, it will register for the appropriate ide major number.

Regards,

K. Y 

> I'm pretty sure I already complained about
> this in a previous review round.
