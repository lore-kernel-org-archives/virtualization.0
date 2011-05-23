From: KY Srinivasan <kys@microsoft.com>
Subject: RE: vmbus driver
Date: Mon, 23 May 2011 12:54:09 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481FC6DF@TK5EX14MBXC122.redmond.corp.microsoft.com>
References: <1305842785-30206-1-git-send-email-kys@microsoft.com>
 <20110520122649.GA550@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481FC2ED@TK5EX14MBXC122.redmond.corp.microsoft.com>
 <20110522105941.GB8346@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110522105941.GB8346@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, "Thomas Gleixner (tglx@linutronix.de)" <tglx@linutronix.de>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Sunday, May 22, 2011 7:00 AM
> To: KY Srinivasan
> Cc: Christoph Hellwig; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: vmbus driver
> 
> > I see maintainers for each of the clocksource drivers and I see John Stultz and
> > Thomas  Gleixner listed as the maintainers for Timekeeping. Who should sign-
> off
> > on the Hyper-V clocksource.
> 
> just send it to both of the with linux-kernel in Cc, and either of them
> will probably put it in.
> 

John, Thomas,

I am working on getting Hyper-V drivers (drivers/staging/hv/*) out of staging.
I would like to request you to look at the Hyper-V timesource driver:
drivers/staging/hv/hv_timesource.c. The supporting code for this driver
is already part of the base kernel. Let me know if this driver is ready to exit staging.

Regards,

K. Y
