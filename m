From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v4 10/10] x86: Support compiling out userspace IO (iopl
	and ioperm)
Date: Mon, 3 Nov 2014 06:13:58 -0800
Message-ID: <20141103141357.GC21818@thin>
References: <cover.1414870871.git.josh@joshtriplett.org>
	<ec10c497d3a7f44f335dbc267edd6de5b4acd671.1414870871.git.josh@joshtriplett.org>
	<20141103121049.2f0c81a9@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141103121049.2f0c81a9@alan.etchedpixels.co.uk>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Kees Cook <keescook@chromium.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 03, 2014 at 12:10:49PM +0000, One Thousand Gnomes wrote:
> On Sun, 2 Nov 2014 09:33:01 -0800
> Josh Triplett <josh@joshtriplett.org> wrote:
> 
> > On the vast majority of modern systems, no processes will use the
> > userspsace IO syscalls, iopl and ioperm.  Add a new config option,
> > CONFIG_X86_IOPORT, to support configuring them out of the kernel
> > entirely.  Most current systems do not run programs using these
> > syscalls, so X86_IOPORT does not depend on EXPERT, though it does still
> > default to y.
> 
> This isn't unreasonable but there are drivers with userspace helpers that
> use iopl/ioperm type functionality where you should be doing a SELECT of
> X86_IOPORT. The one that comes to mind is the uvesa driver. From a quick
> scan it may these days be the only mainstream one that needs the select
> adding.

Should kernel drivers really express dependencies that only their
(current instances of) corresponding userspace components need?
Something seems wrong about that.

> Some X servers for legacy cards still use io port access.

Sure, X servers using UMS rather than KMS seem like a common reason to
need this.

> There are also
> a couple of other highly non-obvious userspace users that hang on for
> some systems - eg some older servers DMI and error records can only by
> read via a real mode BIOS call so management tools have no choice but to
> go the lrmi/io path.

As with any userspace interface, some callers may potentially still
exist.  And this still has "default y", too, to avoid user surprises.

> Still makes sense IMHO.
> 
> From a code perspective however you could define IO_BITMAP_LONGS to 0,
> add an IO_BITMAP_SIZE (defined as LONGS + 1 or 0) and as far as I can see
> gcc would then optimise out a lot of the code you are ifdeffing

IO_BITMAP_LONGS already gets defined to (0/sizeof(long)).  And as far as
I can tell, that would only work for init_tss_io, not anything else.
Even then, that would only work with a zero-size array left around in
tss_struct, which doesn't seem appropriate.  The remaining ifdefs wrap
code that GCC could not constant-fold away, and making that code
constant-foldable seems significantly more invasive than the ifdefs.

- Josh Triplett
