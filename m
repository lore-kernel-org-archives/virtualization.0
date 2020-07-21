From: Erdem Aktas <erdemaktas@google.com>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
Date: Mon, 20 Jul 2020 18:09:19 -0700
Message-ID: <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
References: <20200714120917.11253-1-joro@8bytes.org> <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de> <20200715095556.GI10769@hirez.programming.kicks-ass.net>
 <20200715101034.GM16200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200715101034.GM16200@suse.de>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, David Rientjes <rientjes@google.com>, Cfir Cohen <cfir@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mike Stunes <mstunes@vmware.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Martin Radev <martin.b.radev@gmail.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

It looks like there is an expectation that the bootloader will start
from the 64bit entry point in header_64.S. With the current patch
series, it will not boot up if the bootloader jumps to the startup_32
entry, which might break some default distro images.
What are supported bootloaders and configurations?
I am using grub ( 2.02-2ubuntu8.15) and it fails to boot because of
this reason. I am not a grub expert, so I would appreciate any
pointers on this.
Also, it would be nice to put some error code in the GHCB MSR if the
guest dies for some reason in real mode. Currently, it just dies with
no information provided.

PS: sorry for sending twice due to the wrong email body type.

Regards
-Erdem


On Wed, Jul 15, 2020 at 3:10 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Wed, Jul 15, 2020 at 11:55:56AM +0200, Peter Zijlstra wrote:
> > And recursive #VC was instant death, right? Because there's no way to
> > avoid IST stack corruption in that case.
>
> Right, a #VC exception while still on the IST stack must instantly kill
> the VM. That needs an additional check which is not implemented yet, as
> it only becomes necessary with SNP.
>
> Regards,
>
>         Joerg
>
>
