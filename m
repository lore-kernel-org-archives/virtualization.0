From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: [PATCH -tip v3 00/23] kprobes: introduce NOKPROBE_SYMBOL() and
	general cleaning of kprobe blacklist
Date: Wed, 20 Nov 2013 09:26:59 -0500
Message-ID: <y0mvbznxi6k.fsf__25748.3184956529$1384970928$gmane$org@fche.csb>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	(Masami Hiramatsu's message of "Wed, 20 Nov 2013 04:21:48 +0000")
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
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, systemtap@sourceware.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


masami.hiramatsu.pt wrote:

> [...]  This series also includes a change which prohibits probing on
> the address in .entry.text because the code is used for very
> low-level sensitive interrupt/syscall entries. Probing such code may
> cause unexpected result (actually most of that area is already in
> the kprobe blacklist).  So I've decide to prohibit probing all of
> them. [...]

Does this new blacklist cover enough that the kernel now survives a
broadly wildcarded perf-probe, e.g. over e.g. all of its kallsyms?


- FChE
