From: Erdem Aktas <erdemaktas@google.com>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
Date: Tue, 21 Jul 2020 09:48:51 -0700
Message-ID: <CAAYXXYwVV_g8pGL52W9vxkgdNxg1dNKq_OBsXKZ_QizdXiTx2g@mail.gmail.com>
References: <20200714120917.11253-1-joro@8bytes.org> <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de> <20200715095556.GI10769@hirez.programming.kicks-ass.net>
 <20200715101034.GM16200@suse.de> <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
 <20200721124957.GD6132@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200721124957.GD6132@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Yes, I am using OVMF with SEV-ES (sev-es-v12 patches applied). I am
running Ubuntu 18.04 distro. My grub target is x86_64-efi. I also
tried installing the grub-efi-amd64 package. In all cases, the grub is
running in 64bit but enters the startup_32 in 32 bit mode. I think
there should be a 32bit #VC handler just something very similar in the
OVMF patches to handle the cpuid when the CPU is still in 32bit mode.
As it is now, it will be a huge problem to support different distro images.
I wonder if I am the only one having this problem.

-Erdem

On Tue, Jul 21, 2020 at 5:50 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> Hi,
>
> On Mon, Jul 20, 2020 at 06:09:19PM -0700, Erdem Aktas wrote:
> > It looks like there is an expectation that the bootloader will start
> > from the 64bit entry point in header_64.S. With the current patch
> > series, it will not boot up if the bootloader jumps to the startup_32
> > entry, which might break some default distro images.
> > What are supported bootloaders and configurations?
> > I am using grub ( 2.02-2ubuntu8.15) and it fails to boot because of
> > this reason. I am not a grub expert, so I would appreciate any
> > pointers on this.
>
> This is right, the only supported boot path is via the 64bit EFI entry
> point. The reason is that SEV-ES requires support in the firmware too,
> and currently only OVMF is supported in that regard. The firmware needs
> to setup the AP jump-table, for example.
>
> Other boot-paths have not been implemented. Booting via startup_32 would
> require exception handling in the 32bit-part of the boot-strap code,
> because verify_cpu is called there. Also an AMD specific MSR can't be
> accessed there because this would #GP on non-AMD/SEV-ES machines and,
> as I said, there is no way yet to handle them.
>
> How did you get into the startup_32 entry-point, do you have an SEV-ES
> BIOS supporting this? If it is really needed it could be implemented at
> a later point.
>
> Regards,
>
>         Joerg
>
