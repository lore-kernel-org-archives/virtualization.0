From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH -tip v3 18/23] x86/dumpstack: Use NOKPROBE_SYMBOL macro
	in dumpstack.c
Date: Fri, 22 Nov 2013 11:08:08 +0900
Message-ID: <528EBC88.2030609__14155.4870330312$1385086112$gmane$org@hitachi.com>
References: <20131120042148.15296.88360.stgit@kbuild-fedora.novalocal>
	<20131120042233.15296.31189.stgit@kbuild-fedora.novalocal>
	<20131121113006.GA27659@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131121113006.GA27659@gmail.com>
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
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, "David S. Miller" <davem@davemloft.net>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

(2013/11/21 20:30), Ingo Molnar wrote:
> 
> * Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com> wrote:
> 
>> Use NOKPROBE_SYMBOL macro for protecting functions
>> from kprobes instead of __kprobes annotation in
>> dumpstack.c.
>>
>> Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Jiri Slaby <jslaby@suse.cz>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> ---
>>  arch/x86/kernel/dumpstack.c |    9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Btw., all these mechanic changes of the __kprobes annotation can be 
> merged into a single patch. That will cut down on the size of the 
> series substantially.

Right, I just thought it would be easy to review for each
subsystem maintainer, because some of them including
forcibly (or explicitly) inlined changes (__always_inline).

Thank you,

-- 
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
