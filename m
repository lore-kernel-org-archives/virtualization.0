From: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/2] paravirt inline patching
Date: Tue, 22 Aug 2006 11:14:48 +0200
Message-ID: <20060822111448.a9cdfe68.ak@muc.de>
References: <1156226116.26898.8.camel@localhost.localdomain>
	<1156227152.26898.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1156227152.26898.11.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 22 Aug 2006 16:12:32 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:


> It turns out that the most called ops, by several orders of magnitude,
> are the interrupt manipulation ops.  These are obvious candidates for
> patching, so mark them up and create infrastructure for it.
> =

> The method used is that the ops structure has a patch function, which
> is called for each place which needs to be patched: this returns a
> number of instructions (the rest are NOP-padded).
> =

> Usually we can spare a register (%eax) for the binary patched code to
> use, but in a couple of critical places in entry.S we can't: we make
> the clobbers explicit at the call site, and manually clobber the
> allowed registers in debug mode as an extra check.

Looks good to me.

> +
> +	/* Sync in case we patched this coming "sti" last. */
> +	sync_core();

I guess this needs more comments -- in particular that it is =

only safe because the other CPUs are not executing any of this
yet and preempt does synchronize anyways.

-Andi
