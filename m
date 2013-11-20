From: Josh Stone <jistone@redhat.com>
Subject: Re: [PATCH -tip v3 00/23] kprobes: introduce NOKPROBE_SYMBOL() and
	general cleaning of kprobe blacklist
Date: Wed, 20 Nov 2013 10:09:49 -0800
Message-ID: <528CFAED.1000703__37338.9589404271$1384971256$gmane$org@redhat.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>	<y0mvbznxi6k.fsf@fche.csb>	<20131120153801.GA9743@gmail.com>	<20131120173600.GK8993@redhat.com>
	<20131120125649.40ca99c3@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131120125649.40ca99c3@gandalf.local.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Steven Rostedt <rostedt@goodmis.org>, "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/20/2013 09:56 AM, Steven Rostedt wrote:
> On Wed, 20 Nov 2013 12:36:00 -0500
> "Frank Ch. Eigler" <fche@redhat.com> wrote:
> 
>> Hi -
>>
>>>> Does this new blacklist cover enough that the kernel now survives a 
>>>> broadly wildcarded perf-probe, e.g. over e.g. all of its kallsyms?
>>>
>>> That's generally the purpose of the annotations - if it doesn't then 
>>> that's a bug.
>>
>> AFAIK, no kernel since kprobes was introduced has ever stood up to
>> that test.  perf probe lacks the wildcarding powers of systemtap, so
>> one needs to resort to something like:
>>
>> # cat /proc/kallsyms | grep ' [tT] ' | while read addr type symbol; do
>>    perf probe $symbol
>> done
> 
> I'm curious to why one would do that. IIUC, perf now has function
> tracing support.

Then consider something like probing all inline "call" sites, which will
be sprinkled in the middle where ftrace doesn't apply.

The point is not whether there's an alternative - kprobes really ought
to be wholly safe regardless.  Slow, if you did such broad probing,
sure, but still safe.

And a real use-case probably wouldn't probe *all* functions/inlines, but
it illustrates that there are at least a few in the full set that don't
behave well.
