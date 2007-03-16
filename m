From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with	CONFIG_PARAVIRT
Date: Fri, 16 Mar 2007 00:41:38 -0800
Message-ID: <45FA5842.3070109@vmware.com>
References: <45FA054F.6020107@vmware.com> <45FA0D13.6080601@goop.org> <45FA16FE.7010805@vmware.com> <45FA26DA.7020109@goop.org> <45FA5E7B.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752983AbXCPIll@vger.kernel.org>
In-Reply-To: <45FA5E7B.76E4.0078.0@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Ingo Molnar <mingo@elte.hu>, Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jan Beulich wrote:
>> So I guess the right thing to do is relocate the dynamic stuff via
>> PT_DYNAMIC, and relocate the symtab if its present.
>>     
>
> Symtab should also be deduced from program headers.
>   

Learning more all the time..

> I'm actually surprised this got re-implemented from scratch, when my patch
> already had both variants (one just #ifdef-ed out), and was tested in both
> forms (actually, I first implemented the ELF form, and only after seeing the
> bloat it added to the sources I came up her than with the second variant, which in
> the end unfortunately didn't add significantly less bloat to the Makefile.
>   

This wasn't re-implemented from scratch - I did this in another lifetime:

http://lists.xensource.com/archives/html/xen-devel/2005-08/msg00284.html

Either way of doing things is fine with me - I would just prefer that if 
it has to get down and dirty, we do it in source rather than hidden in a 
makefile.  But just a personal preference.

Zach
