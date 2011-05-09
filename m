From: KY Srinivasan <kys@microsoft.com>
Subject: RE: various vmbus review comments
Date: Mon, 9 May 2011 14:56:52 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E0481E95C6@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <20110503204641.GA11132@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DFCFA@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110504163228.GA19754@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481E0694@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110509143352.GB29635@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110509143352.GB29635@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: Monday, May 09, 2011 10:34 AM
> To: KY Srinivasan
> Cc: Greg KH; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org
> Subject: Re: various vmbus review comments
> 
> On Fri, May 06, 2011 at 01:10:38PM +0000, KY Srinivasan wrote:
> > I audited the block and the net drivers. As part of their exit routine,
> > they invoke vmbus_child_driver_unregister() after properly cleaning
> > up all the devices they are managing. Do you still see an issue with
> > regards to module reference counting.
> 
> Which is not the correct thing to do as explained in my last round
> of reviews.  Take a look at the PCI code - the functional driver only
> does a foo_untegister_driver (which maps almost directly to
> driver_unregister), which then causes the device core to unbind the
> devices.  The function driver must never call device_unregister
> directly as the device continues to exist even if no driver is bound to
> it.

I will address this. Greg had a concern about module reference counting
and looking at the current code, it did not appear to be an issue. The
change you are suggesting will not affect the vmbus core which is what I want
to focus on. I will however, fix this issue in the current round of patches I will
send out this week.

Regards,

K. Y
