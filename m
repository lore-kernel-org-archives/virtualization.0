From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [PATCH 04/20] x86/ticketlock: make large and small ticket
	versions of spin_lock the same
Date: Fri, 12 Nov 2010 17:49:32 +0530
Message-ID: <20101112121932.GA30016__46397.3023499877$1289578084$gmane$org@linux.vnet.ibm.com>
References: <cover.1288794124.git.jeremy.fitzhardinge@citrix.com>
	<5b3cbff3a6e96a085651f140a0525be80a4df8ba.1288794124.git.jeremy.fitzhardinge@citrix.com>
Reply-To: vatsa@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5b3cbff3a6e96a085651f140a0525be80a4df8ba.1288794124.git.jeremy.fitzhardinge@citrix.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Nick Piggin <npiggin@suse.de>, Xen-devel <xen-devel@lists.xensource.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 03, 2010 at 10:59:45AM -0400, Jeremy Fitzhardinge wrote:
> Make the bulk of __ticket_spin_lock look identical for large and small
> number of cpus.

[snip]

>  #if (NR_CPUS < 256)
>  static __always_inline void __ticket_spin_lock(arch_spinlock_t *lock)
>  {
> -	register union {
> -		struct __raw_tickets tickets;
> -		unsigned short slock;
> -	} inc = { .slock = 1 << TICKET_SHIFT };
> +	register struct __raw_tickets inc = { .tail = 1 };

[snip]

>  #else
>  static __always_inline void __ticket_spin_lock(arch_spinlock_t *lock)
>  {
> -	unsigned inc = 1 << TICKET_SHIFT;
> -	__ticket_t tmp;
> +	register struct __raw_tickets inc = { .tickets.tail = 1 };

s/.tickets//?

Otherwise I get a compile error for NR_CPUS > 256, with just 4 patches applied.

- vatsa
