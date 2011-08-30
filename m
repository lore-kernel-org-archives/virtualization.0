From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 37/46] Staging: hv: vmbus: Check for events before
 messages
Date: Tue, 30 Aug 2011 17:06:39 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048081B52F7@TK5EX14MBXC126.redmond.corp.microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-37-git-send-email-kys@microsoft.com>
 <20110829180511.GA7167@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110829180511.GA7167@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, August 29, 2011 2:05 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang
> Subject: Re: [PATCH 37/46] Staging: hv: vmbus: Check for events before
> messages
> 
> On Sat, Aug 27, 2011 at 11:31:36AM -0700, K. Y. Srinivasan wrote:
> > Conform to Windows specification by checking for events before messages.
> 
> What specification?
> 
> Care to provide a comment in the code that you are doing this in this
> explicit order because of some rule that the hypervisor imposes on us?

I am not sure if this is documented anywhere (publicly). In talking to Windows 
guys, they suggested this is the order in which it is done on Windows guests and suggested
I should do the same. I will see if there is some public documentation that specifies this.

Regards,

K. Y
> 
> thanks,
> 
> greg k-h
