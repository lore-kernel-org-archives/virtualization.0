From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] arch: x86: kernel: fixed unused label issue
Date: Wed, 14 Dec 2016 18:06:19 +0100
Message-ID: <20161214170619.GQ3124@twins.programming.kicks-ass.net>
References: <20161214111510.GA23861@westernst>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20161214111510.GA23861@westernst>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Piotr Gregor <piotrgregor@rsyncme.org>
Cc: jeremy@goop.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 14, 2016 at 11:15:13AM +0000, Piotr Gregor wrote:
> The patch_default label is only used from within
> 	case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock)
> and
> 	case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted)
> i.e. when #if defined(CONFIG_PARAVIRT_SPINLOCKS) is true.
> Therefore no code jumps to this label in case CONFIG_PARAVIRT_SPINLOCKS
> is not defined and label should be removed in that case.
> Moving #endif directive just after that label fixes the issue.
> 
> In addition,there are three errors reported by checkpatch script
> on this file. This commit fixes two of them. The last one is
> 	ERROR: Macros with multiple statements should be enclosed
> 	in a do - while loop
> which probably is a false alarm here as PATCH_SITE macro defines
> a case in switch local to native_patch function not meant to be used
> in other places.
> 
> Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
> ---
>  arch/x86/kernel/paravirt_patch_64.c | 67 +++++++++++++++++++------------------
>  1 file changed, 34 insertions(+), 33 deletions(-)

*urgh*

So you forgot to look up the patch that caused it, which made you fail
to Cc the author of the patch that caused it (me).

That also made you miss the fact that you're only fixing half the
problem, namely you failed to touch arch/x86/kernel/paravirt_patch_32.c
which has identical code in.

Thirdly you used checkpatch and moved muck about creating a trainwreck
of a patch.

Anyway, you can use __maybe_unused on a label, I'm not sure which I
prefer, this way you jump into the previous case block and use
fall-through, while with the variant I did you jump into the right case.

Its a shame you cannot jump to the default label itself.
