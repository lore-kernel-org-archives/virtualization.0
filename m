From: Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 20/20] Add apply_to_page_range() which applies a function
	to a pte range.
Date: Tue, 17 Apr 2007 15:56:52 -0500
Message-ID: <20070417205652.GM11115@waste.org>
References: <20070404191151.009821039@goop.org>
	<20070404191206.675793431@goop.org>
	<20070405044133.GE4892@waste.org> <46149CC9.2070903@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46149CC9.2070903@goop.org>
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

On Wed, Apr 04, 2007 at 11:52:57PM -0700, Jeremy Fitzhardinge wrote:
> Matt Mackall wrote:
> >> +/*
> >> + * Scan a region of virtual memory, filling in page tables as necessa=
ry
> >> + * and calling a provided function on each leaf page table.
> >> + */
> >>     =

> >
> > But I'm not sure what the use case is that wants filling in the page
> > table..? If both modes really make sense, perhaps a flag could unify
> > these differences.
> >   =

> =

> Well, two reasons:
> =

> One is the general one that if you're traversing ptes then they need to
> exist to traverse them (for example, if you're creating new mappings). =

> Obviously if you want to just visit existing mappings, then
> instantiating new pagetable is not the right thing to do (and I could
> make use of this too).
> =

> The other is that there are various places in the Xen hypervisor API
> where you pass in a reference to pte entry for the hypervisor to put
> mappings into, and the rest of the pagetable needs to exist.  The Xen
> code uses the side-effect of apply_to_page_range() to create pagetable
> for these calls.

I think adding a flags field and an allocate flag to my callback
struct would be sufficient here.

> > I'd gotten the impression that these sorts of typedefs were out of
> > fashion.
> >   =

> =

> In general yes, but for function pointers the syntax is so clumsy that I
> think typedefs are OK.

The syntax is horrible, but I don't think we end up using the
resultant type enough to justify the namespace pollution.

-- =

Mathematics is the supreme nostalgia of our time.
