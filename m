From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip v3 00/23] kprobes: introduce NOKPROBE_SYMBOL() and
	general cleaning of kprobe blacklist
Date: Wed, 20 Nov 2013 12:56:49 -0500
Message-ID: <20131120125649.40ca99c3__4940.35741216994$1384970223$gmane$org@gandalf.local.home>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<y0mvbznxi6k.fsf@fche.csb> <20131120153801.GA9743@gmail.com>
	<20131120173600.GK8993@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131120173600.GK8993@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 20 Nov 2013 12:36:00 -0500
"Frank Ch. Eigler" <fche@redhat.com> wrote:

> Hi -
> 
> > > Does this new blacklist cover enough that the kernel now survives a 
> > > broadly wildcarded perf-probe, e.g. over e.g. all of its kallsyms?
> > 
> > That's generally the purpose of the annotations - if it doesn't then 
> > that's a bug.
> 
> AFAIK, no kernel since kprobes was introduced has ever stood up to
> that test.  perf probe lacks the wildcarding powers of systemtap, so
> one needs to resort to something like:
> 
> # cat /proc/kallsyms | grep ' [tT] ' | while read addr type symbol; do
>    perf probe $symbol
> done

I'm curious to why one would do that. IIUC, perf now has function
tracing support.

-- Steve

> 
> then wait for a few hours for that to finish. Then, or while the loop
> is still running, run
> 
> # perf record -e 'probe:*' -aR sleep 1
> 
> to take a kernel down.
> 
> 
> - FChE
