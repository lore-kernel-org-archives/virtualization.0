From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 31/43] lguest: Boot with virtual == physical to get
	closer to native Linux.
Date: Sat, 29 Sep 2007 23:02:38 +1000
Message-ID: <1191070958.26950.21.camel@localhost.localdomain>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063650.704084137@rustcorp.com.au> <46FAF57A.5020105@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46FAF57A.5020105@goop.org>
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
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-09-26 at 17:12 -0700, Jeremy Fitzhardinge wrote:
> rusty@rustcorp.com.au wrote:
> > +/* We walk down the guest page tables to get a guest-physical address */
> > +unsigned long guest_pa(struct lguest *lg, unsigned long vaddr)
> > +{
> > +	pgd_t gpgd;
> > +	pte_t gpte;
> > +
> > +	/* First step: get the top-level Guest page table entry. */
> > +	gpgd = __pgd(lgread_u32(lg, gpgd_addr(lg, vaddr)));
> > +	/* Toplevel not present?  We can't map it in. */
> > +	if (!(pgd_flags(gpgd) & _PAGE_PRESENT))
> > +		kill_guest(lg, "Bad address %#lx", vaddr);
> > +
> > +	gpte = __pte(lgread_u32(lg, gpte_addr(lg, gpgd, vaddr)));
> > +	if (!(pte_flags(gpte) & _PAGE_PRESENT))
> > +		kill_guest(lg, "Bad address %#lx", vaddr);
> > +
> > +	return pte_pfn(gpte) * PAGE_SIZE | (vaddr & ~PAGE_MASK);
> > +}
> 
> That's nice and general, but is it necessary?  Is this just to handle
> the two cases of booting with P=V, then switching to the normal kernel
> offset?

Hi Jeremy,

	It's probably overkill, but it has the advantage of being
straightforward and futureproof.

Cheers,
Rusty.
