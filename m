From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v3 35/75] x86/head/64: Build k/head64.c with -fno-stack-protector
Date: Wed, 3 Jun 2020 13:14:11 -0400
Message-ID: <CAMzpN2j4t7UwOFwSR8gVo-FpAQ_RS5pE1c8JZns3xyUXP3yANQ@mail.gmail.com>
References: <20200428151725.31091-1-joro@8bytes.org> <20200428151725.31091-36-joro@8bytes.org>
 <CAMzpN2gfiBAeCV_1+9ogh42bMMuDW=qdwd7dYp49-=zY3kzBaA@mail.gmail.com> <20200603151857.GC23071@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200603151857.GC23071@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 3, 2020 at 11:18 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, May 19, 2020 at 09:58:18AM -0400, Brian Gerst wrote:
> > On Tue, Apr 28, 2020 at 11:28 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> > The proper fix would be to initialize MSR_GS_BASE earlier.
>
> That'll mean to initialize it two times during boot, as the first C
> function with stack-protection is called before the kernel switches to
> its high addresses (early_idt_setup call-path). But okay, I can do that.

Good point.  Since this is boot code which isn't subject to stack
smashing attacks, disabling stack protector is probably the simpler
option.

--
Brian Gerst
