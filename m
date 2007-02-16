From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 11/21] Xen-paravirt: Add apply_to_page_range() which
	applies a function to a pte range.
Date: Thu, 15 Feb 2007 22:37:27 -0800
Message-ID: <20070215223727.6819f962.akpm@linux-foundation.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.344125142@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070216022531.344125142@goop.org>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, Christoph Lameter <clameter@sgi.com>, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Feb 2007 18:25:00 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> Add a new mm function apply_to_page_range() which applies a given
> function to every pte in a given virtual address range in a given mm
> structure. This is a generic alternative to cut-and-pasting the Linux
> idiomatic pagetable walking code in every place that a sequence of
> PTEs must be accessed.
> =

> Although this interface is intended to be useful in a wide range of
> situations, it is currently used specifically by several Xen
> subsystems, for example: to ensure that pagetables have been allocated
> for a virtual address range, and to construct batched special
> pagetable update requests to map I/O memory (in ioremap()).

There was some discussion about this sort of thing last week.  The
consensus was that it's better to run the callback against a whole pmd's
worth of ptes, mainly to amortise the callback's cost (a lot).

It was implemented in
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20/2.6.20=
-mm1/broken-out/smaps-extract-pmd-walker-from-smaps-code.patch
