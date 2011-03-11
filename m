From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 12/21] Staging: hv: Cleanup irq management
Date: Fri, 11 Mar 2011 02:09:15 +0000
Message-ID: <6E21E5352C11B742B20C142EB499E048018B3E@TK5EX14MBXC128.redmond.corp.microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
 <1299794933-1259-1-git-send-email-kys@microsoft.com>,<alpine.LFD.2.00.1103102338230.2787@localhost6.localdomain6>
 <E2765C4D-2B98-4D06-8007-3416952F19FD@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E2765C4D-2B98-4D06-8007-3416952F19FD@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hank Janssen <hjanssen@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Hank Janssen
> Sent: Thursday, March 10, 2011 5:54 PM
> To: Thomas Gleixner
> Cc: KY Srinivasan; gregkh@suse.de; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; virtualization@lists.osdl.org; Haiyang Zhang; Mike
> Sterling; Abhishek Kane (Mindtree Consulting PVT LTD)
> Subject: Re: [PATCH 12/21] Staging: hv: Cleanup irq management
> 
> 
> 
> 
> 
> 
> On Mar 10, 2011, at 14:46, "Thomas Gleixner" <tglx@linutronix.de> wrote:
> >>
> >
> >>    }
> >> -    vector = VMBUS_IRQ_VECTOR;
> >>
> >> -    DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", vmbus_irq, vector);
> >> +    vector = IRQ0_VECTOR + pdev->irq;
> >> +    DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", pdev->irq,
> >> +            IRQ0_VECTOR + pdev->irq);
> >
> > Why evaluating vector first and then not using it for that debug print
> > thingy?
Good point; I will fix this before Hank gets rid of the DPRINT_INFO altogether.

Regards,

K. Y
