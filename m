From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 1/3] x86/xen: Avoid fast syscall path for Xen PV guests
Date: Wed, 18 Nov 2015 12:58:20 -0800
Message-ID: <CALCETrUTp=Shcmvh44fE5URugd6c41dDGdDM8cKvnP=Gqap45A@mail.gmail.com>
References: <1447877179-2775-1-git-send-email-boris.ostrovsky@oracle.com>
	<1447877179-2775-2-git-send-email-boris.ostrovsky@oracle.com>
	<CALCETrVUpqQy_EZMe8T5iRkA0FzS0Oz1Kuicr9yz3SwtdF1=9g@mail.gmail.com>
	<CAMzpN2iofkEeYkiZa8FRJ5gbz5smPbV0COOye9wZ9OhV6pBfow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMzpN2iofkEeYkiZa8FRJ5gbz5smPbV0COOye9wZ9OhV6pBfow@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Brian Gerst <brgerst@gmail.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 18, 2015 at 12:50 PM, Brian Gerst <brgerst@gmail.com> wrote:
> On Wed, Nov 18, 2015 at 3:21 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Wed, Nov 18, 2015 at 12:06 PM, Boris Ostrovsky
>> <boris.ostrovsky@oracle.com> wrote:
>>> After 32-bit syscall rewrite, and specifically after commit 5f310f739b4c
>>> ("x86/entry/32: Re-implement SYSENTER using the new C path"), the stack
>>> frame that is passed to xen_sysexit is no longer a "standard" one (i.e.
>>> it's not pt_regs).
>>>
>>> Since we end up calling xen_iret from xen_sysexit we don't need to fix
>>> up the stack and instead follow entry_SYSENTER_32's IRET path directly
>>> to xen_iret.
>>>
>>> We can do the same thing for compat mode even though stack does not need
>>> to be fixed. This will allow us to drop usergs_sysret32 paravirt op (in
>>> the subsequent patch)
>>
>> Looks generally quite nice.  Minor comments below:
>>
>>> --- a/arch/x86/entry/entry_32.S
>>> +++ b/arch/x86/entry/entry_32.S
>>> @@ -308,7 +308,8 @@ sysenter_past_esp:
>>>
>>>         movl    %esp, %eax
>>>         call    do_fast_syscall_32
>>> -       testl   %eax, %eax
>>> +       /* XEN PV guests always use IRET path */
>>> +       ALTERNATIVE "testl %eax, %eax", "xor %eax, %eax", X86_FEATURE_XENPV
>>>         jz      .Lsyscall_32_done
>>
>> Could we make this a little less subtle:
>>
>> ALTERNATIVE "testl %eax, %eax; lz .Lsyscall_32_done", "jmp
>> .Lsyscasll_32_done", X86_FEATURE_XENPV
>>
>> Borislav, what do you think?
>>
>> Ditto for the others.
>
> Can you just add !xen_pv_domain() to the opportunistic SYSRET check
> instead?  Bury the alternatives in that macro, ie.
> static_cpu_has(X86_FEATURE_XENPV).  That would likely benefit other
> code as well.

We could, but that won't help the 64-bit case where we want to keep
the full asm path.

Also, Xen is capable of the equivalent of sysret32 in the compat case.
We might want to enable something like that, and using the existing
opportunistic sysret check may make sense, in which case we wouldn't
want to disable it.

--Andy
