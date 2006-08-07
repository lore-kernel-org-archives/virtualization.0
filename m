From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
 ops
Date: Sun, 06 Aug 2006 23:23:49 -0700
Message-ID: <44D6DC75.90203@goop.org>
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070730.17813.ak@muc.de> <44D6D315.2030907@goop.org> <200608070802.40614.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751110AbWHGGXw@vger.kernel.org>
In-Reply-To: <200608070802.40614.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
>> so it would be  
>> nice to use one of the other serializing instructions in this case.
>>     
>
> You would first need to find one that works in ring 3. On x86-64 it is 
> used in the gettimeoday vsyscall in ring 3 to synchronize the TSC and 
> afaik John was about to implement that for i386 too.
>   

Well, that's really usermode code, so I don't think we'd necessarily 
touch it at all.  It's not the same problem as the (single, at the 
moment) ring 0 use.

> BTW another issue that I haven't checked but we will need to make
> this also an alternative() for another case - it is faily important
> to patch it out on Intel systems with a synchronized TSC where it is
> fairly expensive. That is also not done yet on i386, but will be 
> likely once vsyscall gettimeofday is implemented.
>
> So basically you would need double patching. Ugly.
>   

Yeah.  I guess the cleanest way to do that is do the paravirt 
substitution, and then nop it out later if it isn't needed in the vsyscall.

> I would recommend to keep it out of para ops.

It's hardly a big deal either way.  There's only one in-kernel use of it.

    J
