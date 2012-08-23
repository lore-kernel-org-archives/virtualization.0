From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: Re: [PATCH 2/5] trace-cmd: Use tracing directory to count
 CPUs
Date: Thu, 23 Aug 2012 21:30:07 +0900
Message-ID: <5036224F.3060706@hitachi.com>
References: <20120822084251.17293.69086.stgit@ltc189.sdl.hitachi.co.jp>
	<20120822084312.17293.47596.stgit@ltc189.sdl.hitachi.co.jp>
	<1345642893.5069.31.camel@gandalf.local.home>
	<50358F13.1030607@hitachi.com> <50359CE9.3000509@hitachi.com>
	<1345712886.5069.41.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1345712886.5069.41.camel@gandalf.local.home>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, qemu-devel@nongnu.org, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@amd64.org>, virtualization@lists.linux-foundation.org, "Franch Ch. Eigler" <fche@redhat.com>, Ingo Molnar <mingo@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Anthony Liguori <anthony@codemonkey.ws>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Shah <amit.shah@redhat.com>, yrl.pp-manager.tt@hitachi.com
List-Id: virtualization@lists.linuxfoundation.org

(2012/08/23 18:08), Steven Rostedt wrote:
> On Thu, 2012-08-23 at 12:00 +0900, Masami Hiramatsu wrote:
>> (2012/08/23 11:01), Masami Hiramatsu wrote:
>>> (2012/08/22 22:41), Steven Rostedt wrote:
>>>> On Wed, 2012-08-22 at 17:43 +0900, Yoshihiro YUNOMAE wrote:
>>>>> From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>>>>>
>>>>> Count debugfs/tracing/per_cpu/cpu* to determine the
>>>>> number of CPUs.
>>>>
>>>> I'm curious, do you find that sysconf doesn't return the # of CPUs the
>>>> system has?
>>>
>>> No, sysconf returns the number of hosts CPUs, not guests.
>>>
>>>> I've had boxes where the per_cpu/cpu* had more cpus than the
>>>> box actually holds. But this was a bug in the kernel, not the tool. This
>>>> change log needs to have rational instead of just explaining what the
>>>> patch does.
>>>
>>> Ah, I see. Hmm, then this should be enabled by a command line
>>> option or an environment variable.
>>
>> Oops, I misunderstood. I'll add more comment for why this
>> should be tried instead of sysconf.
> 
> And now that I understand why you are doing this, why not only do this
> if the TRACE_AGENT or DEBUG_TRACING_DIR is defined. That is, if we are
> doing it against a bare metal system, then sysconf should suffice, but
> if we are tracing against a guest, then it should use the tracing
> directory to determine the buffers.
> 
> We could add options to override this, but I would think the default
> should just Do The Right Thing(tm).

Yeah, so I'd like to push this is the default method, and fix
the kernel bug (but I'm not sure that is a bug).

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
