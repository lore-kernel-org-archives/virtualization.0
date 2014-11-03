From: josh@joshtriplett.org
Subject: Re: [PATCH v4 10/10] x86: Support compiling out userspace IO (iopl
	and ioperm)
Date: Mon, 3 Nov 2014 08:45:39 -0800
Message-ID: <20141103164539.GA18104@cloud>
References: <cover.1414870871.git.josh@joshtriplett.org>
	<ec10c497d3a7f44f335dbc267edd6de5b4acd671.1414870871.git.josh@joshtriplett.org>
	<20141103121049.2f0c81a9@alan.etchedpixels.co.uk>
	<20141103141357.GC21818@thin>
	<20141103152748.327032f8@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141103152748.327032f8@alan.etchedpixels.co.uk>
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

On Mon, Nov 03, 2014 at 03:27:48PM +0000, One Thousand Gnomes wrote:
> > > This isn't unreasonable but there are drivers with userspace helpers that
> > > use iopl/ioperm type functionality where you should be doing a SELECT of
> > > X86_IOPORT. The one that comes to mind is the uvesa driver. From a quick
> > > scan it may these days be the only mainstream one that needs the select
> > > adding.
> > 
> > Should kernel drivers really express dependencies that only their
> > (current instances of) corresponding userspace components need?
> > Something seems wrong about that.
> 
> uvesafb will always need X86_IOPORT. It's kind of implicit in the design.
> I'm not suggesting that fbdev should select X86_IOPORT but in the uvesafb
> case at least it's completely useless to have one and not the other.

OK, fair enough.  Do you want the patch series respun to add that select
in patch 10/10, or would you consider it sufficient to add that in a
followup patch, since the kernel will build and boot either way (so it
won't break bisection)?

Related to that: Is it intentional that FB_UVESA doesn't depend on X86,
even though FB_VESA does?  Does v86d run on non-x86 hardware via
emulation?  If so, should FB_UVESA have "select X86_IOPORT if X86"?

- Josh Triplett
