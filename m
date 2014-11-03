From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v4 10/10] x86: Support compiling out userspace IO (iopl
	and ioperm)
Date: Mon, 3 Nov 2014 15:27:48 +0000
Message-ID: <20141103152748.327032f8__48592.4517423429$1415631716$gmane$org@alan.etchedpixels.co.uk>
References: <cover.1414870871.git.josh@joshtriplett.org>
	<ec10c497d3a7f44f335dbc267edd6de5b4acd671.1414870871.git.josh@joshtriplett.org>
	<20141103121049.2f0c81a9@alan.etchedpixels.co.uk>
	<20141103141357.GC21818@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141103141357.GC21818@thin>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Kees Cook <keescook@chromium.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

> > This isn't unreasonable but there are drivers with userspace helpers that
> > use iopl/ioperm type functionality where you should be doing a SELECT of
> > X86_IOPORT. The one that comes to mind is the uvesa driver. From a quick
> > scan it may these days be the only mainstream one that needs the select
> > adding.
> 
> Should kernel drivers really express dependencies that only their
> (current instances of) corresponding userspace components need?
> Something seems wrong about that.

uvesafb will always need X86_IOPORT. It's kind of implicit in the design.
I'm not suggesting that fbdev should select X86_IOPORT but in the uvesafb
case at least it's completely useless to have one and not the other.

> IO_BITMAP_LONGS already gets defined to (0/sizeof(long)).  And as far as
> I can tell, that would only work for init_tss_io, not anything else.
> Even then, that would only work with a zero-size array left around in
> tss_struct, which doesn't seem appropriate.  The remaining ifdefs wrap
> code that GCC could not constant-fold away, and making that code
> constant-foldable seems significantly more invasive than the ifdefs.

OK
