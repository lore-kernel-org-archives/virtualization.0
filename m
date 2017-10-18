From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v1 15/27] compiler: Option to default to hidden symbols
Date: Wed, 18 Oct 2017 16:15:10 -0700
Message-ID: <CAJcbSZEJ-kjcRQD3uHm0QZuOvbHpg9FV=wn7v4-RweDG7J3uqg__13884.0779582553$1509080600$gmane$org@mail.gmail.com>
References: <20171011203027.11248-1-thgarnie@google.com>
	<20171011203027.11248-16-thgarnie@google.com>
	<20171012200201.GW11645@wotan.suse.de>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171012200201.GW11645@wotan.suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Michal Hocko <mhocko@suse.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-doc@vger.kernel.org, kvm list <kvm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, =?UTF-8?B?SmFuIEggLiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>, Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Waiman Long <longman@redhat.com>, Pavel Machek <pavel@ucw.cz>, "H . Peter Anvin" <hpa@zytor.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Christoph Lameter <cl@linux.com>, Alok Kataria <akataria@vmware.com>, the arch/x86 maintainers <x86@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Daniel Borkmann <daniel@iogearbox.net>, Jonathan
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 12, 2017 at 1:02 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Wed, Oct 11, 2017 at 01:30:15PM -0700, Thomas Garnier wrote:
>> Provide an option to default visibility to hidden except for key
>> symbols. This option is disabled by default and will be used by x86_64
>> PIE support to remove errors between compilation units.
>>
>> The default visibility is also enabled for external symbols that are
>> compared as they maybe equals (start/end of sections). In this case,
>> older versions of GCC will remove the comparison if the symbols are
>> hidden. This issue exists at least on gcc 4.9 and before.
>>
>> Signed-off-by: Thomas Garnier <thgarnie@google.com>
>
> <-- snip -->
>
>> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
>> index 86e8f0b2537b..8f021783a929 100644
>> --- a/arch/x86/kernel/cpu/microcode/core.c
>> +++ b/arch/x86/kernel/cpu/microcode/core.c
>> @@ -144,8 +144,8 @@ static bool __init check_loader_disabled_bsp(void)
>>       return *res;
>>  }
>>
>> -extern struct builtin_fw __start_builtin_fw[];
>> -extern struct builtin_fw __end_builtin_fw[];
>> +extern struct builtin_fw __start_builtin_fw[] __default_visibility;
>> +extern struct builtin_fw __end_builtin_fw[] __default_visibility;
>>
>>  bool get_builtin_firmware(struct cpio_data *cd, const char *name)
>>  {
>
> <-- snip -->
>
>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>> index e5da44eddd2f..1aa5d6dac9e1 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -30,6 +30,9 @@
>>   *   __irqentry_text_start, __irqentry_text_end
>>   *   __softirqentry_text_start, __softirqentry_text_end
>>   */
>> +#ifdef CONFIG_DEFAULT_HIDDEN
>> +#pragma GCC visibility push(default)
>> +#endif
>>  extern char _text[], _stext[], _etext[];
>>  extern char _data[], _sdata[], _edata[];
>>  extern char __bss_start[], __bss_stop[];
>> @@ -46,6 +49,9 @@ extern char __softirqentry_text_start[], __softirqentry_text_end[];
>>
>>  /* Start and end of .ctors section - used for constructor calls. */
>>  extern char __ctors_start[], __ctors_end[];
>> +#ifdef CONFIG_DEFAULT_HIDDEN
>> +#pragma GCC visibility pop
>> +#endif
>>
>>  extern __visible const void __nosave_begin, __nosave_end;
>>
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index e95a2631e545..6997716f73bf 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -78,6 +78,14 @@ extern void __chk_io_ptr(const volatile void __iomem *);
>>  #include <linux/compiler-clang.h>
>>  #endif
>>
>> +/* Useful for Position Independent Code to reduce global references */
>> +#ifdef CONFIG_DEFAULT_HIDDEN
>> +#pragma GCC visibility push(hidden)
>> +#define __default_visibility  __attribute__((visibility ("default")))
>
> Does this still work with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION ?

I cannot make it work with or without this change. How is it supposed
to be used?

For me with, it crashes with a bad consdev at:
http://elixir.free-electrons.com/linux/latest/source/drivers/tty/tty_io.c#L3194

>
>> +#else
>> +#define __default_visibility
>> +#endif
>> +
>>  /*
>>   * Generic compiler-dependent macros required for kernel
>>   * build go below this comment. Actual compiler/compiler version
>> diff --git a/init/Kconfig b/init/Kconfig
>> index ccb1d8daf241..b640201fcff7 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1649,6 +1649,13 @@ config PROFILING
>>  config TRACEPOINTS
>>       bool
>>
>> +#
>> +# Default to hidden visibility for all symbols.
>> +# Useful for Position Independent Code to reduce global references.
>> +#
>> +config DEFAULT_HIDDEN
>> +     bool
>
> Note it is default.
>
> Has 0-day ran through this git tree? It should be easy to get it added for
> testing. Also, even though most changes are x86 based there are some generic
> changes and I'd love a warm fuzzy this won't break odd / random builds.
> Although 0-day does cover a lot of test cases, it only has limited run time
> tests. There are some other test beds which also cover some more obscure
> architectures. Having a test pass on Guenter's test bed would be nice to
> see. For that please coordinate with Guenter if he's willing to run this
> a test for you.

Not yet, plan to give a v1.5 to Kees Cook to keep in one of his tree
for couple weeks. I expect it will identify interesting issues.

>
>   Luis



-- 
Thomas
