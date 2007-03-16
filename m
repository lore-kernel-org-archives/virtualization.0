From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH] Fixup COMPAT_VDSO to work with CONFIG_PARAVIRT
Date: Fri, 16 Mar 2007 12:46:56 -0700
Message-ID: <45FAF430.4060903@goop.org>
References: <45FA054F.6020107@vmware.com>	<m17itho10v.fsf@ebiederm.dsl.xmission.com> <45FAC4EF.4060305@goop.org>	<20070316163118.GA12999@elte.hu> <45FAC6E6.5090000@goop.org> <m1ps79m2ih.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933224AbXCPTrd@vger.kernel.org>
In-Reply-To: <m1ps79m2ih.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@suse.de>, Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> There are three ways of finding the VDSO.
> - AT_SYSINFO
> - AT_SYSINFO_EHDR
> - known fixed address (see x86_64)
>
> Currently it doesn't sound like you need to deal with the known fixed
> address case but COMPAT_VDSO also provides that.
>   

Yes, I don't think any 32-bit userspace expects a fixed address any
more.  64-bit is another matter.

> If userspace uses AT_SYSINFO the premise is that it is not expecting
> not to need to perform any relocation processing.
>
> If userspace uses AT_SYSINFO_EHDR it expects it needs to perform
> relocation processing and fixes up whatever needs fixing up.
>   

Correct.

> With the module code we have shown the kernel is capable of performing
> relocation processing at times and it works.
>   

Good point.  It would be good to reuse that machinery.

> So is it possible to simply relocate the normal vdso and fixup
> it's program header so it shows that relocation is not necessary.
> If you can do that and still export AT_SYSINFO so the problem user
> space still runs you are good.  (If you can relocate the vdso
> you should be able to relocate it anywhere).
>   

Yes.  The plan is to map the relocated compat vdso at some fixed address
in all processes, and map a non-relocated non-compat vdso at some
randomized address (it will probably be the same bits in either case). 
We could map a relocated vdso to a randomized address (ie, only one vdso
mapping), but that would require a per-process copy of the vdso and
effort to relocate on each exec.

> Otherwise it probably just make sense to simply not export a VDSO
> on those systems.
>   

We did that in an earlier version of the patch, and Ingo complained,
with some justification.

> This would leave COMPAT_VDSO for the case where you must use one magic
> fixed address, and if user space does not require that it means
> COMPAT_VDSO could be completely removed.
>   

FC1 and SuSE 9 both shipped with broken glibcs which require
weak-COMPAT_VDSO (not fixed address, but pre-relocated).  There are
still enough of these around that we need to cater to them.

    J
