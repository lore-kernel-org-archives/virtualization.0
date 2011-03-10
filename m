From: Hank Janssen <hjanssen@microsoft.com>
Subject: Re: [PATCH 12/21] Staging: hv: Cleanup irq management
Date: Thu, 10 Mar 2011 22:54:20 +0000
Message-ID: <E2765C4D-2B98-4D06-8007-3416952F19FD@microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
 <1299794933-1259-1-git-send-email-kys@microsoft.com>,<alpine.LFD.2.00.1103102338230.2787@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1103102338230.2787@localhost6.localdomain6>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: KY Srinivasan <kys@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org






On Mar 10, 2011, at 14:46, "Thomas Gleixner" <tglx@linutronix.de> wrote:
>> 
> 
>>    }
>> -    vector = VMBUS_IRQ_VECTOR;
>> 
>> -    DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", vmbus_irq, vector);
>> +    vector = IRQ0_VECTOR + pdev->irq;
>> +    DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", pdev->irq,
>> +            IRQ0_VECTOR + pdev->irq);
> 
> Why evaluating vector first and then not using it for that debug print
> thingy?
> 
> Btw, are you going to replace that DPRINT_* stuff as well ?
> 
> Thanks,
> 
>     

Yes, that is in my next set of patches. 

Hank
