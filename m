From: Thomas Garnier via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: Re: [RFC v3 20/27] x86/ftrace: Adapt function tracing for PIE support
Date: Thu, 5 Oct 2017 09:01:14 -0700
Message-ID: <CAJcbSZHa3SyCR8zEm-Yor9CmBUfcjr0eE_6HMnaeq83gitdJNQ__23997.1859766685$1509080046$gmane$org@mail.gmail.com>
References: <20171004212003.28296-1-thgarnie@google.com>
	<20171004212003.28296-21-thgarnie@google.com>
	<20171005090633.5a6ce840@gandalf.local.home>
Reply-To: Thomas Garnier <thgarnie@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171005090633.5a6ce840@gandalf.local.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Michal Hocko <mhocko@suse.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, linux-doc@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Christopher Li <sparse@chrisli.org>, =?UTF-8?B?SmFuIEggLiBTY2jDtm5oZXJy?= <jschoenh@amazon.de>, Alexei Starovoitov <ast@kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Pavel Machek <pavel@ucw.cz>, "H . Peter Anvin" <hpa@zytor.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>, Chris Metcalf <cmetcalf@mellanox.com>, the arch/x86 maintainers <x86@kernel.or>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 5, 2017 at 6:06 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed,  4 Oct 2017 14:19:56 -0700
> Thomas Garnier <thgarnie@google.com> wrote:
>
>> When using -fPIE/PIC with function tracing, the compiler generates a
>> call through the GOT (call *__fentry__@GOTPCREL). This instruction
>> takes 6 bytes instead of 5 on the usual relative call.
>>
>> With this change, function tracing supports 6 bytes on traceable
>> function and can still replace relative calls on the ftrace assembly
>> functions.
>>
>> Position Independent Executable (PIE) support will allow to extended the
>> KASLR randomization range below the -2G memory limit.
>
> Question: This 6 bytes is only the initial call that gcc creates. When
> function tracing is enabled, the calls are back to the normal call to
> the ftrace trampoline?

That is correct.

>
> -- Steve
>



-- 
Thomas
