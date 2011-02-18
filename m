From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
Date: Fri, 18 Feb 2011 22:00:04 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048011604@TK5EX14MBXC124.redmond.corp.microsoft.com>
References: <1297799735-25917-1-git-send-email-kys@microsoft.com>
 <20110218211423.GH796@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110218211423.GH796@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Friday, February 18, 2011 4:14 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: [PATCH]: Staging: hv: Allocate the vmbus irq dynamically
> 
> On Tue, Feb 15, 2011 at 11:55:35AM -0800, K. Y. Srinivasan wrote:
> >
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
> 
> You didn't run this through checkpatch.pl.
> 
> Please do so and fix the warning it gives you.
Greg, I did run the checkpatch script against this patch and the only complaint I got was with 
regards to the IRQF_SAMPLE_RANDOM flag that I pass. As a virtual machine, this is the only
external event that the VM is going to see and so I chose to keep this flag.  Is there something that would 
replace this flag; looking at the Xen drivers they do pass this flag.

Regards,

K. Y 

> 
> thanks,
> 
> greg k-h
