From: Thomas Garnier <thgarnie@chromium.org>
Subject: Re: [PATCH v11 00/11] x86: PIE support to extend KASLR randomization
Date: Tue, 3 Mar 2020 07:43:31 -0800
Message-ID: <CAJcbSZH1oON2VC2U8HjfC-6=M-xn5eU+JxHG2575iMpVoheKdA@mail.gmail.com>
References: <20200228000105.165012-1-thgarnie@chromium.org>
 <202003022100.54CEEE60F@keescook> <20200303095514.GA2596@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kernel-hardening-return-18053-glkh-kernel-hardening=m.gmane-mx.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <20200303095514.GA2596@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Juergen Gross <jgross@suse.com>, Thomas Hellstrom <thellstrom@vmware.com>, "VMware, Inc." <pv-drivers@vmware.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Slaby <jslaby@>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 3, 2020 at 1:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 02, 2020 at 09:02:15PM -0800, Kees Cook wrote:
> > On Thu, Feb 27, 2020 at 04:00:45PM -0800, Thomas Garnier wrote:
> > > Minor changes based on feedback and rebase from v10.
> > >
> > > Splitting the previous serie in two. This part contains assembly code
> > > changes required for PIE but without any direct dependencies with the
> > > rest of the patchset.
> > >
> > > Note: Using objtool to detect non-compliant PIE relocations is not yet
> > > possible as this patchset only includes the simplest PIE changes.
> > > Additional changes are needed in kvm, xen and percpu code.
> > >
> > > Changes:
> > >  - patch v11 (assembly);
> > >    - Fix comments on x86/entry/64.
> > >    - Remove KASLR PIE explanation on all commits.
> > >    - Add note on objtool not being possible at this stage of the patchset.
> >
> > This moves us closer to PIE in a clean first step. I think these patches
> > look good to go, and unblock the work in kvm, xen, and percpu code. Can
> > one of the x86 maintainers pick this series up?
>
> But,... do we still need this in the light of that fine-grained kaslr
> stuff?
>
> What is the actual value of this PIE crud in the face of that?

If I remember well, it makes it easier/better but I haven't seen a
recent update on that. Is that accurate Kees?
