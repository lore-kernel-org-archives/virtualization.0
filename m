From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with	CONFIG_PARAVIRT
Date: Fri, 16 Mar 2007 09:46:51 -0700
Message-ID: <45FAC9FB.6070800@goop.org>
References: <45FA054F.6020107@vmware.com> <45FA0D13.6080601@goop.org> <45FA16FE.7010805@vmware.com> <45FA26DA.7020109@goop.org> <45FA5E7B.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753578AbXCPQqw@vger.kernel.org>
In-Reply-To: <45FA5E7B.76E4.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: Zachary Amsden <zach@vmware.com>, Ingo Molnar <mingo@elte.hu>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jan Beulich wrote:
> I have one, too (which is one reasone why I created the original Xen patch).
>   

It's some version of SuSE 9, right?  What glibc version?

>>> I'm playing safe.  Binary identical relocation to 0xffffe000 was my goal.
>>>       
>> Yeah, fair enough.  But as Eric likes to keep pointing out, an
>> executable ELF file need not have any sections at all, so the only safe
>> course for anything "real" is via the section headers.
>>     
>
> Program headers you mean.
>   

Er, yep.

>> So I guess the right thing to do is relocate the dynamic stuff via
>> PT_DYNAMIC, and relocate the symtab if its present.
>>     
>
> Symtab should also be deduced from program headers.
>   

Well, the normal symtab might be completely missing.  But yes, the
dynamic symtab should be in the PT_DYNAMIC.

    J
