From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Fri, 09 Feb 2007 04:08:10 -0800
Message-ID: <45CC642A.4010803@vmware.com>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171018812.2718.66.camel@localhost.localdomain> <45CC5771.1070309@vmware.com> <200702091250.06482.ak@muc.de> <45CC60FD.6080606@vmware.com> <20070209115758.GA18080@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946399AbXBIMIN@vger.kernel.org>
In-Reply-To: <20070209115758.GA18080@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>>>  
>>>       
>> My bad, I fell for the same mistake as everyone.  Set_fs is just way too 
>>     
>
> You could change the name. Only 654 occurrences all over the tree @)
>   

I'm preparing a patch.  +not.  This legacy thing is certainly taking a 
long time to disappear.  Long live x86!

>   
>> confusing of a name now.  But good to know interrupts must be disable in 
>> such a circumstance.
>>     
>
> +not
>   

+ack

Zach
