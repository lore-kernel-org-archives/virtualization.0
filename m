From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -tip RFC 0/2] kprobes: introduce NOKPROBE_SYMBOL() and
	prohibit probing on .entry.text
Date: Mon, 11 Nov 2013 22:15:30 +0100
Message-ID: <20131111211530.GA19316@gmail.com>
References: <20131108125213.19972.49271.stgit@kbuild-fedora.novalocal>
	<20131111111618.GA15810@gmail.com> <5281117D.3010202@hitachi.com>
	<20131111122537.5c3192d2@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20131111122537.5c3192d2@gandalf.local.home>
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
Cc: x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 12 Nov 2013 02:18:53 +0900
> Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
> > 
> > > After that we can convert all the rest, probably as part of this series.
> > 
> > OK, I'll do. :)
> > BTW, converting all the __kprobes involves many archs, which
> > kprobes ported. In that case, which mailing-list would better me
> > to post the series, linux-arch?
> 
> I would add linux-arch.
> 
> Note, you may need to support both ways for the current time being, as 
> new __kprobes are being added (I've seen several in patches flying by in 
> LKML).

We'd rather like to know about all cases where new code is added to 
kprobes (or where we missed to consider some existing code).

It's really just a handful of annotations, the brunt of which is internal 
to kprobes.

Thanks,

	Ingo
