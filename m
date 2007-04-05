From: Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 20/20] Add apply_to_page_range() which applies a function
	to a pte range.
Date: Wed, 4 Apr 2007 23:41:33 -0500
Message-ID: <20070405044133.GE4892@waste.org>
References: <20070404191151.009821039@goop.org>
	<20070404191206.675793431@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070404191206.675793431@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Matt Mackall <mpm@waste.org>, Ingo Molnar <mingo@elte.hu>, Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 04, 2007 at 12:12:11PM -0700, Jeremy Fitzhardinge wrote:
> Add a new mm function apply_to_page_range() which applies a given
> function to every pte in a given virtual address range in a given mm
> structure. This is a generic alternative to cut-and-pasting the Linux
> idiomatic pagetable walking code in every place that a sequence of
> PTEs must be accessed.

As we discussed before, this obviously has a lot in common with my
walk_page_range code.

The major difference and one your above description seems to be
missing the important detail of why it's doing this:

> +	pte_alloc_kernel(pmd, addr) :
> +	pmd =3D pmd_alloc(mm, pud, addr);
> +	pud =3D pud_alloc(mm, pgd, addr);

..which is mentioned here:

> +/*
> + * Scan a region of virtual memory, filling in page tables as necessary
> + * and calling a provided function on each leaf page table.
> + */

But I'm not sure what the use case is that wants filling in the page
table..? If both modes really make sense, perhaps a flag could unify
these differences.

> +typedef int (*pte_fn_t)(pte_t *pte, struct page *pmd_page, unsigned long=
 addr,
> +			void *data);

I'd gotten the impression that these sorts of typedefs were out of
fashion.

> +static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> +				     unsigned long addr, unsigned long end,
> +				     pte_fn_t fn, void *data)
> +{
> +	pte_t *pte;
> +	int err;
> +	struct page *pmd_page;
> +	spinlock_t *ptl;
> +
> +	pte =3D (mm =3D=3D &init_mm) ?
> +		pte_alloc_kernel(pmd, addr) :
> +		pte_alloc_map_lock(mm, pmd, addr, &ptl);
> +	if (!pte)
> +		return -ENOMEM;

Seems a bit awkward to pass mm all the way down the tree just for this
quirk. Which is a bit awkward as it means that whether or not a lock
is held in the callback is context dependent.

smaps, clear_ref, and my pagemap code all use the callback at the
pmd_range level, which a) localizes the pte-level locking concerns
with the user b) amortizes the indirection overhead and c)
(unfortunately) makes the user a bit more complex.

We should try to measure whether (b) actually makes a difference.

> +	do {
> +		err =3D fn(pte, pmd_page, addr, data);
> +		if (err)
> +			break;
> +	} while (pte++, addr +=3D PAGE_SIZE, addr !=3D end);

I was about to say this do/while format seems a bit non-idiomatic for
page table walkers, but then I looked at the code in mm/memory.c and
realized the stuff I've been hacking on is the odd one out.

-- =

Mathematics is the supreme nostalgia of our time.
