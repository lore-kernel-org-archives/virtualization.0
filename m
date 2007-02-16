From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 11/21] Xen-paravirt: Add apply_to_page_range() which
	applies a function to a pte range.
Date: Thu, 15 Feb 2007 23:19:36 -0800
Message-ID: <20070215231936.073fadd3.akpm@linux-foundation.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.344125142@goop.org>
	<20070215223727.6819f962.akpm@linux-foundation.org>
	<45D55805.908@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D55805.908@goop.org>
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

On Thu, 15 Feb 2007 23:06:45 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> Andrew Morton wrote:
> > On Thu, 15 Feb 2007 18:25:00 -0800 Jeremy Fitzhardinge <jeremy@goop.org=
> wrote:
> >
> >   =

> >> Add a new mm function apply_to_page_range()[...]
> > There was some discussion about this sort of thing last week.  The
> > consensus was that it's better to run the callback against a whole pmd's
> > worth of ptes, mainly to amortise the callback's cost (a lot).
> >
> > It was implemented in
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20/2.=
6.20-mm1/broken-out/smaps-extract-pmd-walker-from-smaps-code.patch
> =

> Yes I was looking at that and wondering what the upshot would be.  I'll
> have a closer look, but it seems like it should be usable.

It's a question of who-merges-first.  I wasn't planning on merging the
smaps stuff into 2.6.21.

Perhaps the best approach is to proceed as-is and clean things up once it's
all merged.

I guess your pte-at-a-time walker could be quite simply implemented underne=
ath
the smaps pmd-at-a-time walker.
