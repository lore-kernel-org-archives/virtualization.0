From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 0000/0046] Staging: hv: Driver cleanup
Date: Tue, 30 Aug 2011 17:27:54 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B538C@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <20110829181502.GC19668@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110829181502.GC19668@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, August 29, 2011 2:15 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH 0000/0046] Staging: hv: Driver cleanup
> 
> On Sat, Aug 27, 2011 at 11:31:14AM -0700, K. Y. Srinivasan wrote:
> > Further cleanup of the hv drivers.
> >
> > 	1) Cleanup reference counting.
> >
> > 	2) Handle all block devices using the storvsc driver. I have modified
> > 	   the implementation here based on Christoph's feedback on my earlier
> > 	   implementation.
> >
> > 	3) Fix bugs.
> >
> > 	4) Accomodate some host side scsi emulation bugs.
> >
> > 	5) In case of scsi errors off-line the device.
> >
> > This patch-set further reduces the size of Hyper-V drivers - the code is
> > about 10% smaller. This reduction is mainly because we have eliminated the
> > blkvsc driver.
> 
> If my tracking is correct, I applied everything in this series except
> the following patches
> 	[PATCH 37/46] Staging: hv: vmbus: Check for events before messages
> 	[PATCH 41/46] Staging: hv: vmbus: Fix a bug in error handling in
> vmbus_bus_init()
> 	[PATCH 46/46] Staging: hv: Update the TODO file
> 
> Please fix up patches 37 and 41 and resend, and for 46, that should be
> totally different as mentioned, but you might want to send a patch that
> at the least adds your name to the file at the bottom, as you wanted.
> Also note that the MAINTAINERS file should also be adjusted to match.

Thanks Greg. I will try to get these patches back to you as soon as possible.

Regards,

K. Y
