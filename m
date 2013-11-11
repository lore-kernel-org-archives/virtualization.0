From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: [PATCH -tip RFC 0/2] kprobes: introduce NOKPROBE_SYMBOL()
	and prohibit probing on .entry.text
Date: Tue, 12 Nov 2013 02:18:53 +0900
Message-ID: <5281117D.3010202@hitachi.com>
References: <20131108125213.19972.49271.stgit@kbuild-fedora.novalocal>
	<20131111111618.GA15810@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131111111618.GA15810@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

(2013/11/11 20:16), Ingo Molnar wrote:
> 
> * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
> 
>> Currently the blacklist is maintained by hand in kprobes.c 
>> which is separated from the function definition and is hard
>> to catch up the kernel update.
>> To solve this issue, I've tried to implement new
>> NOKPROBE_SYMBOL() macro for making kprobe blacklist at 
>> build time. Since the NOKPROBE_SYMBOL() macros can be placed
>> right after the function is defined, it is easy to maintain.
>> At this moment, I applied the macro only for the symbols
>> which is listed in kprobes.c. As we discussed in previous
>> thread, if the gcc accepts to introduce new annotation to
>> store the function address (and size) at somewhere, we can
>> easily move onto that by replacing NOKPROBE_SYMBOL() with
>> nokprobe annotation (and just modifying the
>> populate_kprobe_blacklist() a bit).
>>
>> This series also includes a change which prohibits probing
>> on the address in .entry.text because the code is used for
>> very low-level sensitive interrupt/syscall entries. Probing
>> such code may cause unexpected result (actually most of
>> that area is already in the kprobe blacklist).
>> So I've decide to prohibit probing all of them.
>>
>> Since Ingo wasn't convinced about the idea in the previous
>> discussion, I just make this series as RFC series.
>> I'd like to ask again with actual implementation and plan.
>>
>> Thank you,
>>
>> ---
>>
>> Masami Hiramatsu (2):
>>       kprobes: Prohibit probing on .entry.text code
>>       kprobes: Introduce NOKPROBE_SYMBOL() macro for blacklist
>>
>>
>>  arch/x86/kernel/entry_32.S        |   33 ------------
>>  arch/x86/kernel/entry_64.S        |   20 --------
>>  arch/x86/kernel/paravirt.c        |    4 ++
>>  include/asm-generic/vmlinux.lds.h |    9 +++
>>  include/linux/kprobes.h           |   19 +++++++
>>  kernel/kprobes.c                  |   98 ++++++++++++++++++-------------------
>>  kernel/sched/core.c               |    1 
>>  7 files changed, 80 insertions(+), 104 deletions(-)
> 
> Ok, I like it after all.
> 
> Mind changing over arch/x86/kprobes/* to use this new facility? There's no 
> sense in kprobes internals using two types

Sure, that's why I introduced this :)

> After that we can convert all the rest, probably as part of this series.

OK, I'll do. :)
BTW, converting all the __kprobes involves many archs, which
kprobes ported. In that case, which mailing-list would better me
to post the series, linux-arch?

> 
> There's a good reason now to do it: it's not just about cleanliness, it 
> will also impact generated code less.

Thank you!


-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
