From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: Re: [PATCH 1/3] x86: process: Unify 32-bit and 64-bit copy_thread I/O
	bitmap handling
Date: Thu, 31 Oct 2013 21:01:30 +0100
Message-ID: <1383249690.4345.41324921.726E659E@webmail.messagingengine.com>
References: <cover.1382407802.git.josh@joshtriplett.org>
	<41c886146639d4ab07331be335b889e2f48a79b5.1382407802.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <41c886146639d4ab07331be335b889e2f48a79b5.1382407802.git.josh@joshtriplett.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <keescook@chromium.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ross Lagerwall <rosslagerwall@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Wright <chrisw@s>
List-Id: virtualization@lists.linuxfoundation.org

Hi Josh,

Since you added me to the CC, I had a look... Comments inline

On Tue, Oct 22, 2013, at 3:34, Josh Triplett wrote:
> The 32-bit and 64-bit versions of copy_thread have functionally
> identical handling for copying the I/O bitmap, modulo differences in
> error handling.  Clean up the error paths in both by moving the copy of
> the I/O bitmap to the end, to eliminate the need to free it if
> subsequent copy steps fail; move the resulting identical code to a
> static inline in a common header.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  arch/x86/kernel/process-io.h | 22 ++++++++++++++++++++++

I don't particularly like this new file. It's also not in a proper place.

>  arch/x86/kernel/process_32.c | 29 ++++++++---------------------
>  arch/x86/kernel/process_64.c | 26 +++++---------------------

Yay, this I like :). However, unification is best done in a separate step. First
make the two parts equal in one or two patches. Then, in a separate patch,
do the mechanical unification.

>  3 files changed, 35 insertions(+), 42 deletions(-)
>  create mode 100644 arch/x86/kernel/process-io.h
> 
> diff --git a/arch/x86/kernel/process-io.h b/arch/x86/kernel/process-io.h
> new file mode 100644
> index 0000000..d884444
> --- /dev/null
> +++ b/arch/x86/kernel/process-io.h
> @@ -0,0 +1,22 @@
> +#ifndef _X86_KERNEL_PROCESS_IO_H
> +#define _X86_KERNEL_PROCESS_IO_H
> +
> +static inline int copy_io_bitmap(struct task_struct *me,
> +				 struct task_struct *p)
> +{
> +	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
> +		p->thread.io_bitmap_ptr = kmemdup(me->thread.io_bitmap_ptr,
> +						  IO_BITMAP_BYTES, GFP_KERNEL);
> +		if (!p->thread.io_bitmap_ptr) {
> +			p->thread.io_bitmap_max = 0;
> +			return -ENOMEM;
> +		}
> +		set_tsk_thread_flag(p, TIF_IO_BITMAP);
> +	} else {
> +		p->thread.io_bitmap_ptr = NULL;
> +	}
> +
> +	return 0;
> +}
> +

I really don't like the .h-file like this. Could you try avoiding it? I think
it's possible to unify the copy_thread function and in the end move it
to process.c instead. The arch-specific parts can be split out in static
functions guarded by CONFIG_X86_64 (cooking up good names is
the challenge here ;) ).
