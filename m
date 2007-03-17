From: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch 13/26] Xen-paravirt_ops: Consistently wrap paravirt ops
 callsites to make them patchable
Date: Sat, 17 Mar 2007 01:10:18 -0800
Message-ID: <45FBB07A.2000701@vmware.com>
References: <20070301232443.195603797@goop.org> <20070301232527.956565107@goop.org> <20070316092445.GM23174@elte.hu> <45FAD592.9010105@goop.org> <45FB283F.6080000@vmware.com> <45FB38F7.5010306@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933766AbXCQJKU@vger.kernel.org>
In-Reply-To: <45FB38F7.5010306@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Rusty Russell <rusty@rustcorp.com.au>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I think the suggestion is much simpler.  If you convince gcc/binutils to
> leave the .reloc section in vmlinux, and make that available to the
> kernel itself, then you can scan all the kernel's relocs to find ones
> which refer to paravirt_ops, and use those to determine which are
> callsites that can be patched.
>   

Yes, that is pretty nice.

> The main upside is that all the callsites are just normal C calls;
> there's no special syntax or strange macros, and we get the full benefit
> of typechecking, etc.
>
> But I can see a few downsides compared the current scheme:
>
>    1. Identifying the callsites is a somewhat hackish process of looking
>       at a reloc and doing a bit of dissassembly to see what is using
>       the reloc, to identify calls and jumps
>    2. There's nothing explicit to tell us how much space there is to
>       patch into; we just have to assume sizeof(indirect call/jmp)
>    3. There's no information about the register environment at the
>       callsite, so we just have to adopt normal C ABI rules.  For the
>       patch sites in hand-written asm, this could be tricky.
>    4. gcc could do strange things which prevent detection of patch
>       sites.  For example, it might CSE the value of, say,
>       paravirt_ops.irq_enable, which would be a reasonable optimisation,
>       but prevent any of the resulting indirect calls from being
>       patched.  In general it relies on gcc to generate identifiable
>       callsites, which is a bit unpredictable.
>    5. There's still a moderate amount of binutils hackery to get the
>       relocs into the right form, and there's plenty of scope for it to
>       screw up.
>   

And yes, those are nasty points.  I think I'd be interested in seeing 
more discussion on it, perhaps those issues could be worked out.

>> [ Roswell technology deleted ]
>>     

Nack.  Everyone needs Roswell technology.

Actually, that was not a serious proposal.  I think the effort and 
complexity would likely not justify the gain.  But I still had to throw 
it out, since it is what we use on Betelgeuse.

Z
