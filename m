From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] avoid ifdefs in desc.h, getting rid of pack_ldt and
	pack_tss
Date: Thu, 13 Dec 2007 21:58:38 +0100
Message-ID: <20071213205838.GA9649@elte.hu>
References: <11975561713425-git-send-email-gcosta@redhat.com>
	<20071213202800.GD25130@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071213202800.GD25130@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: ehabkost@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, tglx@linutronix.de, roland@redhat.com, ak@suse.de
List-Id: virtualization@lists.linuxfoundation.org


just got the crash below. config attached. Suspects are:

 Subject: unify struct desc_ptr
 Subject: unify paravirt pieces of descriptor handling

could we _please_ use basic tools as vmlinux size comparison and 
objcompare when unifying, to make sure it's a 100% identity conversion?

	Ingo

------------>
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
general protection fault: 0080 [#1] SMP 

Pid: 0, comm: swapper Not tainted (2.6.24-rc5 #490)
EIP: 0060:[<40118008>] EFLAGS: 00010086 CPU: 0
EIP is at native_load_tr_desc+0x8/0x10
EAX: 00000080 EBX: 00000009 ECX: 409c9efc EDX: 41e0d080
ESI: 41e0d000 EDI: 40a62000 EBP: 409c9edc ESP: 409c9edc
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
Process swapper (pid: 0, ti=409c8000 task=4090e3e0 task.ti=409c8000)
Stack: 409c9f10 409dcde4 40850594 00000000 000000e5 00000000 409ba000 409ba000 
       77c00009 4100ebe5 00000001 409ba000 409ba000 409c9fc4 409d916d 4088a1f3 
       0060680c 4010ef00 00607400 40108f00 006074b0 40108f00 006073f4 40108f00 
Call Trace:
 [<4010796a>] show_trace_log_lvl+0x1a/0x30
 [<40107a29>] show_stack_log_lvl+0xa9/0xd0
 [<40107b05>] show_registers+0xb5/0x1a0
 [<40107d06>] die+0x116/0x220
 [<401086ac>] do_general_protection+0x19c/0x260
 [<4073b542>] error_code+0x72/0x78
 [<409dcde4>] cpu_init+0x154/0x280
 [<409d916d>] trap_init+0x3cd/0x460
 [<409d1c93>] start_kernel+0x213/0x3d0
 [<00000000>] 0x0
 =======================
Code: 90 90 90 55 89 e5 9c 5a 81 e2 ff cf ff ff 09 c2 52 9d c9 c3 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90 90 55 b8 80 00 00 00 89 e5 <0f> 00 d8 c9 c3 8d 76 00 55 89 e5 0f 01 10 c9 c3 90 8d b4 26 00 
EIP: [<40118008>] native_load_tr_desc+0x8/0x10 SS:ESP 0068:409c9edc
Kernel panic - not syncing: Attempted to kill the idle task!
