From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH] Move KVM, paravirt, lguest, VMI and Xen under	arch-level
 Virtualization option
Date: Thu, 19 Jul 2007 23:10:54 -0700
Message-ID: <46A051EE.7060304@vmware.com>
References: <1184905342.10380.263.camel@localhost.localdomain>	
	<46A046F1.7040207@qumranet.com>
	<1184911347.10380.274.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1184911347.10380.274.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Dike <jdike@addtoit.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
>> Otherwise we end up with $NARCH copies of that Kconfig, each slightly
>> different.  The top-level entry can be made to depend on the archs that
>> actually have some virt capability, so as not to show empty an menu.
>>     
>
> I dislike the duplication, too, but 
>
> 1) it's a CPU capability, and that's where it belongs in the menu.
> 2) And as you can see from the difference between the x86_64 and i386
> help text, there are real platform differences (and not mentioning
> what's under the menu would be kinda cheating).
> 3) Virtualization doesn't even make sense as an option for some
> platforms where it's always on.
>   

I'm rather indifferent on the matter, but I think a virtualization menu 
under UML would be very confusing.

Zach
