From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
Date: Wed, 15 Jul 2020 11:24:56 +0200
Message-ID: <20200715092456.GE10769@hirez.programming.kicks-ass.net>
References: <20200714120917.11253-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 14, 2020 at 02:08:02PM +0200, Joerg Roedel wrote:
> The #VC entry code now tries to pretend that the #VC handler does not
> use an IST stack by switching to the task stack if entered from
> user-mode or the SYSCALL entry path. When it is entered from
> kernel-mode it is doing its best to switch back to the interrupted
> stack. This is only possible if it is entered from a known and safe
> kernel stack (e.g. not the entry stack). If the previous stack is not
> safe to use the #VC handler switches to a fall-back stack and calls a
> special handler function which, as of now, just panics the system. For
> now this is safe as #VC exceptions only happen at know places which
> use a safe stack.
> 
> The use of the fall-back stack is necessary so that the special
> handler function can safely raise nested #VC exceptions, for
> example to print a panic message.

Can we get some more words -- preferably in actual code comments, on
when exactly #VC happens?

Because the only thing I remember is that #VC could happen on any memop,
but I also have vague memories of that being a later extention.
