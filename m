From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 11/13] x86/paravirt: Add paravirt alternatives
	infrastructure
Date: Mon, 16 Oct 2017 14:18:48 -0400
Message-ID: <b9fdc3ec-87cd-da0e-47b7-67cdae8ffb97@oracle.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<39743c79546ede3073586403d0836a4f93519b0a.1507128293.git.jpoimboe@redhat.com>
	<3b9fd404-6912-3b58-db29-36202631b438@oracle.com>
	<20171006143259.rs3zh7k5tmsgesqy@treble>
	<5a49e43a-8d6b-512a-ec5a-641be7bae41d@oracle.com>
	<ed30216f-4b9e-2bc3-b1d2-36135b29d746@citrix.com>
	<a6c3be0b-35f4-8d23-4ea2-ead94a3fc69e@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a6c3be0b-35f4-8d23-4ea2-ead94a3fc69e@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Cooper <andrew.cooper3@citrix.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, live-patching@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Sasha Levin <alexander.levin@verizon.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/12/2017 03:53 PM, Boris Ostrovsky wrote:
> On 10/12/2017 03:27 PM, Andrew Cooper wrote:
>> On 12/10/17 20:11, Boris Ostrovsky wrote:
>>> There is also another problem:
>>>
>>> [    1.312425] general protection fault: 0000 [#1] SMP
>>> [    1.312901] Modules linked in:
>>> [    1.313389] CPU: 0 PID: 1 Comm: init Not tainted 4.14.0-rc4+ #6
>>> [    1.313878] task: ffff88003e2c0000 task.stack: ffffc9000038c000
>>> [    1.314360] RIP: 10000e030:entry_SYSCALL_64_fastpath+0x1/0xa5
>>> [    1.314854] RSP: e02b:ffffc9000038ff50 EFLAGS: 00010046
>>> [    1.315336] RAX: 000000000000000c RBX: 000055f550168040 RCX:
>>> 00007fcfc959f59a
>>> [    1.315827] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
>>> 0000000000000000
>>> [    1.316315] RBP: 000000000000000a R08: 000000000000037f R09:
>>> 0000000000000064
>>> [    1.316805] R10: 000000001f89cbf5 R11: ffff88003e2c0000 R12:
>>> 00007fcfc958ad60
>>> [    1.317300] R13: 0000000000000000 R14: 000055f550185954 R15:
>>> 0000000000001000
>>> [    1.317801] FS:  0000000000000000(0000) GS:ffff88003f800000(0000)
>>> knlGS:0000000000000000
>>> [    1.318267] CS:  e033 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [    1.318750] CR2: 00007fcfc97ab218 CR3: 000000003c88e000 CR4:
>>> 0000000000042660
>>> [    1.319235] Call Trace:
>>> [    1.319700] Code: 51 50 57 56 52 51 6a da 41 50 41 51 41 52 41 53 48
>>> 83 ec 30 65 4c 8b 1c 25 c0 d2 00 00 41 f7 03 df 39 08 90 0f 85 a5 00 00
>>> 00 50 <ff> 15 9c 95 d0 ff 58 48 3d 4c 01 00 00 77 0f 4c 89 d1 ff 14 c5
>>> [    1.321161] RIP: entry_SYSCALL_64_fastpath+0x1/0xa5 RSP: ffffc9000038ff50
>>> [    1.344255] ---[ end trace d7cb8cd6cd7c294c ]---
>>> [    1.345009] Kernel panic - not syncing: Attempted to kill init!
>>> exitcode=0x0000000b
>>>
>>>
>>> All code
>>> ========
>>>    0:    51                       push   %rcx
>>>    1:    50                       push   %rax
>>>    2:    57                       push   %rdi
>>>    3:    56                       push   %rsi
>>>    4:    52                       push   %rdx
>>>    5:    51                       push   %rcx
>>>    6:    6a da                    pushq  $0xffffffffffffffda
>>>    8:    41 50                    push   %r8
>>>    a:    41 51                    push   %r9
>>>    c:    41 52                    push   %r10
>>>    e:    41 53                    push   %r11
>>>   10:    48 83 ec 30              sub    $0x30,%rsp
>>>   14:    65 4c 8b 1c 25 c0 d2     mov    %gs:0xd2c0,%r11
>>>   1b:    00 00
>>>   1d:    41 f7 03 df 39 08 90     testl  $0x900839df,(%r11)
>>>   24:    0f 85 a5 00 00 00        jne    0xcf
>>>   2a:    50                       push   %rax
>>>   2b:*    ff 15 9c 95 d0 ff        callq  *-0x2f6a64(%rip)        #
>>> 0xffffffffffd095cd        <-- trapping instruction
>>>   31:    58                       pop    %rax
>>>   32:    48 3d 4c 01 00 00        cmp    $0x14c,%rax
>>>   38:    77 0f                    ja     0x49
>>>   3a:    4c 89 d1                 mov    %r10,%rcx
>>>   3d:    ff                       .byte 0xff
>>>   3e:    14 c5                    adc    $0xc5,%al
>>>
>>>
>>> so the original 'cli' was replaced with the pv call but to me the offset
>>> looks a bit off, no? Shouldn't it always be positive?
>> callq takes a 32bit signed displacement, so jumping back by up to 2G is
>> perfectly legitimate.
> Yes, but
>
> ostr@workbase> nm vmlinux | grep entry_SYSCALL_64_fastpath
> ffffffff817365dd t entry_SYSCALL_64_fastpath
> ostr@workbase> nm vmlinux | grep " pv_irq_ops"
> ffffffff81c2dbc0 D pv_irq_ops
> ostr@workbase>
>
> so pv_irq_ops.irq_disable is about 5MB ahead of where we are now. (I
> didn't mean that x86 instruction set doesn't allow negative
> displacement, I was trying to say that pv_irq_ops always live further down)

I believe the problem is this:

#define PV_INDIRECT(addr)       *addr(%rip)

The displacement that the linker computes will be relative to the where
this instruction is placed at the time of linking, which is in
.pv_altinstructions (and not .text). So when we copy it into .text the
displacement becomes bogus.

Replacing the macro with

#define PV_INDIRECT(addr)       *addr  // well, it's not so much
indirect anymore

makes things work. Or maybe it can be adjusted top be kept truly indirect.

-boris
