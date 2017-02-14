From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v2 0/3] x86/vdso: Add Hyper-V TSC page clocksource support
Date: Tue, 14 Feb 2017 16:50:10 +0100
Message-ID: <87a89o22ml.fsf@vitty.brq.redhat.com>
References: <20170214124408.25931-1-vkuznets@redhat.com>
	<alpine.DEB.2.20.1702141552360.3635@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.20.1702141552360.3635@nanos> (Thomas Gleixner's
	message of "Tue, 14 Feb 2017 15:56:08 +0100 (CET)")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, devel@linuxdriverproject.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 14 Feb 2017, Vitaly Kuznetsov wrote:
>
>> Hi,
>> 
>> while we're still waiting for a definitive ACK from Microsoft that the
>> algorithm is good for SMP case (as we can't prevent the code in vdso from
>> migrating between CPUs) I'd like to send v2 with some modifications to keep
>> the discussion going.
>
> Migration is irrelevant. The TSC page is guest global so updates will
> happen on some (random) host CPU and therefor you need the usual barriers
> like we have them in our seqcounts unless an access to the sequence will
> trap into the host, which would defeat the whole purpose of the TSC page.
>

KY Srinivasan <kys@microsoft.com> writes:

> I checked with the folks on the Hyper-V side and they have confirmed that we need to
> add memory barriers in the guest code to ensure the various reads from the TSC page are
> correctly ordered - especially, the initial read of the sequence counter must have acquire
> semantics. We should ensure that other reads from the TSC page are completed before the
> second read of the sequence counter. I am working with the Windows team to correctly
> reflect this algorithm in the Hyper-V specification.


Thank you,

do I get it right that combining the above I only need to replace
virt_rmb() barriers with plain rmb() to get 'lfence' in hv_read_tsc_page
(PATCH 2)? As members of struct ms_hyperv_tsc_page are volatile we don't
need READ_ONCE(), compilers are not allowed to merge accesses. The
resulting code looks good to me:

(gdb) disassemble read_hv_clock_tsc 
Dump of assembler code for function read_hv_clock_tsc:
   0xffffffff8102ca60 <+0>:	callq  0xffffffff816c7500 <__fentry__>
   0xffffffff8102ca65 <+5>:	mov    0xf67974(%rip),%rcx        # 0xffffffff81f943e0 <tsc_pg>
   0xffffffff8102ca6c <+12>:	jmp    0xffffffff8102ca87 <read_hv_clock_tsc+39>
   0xffffffff8102ca6e <+14>:	lfence 
   0xffffffff8102ca71 <+17>:	mov    0x8(%rcx),%r9
   0xffffffff8102ca75 <+21>:	mov    0x10(%rcx),%r8
   0xffffffff8102ca79 <+25>:	nop
   0xffffffff8102ca7a <+26>:	nop
   0xffffffff8102ca7b <+27>:	nop
   0xffffffff8102ca7c <+28>:	rdtsc  
   0xffffffff8102ca7e <+30>:	lfence 
   0xffffffff8102ca81 <+33>:	mov    (%rcx),%edi
   0xffffffff8102ca83 <+35>:	cmp    %edi,%esi
   0xffffffff8102ca85 <+37>:	je     0xffffffff8102caa3 <read_hv_clock_tsc+67>
   0xffffffff8102ca87 <+39>:	mov    (%rcx),%esi
   0xffffffff8102ca89 <+41>:	test   %esi,%esi
   0xffffffff8102ca8b <+43>:	jne    0xffffffff8102ca6e <read_hv_clock_tsc+14>
   0xffffffff8102ca8d <+45>:	push   %rbp
   0xffffffff8102ca8e <+46>:	mov    $0x40000020,%edi
   0xffffffff8102ca93 <+51>:	mov    %rsp,%rbp
   0xffffffff8102ca96 <+54>:	and    $0xfffffffffffffff0,%rsp
   0xffffffff8102ca9a <+58>:	callq  *0xffffffff81c36330
   0xffffffff8102caa1 <+65>:	leaveq 
   0xffffffff8102caa2 <+66>:	retq   
   0xffffffff8102caa3 <+67>:	shl    $0x20,%rdx
   0xffffffff8102caa7 <+71>:	or     %rdx,%rax
   0xffffffff8102caaa <+74>:	mul    %r9
   0xffffffff8102caad <+77>:	mov    %rdx,%rax
   0xffffffff8102cab0 <+80>:	add    %r8,%rax
   0xffffffff8102cab3 <+83>:	cmp    $0xffffffffffffffff,%rax
   0xffffffff8102cab7 <+87>:	je     0xffffffff8102ca8d <read_hv_clock_tsc+45>
   0xffffffff8102cab9 <+89>:	repz retq 
End of assembler dump.

-- 
  Vitaly
