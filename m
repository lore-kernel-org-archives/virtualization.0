From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 12/21] Xen-paravirt: Allocate and free vmalloc areas
Date: Thu, 15 Feb 2007 23:24:47 -0800
Message-ID: <20070215232447.5ee67f50.akpm@linux-foundation.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.417300365@goop.org>
	<20070215224322.5c73d8e9.akpm@linux-foundation.org>
	<45D55852.9000103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45D55852.9000103@goop.org>
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

On Thu, 15 Feb 2007 23:08:02 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> Andrew Morton wrote:
> > This won't work when CONFIG_PREEMPT=3Dy.  The pagefault handler will see
> > in_atomic() and will scram.
> >   =

> =

> Is there some other way to get the pagetable populated for the address
> range?
> =


If you really need to run atomically, that gets ugly.  Even of one were to
run handle_mm_fault() by hand, it still needs to allocate memory.

Two ugly options might be:

a) touch all the pages, then go atomic, then touch them all again.  If
   one of them faults (ie: you raced with swapout) then go back and try
   again.  Obviously susceptible to livelocking.

b) Do get_user_pages() against all the pages, then go atomic, then do
   put_page() against them all.  Of course, they can immediately get
   swapped out.

But that function's already racy against swapout and I guess it works OK. =

I don't have clue what it is actually trying to do, so I'm guessing madly
here.
