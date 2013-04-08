From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] x86: make IDT read-only
Date: Tue, 9 Apr 2013 00:42:49 +0100 (BST)
Message-ID: <alpine.LFD.2.03.1304090042220.25182@linux-mips.org>
References: <20130408224328.GA17641@www.outflux.net>
	<alpine.LFD.2.03.1304082350540.25182@linux-mips.org>
	<CAGXu5j+fWeinnBr3JLkLt-M4N8uSXzP9MiRF20h37_WABQ1Rrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGXu5j+fWeinnBr3JLkLt-M4N8uSXzP9MiRF20h37_WABQ1Rrw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Alex Shi <alex.shi@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Will Drewry <wad@chromium.org>, Julien Tinnes <jln@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dan Rosenberg <drosenberg@vsecurity.com>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <borislav.petkov@amd.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 8 Apr 2013, Kees Cook wrote:

> >  FWIW the change looks reasonable to me, however given that that it makes
> > the arrangement unconditional and there is no longer a workaround to
> > enable I think it would make sense to remove the conditional block quoted
> > above altogether, along with the f00f_workaround_enabled variable itself
> > (alternatively "Intel Pentium with F0 0F bug" alone could be printed
> > instead and the name of the variable adjusted to make sense with the new
> > meaning -- up to you to decide).
> 
> Actually, I take it back. The other portion of the workaround is still
> active (in mm/fault.c), and this chunk announces it, so I'm going to
> leave it as-is.

 Ah, OK then.  Thanks for double-checking.

  Maciej
