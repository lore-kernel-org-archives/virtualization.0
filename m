From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Date: Mon, 4 Jan 2016 15:05:09 +0100
Message-ID: <20160104140509.GB6344__36780.4341404282$1451916344$gmane$org@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-32-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1451572003-2440-32-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 31, 2015 at 09:09:47PM +0200, Michael S. Tsirkin wrote:
> At the moment, xchg on sh only supports 4 and 1 byte values, so using it
> from smp_store_mb means attempts to store a 2 byte value using this
> macro fail.
> 
> And happens to be exactly what virtio drivers want to do.
> 
> Check size and fall back to a slower, but safe, WRITE_ONCE+smp_mb.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/sh/include/asm/barrier.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sh/include/asm/barrier.h b/arch/sh/include/asm/barrier.h
> index f887c64..0cc5735 100644
> --- a/arch/sh/include/asm/barrier.h
> +++ b/arch/sh/include/asm/barrier.h
> @@ -32,7 +32,15 @@
>  #define ctrl_barrier()	__asm__ __volatile__ ("nop;nop;nop;nop;nop;nop;nop;nop")
>  #endif
>  
> -#define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
> +#define __smp_store_mb(var, value) do { \
> +	if (sizeof(var) != 4 && sizeof(var) != 1) { \
> +		 WRITE_ONCE(var, value); \
> +		__smp_mb(); \
> +	} else { \
> +		(void)xchg(&var, value);  \
> +	} \
> +} while (0)

So SH is an orphaned arch, which is also why I did not comment on using
xchg() for the UP smp_store_mb() thing.

But I really think we should try fixing the xchg() implementation
instead of this duct-tape.
