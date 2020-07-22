From: Erdem Aktas <erdemaktas@google.com>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
Date: Wed, 22 Jul 2020 09:54:40 -0700
Message-ID: <CAAYXXYxRzO+hFvge4sKvNyH64iW9N2eLNbbKOR2DZf0DDL6CUw@mail.gmail.com>
References: <20200714120917.11253-1-joro@8bytes.org> <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de> <20200715095556.GI10769@hirez.programming.kicks-ass.net>
 <20200715101034.GM16200@suse.de> <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
 <20200721124957.GD6132@suse.de> <CAAYXXYwVV_g8pGL52W9vxkgdNxg1dNKq_OBsXKZ_QizdXiTx2g@mail.gmail.com>
 <20200722090442.GI6132@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200722090442.GI6132@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I am using a custom, optimized and stripped down version, OVMF build.
Do you think it is because of the OVMF or grub?

In my case, there are 2 places where the CPUID is called: the first
one is to decide if long mode is supported, along with few other
features like SSE support and the second one is to retrieve the
encryption bit location.

-Erdem

On Wed, Jul 22, 2020 at 2:04 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> Hi Erdem,
>
> On Tue, Jul 21, 2020 at 09:48:51AM -0700, Erdem Aktas wrote:
> > Yes, I am using OVMF with SEV-ES (sev-es-v12 patches applied). I am
> > running Ubuntu 18.04 distro. My grub target is x86_64-efi. I also
> > tried installing the grub-efi-amd64 package. In all cases, the grub is
> > running in 64bit but enters the startup_32 in 32 bit mode. I think
> > there should be a 32bit #VC handler just something very similar in the
> > OVMF patches to handle the cpuid when the CPU is still in 32bit mode.
> > As it is now, it will be a huge problem to support different distro images.
> > I wonder if I am the only one having this problem.
>
> I havn't heard from anyone else that the startup_32 boot-path is being
> used for SEV-ES. What OVMF binary do you use for your guest?
>
> In general it is not that difficult to support that boot-path too, but
> I'd like to keep that as a future addition, as the patch-set is already
> quite large. In the startup_32 path there is already a GDT set up, so
> whats needed is an IDT and a 32-bit #VC handler using the MRS-based
> protocol (and hoping that there will only be CPUID intercepts until it
> reaches long-mode).
>
> Regards,
>
>         Joerg
>
