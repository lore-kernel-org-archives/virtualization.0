From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 03/13] x86/paravirt: Convert native patch assembly code
	strings to macros
Date: Fri, 17 Nov 2017 20:10:13 +0100
Message-ID: <a9531df0-0a48-e695-a05a-56e654f9dfbb@suse.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<e4cea2b8aa8ca23122d9c807784ca62ee6cbbff8.1507128293.git.jpoimboe@redhat.com>
	<20171117180713.e4up3dwrszpatka6@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171117180713.e4up3dwrszpatka6@pd.tnic>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 17/11/17 19:07, Borislav Petkov wrote:
> On Wed, Oct 04, 2017 at 10:58:24AM -0500, Josh Poimboeuf wrote:
>> Convert the hard-coded native patch assembly code strings to macros to
>> facilitate sharing common code between 32-bit and 64-bit.
>>
>> These macros will also be used by a future patch which requires the GCC
>> extended asm syntax of two '%' characters instead of one when specifying
>> a register name.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>> ---
>>  arch/x86/include/asm/special_insns.h | 24 ++++++++++++++++++++++++
>>  arch/x86/kernel/paravirt_patch_32.c  | 21 +++++++++++----------
>>  arch/x86/kernel/paravirt_patch_64.c  | 29 +++++++++++++++--------------
>>  3 files changed, 50 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
>> index ac402c6fc24b..0549c5f2c1b3 100644
>> --- a/arch/x86/include/asm/special_insns.h
>> +++ b/arch/x86/include/asm/special_insns.h
>> @@ -6,6 +6,30 @@
>>  
>>  #include <asm/nops.h>
>>  
>> +#ifdef CONFIG_X86_64
>> +# define _REG_ARG1			"%rdi"
>> +# define NATIVE_IDENTITY_32		"mov %edi, %eax"
> 
> Yeah, that "identity" looks strange. How about NATIVE_NOOP and
> NATIVE_NOOP_32 ?

Those are not NOPs. They return the identical value which was passed to
them. So identity isn't a bad name after all.

> 
>> +# define NATIVE_USERGS_SYSRET64		"swapgs; sysretq"
>> +#else
>> +# define _REG_ARG1			"%eax"
>> +#endif
>> +
>> +#define _REG_RET			"%" _ASM_AX
>> +
>> +#define NATIVE_ZERO			"xor " _REG_ARG1 ", " _REG_ARG1
> 
> NATIVE_ZERO_OUT
> 
> I guess. NATIVE_ZERO reads like the native representation of 0 :-)

NATIVE_ZERO_ARG1?


Juergen
