From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v3 35/75] x86/head/64: Build k/head64.c with -fno-stack-protector
Date: Tue, 19 May 2020 09:58:18 -0400
Message-ID: <CAMzpN2gfiBAeCV_1+9ogh42bMMuDW=qdwd7dYp49-=zY3kzBaA@mail.gmail.com>
References: <20200428151725.31091-1-joro@8bytes.org> <20200428151725.31091-36-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200428151725.31091-36-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Erdem Aktas <erdemaktas@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Joerg Roedel <jroedel@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtu>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 11:28 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The code inserted by the stack protector does not work in the early
> boot environment because it uses the GS segment, at least with memory
> encryption enabled. Make sure the early code is compiled without this
> feature enabled.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index ba89cabe5fcf..1192de38fa56 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -35,6 +35,10 @@ ifdef CONFIG_FRAME_POINTER
>  OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o             := y
>  endif
>
> +# make sure head64.c is built without stack protector
> +nostackp := $(call cc-option, -fno-stack-protector)
> +CFLAGS_head64.o                := $(nostackp)
> +
>  # If instrumentation of this dir is enabled, boot hangs during first second.
>  # Probably could be more selective here, but note that files related to irqs,
>  # boot, dumpstack/stacktrace, etc are either non-interesting or can lead to

The proper fix would be to initialize MSR_GS_BASE earlier.

--
Brian Gerst
