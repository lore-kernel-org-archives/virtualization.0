From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 13/26] Xen-paravirt_ops: Consistently wrap
 paravirt ops callsites to make them patchable
Date: Fri, 16 Mar 2007 10:36:18 -0700
Message-ID: <45FAD592.9010105@goop.org>
References: <20070301232443.195603797@goop.org>
	<20070301232527.956565107@goop.org>
	<20070316092445.GM23174@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070316092445.GM23174@elte.hu>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Anthony Liguori <anthony@codemonkey.ws>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Wrap a set of interesting paravirt_ops calls in a wrapper which makes 
>> the callsites available for patching.  Unfortunately this is pretty 
>> ugly because there's no way to get gcc to generate a function call, 
>> but also wrap just the callsite itself with the necessary labels.
>>
>> This patch supports functions with 0-4 arguments, and either void or 
>> returning a value.  64-bit arguments must be split into a pair of 
>> 32-bit arguments (lower word first).  Small structures are returned in 
>> registers.
>>     
>
> ugh. This is beyond ugly!

Yes.  I can't say I'm proud of this, but I really couldn't come up with
a cleaner approach.

>  Why dont we just compile two images, one for 
> Xen and one for native, do two passes to get those two images and 
> 'merge' them into a single vmlinuz (so that we still have a 'single' 
> kernel unit to deal with on the distro side). This way we avoid all this 
> crazy, limited, fragile patchery business...

Well, one thing to make clear is this is absolutely not a Xen-specific
patch or piece of code.  This is part of the paravirt_ops infrastructure
designed to remove the overhead of all the indirect calls which are
scattered all over the place.  (Perhaps I should post the general
paravirt and Xen specific patches in separate patch series to make this
clear...).

The idea is to wrap the callsite itself with in the same manner as the
other altinstructions so that the general patcher can, at the very
least, convert the indirect call to a direct one, or nop it out if its
an indirect call.  This means that a pv_ops implementation can get about
90% of the benefit of patching without any extra effort.

So, I disagree with your characterisation that its "limited"; this is a
pretty general mechanism.  The fragile part is in using the PVOP_*
macros properly to match the ABI's calling convention, particularly with
tricky cases like passed and returned structures and 64-bit args.  But
that just needs to be done once in one place, and is otherwise
self-contained.

I would love a better mechanism.  I played with using things like gcc's
builtin_apply stuff, and so on, but I could find no way to get gcc to
set up the args and then be able to just emit the call itself under asm
control.


I haven't looked at Dave's reply in detail, but I saw some mention of
using relocs.  The idea is intriguing , but I don't quite see how it
would all fit together.


    J
