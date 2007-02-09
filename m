From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 6/10] lguest code: the little linux hypervisor.
Date: Fri, 09 Feb 2007 03:54:37 -0800
Message-ID: <45CC60FD.6080606@vmware.com>
References: <1171012296.2718.26.camel@localhost.localdomain> <1171018812.2718.66.camel@localhost.localdomain> <45CC5771.1070309@vmware.com> <200702091250.06482.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422997AbXBILyi@vger.kernel.org>
In-Reply-To: <200702091250.06482.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, Paul Mackerras <paulus@samba.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> Yes, it is a bit, umm, innovative.  If it is going to be kept, even if 
>> just for devel logging, you should disable interrupts around it.  
>> Changing segments is not a normal thing to do.
>>     
>
> Actually that wouldn't be needed because interrupts are not allowed to do any 
> user accesses. And contrary to the name it doesn't actually change
> the segment registers, only state used by *_user.
>   

My bad, I fell for the same mistake as everyone.  Set_fs is just way too 
confusing of a name now.  But good to know interrupts must be disable in 
such a circumstance.

Zach
