From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 13/21] [PATCH 13/21] Staging: hv: Rename
 vmbus_driver_context structure
Date: Fri, 11 Mar 2011 03:17:46 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048018BBD@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
 <1299795131-1335-1-git-send-email-kys@microsoft.com>
 <alpine.LFD.2.00.1103102347450.2787@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1103102347450.2787@localhost6.localdomain6>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx@linutronix.de]
> Sent: Thursday, March 10, 2011 5:50 PM
> To: KY Srinivasan
> Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Mike
> Sterling; Abhishek Kane (Mindtree Consulting PVT LTD); Hank Janssen
> Subject: Re: [PATCH 13/21] [PATCH 13/21] Staging: hv: Rename
> vmbus_driver_context structure
> 
> On Thu, 10 Mar 2011, K. Y. Srinivasan wrote:
> > Now that struct vmbus_driver_context is properly
> > cleaned up, rename this structure appropriately and
> > cleanup the code.
> 
> > @@ -877,10 +873,10 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
> >  	/* Schedules a dpc if necessary */
> >  	if (ret > 0) {
> >  		if (test_bit(0, (unsigned long *)&ret))
> > -			tasklet_schedule(&vmbus_drv.msg_dpc);
> > +			tasklet_schedule(&hv_bus.msg_dpc);
> >
> >  		if (test_bit(1, (unsigned long *)&ret))
> > -			tasklet_schedule(&vmbus_drv.event_dpc);
> > +			tasklet_schedule(&hv_bus.event_dpc);
> 
> What's the plan to convert that tasklet/work stuff to threaded irqs ?


This is on my plate; I was going to work on this after I addressed all other issues 
preventing the vmbus driver from exiting staging.

Regards,

K. Y 
