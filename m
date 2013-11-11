From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip RFC 0/2] kprobes: introduce NOKPROBE_SYMBOL() and
	prohibit probing on .entry.text
Date: Mon, 11 Nov 2013 12:25:37 -0500
Message-ID: <20131111122537.5c3192d2@gandalf.local.home>
References: <20131108125213.19972.49271.stgit@kbuild-fedora.novalocal>
	<20131111111618.GA15810@gmail.com> <5281117D.3010202@hitachi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5281117D.3010202@hitachi.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 12 Nov 2013 02:18:53 +0900
Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
> 
> > After that we can convert all the rest, probably as part of this series.
> 
> OK, I'll do. :)
> BTW, converting all the __kprobes involves many archs, which
> kprobes ported. In that case, which mailing-list would better me
> to post the series, linux-arch?

I would add linux-arch.

Note, you may need to support both ways for the current time being, as
new __kprobes are being added (I've seen several in patches flying by
in LKML).

But perhaps at a later -rc we convert the rest and discontinue them.
That way, linux-next will break all new __kprobes, and that should get
them fixed before we enter 3.14-rc.

-- Steve
