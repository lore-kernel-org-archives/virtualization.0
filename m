From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 38/62] x86/sev-es: Handle instruction fetches from user-space
Date: Wed, 12 Feb 2020 13:42:48 -0800
Message-ID: <CALCETrVRmg88xY0s4a2CONXQ3fgvCKXpW2eYJRJGhqQLneoGqQ@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-39-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-39-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> When a #VC exception is triggered by user-space the instruction
> decoder needs to read the instruction bytes from user addresses.
> Enhance es_fetch_insn_byte() to safely fetch kernel and user
> instruction bytes.

I realize that this is a somewhat arbitrary point in the series to
complain about this, but: the kernel already has infrastructure to
decode and fix up an instruction-based exception.  See
fixup_umip_exception().  Please refactor code so that you can share
the same infrastructure rather than creating an entirely new thing.

FWIW, the fixup_umip_exception() code seems to have much more robust
segment handling than yours :)

--Andy
