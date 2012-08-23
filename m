From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH 2/5] trace-cmd: Use tracing directory to count CPUs
Date: Thu, 23 Aug 2012 12:00:57 +0900
Message-ID: <50359CE9.3000509@hitachi.com>
References: <20120822084251.17293.69086.stgit@ltc189.sdl.hitachi.co.jp>
	<20120822084312.17293.47596.stgit@ltc189.sdl.hitachi.co.jp>
	<1345642893.5069.31.camel@gandalf.local.home>
	<50358F13.1030607@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50358F13.1030607@hitachi.com>
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

(2012/08/23 11:01), Masami Hiramatsu wrote:
> (2012/08/22 22:41), Steven Rostedt wrote:
>> On Wed, 2012-08-22 at 17:43 +0900, Yoshihiro YUNOMAE wrote:
>>> From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>>>
>>> Count debugfs/tracing/per_cpu/cpu* to determine the
>>> number of CPUs.
>>
>> I'm curious, do you find that sysconf doesn't return the # of CPUs the
>> system has?
> 
> No, sysconf returns the number of hosts CPUs, not guests.
> 
>> I've had boxes where the per_cpu/cpu* had more cpus than the
>> box actually holds. But this was a bug in the kernel, not the tool. This
>> change log needs to have rational instead of just explaining what the
>> patch does.
> 
> Ah, I see. Hmm, then this should be enabled by a command line
> option or an environment variable.

Oops, I misunderstood. I'll add more comment for why this
should be tried instead of sysconf.

Thank you,
-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
