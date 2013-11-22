From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH -tip v3 13/23] x86/trap: Use NOKPROBE_SYMBOL macro in
	trap.c
Date: Fri, 22 Nov 2013 13:21:19 -0800
Message-ID: <20131122212119.GE19762__18248.4101540924$1385400655$gmane$org@tassilo.jf.intel.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<20131120042221.15296.85443.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20131120042221.15296.85443.stgit@kbuild-fedora.novalocal>
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
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Seiji Aguchi <seiji.aguchi@hds.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 20, 2013 at 04:22:21AM +0000, Masami Hiramatsu wrote:
> Use NOKPROBE_SYMBOL macro to protect functions from kprobes
> instead of __kprobes annotation in trap.c.
> This also applies __always_inline annotation for some cases,
> because NOKPROBE_SYMBOL() will inhibit inlining by referring
> the symbol address.

NOKPROBE_SYMBOL seems to add a reference from some variable to the function?

With LTO we can optimize away unused functions, but not
when there are references to the symbol. So this would likely
prevent optimizations with LTO.

I prefer a simpler "__kprobe" annotation.

-Andi
