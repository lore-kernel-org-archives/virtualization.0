From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] x86: tss: Eliminate fragile calculation of TSS
	segment limit
Date: Thu, 31 Oct 2013 04:17:43 -0700
Message-ID: <20131031111742.GB25280@leaf>
References: <cover.1382407802.git.josh@joshtriplett.org>
	<edeb47cf74bc015f4e36f5c5c7af4cd7d9532df8.1382407802.git.josh@joshtriplett.org>
	<CAGXu5jLNhzrQHtgkW8rAm3em=aEHsTXy+DndEqLJCMH0H8n_Sg@mail.gmail.com>
	<52718DD7.7040905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <52718DD7.7040905@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Jeremy Fitzhardinge <jeremy@goop.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, xen-devel@lists.xenproject.org, Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <kees>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 30, 2013 at 03:53:11PM -0700, H. Peter Anvin wrote:
> On 10/30/2013 03:22 PM, Kees Cook wrote:
> >>
> >> -       /*
> >> -        * sizeof(unsigned long) coming from an extra "long" at the end
> >> -        * of the iobitmap. See tss_struct definition in processor.h
> >> -        *
> >> -        * -1? seg base+limit should be pointing to the address of the
> >> -        * last valid byte
> > 
> > I think it might be better to keep at least a minimal comment near the
> > TSS_LIMIT declaration, just to explain the "-1" part, which is not
> > entirely obvious from just reading the code.
> > 
> 
> Agreed, although it doesn't need to be an unsigned long at all... the
> CPU will only ever access one extra byte past the end.

True, but the thing immediately following the iobitmap is a stack, which
needs aligning, so the array does need to contain a full additional
unsigned long even if the CPU only accesses a byte of it.  In any case,
that isn't the reason for the -1, just the reason for the
sizeof(unsigned long) mentioned in the comment above, which goes away
now that TSS_LIMIT uses the offset of the *following* field rather than
recalculating the size of the iobitmap.

- Josh Triplett
