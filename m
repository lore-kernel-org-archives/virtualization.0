From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 12/21] Xen-paravirt: Allocate and free vmalloc areas
Date: Thu, 15 Feb 2007 22:43:22 -0800
Message-ID: <20070215224322.5c73d8e9.akpm@linux-foundation.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.417300365@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070216022531.417300365@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Feb 2007 18:25:01 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> +void lock_vm_area(struct vm_struct *area)
> +{
> +	unsigned long i;
> +	char c;
> +
> +	/*
> +	 * Prevent context switch to a lazy mm that doesn't have this area
> +	 * mapped into its page tables.
> +	 */
> +	preempt_disable();
> +
> +	/*
> +	 * Ensure that the page tables are mapped into the current mm. The
> +	 * page-fault path will copy the page directory pointers from init_mm.
> +	 */
> +	for (i =3D 0; i < area->size; i +=3D PAGE_SIZE)
> +		(void)__get_user(c, (char __user *)area->addr + i);
> +}
> +EXPORT_SYMBOL_GPL(lock_vm_area);

This won't work when CONFIG_PREEMPT=3Dy.  The pagefault handler will see
in_atomic() and will scram.

(pet-peeve-from-someone-who-remembers-fortran: the reader expects the
variable `i' to be signed.  signed int really)
