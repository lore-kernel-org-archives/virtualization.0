From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 0000/0117] Staging: hv: Driver cleanup
Date: Wed, 24 Aug 2011 01:01:26 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B23B1@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <20110823231120.GP9641@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110823231120.GP9641@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Tuesday, August 23, 2011 7:11 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 0000/0117] Staging: hv: Driver cleanup
> 
> On Fri, Jul 15, 2011 at 10:47:04AM -0700, K. Y. Srinivasan wrote:
> > Further cleanup of the hv drivers. Back in June I had sent two patch
> > sets to address these issues. I have addressed the comments I got from
> > the community on my earlier patches here:
> >
> > 	1) Implement code for autoloading the vmbus drivers without using PCI
> or DMI
> > 	   signatures. I have implemented this based on Greg's feedback on my
> earlier
> > 	   implementation.
> >
> > 	2) Cleanup error handling across the board and use standard Linux error
> codes.
> >
> > 	3) General cleanup
> >
> > 	4) Some bug fixes.
> >
> > 	5) Cleanup the reference counting mess for both stor and net devices.
> >
> > 	6) Handle all block devices using the storvsc driver. I have modified
> > 	   the implementation here based on Christoph's feedback on my earlier
> > 	   implementation.
> >
> > 	7) Accomodate some host side scsi emulation bugs.
> >
> > 	8) In case of scsi errors off-line the device.
> 
> Care to respin this patch series based on my comments?

Greg,

Thank you for your comments. I will try to re-submit these patches as soon as I
possibly can. If I were to get these patches re-spun and sent to you in the next couple of 
days, can I still make this current merge window?

Regards,

K. Y
> 
> thanks,
> 
> greg k-h
