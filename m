From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [Xen-devel] [PATCH v2 0/3] Fix and cleanup for 32-bit PV sysexit
Date: Tue, 15 Dec 2015 13:27:05 -0800
Message-ID: <CALCETrX3HdfJc89T_eONftYpAhuPyL_3aPz223CBkKD0s5c-PQ@mail.gmail.com>
References: <1447970147-1733-1-git-send-email-boris.ostrovsky@oracle.com>
	<CALCETrUeGoeB8vNgbRNkFXjH0A570=M+4L1sRsfh-7btym59nA@mail.gmail.com>
	<56707ACE.9060809@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <56707ACE.9060809@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 15, 2015 at 12:40 PM, Andrew Cooper
<andrew.cooper3@citrix.com> wrote:
> On 19/11/15 22:07, Andy Lutomirski wrote:
>> On Thu, Nov 19, 2015 at 1:55 PM, Boris Ostrovsky
>> <boris.ostrovsky@oracle.com> wrote:
>>> The first patch fixes Xen PV regression introduced by 32-bit rewrite. Unlike the
>>> earlier version it uses ALTERNATIVE instruction and avoids using xen_sysexit
>>> (and sysret32 in compat mode) pv ops, as suggested by Andy.
>>>
>>> As result of this patch irq_enable_sysexit and usergs_sysret32 pv ops are not
>>> used anymore by anyone and so can be removed.
>> This whole series is:
>>
>> Acked-by: Andy Lutomirski <luto@kernel.org>
>>
>> Now I just have to sucker someone into getting rid of
>> PARAVIRT_ADJUST_EXCEPTION_FRAME (by using stub entries) and the
>> overcomplicated syscall entry stuff.  :)
>
> Looking at this, it should be quite easy now.
>
> ALTERNATIVE "", "pop %rcx; %pop %11", X86_FEATURE_XENPV
>
> (Completely untested)

Can't we do one better, though?  Generate a pile of stubs that do the
pops and jump into the normal native asm path.  Admittedly, that's a
lot more work, and I think that the ALTERNATIVE thing you're
suggesting would be a nice improvement.

>
>> And whoever gets rid of
>> PARAVIRT_ADJUST_EXCEPTION_FRAME gets to wonder why it doesn't crash
>> and burn for NMIs on Xen, since I'm reasonably confident that it can't
>> possibly be correct.
>
> The Xen PV ABI only has a single kernel stack pointer which may be
> registered.  There is no equivalent of an IST, so if a second fault
> occurs, it is delivered normally on the current stack.
>
> By the looks of it, the other NMI handling is ambivalent to the fact
> that it isn't really on an IST stack under Xen.

I'll try to find some time to look at it.

--Andy
