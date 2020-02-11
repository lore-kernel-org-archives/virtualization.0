From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 62/62] x86/sev-es: Add NMI state tracking
Date: Tue, 11 Feb 2020 14:50:29 -0800
Message-ID: <CALCETrWV15+YTGsEwUHBSjT2MYappLANw4fQHjgZgei2UyV1JQ@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-63-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-63-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Keep NMI state in SEV-ES code so the kernel can re-enable NMIs for the
> vCPU when it reaches IRET.

This patch is overcomplicated IMO.  Just do the magic incantation in C
from do_nmi or from here:

        /*
         * For ease of testing, unmask NMIs right away.  Disabled by
         * default because IRET is very expensive.

If you do the latter, you'll need to handle the case where the NMI
came from user mode.

The ideal solution is do_nmi, I think.

if (static_cpu_has(X86_BUG_AMD_FORGOT_ABOUT_NMI))
  sev_es_unmask_nmi();

Feel free to use X86_FEATURE_SEV_ES instead :)

--Andu
